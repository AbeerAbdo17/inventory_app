import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Test {

    static final String DB_URL ="jdbc:mysql://localhost:3306/k_shipping_db";
    static final String USER = "root";
    static final String PASS = "0000";

    public static void insertJournalEntry(String NO, double amount) {
        String insertQuery = "INSERT INTO journal (JOURNAL_NO, journal_dr, journal_cr) VALUES (?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             PreparedStatement ps = conn.prepareStatement(insertQuery)) {

             

            ps.setString(1, NO);
            ps.setDouble(2, amount);  // journal_dr
            ps.setDouble(3, 0.0);     // journal_cr
            ps.executeUpdate();
            
            ps.setString(1, NO);
            ps.setDouble(2, 0.0);     // journal_dr
            ps.setDouble(3, amount);  // journal_cr
            ps.executeUpdate();

            System.out.println("تم حفظ القيد المزدوج في جدول journal.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // زر الحفظ - تشغيل مثال
    public static void main(String[] args) {
        // مثال لإدخال من المستخدم
        String accountName = "الصندوق";
        double amount = 1000.0;

        insertJournalEntry(accountName, amount);
    }
}
