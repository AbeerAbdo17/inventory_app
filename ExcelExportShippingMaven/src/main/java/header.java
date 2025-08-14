import java.sql.*;

public class header {
    public static void main(String[] args) {
        String dbDataURL = "jdbc:mysql://localhost:3306/abtest?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
        String dbHeaderURL = "jdbc:mysql://localhost:3306/k_shipping_db?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";

        String username = "root";
        String password = "0000";

        String tableName = "delivery";

        try (
            Connection abtestConn = DriverManager.getConnection(dbDataURL, username, password);
            Connection headerConn = DriverManager.getConnection(dbHeaderURL, username, password);
            Statement abtestStmt = abtestConn.createStatement();
            Statement headerStmt = headerConn.createStatement()
        ) {
            // نقرأ فقط صف واحد للحصول على metadata
            ResultSet headerRS = headerStmt.executeQuery("SELECT * FROM " + tableName + " LIMIT 1");
            ResultSetMetaData headerMeta = headerRS.getMetaData();

            ResultSet dataRS = abtestStmt.executeQuery("SELECT * FROM " + tableName + " LIMIT 1");
            ResultSetMetaData dataMeta = dataRS.getMetaData();

            int columnCount = dataMeta.getColumnCount();

            // تحقق من تطابق عدد الأعمدة
            if (columnCount != headerMeta.getColumnCount()) {
                System.err.println("the num of columns does not ");
                return;
            }

            // نغير أسماء الأعمدة واحدًا واحدًا
            for (int i = 1; i <= columnCount; i++) {
                String oldName = dataMeta.getColumnName(i);
                String newName = headerMeta.getColumnName(i);

                // نفترض نوع العمود VARCHAR(255) — يمكن جعله ديناميكي لاحقًا
                String alterSQL = String.format(
                    "ALTER TABLE %s CHANGE `%s` `%s` VARCHAR(255);",
                    tableName, oldName, newName
                );

                try {
                    abtestStmt.executeUpdate(alterSQL);
                    System.out.println("✅done" + oldName + " → " + newName);
                } catch (SQLException e) {
                    System.err.println("❌ error " + oldName + ": " + e.getMessage());
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
