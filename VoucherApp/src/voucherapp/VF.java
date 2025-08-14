package voucherapp;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import javax.swing.text.JTextComponent;
import java.awt.*;
import java.awt.event.*;
import java.sql.*;
import java.util.Vector;

public class VF extends JFrame {
    private JComboBox<String> fromAccountCombo, toAccountCombo;
    private JTextField amountField, descriptionField, searchField;
    private JButton saveButton, deleteButton, newButton;
    private JTable table;
    private DefaultTableModel model;
    private int currentVoucherNo = -1;

    public VF() {
        setTitle("Voucher Form");
        setSize(800, 600);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(EXIT_ON_CLOSE);

        JPanel mainPanel = new JPanel(new BorderLayout(10, 10));
        mainPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
        add(mainPanel);

        JPanel formPanel = new JPanel(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(5, 5, 5, 5);
        gbc.fill = GridBagConstraints.HORIZONTAL;

        fromAccountCombo = new JComboBox<>();
        fromAccountCombo.setEditable(true);
        toAccountCombo = new JComboBox<>();
        toAccountCombo.setEditable(true);
        amountField = new JTextField();
        descriptionField = new JTextField();

        saveButton = new JButton("حفظ");
        deleteButton = new JButton("حذف");

        // Back button
       JButton backButton = new JButton("رجوع");
       backButton.setFont(new Font("SansSerif", Font.PLAIN, 13));
       backButton.setFocusPainted(false);
       backButton.setBackground(new Color(230, 230, 230));
       backButton.setPreferredSize(new Dimension(100, 30));
       backButton.addActionListener(e -> {
       this.dispose();
      // new Frmmain().setVisible(true);
       });

       JPanel backPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
       backPanel.setComponentOrientation(ComponentOrientation.RIGHT_TO_LEFT);
       backPanel.add(backButton);

        
        newButton = new JButton("جديد");
        newButton.addActionListener(e -> {
        currentVoucherNo = -1;
        clearForm();
        });
        

        JPanel bottomPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        formPanel.setComponentOrientation(ComponentOrientation.RIGHT_TO_LEFT);
        bottomPanel.add(backButton);
        add(bottomPanel, BorderLayout.SOUTH);

        int row = 0;

        gbc.gridx = 0; gbc.gridy = row;
        formPanel.add(new JLabel("من حساب"), gbc);
        gbc.gridx = 1;
        formPanel.add(fromAccountCombo, gbc);

        row++;
        gbc.gridx = 0; gbc.gridy = row;
        formPanel.add(new JLabel("الي حساب"), gbc);
        gbc.gridx = 1;
        formPanel.add(toAccountCombo, gbc);

        row++;
        gbc.gridx = 0; gbc.gridy = row;
        formPanel.add(new JLabel("المبلغ"), gbc);
        gbc.gridx = 1;
        formPanel.add(amountField, gbc);

        row++;
        gbc.gridx = 0; gbc.gridy = row;
        formPanel.add(new JLabel("الوصف"), gbc);
        gbc.gridx = 1;
        formPanel.add(descriptionField, gbc);

        row++;
        gbc.gridx = 0; gbc.gridy = row; gbc.gridwidth = 2;
        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 10, 0));
        buttonPanel.add(saveButton);
        buttonPanel.add(deleteButton);
        buttonPanel.add(newButton);
        formPanel.add(buttonPanel, gbc);

        searchField = new JTextField(15);
        searchField.getDocument().addDocumentListener(new javax.swing.event.DocumentListener() {
        public void insertUpdate(javax.swing.event.DocumentEvent e) {
            searchVouchers();
        }

        public void removeUpdate(javax.swing.event.DocumentEvent e) {
            searchVouchers();
        } 

        public void changedUpdate(javax.swing.event.DocumentEvent e) {
            searchVouchers();
        }
        });

        
        JPanel searchPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        searchPanel.setComponentOrientation(ComponentOrientation.RIGHT_TO_LEFT);
        searchPanel.add(new JLabel("بحث"));
        searchPanel.add(searchField);
        
        JPanel topPanel = new JPanel(new BorderLayout());
        topPanel.add(formPanel, BorderLayout.NORTH);
        topPanel.add(searchPanel, BorderLayout.SOUTH);

        mainPanel.add(topPanel, BorderLayout.NORTH);


