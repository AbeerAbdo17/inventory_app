import java.io.FileWriter;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

public class COARRI {

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
        mast.MAST_D_DATE,
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
        String nowUNB = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyMMdd:HHmm"));
        String controlRef = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));

        edi.append("UNB+UNOA:2+OMSOH+TMR+").append(nowUNB).append("+").append(controlRef).append("'\n");
        edi.append("UNH+00000000000001+COARRI:D:95B:UN'\n");
        edi.append("BGM+98+00000000000001+9'\n");

        int count = 0;
        DateTimeFormatter dateTimeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss[.SSS]");

        while (rs.next()) {
            String containerNo = rs.getString("mast_cno");
            String type = rs.getString("mast_ctype");
            String weight = rs.getString("MAST_WEIGHT");
            String seal = rs.getString("seal_no");
            String gateInStr = rs.getString("voydate_time");
            String location = rs.getString("voyfrom");
            String vessel = rs.getString("vessel");
            String voyageNo = rs.getString("voyageno");
            String mastDDateStr = rs.getString("MAST_D_DATE");
            String destination = rs.getString("toport");
            String destinationCode = getPortCode(conn, destination);
            String RFF = rs.getString("mast_blno");

            if (gateInStr == null || gateInStr.isBlank() || mastDDateStr == null || mastDDateStr.isBlank()) {
                System.out.println("Missing date for container " + containerNo);
                continue;
            }

            LocalDateTime gateInTime, mastDDate;
            try {
                gateInTime = LocalDateTime.parse(gateInStr.trim(), dateTimeFormat);
                mastDDate = LocalDateTime.parse(mastDDateStr.trim(), dateTimeFormat);
            } catch (DateTimeParseException ex) {
                System.err.println("Date parse error for container " + containerNo + ": " + ex.getMessage());
                continue;
            }

            edi.append("TDT+20+").append(voyageNo).append("+1++GFS:172:20+++")
               .append(voyageNo).append(":103::").append(vessel).append("'\n");
            edi.append("LOC+11+").append(location).append(":139:6+OICT:TER:ZZZ'\n");
            edi.append("DTM+133:").append(formatDate(gateInTime)).append(":203'\n");
            edi.append("DTM+178:").append(formatDate(mastDDate)).append(":203'\n");
            edi.append("NAD+CA+GFS:160:20'\n");
            edi.append("EQD+CN+").append(containerNo).append("+").append(type).append(":102:5++3+5'\n");
            edi.append("RFF+BM:").append(RFF).append("'\n");
            edi.append("DTM+203:").append(formatDate(gateInTime)).append(":203'\n");
            edi.append("LOC+9+").append(destinationCode).append(":139:6'\n");
            edi.append("LOC+11+").append(location).append(":139:6'\n");
            edi.append("LOC+83+").append(location).append(":139:6'\n");
            edi.append("LOC+147+0061282::5'\n");
            edi.append("MEA+WT+VGM+KGM:").append(weight).append("'\n");
            edi.append("SEL+").append(seal).append("'\n");

            count++;
        }

      if (count > 0) {
          edi.append("CNT+16:").append(count).append("'\n");
          edi.append("UNT+").append(18 + (count * 13)).append("+00000000000001'\n");
          edi.append("UNZ+1+").append(controlRef).append("'\n");
          
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


    } catch (SQLException e) {
        e.printStackTrace();
    }
}


    private static String formatDate(LocalDateTime dateTime) {
        return dateTime.format(DateTimeFormatter.ofPattern("yyyyMMddHHmm"));
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
