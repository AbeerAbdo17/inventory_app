import javax.swing.*;
import java.awt.*;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class EDIForm extends JFrame {

    private final JComboBox<String> modeComboBox;
    private final JComboBox<LineItem> lineComboBox;
    private final JButton startButton;
    private final JTextField sinceField;
    private Connection conn;

    public EDIForm() {
        setTitle("EDI File Generator");
        setSize(500, 350);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        getContentPane().setBackground(new Color(245, 245, 245));
        setFont(new Font("Arial", Font.PLAIN, 14));

        JPanel panel = new JPanel();
        panel.setLayout(new GridBagLayout());
        panel.setBackground(new Color(245, 245, 245));
        panel.setComponentOrientation(ComponentOrientation.LEFT_TO_RIGHT);

        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(10, 20, 10, 20);
        gbc.fill = GridBagConstraints.HORIZONTAL;
        gbc.gridx = 0;

        modeComboBox = new JComboBox<>(new String[]{
            "No Sending",
            "Auto Every 2 Minutes",
            "Manual Sending"
        });

        lineComboBox = new JComboBox<>();
        sinceField = new JTextField(LocalDateTime.now().minusDays(1)
                .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

        startButton = new JButton("Start");
        startButton.setBackground(new Color(70, 130, 180));
        startButton.setForeground(Color.WHITE);
        startButton.setFocusPainted(false);

        addField(panel, gbc, "Select Mode:", modeComboBox);
        addField(panel, gbc, "Select Shipping Line:", lineComboBox);
        addField(panel, gbc, "Since:", sinceField);

        gbc.gridx = 0;
        gbc.gridy++;
        gbc.gridwidth = 2;
        panel.add(startButton, gbc);

        add(panel);
        startButton.addActionListener(e -> startProcess());

        connectToDatabase();      // Establish DB connection
        loadLinesFromDatabase();  // Load line names from DB
    }

    private void addField(JPanel panel, GridBagConstraints gbc, String label, JComponent component) {
        gbc.gridy++;
        gbc.gridwidth = 1;
        panel.add(new JLabel(label, SwingConstants.RIGHT), gbc);
        gbc.gridx = 1;
        panel.add(component, gbc);
        gbc.gridx = 0;
    }

    private void startProcess() {
        String mode = (String) modeComboBox.getSelectedItem();
        LineItem selectedLine = (LineItem) lineComboBox.getSelectedItem();
        String lineCode = selectedLine != null ? selectedLine.getId() : "";
        String sinceStr = sinceField.getText().trim();

        switch (mode) {
            case "Auto Every 2 Minutes" -> {
                EDIWatcher.startWatching();
                JOptionPane.showMessageDialog(this, "Auto generation started.");
            }
            case "Manual Sending" -> {
                generateFiles(sinceStr, lineCode);
                JOptionPane.showMessageDialog(this, "Manual sending completed.");
            }
            default -> JOptionPane.showMessageDialog(this, "No sending mode selected. Nothing will be done.");
        }
    }

    private void generateFiles(String sinceStr, String lineCode) {
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
        String ediFileName = "codeco_" + timestamp + ".edi";
        String coarriFileName = "coarri_" + timestamp + ".edi";

        EDI.generateEDIFromDB(ediFileName, sinceStr, lineCode);
        COARRI.generateEDIFromDB(coarriFileName, sinceStr, lineCode);
    }

    private void connectToDatabase() {
        try {
          String jdbcURL = "jdbc:mysql://localhost:3306/k_shipping_db";
          String dbUser = "root";
          String dbPassword = "0000";
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, "Database connection error: " + ex.getMessage());
        }
    }

    private void loadLinesFromDatabase() {
        try {
            String query = "SELECT id, name FROM line";
            try (PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
                
                while (rs.next()) {
                    String id = rs.getString("id");
                    String name = rs.getString("name");
                    lineComboBox.addItem(new LineItem(id, name));
                }
                
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, "Error loading shipping lines: " + ex.getMessage());
        }
    }

    private static class LineItem {
        private final String id;
        private final String name;

        public LineItem(String id, String name) {
            this.id = id;
            this.name = name;
        }

        public String getId() {
            return id;
        }

        @Override
        public String toString() {
            return name;
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new EDIForm().setVisible(true));
    }
}