        model = new DefaultTableModel(new String[]{"رقم القيد", "من حساب", "الي حساب", "المبلغ", "الوصف"}, 0) {
            
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };
        table = new JTable(model);
        table.setComponentOrientation(ComponentOrientation.RIGHT_TO_LEFT);
        JScrollPane scrollPane = new JScrollPane(table);
//        scrollPane.setBorder(BorderFactory.createTitledBorder("Entries"));
        mainPanel.add(scrollPane, BorderLayout.CENTER);

        loadVoucherTable("");

        saveButton.addActionListener(e -> saveVoucher());
        deleteButton.addActionListener(e -> deleteVoucher());

        table.addMouseListener(new MouseAdapter() {
            public void mouseClicked(MouseEvent e) {
                if (e.getClickCount() == 2) {
                    int row = table.getSelectedRow();
                    currentVoucherNo = Integer.parseInt(model.getValueAt(row, 0).toString());
                    fromAccountCombo.setSelectedItem(model.getValueAt(row, 1).toString());
                    toAccountCombo.setSelectedItem(model.getValueAt(row, 2).toString());
                    amountField.setText(model.getValueAt(row, 3).toString());
                    descriptionField.setText(model.getValueAt(row, 4).toString());
                }
            }
        });

        setupDynamicSearch(fromAccountCombo);
        setupDynamicSearch(toAccountCombo);
    }

    private void searchVouchers() {
    String filter = searchField.getText().trim();
    loadVoucherTable(filter);
    }

    
    private void setupDynamicSearch(JComboBox<String> combo) {
        combo.setEditable(true);
        JTextComponent editor = (JTextComponent) combo.getEditor().getEditorComponent();

        editor.addKeyListener(new KeyAdapter() {
            @Override
            public void keyReleased(KeyEvent e) {
                String text = editor.getText();
                if (text.length() >= 1) {
                    Vector<String> results = fetchAccNameFromDB(text);
                    if (!results.isEmpty()) {
                        DefaultComboBoxModel<String> model = new DefaultComboBoxModel<>(results);
                        combo.setModel(model);
                        editor.setText(text);
                        combo.showPopup();
                    } else {
                        combo.hidePopup();
                    }
                } else {
                    combo.hidePopup();
                }
            }
        });
    }

    private Vector<String> fetchAccNameFromDB(String text) {
        Vector<String> list = new Vector<>();
        String sql = "SELECT SUBMAIN_NAME FROM submain WHERE SUBMAIN_NAME LIKE ? ORDER BY SUBMAIN_NAME LIMIT 10";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, text + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("SUBMAIN_NAME"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private int getNextVoucherNo() {
        int next = 1;
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT MAX(topno) AS max_no FROM yeartopno")) {
            if (rs.next() && rs.getInt("max_no") > 0) {
                next = rs.getInt("max_no") + 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return next;
    }

    private void updateTopNo(int topno) {
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO yeartopno (topno) VALUES (?)");
            ps.setInt(1, topno);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private int getAccountNoByName(String name) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT SUBMAIN_NO FROM submain WHERE SUBMAIN_NAME = ?")) {
            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("SUBMAIN_NO");
            }
        }
        return -1;
    }

    private void saveVoucher() {
        try {
            String from = (String) fromAccountCombo.getSelectedItem();
            String to = (String) toAccountCombo.getSelectedItem();
            String desc = descriptionField.getText().trim();
            String amtText = amountField.getText().trim();

            if (from == null || to == null || from.trim().isEmpty() || to.trim().isEmpty() || desc.isEmpty() || amtText.isEmpty()) {
                JOptionPane.showMessageDialog(this, "الرجاء ملء جميع الحقول", "تنبية", JOptionPane.WARNING_MESSAGE);
                return;
            }

            double amt = Double.parseDouble(amtText);
            int fromNo = getAccountNoByName(from.trim());
            int toNo = getAccountNoByName(to.trim());

            if (fromNo == -1 || toNo == -1) {
                JOptionPane.showMessageDialog(this, "الحساب غير موجود", "خطاء", JOptionPane.ERROR_MESSAGE);
                return;
            }

            int voucherNo = currentVoucherNo == -1 ? getNextVoucherNo() : currentVoucherNo;

            try (Connection conn = DBConnection.getConnection()) {
                conn.setAutoCommit(false);

                PreparedStatement deleteOld = conn.prepareStatement("DELETE FROM journal WHERE JOURNAL_NO = ?");
                deleteOld.setInt(1, voucherNo);
                deleteOld.executeUpdate();

                PreparedStatement ps = conn.prepareStatement("INSERT INTO journal (JOURNAL_NO, JOURNAL_SUBMAIN_NO, JOURNAL_DR, JOURNAL_CR, JOURNAL_DESC, JOURNAL_DATE) VALUES (?, ?, ?, ?, ?, ?)");

                ps.setInt(1, voucherNo);
                ps.setInt(2, toNo);
                ps.setDouble(3, amt);
                ps.setDouble(4, 0);
                ps.setString(5, desc);
                ps.setDate(6, new java.sql.Date(System.currentTimeMillis()));
                ps.executeUpdate();

                ps.setInt(1, voucherNo);
                ps.setInt(2, fromNo);
                ps.setDouble(3, 0);
                ps.setDouble(4, amt);
                ps.setString(5, desc);
                ps.setDate(6, new java.sql.Date(System.currentTimeMillis()));
                ps.executeUpdate();

                conn.commit();
            }

            if (currentVoucherNo == -1) {
                updateTopNo(voucherNo);
            }

            currentVoucherNo = -1;
            clearForm();
            loadVoucherTable("");
        } catch (NumberFormatException e) {
            JOptionPane.showMessageDialog(this, "المبلغ غير صحيح", "خطاء", JOptionPane.ERROR_MESSAGE);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void clearForm() {
        fromAccountCombo.setSelectedItem("");
        toAccountCombo.setSelectedItem("");
        amountField.setText("");
        descriptionField.setText("");
    }

    private void deleteVoucher() {
        int row = table.getSelectedRow();
        if (row == -1) return;

        int confirm = JOptionPane.showConfirmDialog(this, "هل انت متأكد من الحذف?", "Confirm", JOptionPane.YES_NO_OPTION);
        if (confirm != JOptionPane.YES_OPTION) return;

        int voucherNo = Integer.parseInt(model.getValueAt(row, 0).toString());

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement stmtJournal = conn.prepareStatement("DELETE FROM journal WHERE JOURNAL_NO = ?")) {
                stmtJournal.setInt(1, voucherNo);
                stmtJournal.executeUpdate();
            }

            try (PreparedStatement stmtTopNo = conn.prepareStatement("DELETE FROM yeartopno WHERE topno = ?")) {
                stmtTopNo.setInt(1, voucherNo);
                stmtTopNo.executeUpdate();
            }

            conn.commit();
            loadVoucherTable("");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void loadVoucherTable(String filterText){
        model.setRowCount(0);
        String sql = "SELECT j1.JOURNAL_NO, sm1.SUBMAIN_NAME as from_acc, sm2.SUBMAIN_NAME as to_acc, " +
        "j1.JOURNAL_CR as amount, j1.JOURNAL_DESC " +
        "FROM journal j1 " +
        "JOIN journal j2 ON j1.JOURNAL_NO = j2.JOURNAL_NO AND j1.JOURNAL_CR > 0 AND j2.JOURNAL_DR > 0 " +
        "JOIN submain sm1 ON j2.JOURNAL_SUBMAIN_NO = sm1.SUBMAIN_NO " +
        "JOIN submain sm2 ON j1.JOURNAL_SUBMAIN_NO = sm2.SUBMAIN_NO " +
        "WHERE CONCAT(" +
        "CAST(j1.JOURNAL_NO AS CHAR), ' ', " +
        "sm1.SUBMAIN_NAME COLLATE utf8_general_ci, ' ', " +
        "sm2.SUBMAIN_NAME COLLATE utf8_general_ci, ' ', " +
        "CAST(j1.JOURNAL_CR AS CHAR), ' ', " +
        "j1.JOURNAL_DESC COLLATE utf8_general_ci) " +
        "LIKE ? " +
        "GROUP BY j1.JOURNAL_NO, sm1.SUBMAIN_NAME, sm2.SUBMAIN_NAME, j1.JOURNAL_CR, j1.JOURNAL_DESC";


        try (Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, "%" + filterText + "%");
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            model.addRow(new Object[]{
                rs.getInt("JOURNAL_NO"),
                rs.getString("to_acc"),
                rs.getString("from_acc"),
                rs.getDouble("amount"),
                rs.getString("JOURNAL_DESC")
               });
            }

        } catch (SQLException e) {
          e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new VF().setVisible(true));
    }
}