import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class save {

    static final String DB_URL = "jdbc:mysql://localhost:3306/k_shipping_db?useSSL=false&serverTimezone=UTC";
    static final String USER = "root";
    static final String PASS = "0000";

    public static void insertJournalEntry(double accountNO, double amount) {
        String insertQuery = "INSERT INTO journal (JOURNAL_NO, journal_dr, journal_cr, JOURNAL_DATE) VALUES (?, ?, ?, ?)";

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             PreparedStatement ps = conn.prepareStatement(insertQuery)) {

            String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

           
            ps.setDouble(1, accountNO);
            ps.setDouble(2, amount);
            ps.setDouble(3, 0.0);
            ps.setString(4, now);
            ps.executeUpdate();

            
            ps.setDouble(1, accountNO);
            ps.setDouble(2, 0.0);
            ps.setDouble(3, amount);
            ps.setString(4, now);
            ps.executeUpdate();

            System.out.println("done");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        insertJournalEntry(1, 500.0);
    }
}
