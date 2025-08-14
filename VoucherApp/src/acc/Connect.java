
package acc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Connect {
    public static Connection ConnectDB() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/k_shipping_db?useSSL=false&serverTimezone=UTC";
        String user = "root";    
        String password = "0000"; 
        return DriverManager.getConnection(url, user, password);
    }
}
