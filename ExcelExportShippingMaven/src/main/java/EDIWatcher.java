//package containers;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import javax.swing.JOptionPane;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;

public class EDIWatcher {
    public static void main(String[] args) {
    startWatching();
    }

    public static void startWatching() {
        Timer timer = new Timer();
        timer.schedule(new WatchTask(), 0, 1 * 5 * 1000);

        System.out.println("Started EDI Auto-Watcher...");
    }

    static class WatchTask extends TimerTask {
        static String lineCode = "1";

        @Override
        public void run() {
            Connection conn = null;
            boolean lockAcquired = false;

            try {
                conn = acc.Connect.ConnectDB();//DriverManager.getConnection(
             //       "jdbc:mysql://localhost:3306/k_shipping_db",
             //       "root", "0000"
             //   );
                conn.setAutoCommit(false);

                // فك الأقفال القديمة
                try (PreparedStatement unlockOld = conn.prepareStatement(
                    "UPDATE edi_lock SET is_locked = FALSE, locked_at = NULL " +
                    "WHERE is_locked = TRUE AND locked_at < (NOW() - INTERVAL 10 MINUTE)"
                )) {
                    unlockOld.executeUpdate();
                }

                // محاولة قفل السجل الوحيد
                try (PreparedStatement lockStmt = conn.prepareStatement(
                    "UPDATE edi_lock SET is_locked = TRUE, locked_at = NOW() WHERE id = 1 AND is_locked = FALSE"
                )) {
                    int locked = lockStmt.executeUpdate();
                    System.out.printf("[%s] Lock attempt: %s%n", LocalDateTime.now(), locked == 1 ? "SUCCESS" : "FAILED");

                    if (locked == 0) {
                        System.out.println("Another instance is already running. Exiting...");
                        conn.rollback();
                        return;
                    } else {
                        lockAcquired = true;
                    }
                }

                // جلب آخر وقت توليد ( أقل تاريخ ممكن)
                LocalDateTime lastGenerated = LocalDateTime.MIN;
                try (PreparedStatement fetchLastTime = conn.prepareStatement(
                        "SELECT MAX(created_at) AS last_time FROM edi_hash_log"
                    );
                    ResultSet rs = fetchLastTime.executeQuery()) {
                    if (rs.next() && rs.getTimestamp("last_time") != null) {
                        lastGenerated = rs.getTimestamp("last_time").toLocalDateTime();
                    }
                }
                String lastGeneratedStr = lastGenerated.format(
                    DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")
                );

                // جلب الصفوف المعدلة
                String sql =
                    "SELECT m.mast_cno, m.mast_ctype, m.mast_status, m.MAST_WEIGHT, m.seal_no, " +
                    "v.voydate_time, v.voyfrom, v.toport " +
                    "FROM mast m JOIN voys v ON m.mast_vslvoy = v.serial " +
                    "WHERE (m.updated_at > ? OR v.updated_at > ?) AND m.line = ? " +
                    "ORDER BY m.mast_cno, v.voydate_time";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, lastGeneratedStr);
                ps.setString(2, lastGeneratedStr);
                ps.setString(3, lineCode);

                ResultSet rs = ps.executeQuery();
                List<String> rowDataList = new ArrayList<>();
                StringBuilder builder = new StringBuilder();

                while (rs.next()) {
                    String row = rs.getString("mast_cno")
                               + rs.getString("mast_ctype")
                               + rs.getString("mast_status")
                               + rs.getDouble("MAST_WEIGHT")
                               + rs.getString("seal_no")
                               + rs.getString("voydate_time")
                               + rs.getString("voyfrom")
                               + rs.getString("toport");
                    rowDataList.add(row);
                    builder.append(row);
                }

                if (rowDataList.isEmpty()) {
                    System.out.println("No updates since last generation at " + lastGeneratedStr);
                    conn.rollback();
                    return;
                }

                // حساب الهاش
                String newHash = sha256(builder.toString());

                // جلب آخر هاش
                String lastHash = "";
                try (PreparedStatement fetchLastHash = conn.prepareStatement(
                        "SELECT hash_value FROM edi_hash_log ORDER BY created_at DESC LIMIT 1"
                    );
                    ResultSet hashRs = fetchLastHash.executeQuery()) {
                    if (hashRs.next()) {
                        lastHash = hashRs.getString("hash_value");
                    }
                }

                if (!newHash.equals(lastHash)) {
                    System.out.println("[CHANGE DETECTED] Generating EDI for " + rowDataList.size()
                                       + " new rows since " + lastGeneratedStr);

                    generateEDIForRows(rowDataList, lastGeneratedStr);

                    // تخزين الهاش الجديد
                    try (PreparedStatement insertHash = conn.prepareStatement(
                        "INSERT INTO edi_hash_log(hash_value, created_at) VALUES(?, NOW())"
                    )) {
                        insertHash.setString(1, newHash);
                        insertHash.executeUpdate();
                    }

                    conn.commit();

                } else {
                    System.out.println("[NO CHANGE] Hash matched, skipping EDI generation.");
                    conn.rollback();
                }

            } catch (Exception ex) {
                ex.printStackTrace();
                try {
                    if (conn != null) conn.rollback();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                } finally {
                if (conn != null) {
                    try {
                        if (lockAcquired) {
                            try (PreparedStatement unlockStmt = conn.prepareStatement(
                                    "UPDATE edi_lock SET is_locked = FALSE, locked_at = NULL WHERE id = 1"
                            )) {
                                int result = unlockStmt.executeUpdate();
                                System.out.println("Lock released: " + result);
                            }
                            conn.commit();
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }

        private static String sha256(String input) {
            try {
                MessageDigest digest = MessageDigest.getInstance("SHA-256");
                byte[] hash = digest.digest(input.getBytes(StandardCharsets.UTF_8));
                StringBuilder hexString = new StringBuilder();
                for (byte b : hash) {
                    String hex = Integer.toHexString(0xff & b);
                    if (hex.length() == 1) hexString.append('0');
                    hexString.append(hex);
                }
                return hexString.toString();
            } catch (Exception e) {
                e.printStackTrace();
                return null;
            }
        }

        private static void generateEDIForRows(List<String> rows, String sinceTimestamp) {
            System.out.println("Generating EDI files for rows updated since " + sinceTimestamp);
            String timestampTag = LocalDateTime.now().format(
                DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss")
            );
            String ediFile = "codeco_" + timestampTag + ".edi";
            String coarriFile = "coarri_" + timestampTag + ".edi";

            EDI.generateEDIFromDB(ediFile, sinceTimestamp, lineCode);
            COARRI.generateEDIFromDB(coarriFile, sinceTimestamp, lineCode);
            uploadFile(ediFile);
            uploadFile2(coarriFile);
            System.out.println("EDI files created at: " + timestampTag);
        }
    }
      private static void uploadFile(String f1) {
            String path = f1;
        String localFilePath = path.trim();//.getText().trim();
        if (localFilePath.isEmpty()) {
            JOptionPane.showMessageDialog(null, "يرجى إدخال مسار الملف.");
            return;
        }
        
                // إعدادات FTP
        String server = "192.168.0.45"; 
        int port = 21;
        String user = "kian2025";      
        String pass = "0000";      

        FTPClient ftpClient = new FTPClient();

        try {
            
            ftpClient.connect(server, port);
            
            boolean success = ftpClient.login(user, pass);

            if (!success) {
                JOptionPane.showMessageDialog(null, "فشل تسجيل الدخول إلى خادم FTP.");
                return;
            }

           ftpClient.enterLocalPassiveMode();
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);

            String remoteFileName = localFilePath.substring(localFilePath.lastIndexOf("\\") + 1); // اسم الملف فقط
            InputStream inputStream = new FileInputStream(localFilePath);
JOptionPane.showMessageDialog(null, "sending .... ");
            boolean done = ftpClient.storeFile(remoteFileName, inputStream);
            JOptionPane.showMessageDialog(null, "sent ");
            inputStream.close();

            System.out.println("Result of storeFile: " + done);
            System.out.println("Reply Code: " + ftpClient.getReplyCode());
            System.out.println("Reply String: " + ftpClient.getReplyString());

            if (done) {
                JOptionPane.showMessageDialog(null, "✅ تم رفع الملف بنجاح.");
            } else {
                JOptionPane.showMessageDialog(null, "❌ فشل رفع الملف.\n" + ftpClient.getReplyString());
            }

            ftpClient.logout();
            ftpClient.disconnect();

        } catch (IOException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(null, "خطأ: " + ex.getMessage());
        }
    } 
    private static void uploadFile2(String f2) {
            String path = f2;
        String localFilePath = path.trim();//.getText().trim();
        if (localFilePath.isEmpty()) {
            JOptionPane.showMessageDialog(null, "يرجى إدخال مسار الملف.");
            return;
        }
        
                // إعدادات FTP
        String server = "192.168.0.44"; 
        int port = 21;
        String user = "kian2025";      
        String pass = "0000";      

        FTPClient ftpClient = new FTPClient();

        try {
            
            ftpClient.connect(server, port);
            
            boolean success = ftpClient.login(user, pass);

            if (!success) {
                JOptionPane.showMessageDialog(null, "فشل تسجيل الدخول إلى خادم FTP.");
                return;
            }

           ftpClient.enterLocalPassiveMode();
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);

            String remoteFileName = localFilePath.substring(localFilePath.lastIndexOf("\\") + 1); // اسم الملف فقط
            InputStream inputStream = new FileInputStream(localFilePath);
JOptionPane.showMessageDialog(null, "sending .... ");
            boolean done = ftpClient.storeFile(remoteFileName, inputStream);
            JOptionPane.showMessageDialog(null, "sent ");
            inputStream.close();

            System.out.println("Result of storeFile: " + done);
            System.out.println("Reply Code: " + ftpClient.getReplyCode());
            System.out.println("Reply String: " + ftpClient.getReplyString());

            if (done) {
                JOptionPane.showMessageDialog(null, "✅ تم رفع الملف بنجاح.");
            } else {
                JOptionPane.showMessageDialog(null, "❌ فشل رفع الملف.\n" + ftpClient.getReplyString());
            }

            ftpClient.logout();
            ftpClient.disconnect();

        } catch (IOException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(null, "خطأ: " + ex.getMessage());
        }
    }

}
