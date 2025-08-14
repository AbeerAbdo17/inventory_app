/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package General;
// Java program to write data in excel sheet using java code

 
import acc.Connect;
import java.io.*;
import java.sql.*;
import javax.swing.JOptionPane;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.*;
 
/**
 * A simple Java program that exports data from database to Excel file.
 * @author Nam Ha Minh
 * (C) Copyright codejava.net
 */
public class ExcelAccounting2 {
    public static void main(String[] args) {
      //  new ExportExcel().export();
    } 
    public static void export(String date1,String date2) {
      //  String voy = voyval;
      Statement stmt1;
   ResultSet rs1;
        String excelFilePath = "Daily_invoice_report.xlsx";
        try (Connection connection = acc.Connect.ConnectDB();) {
     //       String sql = "SELECT * FROM demurrage inner join mast on mast.mast_dem_serial = demurrage.dem_serial and dem_date between  '"+date1+"' and '"+date2+"' order by dem_date desc";
             String sql = "select * from delivery left join mast on mast.mast_d_serial = delivery.del_serial where delivery.del_date between  '"+date1+"' and '"+date2+"'";       
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery(sql);
            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet sheet = workbook.createSheet("Daily_invoice_report");
            writeHeaderLine(sheet);           
            writeDataLines(result, workbook, sheet); 
            FileOutputStream outputStream = new FileOutputStream(excelFilePath);
            workbook.write(outputStream);
       //     workbook.close();
 
            statement.close();
 //Runtime.getRuntime().exec("rundll32 url.dll,FileProtocolHandler Daily_invoice_report_"+date1+".pdf");
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, e);
            System.out.println("Datababse error:");
            e.printStackTrace();
        } catch (IOException e) {
            JOptionPane.showMessageDialog(null, e);
            System.out.println("File IO error:");
            e.printStackTrace();
        }
    }
    public static void writeHeaderLine(XSSFSheet sheet) {

        Row headerRow = sheet.createRow(0);
        Cell headerCell = headerRow.createCell(0);
headerCell.setCellValue("Customer Name");

headerCell = headerRow.createCell(1);
headerCell.setCellValue("Transaction Date");

headerCell = headerRow.createCell(2);
headerCell.setCellValue("RefNumber/BIL No."); 

headerCell = headerRow.createCell(3);
headerCell.setCellValue("PO Number");

headerCell = headerRow.createCell(4);
headerCell.setCellValue("Terms");

headerCell = headerRow.createCell(5);
headerCell.setCellValue("Class");

headerCell = headerRow.createCell(6);
headerCell.setCellValue("Template Name");

headerCell = headerRow.createCell(7);
headerCell.setCellValue("To Be Printed");


headerCell = headerRow.createCell(8);
headerCell.setCellValue("Ship Date");


headerCell = headerRow.createCell(9);
headerCell.setCellValue("BillTo Line1");


headerCell = headerRow.createCell(10);
headerCell.setCellValue("BillTo Line2");


headerCell = headerRow.createCell(11);
headerCell.setCellValue("BillTo Line3");


headerCell = headerRow.createCell(12);
headerCell.setCellValue("BillTo Line4");


headerCell = headerRow.createCell(13);
headerCell.setCellValue("BillTo City");



headerCell = headerRow.createCell(14);
headerCell.setCellValue("BillTo State");


headerCell = headerRow.createCell(15);
headerCell.setCellValue("BillToPostalCode");


headerCell = headerRow.createCell(16);
headerCell.setCellValue("BillTo Country");


headerCell = headerRow.createCell(17);
headerCell.setCellValue("ShipTo Line1");


headerCell = headerRow.createCell(18);
headerCell.setCellValue("ShipTo Line2");


headerCell = headerRow.createCell(19);
headerCell.setCellValue("ShipTo Line3");



headerCell = headerRow.createCell(20);
headerCell.setCellValue("ShipTo Line4");

headerCell = headerRow.createCell(21);
headerCell.setCellValue("ShipTo City");

headerCell = headerRow.createCell(22);
headerCell.setCellValue("ShipTo State");

headerCell = headerRow.createCell(23);
headerCell.setCellValue("ShipTo PostalCode");

headerCell = headerRow.createCell(24);
headerCell.setCellValue("ShipTo Country");

headerCell = headerRow.createCell(25);
headerCell.setCellValue("Phone");

headerCell = headerRow.createCell(26);
headerCell.setCellValue("Fax");

headerCell = headerRow.createCell(27);
headerCell.setCellValue("Email");


headerCell = headerRow.createCell(28);
headerCell.setCellValue("Contact Name");

headerCell = headerRow.createCell(29);
headerCell.setCellValue("First Name");

headerCell = headerRow.createCell(30);
headerCell.setCellValue("Last Name");

headerCell = headerRow.createCell(31);
headerCell.setCellValue("Rep");

headerCell = headerRow.createCell(32);
headerCell.setCellValue("Due Date/Arrived On");

headerCell = headerRow.createCell(33);
headerCell.setCellValue("Ship Method");

headerCell = headerRow.createCell(34);
headerCell.setCellValue("Customer Message");

headerCell = headerRow.createCell(35);
headerCell.setCellValue("Memo");

headerCell = headerRow.createCell(36);
headerCell.setCellValue("Item Name");

headerCell = headerRow.createCell(37);
headerCell.setCellValue("Quantity");

headerCell = headerRow.createCell(38);
headerCell.setCellValue("Description");

headerCell = headerRow.createCell(39);
headerCell.setCellValue("Rate");

headerCell = headerRow.createCell(40);
headerCell.setCellValue("VAT Code");

headerCell = headerRow.createCell(41);
headerCell.setCellValue("VAT Amount");

headerCell = headerRow.createCell(42);
headerCell.setCellValue("Amount Incl VAT");

headerCell = headerRow.createCell(43);
headerCell.setCellValue("Other1/From Port");


headerCell = headerRow.createCell(44);
headerCell.setCellValue("FOB/Vessel");

headerCell = headerRow.createCell(45);
headerCell.setCellValue("Other2/Voyage");

headerCell = headerRow.createCell(46);
headerCell.setCellValue("Other/R/G No");

headerCell = headerRow.createCell(47);
headerCell.setCellValue("AR Account");


    }
 
    public static void writeDataLines(ResultSet result, XSSFWorkbook workbook,
            XSSFSheet sheet) throws SQLException {
        int rowCount = 1;
        int k = 1;
        while (result.next()) {
          //  String V1 = "",V2 = "",V3 = "",V4 = "",V5 = "",V6 = "",V7 = "",V8 = "",V9 = "",V10 = "";
          String V1 ,V2 ,V4 ;
          double V3,V5;
          int del_serial;
            for(int i = 1;i<18;i++) // 18 is equal count of every table and after that sum of this values from that tables(delivery ,demurrage, ex_manifest * values of 20 or 40)
            {
            Row row = sheet.createRow(rowCount++);
            int columnCount = 0;
            Cell cell = row.createCell(columnCount++);
            cell.setCellValue(result.getString("clearername")); 
            
            cell = row.createCell(columnCount++);
            cell.setCellValue(result.getString("del_date"));
            
            cell = row.createCell(columnCount++);
            cell.setCellValue(result.getString("mast_blno")); 
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
          //  cell.setCellValue(result.getInt("del_serial"));
            
            cell = row.createCell(columnCount++);
            cell.setCellValue(""); //term
            
            cell = row.createCell(columnCount++);
            cell.setCellValue(""); //class
            
            cell = row.createCell(columnCount++);
            cell.setCellValue(""); //tembled
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");//
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
             cell = row.createCell(columnCount++);
            cell.setCellValue("");//
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
             cell = row.createCell(columnCount++);
            cell.setCellValue("");//
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");
              
            cell = row.createCell(columnCount++);
            cell.setCellValue(GetItemname(i));
            
            cell = row.createCell(columnCount++);
            cell.setCellValue(1); // quantity
            
            cell = row.createCell(columnCount++);
            cell.setCellValue("");  //desc
            
            cell = row.createCell(columnCount++);
            del_serial = result.getInt("del_serial");
             V3 = GetItemrate(i,del_serial);
             cell.setCellValue(V3);
             
             cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
             cell = row.createCell(columnCount++);
          //  del_serial = result.getInt("del_serial");
             V5 = GetItemratevat(i,del_serial);
             cell.setCellValue(V5);
          //    cell = row.createCell(columnCount++);
           // cell.setCellValue("");  //vat code
            
             cell = row.createCell(columnCount++);
            cell.setCellValue("");   
            
               cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
               cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
               cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
               cell = row.createCell(columnCount++);
            cell.setCellValue("");
            
               cell = row.createCell(columnCount++);
            cell.setCellValue("");

            } //for loop
        }
        JOptionPane.showMessageDialog(null,"Data Exported" ,"" , JOptionPane.INFORMATION_MESSAGE);
        try{
          //  Date date = new Date();
        Runtime.getRuntime().exec("rundll32 url.dll,FileProtocolHandler Daily_invoice_report.xlsx");
        }catch(IOException e){JOptionPane.showMessageDialog(null,e);}

    }
    private static String GetItemname(int x){
        String itemname = "";
        switch (x) {
            case 1:
                itemname = "Land Charge";
                break;
            case 2:
                itemname = "D.Charge";
                break;
            case 3:
                itemname = "Clean PHC";
                break;
            case 4:
                itemname = "Traffic"; 
                break;
            case 5:
                itemname = "Stamp Duty"; 
                break;
                case 6:
                itemname = "PPD"; 
                break;
                case 7:
                itemname = "WE"; 
                break;
                case 8:
                itemname = "SSC"; 
                break;
                case 9:
                itemname = "Insurance"; 
                break;
                case 10:
                itemname = "Food Bank"; 
                break;
                case 11:
                itemname = "Administrastion"; 
                break;
                case 12:
                itemname = "State Govt"; 
                break;
                case 13:
                itemname = "EUS"; 
                break;
                case 14:
                itemname = "P.C.Stamp"; 
                break;
                case 15:
                itemname = "Notification"; 
                break;
                 case 16:
                itemname = "T.C.Stamp"; 
                break;
                 case 17:
                itemname = "Lifting"; 
                break;
               
            default:
                break;
        }
            return itemname;
    }
      private static double GetItemrate(int x,int d_ser){
          double itemrate = '0';
          try {
    Connection conn=Connect.ConnectDB();
    Statement stmt1 = conn.createStatement();    //select from barcode inner join item
    //  String rq1 = "select item_qnt,item_units from items where item_id ="+item_i+"";  //should find by name ?
     String rq1 = "select * from delivery where del_serial = '"+d_ser+"'"; 
           ResultSet rs1 = stmt1.executeQuery(rq1);
    //     rs1.next(); 
         while (rs1.next()){ 
        switch (x) {
            case 1:
                itemrate = rs1.getDouble("landing");
                break;
            case 2:
                itemrate = rs1.getDouble("delivery");
                break;
            case 3:
                itemrate = rs1.getDouble("clean");
                break;
            case 4:
                itemrate = rs1.getDouble("elect");
                break;
                case 5:
                itemrate = rs1.getDouble("stamp");
                break;
                case 6:
                itemrate = rs1.getDouble("freight");
                break;
                case 7:
                itemrate = rs1.getDouble("militry");
                break;
                case 8:
                itemrate = rs1.getDouble("conference");
                  break;
                case 9:
                itemrate = rs1.getDouble("insurance");
                break;
                case 10:
                itemrate = rs1.getDouble("food");
                break;
                case 11:
                itemrate = rs1.getDouble("admin");
                break;
                case 12:
                itemrate = rs1.getDouble("others");
                break;
                case 13:
                itemrate = rs1.getDouble("deposit");
                break;
                case 14:
                itemrate = rs1.getDouble("wharfage");
                break;
                case 15:
                itemrate = rs1.getDouble("notifications");
                break;
                case 16:
                itemrate = rs1.getDouble("thc");
                break;
                case 17:
                itemrate = rs1.getDouble("extraction");
                break;
                case 18:
                itemrate = rs1.getDouble("elect");
                break;
            default:
                break;
        }
            }}
catch(Exception e){JOptionPane.showMessageDialog(null, e);}
            return itemrate;
    }
            private static double GetItemratevat(int x,int d_ser){
          double itemrate = '0';
          try {
    Connection conn=Connect.ConnectDB();
    Statement stmt1 = conn.createStatement();    //select from barcode inner join item
    //  String rq1 = "select item_qnt,item_units from items where item_id ="+item_i+"";  //should find by name ?
     String rq1 = "select *,dsetting.vat as vat1 from delivery,dsetting where del_serial = '"+d_ser+"'"; 
           ResultSet rs1 = stmt1.executeQuery(rq1);
    //     rs1.next(); 
         while (rs1.next()){ 
        switch (x) {
            case 1:
                itemrate = rs1.getDouble("landing")*rs1.getDouble("vat1");
                break;
            case 2:
                itemrate = rs1.getDouble("delivery")*rs1.getDouble("vat1");
                break;
            case 3:
                itemrate = rs1.getDouble("clean")*rs1.getDouble("vat1");
                break;
            case 4:
                itemrate = rs1.getDouble("elect")*rs1.getDouble("vat1");
                break;
                case 5:
                itemrate = rs1.getDouble("stamp")*rs1.getDouble("vat1");
                break;
                case 6:
                itemrate = rs1.getDouble("freight")*rs1.getDouble("vat1");
                break;
                case 7:
                itemrate = rs1.getDouble("militry")*rs1.getDouble("vat1");
                break;
                case 8:
                itemrate = rs1.getDouble("conference")*rs1.getDouble("vat1");
                  break;
                case 9:
                itemrate = rs1.getDouble("insurance")*rs1.getDouble("vat1");
                break;
                case 10:
                itemrate = rs1.getDouble("food")*rs1.getDouble("vat1");
                break;
                case 11:
                itemrate = rs1.getDouble("admin")*rs1.getDouble("vat1");
                break;
                case 12:
                itemrate = rs1.getDouble("others")*rs1.getDouble("vat1");
                break;
                case 13:
                itemrate = rs1.getDouble("deposit")*rs1.getDouble("vat1");
                break;
                case 14:
                itemrate = rs1.getDouble("wharfage")*rs1.getDouble("vat1");
                break;
                case 15:
                itemrate = rs1.getDouble("notifications")*rs1.getDouble("vat1");
                break;
                case 16:
                itemrate = rs1.getDouble("thc")*rs1.getDouble("vat1");
                break;
                case 17:
                itemrate = rs1.getDouble("extraction")*rs1.getDouble("vat1");
                break;
                case 18:
                itemrate = rs1.getDouble("elect")*rs1.getDouble("vat1");
                break;
            default:
                break;
        }
            }}
catch(Exception e){JOptionPane.showMessageDialog(null, e);}
            return itemrate;
    }
        public static void export2(String date1,String date2) {
      //  String voy = voyval;
        String excelFilePath = "Del-Manifest.xlsx";
        try (Connection connection = acc.Connect.ConnectDB();) {
            String sql = "SELECT * , (\n" +
        "\n" +
        "SELECT mast_blno\n" +
        "FROM mast\n" +
        "INNER JOIN delivery ON mast.mast_d_serial = delivery.del_serial\n" +
        "LIMIT 1\n" +
        ") AS blnoval,\n" +
        "(SELECT mast_consignee\n" +
        "FROM mast\n" +
        "INNER JOIN delivery ON mast.mast_d_serial = delivery.del_serial\n" +
        "LIMIT 1\n" +
") AS consval\n" +
"FROM delivery where delivery.del_date between  '"+date1+"' and '"+date2+"' order by delivery.del_date desc";
 
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery(sql);
            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet sheet = workbook.createSheet("Manifest1");
            writeHeaderLine2(sheet);           
            writeDataLines2(result, workbook, sheet); 
            FileOutputStream outputStream = new FileOutputStream(excelFilePath);
            workbook.write(outputStream);
       //     workbook.close(); 
            statement.close();
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, e);
            System.out.println("Datababse error:");
            e.printStackTrace();
        } catch (IOException e) {
            JOptionPane.showMessageDialog(null, e);
            System.out.println("File IO error:");
            e.printStackTrace();
        }
    }
    public static void writeHeaderLine2(XSSFSheet sheet) {

        Row headerRow = sheet.createRow(0);

        Cell headerCell = headerRow.createCell(0);
        headerCell.setCellValue("DELIVERY.");
      //  headerCell.
        headerCell = headerRow.createCell(1);
        headerCell.setCellValue("DATE.");

        headerCell = headerRow.createCell(2);
        headerCell.setCellValue("CONSIGNEE.");
 
        headerCell = headerRow.createCell(3);
        headerCell.setCellValue("CLEARER.");
        
        headerCell = headerRow.createCell(4);
        headerCell.setCellValue("BLNO.");
        
        headerCell = headerRow.createCell(5);
        headerCell.setCellValue("VAT.");

         headerCell = headerRow.createCell(6);
        headerCell.setCellValue("TOTAL.");
    }
 
    public static void writeDataLines2(ResultSet result, XSSFWorkbook workbook,
            XSSFSheet sheet) throws SQLException {
        int rowCount = 1;
        while (result.next()) {
            String V1 = result.getString("del_serial");
            String V2 = result.getString("delivery.del_date");
            String V3 = result.getString("consval");
            String V4 = result.getString("clearername");           
            String V5 = result.getString("blnoval");
            String V6 = result.getString("vat");
            String v7 = result.getString("gtotal");
        //    String shipper = result.getString("shipper");
       //     String bol = result.getString("bol");
         //   float rating = result.getFloat("mark");
       //     Timestamp timestamp = result.getTimestamp("cdate");
       //     String comment = result.getString("vessel");
 
            Row row = sheet.createRow(rowCount++);
 
            int columnCount = 0;
            Cell cell = row.createCell(columnCount++);
            cell.setCellValue(V1);
 
            cell = row.createCell(columnCount++);
            cell.setCellValue(V2);
 
            cell = row.createCell(columnCount++);
            cell.setCellValue(V3); 
            
            cell = row.createCell(columnCount++);
            cell.setCellValue(V4); 
  
            cell = row.createCell(columnCount++);
            cell.setCellValue(V5); 
//            
            cell = row.createCell(columnCount++);
            cell.setCellValue(V6); 

            cell = row.createCell(columnCount++);
            cell.setCellValue(v7);
        }
        JOptionPane.showMessageDialog(null,"Data Exported" ,"" , JOptionPane.INFORMATION_MESSAGE);
        try{
        Runtime.getRuntime().exec("rundll32 url.dll,FileProtocolHandler Del-Manifest.xlsx");
        }catch(IOException e){JOptionPane.showMessageDialog(null,e);}
;
    }
}

