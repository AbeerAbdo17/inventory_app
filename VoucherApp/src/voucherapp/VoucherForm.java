package voucherapp;

//import acc.Frmlogin;
//import acc.Frmmain;
import javax.swing.*;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.table.*;
import javax.swing.text.JTextComponent;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Vector;
import java.util.HashMap;
import java.awt.print.PrinterException;

public class VoucherForm extends JFrame {
    private JTable table;
    private DefaultTableModel model;
    private JButton saveButton, deleteButton;
    private JComboBox<String> accBox;
    private JComboBox<String> accNameBox;
    private JTextField voucherNoField;
    private JTextField dateField;
    private JTextField searchField;
    private HashMap<String, String> accToName = new HashMap<>();
    private HashMap<String, String> nameToAcc = new HashMap<>();
    private int currentVoucherNo;
    private int currentTopNo;
    private boolean isNewVoucher = true;
    private JTextField referenceField;

    
    private JLabel drTotalLabel;
    private JLabel crTotalLabel;

    public VoucherForm() {
        ImageIcon printIcon = resizeIcon("/voucherapp/icons/printer-32.png", 32, 32);
        JButton printButton = new JButton("Print", printIcon);
        printButton.setPreferredSize(new Dimension(120, 40));
        printButton.setHorizontalTextPosition(SwingConstants.RIGHT);
        printButton.setIconTextGap(10);


       ImageIcon saveIcon = resizeIcon("/voucherapp/icons/save-32.png", 32, 32);
       ImageIcon deleteIcon = resizeIcon("/voucherapp/icons/trash-2-32.png", 32, 32);
       ImageIcon backIcon = resizeIcon("/voucherapp/icons/power-32.png", 32, 32);
           
        Font uiFont = new Font("Times New Roman", Font.BOLD, 14);
        UIManager.put("Label.font", uiFont);
        UIManager.put("Button.font", uiFont);
        UIManager.put("TextField.font", uiFont);
        UIManager.put("ComboBox.font", uiFont);
        UIManager.put("Table.font", uiFont);
        UIManager.put("TableHeader.font", uiFont);

        setTitle("Voucher Entry");
        setSize(900, 500);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setLayout(new BorderLayout());

        // Top panel for voucher metadata
        JPanel topPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
        topPanel.setBorder(BorderFactory.createTitledBorder("Voucher Info"));

        // Initialize voucher number
        voucherNoField = new JTextField(10);
        currentTopNo = fetchTopNoFromYearTopNo();
        currentVoucherNo = currentTopNo;
        voucherNoField.setText(String.valueOf(currentVoucherNo));
        voucherNoField.setEditable(false);

        // Initialize date field with today's date
        dateField = new JTextField(10);
        dateField.setText(java.time.LocalDate.now().toString());
        dateField.setEditable(true);
        dateField.setToolTipText("Enter the date in the format yyyy-MM-dd");
        
        // Search field for filtering vouchers
        searchField = new JTextField(15);
        searchField.setToolTipText("Search");

        JLabel searchIcon = new JLabel(resizeIcon("/voucherapp/icons/search-3-32.png", 20, 20));
        
        
        
//printButton.addActionListener(e -> {
//   if (table.getRowCount() == 0) {
//        JOptionPane.showMessageDialog(this, 
//            "No data to print.", 
//            "Warning", 
//            JOptionPane.WARNING_MESSAGE);
//        return; // Stop the process
//    }
//
//    String headerText = String.format(
//        "Voucher No: %s    Date: %s    Reference: %s",
//        voucherNoField.getText(),
//        dateField.getText(),
//        referenceField.getText()
//    );
//
//    try {
//        boolean complete = table.print(
//            JTable.PrintMode.FIT_WIDTH,
//            new java.text.MessageFormat(headerText),
//            null
//        );
//        if (complete) {
//            JOptionPane.showMessageDialog(this, "Printing completed successfully.");
//        } else {
//            JOptionPane.showMessageDialog(this, "Printing was canceled.");
//        }
//    } catch (PrinterException ex) {
//        ex.printStackTrace();
//        JOptionPane.showMessageDialog(this, "An error occurred while printing: " + ex.getMessage());
//    }
//});




        topPanel.add(new JLabel("Voucher No:"));
        topPanel.add(voucherNoField);
        topPanel.add(new JLabel("Date:"));
        topPanel.add(dateField);
        
        
        referenceField = new JTextField(10);
        topPanel.add(new JLabel("Reference:"));
        topPanel.add(referenceField);
        
        JPanel searchPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 5, 0));

        searchPanel.add(new JLabel("Search:"));
        searchPanel.add(searchIcon);
        searchPanel.add(searchField);

        topPanel.add(searchPanel, BorderLayout.EAST);

        add(topPanel, BorderLayout.NORTH);

        model = new DefaultTableModel(new String[]{"Acc No", "Acc Name", "Dr", "Cr", "Description"}, 0) {
            public boolean isCellEditable(int row, int col) {
                return true; 
            }
        };

        table = new JTable(model);
        table.setRowHeight(25);

        accBox = new JComboBox<>();
        accBox.setEditable(true);

        accNameBox = new JComboBox<>();
        accNameBox.setEditable(true);

        TableColumn accCol = table.getColumnModel().getColumn(0);
        TableColumn accNameCol = table.getColumnModel().getColumn(1);
        accCol.setCellEditor(new DefaultCellEditor(accBox));
        accNameCol.setCellEditor(new DefaultCellEditor(accNameBox));

        add(new JScrollPane(table), BorderLayout.CENTER);

        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
         JButton backButton = new JButton("Back", backIcon);
        backButton.addActionListener(e -> {
        dispose(); 
        // new Frmmain().setVisible(true); 
        });
        buttonPanel.add(backButton);
        saveButton = new JButton("Save", saveIcon);
        
        deleteButton = new JButton("Delete", deleteIcon);
        buttonPanel.add(deleteButton);
        buttonPanel.add(printButton);
        buttonPanel.add(saveButton);

        drTotalLabel = new JLabel("Dr Total: 0.00");
        crTotalLabel = new JLabel("Cr Total: 0.00");
        buttonPanel.add(drTotalLabel);
        buttonPanel.add(crTotalLabel);

        add(buttonPanel, BorderLayout.SOUTH);

        model.addRow(new Object[]{"", "", "", "", ""});

        // actions
   
       saveButton.addActionListener(e -> {
       if (isNewVoucher) {
        int lastTopNo = fetchTopNoFromYearTopNo();
        currentVoucherNo = lastTopNo;
        currentTopNo = currentVoucherNo;
        voucherNoField.setText(String.valueOf(currentVoucherNo));
        }
        saveData();
       });

        deleteButton.addActionListener(e -> deleteVoucher());

        saveButton.setPreferredSize(new Dimension(120, 40));
        deleteButton.setPreferredSize(new Dimension(120, 40));
        backButton.setPreferredSize(new Dimension(120, 40));

        saveButton.setHorizontalTextPosition(SwingConstants.RIGHT); 
        saveButton.setIconTextGap(10);
        deleteButton.setHorizontalTextPosition(SwingConstants.RIGHT);
        deleteButton.setIconTextGap(10);
        backButton.setHorizontalTextPosition(SwingConstants.RIGHT);
        backButton.setIconTextGap(10);

        // Listen for table changes to update logic and totals
        model.addTableModelListener(e -> {
            int row = e.getFirstRow();
            int col = e.getColumn();
            if (row < 0 || row >= model.getRowCount()) return;

            String acc = (String) model.getValueAt(row, 0);
            String name = (String) model.getValueAt(row, 1);

            // Auto-sync account and name columns
            if (col == 0 && acc != null && !acc.isEmpty()) {
                String correctName = getNameByAcc(acc);
                if (correctName != null && !correctName.equals(name)) {
                    model.setValueAt(correctName, row, 1);
                }
            } else if (col == 1 && name != null && !name.isEmpty()) {
                String correctAcc = getAccByName(name);
                if (correctAcc != null && !correctAcc.equals(acc)) {
                    model.setValueAt(correctAcc, row, 0);
                }
            }

            // Ensure only one of Dr/Cr is non-zero
            if (col == 2) {
                Object drVal = model.getValueAt(row, 2);
                if (drVal != null && !drVal.toString().equals("0") && !drVal.toString().isEmpty()) {
                    model.setValueAt("0", row, 3);
                }
            } else if (col == 3) {
                Object crVal = model.getValueAt(row, 3);
                if (crVal != null && !crVal.toString().equals("0") && !crVal.toString().isEmpty()) {
                    model.setValueAt("0", row, 2);
                }
            }
            
          if (isNewVoucher) {
            // If last row is filled, add a new blank row
            if (row == model.getRowCount() - 1) {
                String accVal = (String) model.getValueAt(row, 0);
                String nameVal = (String) model.getValueAt(row, 1);
                Object drVal = model.getValueAt(row, 2);
                Object crVal = model.getValueAt(row, 3);

                if ((accVal != null && !accVal.isEmpty()) &&
                    (nameVal != null && !nameVal.isEmpty()) &&
                    ((drVal != null && !drVal.toString().isEmpty() && !drVal.toString().equals("0")) ||
                     (crVal != null && !crVal.toString().isEmpty() && !crVal.toString().equals("0")))) {

                    boolean hasEmpty = false;
                    for (int i = 0; i < model.getRowCount(); i++) {
                        boolean allEmpty = true;
                        for (int j = 0; j < model.getColumnCount(); j++) {
                            Object val = model.getValueAt(i, j);
                            if (val != null && !val.toString().trim().isEmpty()) {
                                allEmpty = false;
                                break;
                            }
                        }
                        if (allEmpty) {
                            hasEmpty = true;
                            break;
                        }
                    }

                    if (!hasEmpty) {
                        model.addRow(new Object[]{"", "", "", "", ""});
                    }
                }
            }
          }
            // Recalculate and display total debits and credits
            double drSum = 0.0;
            double crSum = 0.0;
            for (int i = 0; i < model.getRowCount(); i++) {
                Object drVal = model.getValueAt(i, 2);
                Object crVal = model.getValueAt(i, 3);
                if (drVal != null && !drVal.toString().isEmpty()) {
                    try { drSum += Double.parseDouble(drVal.toString()); } catch (NumberFormatException ex) {}
                }
                if (crVal != null && !crVal.toString().isEmpty()) {
                    try { crSum += Double.parseDouble(crVal.toString()); } catch (NumberFormatException ex) {}
                }
            }
            drTotalLabel.setText(String.format("Dr Total: %.2f", drSum));
            crTotalLabel.setText(String.format("Cr Total: %.2f", crSum));
        });

        // Dynamic search for accBox
        setupDynamicSearch(accBox, true);
        // Dynamic search for accNameBox
        setupDynamicSearch(accNameBox, false);

        // Filter/search as user types in voucher search field
        searchField.getDocument().addDocumentListener(new DocumentListener() {
            public void insertUpdate(DocumentEvent e) { performSearch(searchField.getText().trim()); }
            public void removeUpdate(DocumentEvent e) { performSearch(searchField.getText().trim()); }
            public void changedUpdate(DocumentEvent e) { performSearch(searchField.getText().trim()); }
        });
    }
    
    public void updateTopNo(int newTopNo) {
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement("UPDATE yeartopno SET topno = ?")) {

        stmt.setInt(1, newTopNo);
        stmt.executeUpdate();

    } catch (SQLException e) {
        e.printStackTrace();
    }
    }


    private ImageIcon resizeIcon(String path, int width, int height) {
    try {
        ImageIcon icon = new ImageIcon(getClass().getResource(path));
        Image img = icon.getImage();
        Image newImg = img.getScaledInstance(width, height, Image.SCALE_SMOOTH);
        return new ImageIcon(newImg);
    } catch (Exception e) {
        System.err.println("Icon not found: " + path);
        return null;
    }
    }

    // Setup dynamic search
    private void setupDynamicSearch(JComboBox<String> combo, boolean isAcc) {
        combo.setEditable(true);
        JTextComponent editor = (JTextComponent) combo.getEditor().getEditorComponent();

        editor.addKeyListener(new KeyAdapter() {
            @Override
            public void keyReleased(KeyEvent e) {
                String text = editor.getText();
                if (text.length() >= 1) { //after first litter
                    Vector<String> results = isAcc ? fetchAccFromDB(text) : fetchAccNameFromDB(text);
                    DefaultComboBoxModel<String> model = new DefaultComboBoxModel<>(results);
                    combo.setModel(model);
                    editor.setText(text);
                    combo.showPopup();
                } else {
                    combo.hidePopup();
                }
            }
        });
    }

    /**
     * Fetch account codes from DB matching keyword
     */
    private Vector<String> fetchAccFromDB(String keyword) {
        Vector<String> list = new Vector<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "SELECT SUBMAIN_NO FROM submain WHERE SUBMAIN_NO LIKE ? OR SUBMAIN_NAME LIKE ? LIMIT 20")) {
            String pattern = "%" + keyword + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String acc = rs.getString("SUBMAIN_NO");
                list.add(acc);
                // cache in hashmap for quick lookup
                if (!accToName.containsKey(acc)) {
                    String name = fetchNameByAcc(acc);
                    if (name != null) {
                        accToName.put(acc, name);
                        nameToAcc.put(name, acc);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Fetch account names from DB matching keyword
     */
    private Vector<String> fetchAccNameFromDB(String keyword) {
        Vector<String> list = new Vector<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "SELECT SUBMAIN_NAME FROM submain WHERE SUBMAIN_NAME LIKE ? OR SUBMAIN_NO LIKE ? LIMIT 20")) {
            String pattern = "%" + keyword + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String name = rs.getString("SUBMAIN_NAME");
                list.add(name);
                // cache in hashmap for quick lookup
                if (!nameToAcc.containsKey(name)) {
                    String acc = fetchAccByName(name);
                    if (acc != null) {
                        nameToAcc.put(name, acc);
                        accToName.put(acc, name);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Get account name by acc code from cache or DB
     */
    private String getNameByAcc(String acc) {
        if (accToName.containsKey(acc)) return accToName.get(acc);
        String name = fetchNameByAcc(acc);
        if (name != null) {
            accToName.put(acc, name);
            nameToAcc.put(name, acc);
        }
        return name;
    }

    /**
     * Get account code by name from cache or DB
     */
    private String getAccByName(String name) {
        if (nameToAcc.containsKey(name)) return nameToAcc.get(name);
        String acc = fetchAccByName(name);
        if (acc != null) {
            nameToAcc.put(name, acc);
            accToName.put(acc, name);
        }
        return acc;
    }

    /**
     * Fetch acc name from DB by acc code
     */
    private String fetchNameByAcc(String acc1) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT SUBMAIN_NAME FROM submain WHERE SUBMAIN_NO = ?")) {
            ps.setString(1, acc1);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("SUBMAIN_NAME");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Fetch acc code from DB by acc name
     */
    private String fetchAccByName(String name) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT SUBMAIN_NO FROM submain WHERE SUBMAIN_NAME = ?")) {
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("SUBMAIN_NO");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /** Reset form to new voucher state */
   private void resetForm() {
       dateField.setText(LocalDate.now().toString());
        model.setRowCount(0);
        model.addRow(new Object[]{"", "", "", "", ""});
        referenceField.setText("");
        currentTopNo = fetchTopNoFromYearTopNo();
        currentVoucherNo = currentTopNo;
        voucherNoField.setText(String.valueOf(currentVoucherNo));
        isNewVoucher = true;
    }

    /** Delete current voucher from journal table */
    private void deleteVoucher() {
    int confirm = JOptionPane.showConfirmDialog(this, "Do you want to delete the current voucher?", "Delete Confirmation", JOptionPane.YES_NO_OPTION);
    if (confirm != JOptionPane.YES_OPTION) return;

    try (Connection conn = DBConnection.getConnection()) {
        conn.setAutoCommit(false); // نبدأ عملية حذف متكاملة

        // حذف من journal
        PreparedStatement psJournal = conn.prepareStatement("DELETE FROM journal WHERE JOURNAL_NO = ?");
        psJournal.setString(1, voucherNoField.getText());
        int rows = psJournal.executeUpdate();

        if (rows > 0) {
             PreparedStatement psTopno = conn.prepareStatement("DELETE FROM yeartopno WHERE topno = ?");
             int topnoToDelete = Integer.parseInt(voucherNoField.getText());
                    psTopno.setInt(1, topnoToDelete);
                    psTopno.executeUpdate();

            conn.commit(); // تنفيذ الحذف

            JOptionPane.showMessageDialog(this, "Voucher deleted successfully.");
            resetForm();
        } else {
            JOptionPane.showMessageDialog(this, "No voucher found to delete.");
            conn.rollback(); // إلغاء العملية إذا لم يتم الحذف
        }

    } catch (Exception e) {
        e.printStackTrace();
        JOptionPane.showMessageDialog(this, "Error deleting voucher.");
    }
}

    /** Fetch next voucher sequential number from yeartopno table */
    private int fetchTopNoFromYearTopNo() {
        int next = 1;
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT MAX(topno) AS max_no FROM yeartopno where SYSYEAR = '2025'")) {
            if (rs.next() && rs.getInt("max_no") > 0) {
                next = rs.getInt("max_no") + 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return next;
    }

    /** Insert new top number in yeartopno table */
    private void insertTopNo(int topno) {
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO yeartopno (topno, sysyear) VALUES (?,?)");
            ps.setInt(1, topno);
            ps.setInt(2, 2025);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /** Save voucher data to the database */
    private void saveData() {
        
        // date check
     String inputDate = dateField.getText().trim();
     DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
     LocalDate inputLocalDate;
     try {
     inputLocalDate = LocalDate.parse(inputDate, formatter);
     } catch (Exception ex) {
     JOptionPane.showMessageDialog(this, "Invalid date format. Expected format: yyyy-MM-dd\n");
     return; 
     }

     if (inputLocalDate.isAfter(LocalDate.now())) {
     JOptionPane.showMessageDialog(this, "Date cannot be in the future.");
     return;
     }


        
        if (table.isEditing()) {
        table.getCellEditor().stopCellEditing();
     }
        
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            // If editing, delete previous lines
            if (!isNewVoucher) {
                PreparedStatement del = conn.prepareStatement("DELETE FROM journal WHERE JOURNAL_NO = ?");
                del.setInt(1, currentVoucherNo);
                del.executeUpdate();
            }

            // Prepare insert statement
            PreparedStatement ps = conn.prepareStatement("INSERT INTO journal (JOURNAL_NO, JOURNAL_SUBMAIN_NO, JOURNAL_DR, JOURNAL_CR, JOURNAL_DESC, JOURNAL_DATE, JOURNAL_DOCNO) VALUES (?, ?, ?, ?, ?, ?, ?)");

            boolean hasValidData = false;
            double totalDr = 0.0;
            double totalCr = 0.0;

            // Iterate table rows
           for (int i = 0; i < model.getRowCount(); i++) {
           String acc = (String) model.getValueAt(i, 0);
           String desc = model.getValueAt(i, 4) != null ? model.getValueAt(i, 4).toString().trim() : "";
           double dr = model.getValueAt(i, 2) != null && !model.getValueAt(i, 2).toString().isEmpty()
           ? Double.parseDouble(model.getValueAt(i, 2).toString()) : 0.0;
           double cr = model.getValueAt(i, 3) != null && !model.getValueAt(i, 3).
           toString().isEmpty() ? Double.parseDouble(model.getValueAt(i, 3).toString()) : 0.0;

          if ((acc == null || acc.isEmpty()) && desc.isEmpty() && dr == 0.0 && cr == 0.0) {
          continue;
         }

    
        if (!isAccExists(acc)) {
        JOptionPane.showMessageDialog(this, "account " + acc + " does not exist.");
        return; 
        }
 
       totalDr += dr;
       totalCr += cr;
       hasValidData = true;

       ps.setInt(1, currentVoucherNo);
       ps.setString(2, acc);
       ps.setDouble(3, dr);
       ps.setDouble(4, cr);
       ps.setString(5, desc);
       ps.setString(6, dateField.getText());
       ps.setString(7, referenceField.getText());
//       ps.setString(8, Frmlogin.myname);

       ps.addBatch();
      }
            // Validate input data
            if (!hasValidData) {
                JOptionPane.showMessageDialog(this, "No data to save.");
                return;
            }
            if (Math.abs(totalDr - totalCr) > 0.001) {
                JOptionPane.showMessageDialog(this, "Debit and credit totals must match.");
                return;
            }

            // Execute batch insert
            ps.executeBatch();
            conn.commit();

            if (isNewVoucher) {
                insertTopNo(currentTopNo);
            }
            isNewVoucher = false;

            JOptionPane.showMessageDialog(this, "Saved successfully.");
        } catch (Exception ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(this, "Error saving data.");
        }

        // Reset form after save
        resetForm();
        drTotalLabel.setText("Dr Total: 0.00");
        crTotalLabel.setText("Cr Total: 0.00");
        dateField.setText(LocalDate.now().toString());
    }

    /** Filter vouchers based on search text */
     private void performSearch(String keyword) {
     if (keyword.isEmpty()) {
        resetForm();
        return;
     }

     try (Connection conn = DBConnection.getConnection()) {
         
         String currentYear = "2025";
        // أولاً نبحث عن أول قيد يطابق الكلمة
PreparedStatement findVoucher = conn.prepareStatement(
    "SELECT j.JOURNAL_NO, j.JOURNAL_DOCNO, j.JOURNAL_DATE " +
    "FROM journal j " +
    "LEFT JOIN submain s ON j.JOURNAL_SUBMAIN_NO = s.SUBMAIN_NO " +
    "WHERE j.JOURNAL_NO IN (SELECT TOPNO FROM yeartopno WHERE SYSYEAR = ?) " +
    "AND YEAR(j.JOURNAL_DATE) = ? AND (" +
    "CAST(j.JOURNAL_NO AS CHAR) LIKE ? OR " +
    "CAST(j.JOURNAL_SUBMAIN_NO AS CHAR) LIKE ? OR " +
    "j.JOURNAL_DESC LIKE ? OR " +
    "s.SUBMAIN_NAME LIKE ? ) " +
    "ORDER BY j.JOURNAL_DATE DESC, j.JOURNAL_NO DESC LIMIT 1"
);





     String pattern = "%" + keyword + "%";
    findVoucher.setString(1, currentYear);
    findVoucher.setString(2, currentYear);
        for (int i = 3; i <= 6; i++) {
            findVoucher.setString(i, pattern);
        }

        ResultSet rs1 = findVoucher.executeQuery();
        if (rs1.next()) {
            dateField.setText(rs1.getString("JOURNAL_DATE"));
            referenceField.setText(rs1.getString("JOURNAL_DOCNO"));
            currentVoucherNo = rs1.getInt("JOURNAL_NO");
            voucherNoField.setText((String.valueOf(currentVoucherNo)));
            isNewVoucher = false;

            System.out.println("Matched JOURNAL_NO: " + rs1.getString("JOURNAL_NO"));
System.out.println("Matched JOURNAL_DATE: " + rs1.getString("JOURNAL_DATE"));

            // all row with same voucheer no
       PreparedStatement ps = conn.prepareStatement(
    "SELECT j.JOURNAL_SUBMAIN_NO, s.SUBMAIN_NAME, j.JOURNAL_DR, j.JOURNAL_CR, j.JOURNAL_DESC " +
    "FROM journal j " +
    "LEFT JOIN submain s ON j.JOURNAL_SUBMAIN_NO = s.SUBMAIN_NO " +
    "JOIN yeartopno y ON j.JOURNAL_NO = y.TOPNO " +
    "WHERE j.JOURNAL_NO = ? AND y.SYSYEAR = ? AND YEAR(j.JOURNAL_DATE) = ?"
);
           ps.setInt(1, currentVoucherNo);
ps.setString(2, currentYear);
ps.setString(3, currentYear);

            ResultSet rs2 = ps.executeQuery();
            model.setRowCount(0);
            while (rs2.next()) {
                model.addRow(new Object[]{
                    rs2.getString("JOURNAL_SUBMAIN_NO"),
                    rs2.getString("SUBMAIN_NAME"),
                    rs2.getString("JOURNAL_DR"),
                    rs2.getString("JOURNAL_CR"),
                    rs2.getString("JOURNAL_DESC")
                });
            }

         } else {
            voucherNoField.setText("");
            isNewVoucher = true;
         }

         } catch (Exception e) {
        e.printStackTrace();
        JOptionPane.showMessageDialog(this, "Error during search.");
     }
}
    private boolean isAccExists(String acc1) {
        Connection conn = DBConnection.getConnection();
    if (acc1 == null || acc1.trim().isEmpty()) return false;
    try (
         PreparedStatement ps = conn.prepareStatement("SELECT 1 FROM submain WHERE SUBMAIN_NO = ?")) {
        ps.setString(1, acc1);
        ResultSet rs = ps.executeQuery();
        return rs.next();
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}
    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new VoucherForm().setVisible(true));
    }
}
