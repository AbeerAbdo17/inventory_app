import java.io.FileWriter;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class EDICNO {

    public static void main(String[] args) {
        String containerNo = "WEDU1765189";
        String lineCode = "1";

        // date range period
        LocalDate startDate = LocalDate.of(2025, 6, 28);
        LocalDate endDate = LocalDate.of(2025, 6, 30);

        generateEDIForContainer("codecoCNO.edi", containerNo, lineCode, startDate, endDate);
    }

    public static void generateEDIForContainer(String outputPath, String containerNo, String lineCode,
                                               LocalDate startDate, LocalDate endDate) {

        String jdbcURL = "jdbc:mysql://localhost:3306/k_shipping_db";
        String dbUser = "root";
        String dbPassword = "0000";

        String query = """
            SELECT 
                mast.mast_cno,
                mast.mast_ctype,
                mast.mast_status,
                mast.MAST_WEIGHT,
                mast.seal_no,
                mast.line,
                voys.voydate_time,
                voys.voyfrom,
                voys.vessel,
                voys.toport
            FROM mast
            JOIN voys ON mast.mast_vslvoy = voys.serial
            WHERE (
                (DATE(mast.del_date) BETWEEN ? AND ?) OR 
                (DATE(mast.mast_d_date) BETWEEN ? AND ?)
            ) AND mast.line = ? AND mast.mast_cno = ?
        """;

        try (
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            PreparedStatement stmt = conn.prepareStatement(query)
        ) {
            stmt.setDate(1, Date.valueOf(startDate)); // del_date
            stmt.setDate(2, Date.valueOf(endDate));
            stmt.setDate(3, Date.valueOf(startDate)); // mast_d_date
            stmt.setDate(4, Date.valueOf(endDate));
            stmt.setString(5, lineCode);
            stmt.setString(6, containerNo);
            

            ResultSet rs = stmt.executeQuery();

            StringBuilder edi = new StringBuilder();
            String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyMMdd:HHmm"));
            String ref = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));

            edi.append("UNB+UNOA:2+OMSOH+TMR+").append(now).append("+").append(ref).append("'\n");

            int count = 0;
            DateTimeFormatter inputFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

            while (rs.next()) {
                if (count == 0) {
                    edi.append("UNH+0000000000001+CODECO:D:95B:UN'\n");
                    edi.append("BGM+36+1+9'\n");
                }

                String type = rs.getString("mast_ctype");
                String status = rs.getString("mast_status");
                String readableStatus = translateStatus(status);
                String weight = rs.getString("MAST_WEIGHT");
                String seal = rs.getString("seal_no");
                String SHIPNAME = rs.getString("vessel");

                String gateInStr = rs.getString("voydate_time");
                if (gateInStr == null || gateInStr.trim().isEmpty()) {
                    System.out.println("️ Empty date for container: " + containerNo);
                    continue;
                }

                LocalDateTime localDateTime = LocalDateTime.parse(gateInStr.trim(), inputFormat);
                Timestamp gateInTime = Timestamp.valueOf(localDateTime);

                String location = rs.getString("voyfrom");
                String destination = rs.getString("toport");

                edi.append("TDT+20+12345+1++ESL:172+++::").append(SHIPNAME).append("'\n");
                edi.append("LOC+11+").append(location).append(":139:6'\n");
                edi.append("DTM+133:").append(formatDate(gateInTime)).append(":203'\n");
                edi.append("NAD+CA+TMR:160:20'\n");
                edi.append("GID+").append(String.format("%05d", count + 1)).append("'\n");
                edi.append("SGP+").append(containerNo).append("'\n");
                edi.append("EQD+CN+").append(containerNo).append("+").append(type).append(":102:5++").append(readableStatus).append("+5'\n");
                edi.append("DTM+7:").append(formatDate(gateInTime)).append(":203'\n");
                edi.append("LOC+9+").append(destination).append(":139:6'\n");
                edi.append("MEA+AAE+G+KGM:").append(weight).append("'\n");
                edi.append("SEL+").append(seal).append("'\n");
                edi.append("TDT+1++3+++++854WA:146'\n");
                count++;
            }

            if (count > 0) {
                edi.append("CNT+16:").append(count).append("'\n");
                edi.append("UNT+").append(16 + (count * 12)).append("+0000000000001'\n");
                edi.append("UNZ+1+").append(ref).append("'\n");

                try (FileWriter writer = new FileWriter(outputPath)) {
                    writer.write(edi.toString());
                    System.out.println(" Exported EDI Successfully: " + outputPath);
                }
            } else {
                System.out.println("️ No data found for container " + containerNo +
                                   " on line " + lineCode + " within the specified period.");
            }

        } catch (SQLException | IOException | RuntimeException e) {
            e.printStackTrace();
        }
    }

    private static String formatDate(Timestamp timestamp) {
        return timestamp.toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyyMMddHHmm"));
    }

    private static String translateStatus(String statusCode) {
        return switch (statusCode) {
            case "1" -> "empty for import";
            case "2" -> "loaded for import";
            case "3" -> "empty for export";
            case "4" -> "loaded for export";
            case "5" -> "empty returned";
            case "6" -> "loaded transshipment";
            case "7" -> "empty transshipment";
            case "8" -> "full storage";
            case "9" -> "empty storage";
            default -> "unknown";
        };
    }
}
