import java.io.FileWriter;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class EDI {

    public static void main(String[] args) {
        String lineCode = "1"; 
        generateEDIFromDB("somefile.edi", "2025-08-02 14:00:00", lineCode);
    }

  public static void generateEDIFromDB(String filename, String lastGeneratedTime, String lineCode){
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
        mast.mast_blno,
        mast.updated_at,  
        voys.voydate_time,
        voys.voyfrom,
        voys.voyageno,
        voys.vessel,
        voys.toport
    FROM mast
    JOIN voys ON mast.mast_vslvoy = voys.serial
    WHERE (mast.updated_at > ? OR voys.updated_at > ?) AND mast.line = ?
""";

  

    try (
        Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        PreparedStatement stmt = conn.prepareStatement(query)
    ) {
        stmt.setString(1, lastGeneratedTime);
        stmt.setString(2, lastGeneratedTime);  
        stmt.setString(3, lineCode);           

       ResultSet rs = stmt.executeQuery();

        StringBuilder edi = new StringBuilder();
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyMMdd:HHmm"));
        String ref = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));

        edi.append("UNB+UNOA:2+OMSOH+TMR+").append(now).append("+").append(ref).append("'\n");

        int count = 0;
        DateTimeFormatter inputFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss[.SSS]");

        while (rs.next()) {
            if (count == 0) {
                edi.append("UNH+0000000000001+CODECO:D:95B:UN'\n");
                edi.append("BGM+36+1+9'\n");
            }

            String containerNo = rs.getString("mast_cno");
            String type = rs.getString("mast_ctype");
            String status = rs.getString("mast_status");
            String weight = rs.getString("MAST_WEIGHT");
            String seal = rs.getString("seal_no");
            String SHIPNAME = rs.getString("vessel");

            String gateInStr = rs.getString("voydate_time");
            if (gateInStr == null || gateInStr.trim().isEmpty()) {
                System.out.println("empty date to container " + containerNo);
                continue;
            }

            LocalDateTime localDateTime = LocalDateTime.parse(gateInStr.trim(), inputFormat);
            Timestamp gateInTime = Timestamp.valueOf(localDateTime);

            String voyageNumber = rs.getString("voyageno");
            String location = rs.getString("voyfrom");
            String destination = rs.getString("toport");
            String destinationCode = getPortCode(conn, destination);
            String RFF = rs.getString("mast_blno");

            edi.append("TDT+20+").append(voyageNumber).append("+1++ESL:172+++").append(voyageNumber).append(":103::").append(SHIPNAME).append("'\n");
            edi.append("LOC+11+").append(location).append(":139:6'\n");
            edi.append("DTM+133:").append(formatDate(gateInTime)).append(":203'\n");
            edi.append("NAD+CA+TMR:160:20'\n");
            edi.append("GID+").append(String.format("%05d", count + 1)).append("'\n");
            edi.append("SGP+").append(containerNo).append("'\n");
            edi.append("EQD+CN+").append(containerNo).append("+").append(type).append(":102:5++").append(status).append("+5'\n");
            edi.append("RFF+BM:").append(RFF).append("'\n");
            edi.append("DTM+7:").append(formatDate(gateInTime)).append(":203'\n");
            edi.append("LOC+9+").append(destinationCode).append(":139:6'\n");
            edi.append("MEA+AAE+G+KGM:").append(weight).append("'\n");
            edi.append("SEL+").append(seal).append("'\n");
            edi.append("TDT+1++3+++++854WA:146'\n");

            count++;
        }

    if (count > 0) {
    edi.append("CNT+16:").append(count).append("'\n");
    edi.append("UNT+").append(16 + (count * 12)).append("+0000000000001'\n");
    edi.append("UNZ+1+").append(ref).append("'\n");

  
    String fileName = filename;
    try (FileWriter writer = new FileWriter(fileName)) {
        writer.write(edi.toString());
        System.out.println("Exported EDI Successfully: " + fileName);
    } catch (IOException e) {
        System.err.println("Error writing EDI file: " + e.getMessage());
    }

} else {
    System.out.println("No containers found to export.");
}


    } catch (SQLException | RuntimeException e) {
        e.printStackTrace();
    }
}


    private static String formatDate(Timestamp timestamp) {
        return timestamp.toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyyMMddHHmm"));
    }
    
    private static String getPortCode(Connection conn, String destination) throws SQLException {
    String portCode = "UNKNOWN";

    String query = "SELECT isopol FROM loct WHERE pol = ?";
    try (PreparedStatement stmt = conn.prepareStatement(query)) {
        stmt.setString(1, destination);
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                portCode = rs.getString("isopol");
            }
        }
    }

    return portCode;
}

}
