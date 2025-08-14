package exportexcel;

import acc.Connect;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.swing.JOptionPane;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelAccounting2 {

    private static final LinkedHashMap<String, String> DELIVERY_CHARGES = new LinkedHashMap<>();

    static {
        DELIVERY_CHARGES.put("landing", "Land Charge");
        DELIVERY_CHARGES.put("delivery", "D.Charge");
        DELIVERY_CHARGES.put("clean", "Clean PHC");
        //DELIVERY_CHARGES.put("militry", "Traffic");
        DELIVERY_CHARGES.put("stamp", "Stamp Duty");
        DELIVERY_CHARGES.put("ppd", "PPD");
        DELIVERY_CHARGES.put("militry", "WE");
        DELIVERY_CHARGES.put("conference", "SSC");
        DELIVERY_CHARGES.put("insurance", "Insurance");
        DELIVERY_CHARGES.put("food", "Food Bank");
        DELIVERY_CHARGES.put("admin", "Administration");
        DELIVERY_CHARGES.put("others", "State Govt");
        DELIVERY_CHARGES.put("congestion", "EUS");
        DELIVERY_CHARGES.put("freight", "P.C.Stamp");
        DELIVERY_CHARGES.put("notifications", "Notification");
        DELIVERY_CHARGES.put("thc", "T.S.Stamp");
        //DELIVERY_CHARGES.put("extraction", "Lifting");
        DELIVERY_CHARGES.put("extraction", "Finance");
    }

    private static final double VAT_RATE = 0.17;

    public static void main(String[] args) {
        export("2025-04-18", "2025-05-25");
    }

    public static void export(String dateFrom, String dateTo) {
        String excelFilePath = "Daily_invoice_report.xlsx";

        String deliverySQL = "SELECT d.*, m.mast_blno FROM delivery d " +
                "LEFT JOIN mast m ON m.mast_d_serial = d.del_serial " +
                "WHERE d.del_date BETWEEN ? AND ? ORDER BY d.del_date DESC";

        String demurrageSQL = "SELECT d.*, m.mast_blno FROM demurrage d " +
                "LEFT JOIN mast m ON m.mast_dem_serial = d.dem_serial " +
                "WHERE d.dem_date BETWEEN ? AND ? ORDER BY d.dem_date DESC";

        String exManifestSQL = "SELECT *, bl_no as ref FROM ex_manifest " +
                "WHERE date BETWEEN ? AND ? ORDER BY date DESC";

        String settingsSQL = "SELECT * FROM dsetting";

        try (Connection conn = Connect.ConnectDB();
             PreparedStatement psDelivery = conn.prepareStatement(deliverySQL);
             PreparedStatement psDem = conn.prepareStatement(demurrageSQL);
             PreparedStatement psEx = conn.prepareStatement(exManifestSQL);
             PreparedStatement psSetting = conn.prepareStatement(settingsSQL);
             XSSFWorkbook workbook = new XSSFWorkbook()) {

            psDelivery.setString(1, dateFrom);
            psDelivery.setString(2, dateTo);
            psDem.setString(1, dateFrom);
            psDem.setString(2, dateTo);
            psEx.setString(1, dateFrom);
            psEx.setString(2, dateTo);

            Map<String, Double> settings = new HashMap<>();
            try (ResultSet rsSet = psSetting.executeQuery()) {
                ResultSetMetaData meta = rsSet.getMetaData();
                if (rsSet.next()) {
                    for (int i = 1; i <= meta.getColumnCount(); i++) {
                        settings.put(meta.getColumnName(i).toLowerCase(), rsSet.getDouble(i));
                    }
                }
            }

            Sheet sheet = workbook.createSheet("Daily Invoice Report");
            writeHeaderLine(sheet);
            int rowCount = 1;

            // Process Demurrage
            try (ResultSet rsDem = psDem.executeQuery()) {
                while (rsDem.next()) {
                    String clearer = rsDem.getString("dem_clearer");
                    java.util.Date transDate = rsDem.getDate("dem_date");
                    String ref = rsDem.getString("mast_blno");

                    if (ref == null || ref.trim().isEmpty()) {
                        ref = String.valueOf(rsDem.getLong("dem_serial"));
                    }

                    double amount = rsDem.getDouble("dem_gtotal");
                    double vatAmount = rsDem.getDouble("dem_vat");

                    rowCount = writeRow(sheet, rowCount, clearer, transDate, ref, "Demurrage", amount, "S", vatAmount, "");
                    rowCount = writeRow(sheet, rowCount, clearer, transDate, ref, "Stamp", settings.getOrDefault("stamp", 0.0), "Z", 0.0, "");
                }
            }

            // Process Delivery
            try (ResultSet rsDelivery = psDelivery.executeQuery()) {
                while (rsDelivery.next()) {
                    String clearer = rsDelivery.getString("clearername");
                    java.util.Date transDate = rsDelivery.getDate("del_date");
                    String ref = rsDelivery.getString("mast_blno");

                    if (ref == null || ref.trim().isEmpty()) {
                        ref = String.valueOf(rsDelivery.getLong("del_serial"));
                    }

                    for (var entry : DELIVERY_CHARGES.entrySet()) {
                        double amt = rsDelivery.getDouble(entry.getKey());
                        if (amt <= 0) continue;

                        double vat = amt * VAT_RATE;
                        rowCount = writeRow(sheet, rowCount, clearer, transDate, ref, entry.getValue(), amt, "S", vat, "");
                    }
                }
            }

            // Process Ex-Manifest
            try (ResultSet rsEx = psEx.executeQuery()) {
                Map<String, Integer> sizeCountMap = new HashMap<>();
                List<Map<String, Object>> exData = new ArrayList<>();

                while (rsEx.next()) {
                    String clearer = rsEx.getString("shipper");
                    java.util.Date transDate = rsEx.getDate("date");
                    String ref = rsEx.getString("bl_no");
                    String size = rsEx.getString("size").trim();

                    if (!size.equals("20") && !size.equals("40")) continue;

                    String key = clearer + "|" + transDate + "|" + size;
                    sizeCountMap.merge(key, 1, Integer::sum);

                    Map<String, Object> row = new HashMap<>();
                    row.put("clearer", clearer);
                    row.put("date", transDate);
                    row.put("size", size);
                    row.put("ref", ref);
                    exData.add(row);
                }

                Set<String> processed = new HashSet<>();
                for (Map<String, Object> row : exData) {
                    String clearer = (String) row.get("clearer");
                    java.util.Date transDate = (java.util.Date) row.get("date");
                    String size = (String) row.get("size");
                    String ref = (String) row.get("ref");
                    String key = clearer + "|" + transDate + "|" + size;

                    if (processed.contains(key)) continue;
                    processed.add(key);

                    int count = sizeCountMap.getOrDefault(key, 0);
                    double unitRate = settings.getOrDefault("ex_" + size, 0.0);
                    double totalRate = unitRate * count;
                    double vat = totalRate * VAT_RATE;
                    String desc = count + "x" + size;

                    rowCount = writeRow(sheet, rowCount, clearer, transDate, ref, "Outbound Charges", totalRate, "S", vat, desc);

                    double val3sets = settings.getOrDefault("ex_3sets", 0.0);
                    double valStamp = settings.getOrDefault("ex_stamp_duty", 0.0);
                    double valCourier = settings.getOrDefault("ex_couries", 0.0);

                    rowCount = writeRow(sheet, rowCount, clearer, transDate, ref, "Three Sets Original", val3sets, "S", val3sets * VAT_RATE, "");
                    rowCount = writeRow(sheet, rowCount, clearer, transDate, ref, "Stamp Duty", valStamp, "S", valStamp * VAT_RATE, "");
                    rowCount = writeRow(sheet, rowCount, clearer, transDate, ref, "Courier Charges", valCourier, "S", valCourier * VAT_RATE, "");
                }
            }

            // Write to Excel
            try (FileOutputStream out = new FileOutputStream(excelFilePath)) {
                workbook.write(out);
            }

            JOptionPane.showMessageDialog(null, "Data Exported Successfully", "Success", JOptionPane.INFORMATION_MESSAGE);
            Runtime.getRuntime().exec("rundll32 url.dll,FileProtocolHandler " + excelFilePath);

        } catch (SQLException | IOException e) {
            JOptionPane.showMessageDialog(null, "Error: " + e.getMessage());
        }
    }

    private static void writeHeaderLine(Sheet sheet) {
        String[] headers = {
            "Customer Name", "Transaction Date", "RefNumber/BIL No.", "PO Number", "Terms",
            "Class", "Template Name", "To Be Printed", "Ship Date",
            "BillTo Line1", "BillTo Line2", "BillTo Line3", "BillTo Line4",
            "BillTo City", "BillTo State", "BillTo PostalCode", "BillTo Country",
            "ShipTo Line1", "ShipTo Line2", "ShipTo Line3", "ShipTo Line4",
            "ShipTo City", "ShipTo State", "ShipTo PostalCode", "ShipTo Country",
            "Phone", "Fax", "Email", "Contact Name", "First Name", "Last Name", "Rep",
            "Due Date/Arrived On", "Ship Method", "Customer Message", "Memo",
            "Item Name", "Quantity", "Description", "Rate", "VAT Code", "VAT Amount",
            "Amount Incl VAT", "Other1/From Port", "FOB/Vessel", "Other2/Voyage",
            "Other/R/G No", "AR Account"
        };

        Row row = sheet.createRow(0);
        for (int i = 0; i < headers.length; i++) {
            row.createCell(i).setCellValue(headers[i]);
        }
    }

    private static int writeRow(Sheet sheet, int rowCount, String clearer, java.util.Date transDate, String ref,
                                String itemName, double rate, String vatCode, double vatAmount, String description) {
        Row row = sheet.createRow(rowCount++);
        for (int i = 0; i < 48; i++) row.createCell(i);

        row.getCell(0).setCellValue(clearer);
        row.getCell(1).setCellValue(transDate != null ? transDate.toString() : "");
        row.getCell(2).setCellValue(ref);

        int c = 36;
        row.getCell(c++).setCellValue(itemName);
        row.getCell(c++).setCellValue(1); // Quantity
        row.getCell(c++).setCellValue(description);
        row.getCell(c++).setCellValue(rate);
        row.getCell(c++).setCellValue(vatCode);
        row.getCell(c++).setCellValue(vatAmount);

        return rowCount;
    }
}
