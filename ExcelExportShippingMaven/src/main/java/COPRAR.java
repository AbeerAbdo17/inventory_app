import java.io.FileWriter;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class COPRAR {

//    public static void main(String[] args) {
//        LocalDate startDate = LocalDate.of(2025, 7, 3);
//        LocalDate endDate = LocalDate.of(2025, 7, 3);
//        String shippingLine = "1";
//
//        String referenceNumber = generateReferenceNumber();
//        StringBuilder edi = new StringBuilder();
//
//        edi.append("UNB+UNOA:2+++").append(getCurrentDateTime()).append("+").append(referenceNumber).append("'\n");
//        edi.append("UNH+").append(referenceNumber).append("+COPRAR:D:95B:UN'\n");
//        edi.append("BGM+43+").append(referenceNumber).append("+9'\n");
//        edi.append("RFF+XXX:1'\n");
//
//        int containerCount = 0;
//
//        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/k_shipping_db", "root", "0000")) {
//            String query = "SELECT m.*, v.*, " +
//                    "l1.pol AS from_port_name, l1.isopol AS from_port_code, " +
//                    "l2.pol AS to_port_name, l2.isopol AS to_port_code " +
//                    "FROM mast m " +
//                    "JOIN voys v ON m.mast_vslvoy = v.serial " +
//                    "LEFT JOIN loct l1 ON (v.voyfrom = l1.isopol OR v.voyfrom = l1.pol) " +
//                    "LEFT JOIN loct l2 ON (v.toport = l2.isopol OR v.toport = l2.pol) " +
//                    "WHERE ((DATE(m.del_date) BETWEEN ? AND ?) OR (DATE(m.mast_d_date) BETWEEN ? AND ?)) " +
//                    "AND m.line = ?";
//
//            PreparedStatement stmt = conn.prepareStatement(query);
//            stmt.setDate(1, Date.valueOf(startDate));
//            stmt.setDate(2, Date.valueOf(endDate));
//            stmt.setDate(3, Date.valueOf(startDate));
//            stmt.setDate(4, Date.valueOf(endDate));
//            stmt.setString(5, shippingLine);
//
//            ResultSet rs = stmt.executeQuery();
//
//            boolean headerWritten = false;
//
//            while (rs.next()) {
//                if (!headerWritten) {
//                    String voyageNumber = rs.getString("voyageno");
//                    String SHIPNAME = rs.getString("vessel");
//                    edi.append("TDT+20+").append(voyageNumber).append("+9++TMC:172:87+++")
//                            .append(voyageNumber).append(":146::").append(SHIPNAME).append("'\n");
//                    headerWritten = true;
//                }
//
//                String containerNo = rs.getString("mast_cno");
//                if (containerNo == null || containerNo.isEmpty()) continue;
//
//                String containerType = rs.getString("mast_ctype");
//                String status = rs.getString("mast_status");
//                String seal = rs.getString("seal_no");
//
//                double grossWeight = rs.getDouble("mast_nweight");
//                double tareWeight = grossWeight - rs.getDouble("MAST_WEIGHT");
//
//                String fromPortCode = rs.getString("from_port_code");
//                String fromPortName = rs.getString("from_port_name");
//                String toPortCode = rs.getString("to_port_code");
//                String toPortName = rs.getString("to_port_name");
//
//                Timestamp gateInTime = rs.getTimestamp("voydate_time");
//                Timestamp gateOutTime = rs.getTimestamp("voydate");
//
//                edi.append("LOC+11+").append(toPortCode).append(":139:6:").append(toPortName)
//                        .append("+").append(toPortCode).append(":TER:ZZZ:").append(toPortCode).append("'\n");
//
//                if (gateInTime != null) {
//                    edi.append("DTM+132:").append(formatTimestamp(gateInTime)).append(":203'\n");
//                }
//
//                if (gateOutTime != null) {
//                    edi.append("DTM+133:").append(formatTimestamp(gateOutTime)).append(":203'\n");
//                }
//
//                edi.append("NAD+CF+TMC:160:20'\n");
//
//                edi.append("EQD+CN+").append(containerNo).append("+").append(containerType)
//                        .append("+").append(status).append("+5'\n");
//
//                edi.append("RFF+BN:").append(containerNo).append("'\n");
//                edi.append("RFF+BM:").append(containerNo).append("'\n");
//                edi.append("EQN+1'\n");
//
//                edi.append("LOC+9+").append(fromPortCode).append(":139:6:").append(fromPortName)
//                        .append("+").append(fromPortCode).append(":TER:ZZZ:").append(fromPortName).append("'\n");
//
//                edi.append("LOC+11+").append(toPortCode).append(":139:6:").append(toPortName)
//                        .append("+").append(toPortCode).append(":TER:ZZZ:").append(toPortName).append("'\n");
//
//                edi.append("LOC+7+").append(toPortCode).append(":139:6:").append(toPortName)
//                        .append("+").append(toPortCode).append(":TER:ZZZ:").append(toPortName).append("'\n");
//
//                edi.append("MEA+AAE+T+KGM:").append((int) tareWeight).append("'\n");
//                edi.append("MEA+AAE+G+KGM:").append((int) grossWeight).append("'\n");
//
//                edi.append("SEL+").append(seal).append("+CA'\n");
//                edi.append("TDT+30++3+31'\n");
//
//                containerCount++;
//            }
//
//            edi.append("CNT+16:").append(containerCount).append("'\n");
//            edi.append("UNT+").append(referenceNumber.length()).append("+").append(referenceNumber).append("'\n");
//            edi.append("UNZ+1+").append(referenceNumber).append("'\n");
//
//            try (FileWriter writer = new FileWriter("coprar.edi")) {
//                writer.write(edi.toString());
//            }
//
//            System.out.println("COPRAR EDI file generated successfully with " + containerCount + " containers.");
//
//        } catch (SQLException | IOException e) {
//            e.printStackTrace(); 
//        }
//    }
 public static void generateCOPRAR(String path, LocalDate startDate, LocalDate endDate, String shippingLine) {
    String referenceNumber = generateReferenceNumber();
    StringBuilder edi = new StringBuilder();

    edi.append("UNB+UNOA:2+++").append(getCurrentDateTime()).append("+").append(referenceNumber).append("'\n");
    edi.append("UNH+").append(referenceNumber).append("+COPRAR:D:95B:UN'\n");
    edi.append("BGM+43+").append(referenceNumber).append("+9'\n");
    edi.append("RFF+XXX:1'\n");

    int containerCount = 0;

    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/k_shipping_db", "root", "0000")) {
        String query = "SELECT m.*, v.*, " +
                "l1.pol AS from_port_name, l1.isopol AS from_port_code, " +
                "l2.pol AS to_port_name, l2.isopol AS to_port_code " +
                "FROM mast m " +
                "JOIN voys v ON m.mast_vslvoy = v.serial " +
                "LEFT JOIN loct l1 ON (v.voyfrom = l1.isopol OR v.voyfrom = l1.pol) " +
                "LEFT JOIN loct l2 ON (v.toport = l2.isopol OR v.toport = l2.pol) " +
                "WHERE ((DATE(m.del_date) BETWEEN ? AND ?) OR (DATE(m.mast_d_date) BETWEEN ? AND ?)) " +
                "AND m.line = ?";

        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setDate(1, Date.valueOf(startDate));
        stmt.setDate(2, Date.valueOf(endDate));
        stmt.setDate(3, Date.valueOf(startDate));
        stmt.setDate(4, Date.valueOf(endDate));
        stmt.setString(5, shippingLine);

        ResultSet rs = stmt.executeQuery();
        boolean headerWritten = false;

        while (rs.next()) {
            if (!headerWritten) {
                String voyageNumber = rs.getString("voyageno");
                String SHIPNAME = rs.getString("vessel");
                edi.append("TDT+20+").append(voyageNumber).append("+9++TMC:172:87+++")
                        .append(voyageNumber).append(":146::").append(SHIPNAME).append("'\n");
                headerWritten = true;
            }

            String containerNo = rs.getString("mast_cno");
            if (containerNo == null || containerNo.isEmpty()) continue;

            String containerType = rs.getString("mast_ctype");
            String status = rs.getString("mast_status");
            String seal = rs.getString("seal_no");

            double grossWeight = rs.getDouble("mast_nweight");
            double tareWeight = grossWeight - rs.getDouble("MAST_WEIGHT");

            String fromPortCode = rs.getString("from_port_code");
            String fromPortName = rs.getString("from_port_name");
            String toPortCode = rs.getString("to_port_code");
            String toPortName = rs.getString("to_port_name");

            Timestamp gateInTime = rs.getTimestamp("voydate_time");
            Timestamp gateOutTime = rs.getTimestamp("voydate");

            edi.append("LOC+11+").append(toPortCode).append(":139:6:").append(toPortName)
                    .append("+").append(toPortCode).append(":TER:ZZZ:").append(toPortCode).append("'\n");

            if (gateInTime != null)
                edi.append("DTM+132:").append(formatTimestamp(gateInTime)).append(":203'\n");
            if (gateOutTime != null)
                edi.append("DTM+133:").append(formatTimestamp(gateOutTime)).append(":203'\n");

            edi.append("NAD+CF+TMC:160:20'\n");
            edi.append("EQD+CN+").append(containerNo).append("+").append(containerType)
                    .append("+").append(status).append("+5'\n");

            edi.append("RFF+BN:").append(containerNo).append("'\n");
            edi.append("RFF+BM:").append(containerNo).append("'\n");
            edi.append("EQN+1'\n");

            edi.append("LOC+9+").append(fromPortCode).append(":139:6:").append(fromPortName)
                    .append("+").append(fromPortCode).append(":TER:ZZZ:").append(fromPortName).append("'\n");

            edi.append("LOC+11+").append(toPortCode).append(":139:6:").append(toPortName)
                    .append("+").append(toPortCode).append(":TER:ZZZ:").append(toPortName).append("'\n");

            edi.append("LOC+7+").append(toPortCode).append(":139:6:").append(toPortName)
                    .append("+").append(toPortCode).append(":TER:ZZZ:").append(toPortName).append("'\n");

            edi.append("MEA+AAE+T+KGM:").append((int) tareWeight).append("'\n");
            edi.append("MEA+AAE+G+KGM:").append((int) grossWeight).append("'\n");
            edi.append("SEL+").append(seal).append("+CA'\n");
            edi.append("TDT+30++3+31'\n");

            containerCount++;
        }

        edi.append("CNT+16:").append(containerCount).append("'\n");
        edi.append("UNT+").append(referenceNumber.length()).append("+").append(referenceNumber).append("'\n");
        edi.append("UNZ+1+").append(referenceNumber).append("'\n");

        try (FileWriter writer = new FileWriter(path)) {
            writer.write(edi.toString());
        }

        System.out.println("✅ COPRAR EDI file generated to " + path);

    } catch (SQLException | IOException e) {
        e.printStackTrace();
        throw new RuntimeException("فشل توليد الملف: " + e.getMessage());
    }
}


    private static String getCurrentDateTime() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd:HHmm");
        return LocalDateTime.now().format(formatter);
    }

    private static String formatTimestamp(Timestamp timestamp) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmm");
        return timestamp.toLocalDateTime().format(formatter);
    }

    private static String generateReferenceNumber() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMddHHmmss");
        return formatter.format(LocalDateTime.now());
    }
}
