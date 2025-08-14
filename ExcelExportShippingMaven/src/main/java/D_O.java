import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class D_O {

    private static final Map<String, String> ACCOUNT_MAP = new HashMap<>();
    static {
        ACCOUNT_MAP.put("Landing Charge", "101");
        ACCOUNT_MAP.put("Cleaning Charge", "102");
        ACCOUNT_MAP.put("Delivery Charge", "103");
        ACCOUNT_MAP.put("Conference", "104");
        ACCOUNT_MAP.put("Admin Fees", "105");
        ACCOUNT_MAP.put("Trafic Map", "106");
        ACCOUNT_MAP.put("Military Support", "107");
        ACCOUNT_MAP.put("Continer Insurrance", "108");
        ACCOUNT_MAP.put("Red Sea Support", "109");
        ACCOUNT_MAP.put("Toursm Stamp", "110");
        ACCOUNT_MAP.put("Province Duty", "111");
        ACCOUNT_MAP.put("Extraction Bill", "112");
        ACCOUNT_MAP.put("Business Employee", "113");
        ACCOUNT_MAP.put("Food Subsidy", "114");
        ACCOUNT_MAP.put("Arival Notice", "115");
        ACCOUNT_MAP.put("Stamp Duty", "116");
        ACCOUNT_MAP.put("Lift On Lift Off", "117");
        ACCOUNT_MAP.put("SSC", "118");
        ACCOUNT_MAP.put("L.Guarantee", "119");
    }

    private static final String DO_ACC = "500";

    public static int generateNextJournalNo(Connection conn) throws SQLException {
        int nextNo = 1;
        String selectSQL = "SELECT topno FROM yeartopno ORDER BY topno DESC LIMIT 1";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(selectSQL);
        if (rs.next()) {
            nextNo = rs.getInt("topno") + 1;
        }
        rs.close();
        stmt.close();

        
        String insertSQL = "INSERT INTO yeartopno (topno) VALUES (?)";
        PreparedStatement insertStmt = conn.prepareStatement(insertSQL);
        insertStmt.setInt(1, nextNo);
        insertStmt.executeUpdate();
        insertStmt.close();

        return nextNo;
    }
    
    public static void insertCharges(Connection conn, Map<String, Double> chargeValues, int journalNo) throws SQLException {
        String sql = "INSERT INTO journal (JOURNAL_NO, JOURNAL_SUBMAIN_NO, JOURNAL_DR, JOURNAL_CR, JOURNAL_DESC) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);

        for (Map.Entry<String, Double> entry : chargeValues.entrySet()) {
            String chargeName = entry.getKey();
            double amount = entry.getValue();

            if (amount <= 0) continue;

            String acc = ACCOUNT_MAP.get(chargeName);
            if (acc == null) continue;

          
            stmt.setInt(1, journalNo);
            stmt.setString(2, acc);
            stmt.setDouble(3, amount);
            stmt.setDouble(4, 0.0);
            stmt.setString(5, chargeName + " For BL " + "رقم البوليصة");//مرر رقم البوليصة هنا
            stmt.addBatch();

            stmt.setInt(1, journalNo);
            stmt.setString(2, DO_ACC);
            stmt.setDouble(3, 0.0);
            stmt.setDouble(4, amount);
            stmt.setString(5, "DO_ACC" +"-"+ chargeName + " For BL " + "رقم البوليصة");//مرر رقم البوليصة هنا
            stmt.addBatch();
        }

        stmt.executeBatch();
        stmt.close();
    }

    
    public static void main(String[] args) {
        Map<String, Double> charges = new HashMap<>();
        charges.put("Landing Charge", 54000.0);
        charges.put("Cleaning Charge", 3000.0);
        charges.put("Delivery Charge", 5000.0);
        charges.put("SSC", 5000.0);


        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/k_shipping_db", "root", "0000");

            int newJournalNo = generateNextJournalNo(conn);
            insertCharges(conn, charges, newJournalNo);

            conn.close();
            System.out.println("save done" + newJournalNo);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}