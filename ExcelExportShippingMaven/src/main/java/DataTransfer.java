import java.sql.*;
//احول الداتا من جدول في الداتا بيز لي جدول تاني في داتا بيز تانية
public class DataTransfer {
    public static void main(String[] args) {
        String dbUrl = "jdbc:mysql://localhost:3306/k_shipping_db"; // target database
        String dbUser = "root";
        String dbPass = "0000";

        String insertQuery = """
            INSERT INTO delivery (
                del_date, del_serial, clearername, delivery, clean, landing, others,
                ppd, notifications, wharfage, insurance, vat, gtotal, thc, elect, congestion, deposit
            )
            SELECT
                del_date, del_serial, del_clearname, del_delivery, del_clean, del_land, other,
                del_ppd, del_notification, wharfage, insure, del_vat, del_total,
                del_thcvat, DEL_elec, DEL_CONG, del_deposit
            FROM abtest.delivery
        """;

        try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
             Statement stmt = conn.createStatement()) {

            // transfer data
            int insertedRows = stmt.executeUpdate(insertQuery);
            System.out.println("✅ Transferred " + insertedRows + " row(s).");

            // verify row counts
            int sourceCount = getRowCount(conn, "abtest.delivery");
            int targetCount = getRowCount(conn, "delivery");

            System.out.println("🔎 Row count in abtest.delivery = " + sourceCount);
            System.out.println("🔎 Row count in delivery = " + targetCount);

            if (targetCount >= sourceCount) {
                System.out.println("✅ Row counts match or target has more.");
            } else {
                System.out.println("⚠️ There's a deficit in transferred rows.");
            }

            // verify a specific row matches
            String testSerial = "123"; // put a real del_serial here
            compareRow(conn, testSerial);

        } catch (SQLException e) {
            System.out.println("❌ An error occurred during the operation:");
            e.printStackTrace();
        }
    }

    // ✅ Method to get row count from a table
    private static int getRowCount(Connection conn, String tableName) throws SQLException {
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM " + tableName)) {
            rs.next();
            return rs.getInt(1);
        }
    }

    // ✅ Method to compare a specific row by del_serial
    private static void compareRow(Connection conn, String delSerial) throws SQLException {
        String sourceQuery = "SELECT * FROM abtest.delivery WHERE del_serial = ?";
        String targetQuery = "SELECT * FROM delivery WHERE del_serial = ?";

        try (
            PreparedStatement srcStmt = conn.prepareStatement(sourceQuery);
            PreparedStatement tgtStmt = conn.prepareStatement(targetQuery)
        ) {
            srcStmt.setString(1, delSerial);
            tgtStmt.setString(1, delSerial);

            ResultSet src = srcStmt.executeQuery();
            ResultSet tgt = tgtStmt.executeQuery();

            if (src.next() && tgt.next()) {
                // verify matching for an example column
                String srcName = src.getString("del_clearname");
                String tgtName = tgt.getString("clearername");

                if (srcName.equals(tgtName)) {
                    System.out.println("✅ Row with serial " + delSerial + " matches ✅");
                } else {
                    System.out.println("❌ Difference in clearername for serial " + delSerial);
                    System.out.println("    Source: " + srcName);
                    System.out.println("    Target: " + tgtName);
                }
            } else {
                System.out.println("❌ Could not find row serial = " + delSerial + " in one of the tables.");
            }
        }
    }
}
