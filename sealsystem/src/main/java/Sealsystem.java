import java.sql.*;
import java.util.*;

public class Sealsystem {

    static final String DB_URL = "jdbc:mysql://localhost:3306/fersan?characterEncoding=UTF-8";
    static final String USER = "root";
    static final String PASS = "0000";

    public static void main(String[] args) {
        Map<Long, Double> itemsToDeduct = new HashMap<>();
        itemsToDeduct.put(2L, 0.0); // item_id = 8, required 2.9

        int storeId = 1;

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
            for (Map.Entry<Long, Double> entry : itemsToDeduct.entrySet()) {
                long itemId = entry.getKey();
                double requiredQty = roundTo(entry.getValue(), 6);

                double availableQty = roundTo(getAvailableStock(conn, itemId, storeId), 6);

                if (availableQty >= requiredQty) {
                    deductFromStock(conn, itemId, requiredQty, storeId);
                } else {
                    System.out.println("Not enough stock for item " + itemId +
                            " -- " + "requested: " + requiredQty + ", available: " + availableQty);

                    if (availableQty > 0.0001) {
                        deductFromStock(conn, itemId, availableQty, storeId);
                    }

                    saveShortage(conn, itemId, storeId, requiredQty, availableQty);
                    System.out.println("Shortage recorded = " + roundTo(availableQty - requiredQty, 6));
                }

                resolveShortageIfExists(conn, itemId, storeId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static double getAvailableStock(Connection conn, long itemId, int storeId) throws SQLException {
        String sql = "SELECT SUM(quantity) AS total FROM batches WHERE item_id = ? AND store = ? AND quantity > 0";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, itemId);
            stmt.setInt(2, storeId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total");
            }
        }
        return 0.0;
    }

    public static void saveShortage(Connection conn, long itemId, int storeId, double requiredQty, double availableQty) throws SQLException {
        double shortage = roundTo(availableQty - requiredQty, 6);
        String sql = "INSERT INTO stock_shortage (item_id, store_id, required_qty, available_qty, shortage) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setLong(1, itemId);
            stmt.setInt(2, storeId);
            stmt.setDouble(3, requiredQty);
            stmt.setDouble(4, availableQty);
            stmt.setDouble(5, shortage);
            stmt.executeUpdate();
            System.out.println("Shortage logged in stock_shortage (shortage = " + shortage + ")");
        }
    }

    public static void deductFromStock(Connection conn, long itemId, double requiredQty, int storeId) throws SQLException {
        requiredQty = roundTo(requiredQty, 6);
        System.out.println("===========================================");
        System.out.println("Starting deduction for item: " + itemId);
        System.out.println("Required quantity: " + requiredQty);

        while (requiredQty > 0.0001) {
            String sql = "SELECT serial, quantity FROM batches WHERE item_id = ? AND store = ? AND quantity > 0 " +
                         "AND expiry = (SELECT MIN(expiry) FROM batches WHERE item_id = ? AND store = ? AND quantity > 0) LIMIT 1";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setLong(1, itemId);
                stmt.setInt(2, storeId);
                stmt.setLong(3, itemId);
                stmt.setInt(4, storeId);

                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    long serial = rs.getLong("serial");
                    double availableQty = roundTo(rs.getDouble("quantity"), 6);

                    System.out.println("Batch serial = " + serial);
                    System.out.println("Quantity before deduction = " + availableQty);

                    if (availableQty <= requiredQty) {
                        String updateSQL = "UPDATE batches SET quantity = 0 WHERE serial = ?";
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateSQL)) {
                            updateStmt.setLong(1, serial);
                            updateStmt.executeUpdate();
                        }
                        System.out.println("Entire batch deducted");
                        System.out.println("Quantity after deduction = 0.0");
                        requiredQty -= availableQty;
                    } else {
                        double newQty = roundTo(availableQty - requiredQty, 6);
                        String updateSQL = "UPDATE batches SET quantity = ? WHERE serial = ?";
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateSQL)) {
                            updateStmt.setDouble(1, newQty);
                            updateStmt.setLong(2, serial);
                            updateStmt.executeUpdate();
                        }
                        System.out.println("Partial deduction = " + requiredQty);
                        System.out.println("Quantity after deduction = " + newQty);
                        requiredQty = 0;
                    }
                } else {
                    System.out.println("No more batches available for item: " + itemId);
                    break;
                }
            }
        }
        System.out.println("===========================================");
    }

    public static void resolveShortageIfExists(Connection conn, long itemId, int storeId) throws SQLException {
        String selectSQL = "SELECT id, shortage, available_qty, required_qty FROM stock_shortage " +
                           "WHERE item_id = ? AND store_id = ? AND shortage < 0 ORDER BY id ASC";

        try (PreparedStatement selectStmt = conn.prepareStatement(
                 selectSQL,
                 ResultSet.TYPE_SCROLL_INSENSITIVE,
                 ResultSet.CONCUR_UPDATABLE)) {

            selectStmt.setLong(1, itemId);
            selectStmt.setInt(2, storeId);
            ResultSet rs = selectStmt.executeQuery();

            double availableToUse = roundTo(getAvailableStock(conn, itemId, storeId), 6);

            while (rs.next() && availableToUse > 0.0001) {
                int shortageId = rs.getInt("id");
                double currentShortage = rs.getDouble("shortage");
                double oldAvailableQty = rs.getDouble("available_qty");

                double shortageToCover = roundTo(Math.min(availableToUse, -currentShortage), 6);

                System.out.println("Auto-deducting to cover shortage: " + shortageToCover);
                deductFromStock(conn, itemId, shortageToCover, storeId);

                availableToUse = roundTo(availableToUse - shortageToCover, 6);
                double remainingShortage = roundTo(currentShortage + shortageToCover, 6);

                if (remainingShortage >= -0.0001) {
                    String deleteSQL = "DELETE FROM stock_shortage WHERE id = ?";
                    try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSQL)) {
                        deleteStmt.setInt(1, shortageId);
                        deleteStmt.executeUpdate();
                        System.out.println("Shortage fully resolved for record " + shortageId);
                    }
                } else {
                    String updateSQL = "UPDATE stock_shortage SET available_qty = ?, shortage = ? WHERE id = ?";
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSQL)) {
                        updateStmt.setDouble(1, oldAvailableQty + shortageToCover);
                        updateStmt.setDouble(2, remainingShortage);
                        updateStmt.setInt(3, shortageId);
                        updateStmt.executeUpdate();
                        System.out.println("Updated shortage for record " + shortageId +
                                           " | Remaining: " + remainingShortage);
                    }
                }
            }
        }
    }


    public static double roundTo(double value, int digits) {
        double factor = Math.pow(10, digits);
        return Math.round(value * factor) / factor;
    }
}
