import com.opencsv.CSVParserBuilder;
import com.opencsv.CSVReader;
import com.opencsv.CSVReaderBuilder;

import javax.swing.*;
import java.io.File;
import java.io.FileReader;
import java.sql.*;
import java.util.Arrays;

public class csvtosql {

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            JFileChooser fileChooser = new JFileChooser();
            fileChooser.setDialogTitle("Select a CSV file");

            int result = fileChooser.showOpenDialog(null);

            if (result == JFileChooser.APPROVE_OPTION) {
                File selectedFile = fileChooser.getSelectedFile();
                String csvFilePath = selectedFile.getAbsolutePath();

                // Extract the file name to use as table name (without extension)
                String fileName = selectedFile.getName();
                String tableName = fileName.substring(0, fileName.lastIndexOf('.')).replaceAll("[^a-zA-Z0-9_]", "_");

                runImport(csvFilePath, tableName);
            } else {
                JOptionPane.showMessageDialog(null, "No file was selected.");
            }
        });
    }

    public static void runImport(String csvFilePath, String tableName) {
        String jdbcURL = "jdbc:mysql://localhost:3306/abtest?useUnicode=true&characterEncoding=UTF-8";
        String username = "root";
        String password = "0000";

        char separator = ',';

        try (
            Connection conn = DriverManager.getConnection(jdbcURL, username, password);
            FileReader fileReader = new FileReader(csvFilePath);
            CSVReader reader = new CSVReaderBuilder(fileReader)
                    .withCSVParser(new CSVParserBuilder()
                            .withSeparator(separator)
                            .withQuoteChar('"')
                            .withIgnoreQuotations(false)
                            .build())
                    .build()
        ) {
            conn.setAutoCommit(false);

            String[] headers = reader.readNext();
            if (headers == null) {
                JOptionPane.showMessageDialog(null, "❌ The file is empty or has no headers.");
                return;
            }

            // Automatically create the table
            StringBuilder createSQL = new StringBuilder("CREATE TABLE IF NOT EXISTS `" + tableName + "` (");
            for (int i = 0; i < headers.length; i++) {
                createSQL.append("`").append(headers[i].trim()).append("` TEXT");
                if (i < headers.length - 1) createSQL.append(", ");
            }
            createSQL.append(");");

            conn.createStatement().execute(createSQL.toString());

            // Prepare insert statement
            StringBuilder insertSQL = new StringBuilder("INSERT INTO `" + tableName + "` (");
            insertSQL.append(String.join(", ", Arrays.stream(headers).map(h -> "`" + h.trim() + "`").toArray(String[]::new)));
            insertSQL.append(") VALUES (");
            insertSQL.append("?,".repeat(headers.length));
            insertSQL.setLength(insertSQL.length() - 1);
            insertSQL.append(");");

            PreparedStatement insertStmt = conn.prepareStatement(insertSQL.toString());

            String[] row;
            int insertedCount = 0;
            int ignoredCount = 0;

            while ((row = reader.readNext()) != null) {
                if (row.length != headers.length) {
                    ignoredCount++;
                    continue;
                }

                for (int i = 0; i < headers.length; i++) {
                    insertStmt.setString(i + 1, i < row.length ? row[i] : null);
                }

                insertStmt.addBatch();
                insertedCount++;

                if (insertedCount % 100 == 0) {
                    insertStmt.executeBatch();
                }
            }

            insertStmt.executeBatch();
            conn.commit();

            JOptionPane.showMessageDialog(null,
                    "✅ Exported Successfully!\n" +
                    "📁 Table name: " + tableName + "\n" +
                    "✅ Rows inserted: " + insertedCount + "\n" +
                    "❌ Rows ignored: " + ignoredCount,
                    "Success", JOptionPane.INFORMATION_MESSAGE
            );

        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "❌ Error during import:\n" + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
            e.printStackTrace();
        }
    }
}
