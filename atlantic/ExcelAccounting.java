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
public class ExcelAccounting {
    public static void main(String[] args) {
      //  new ExportExcel().export();
    } 
    public static void export(String date1,String date2) {
      //  String voy = voyval;
      Statement stmt1;
   ResultSet rs1;

        String excelFilePath = "Delivery.xlsx";
 
        try (Connection connection = acc.Connect.ConnectDB();) {
     //       String sql = "SELECT * FROM demurrage inner join mast on mast.mast_dem_serial = demurrage.dem_serial and dem_date between  '"+date1+"' and '"+date2+"' order by dem_date desc";
 
             String sql = "SELECT * from delivery where del_date between  '"+date1+"' and '"+date2+"' order by del_date";
            
            Statement statement = connection.createStatement();
 
            ResultSet result = statement.executeQuery(sql);
 
            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet sheet = workbook.createSheet("Delivery");
            writeHeaderLine(sheet);           
            writeDataLines(result, workbook, sheet); 
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
    public static void writeHeaderLine(XSSFSheet sheet) {

        Row headerRow = sheet.createRow(0);

        Cell headerCell = headerRow.createCell(0);
        headerCell.setCellValue("Customer Name");
      //  headerCell.
        headerCell = headerRow.createCell(1);
        headerCell.setCellValue("Transaction Date");

        headerCell = headerRow.createCell(2);
        headerCell.setCellValue("RefNumber/BIL No.");
 
        headerCell = headerRow.createCell(3);
        headerCell.setCellValue("PO Number");
        
        headerCell = headerRow.createCell(4);
        headerCell.setCellValue("Terms");
        
        headerCell = headerRow.createCell(5);
        headerCell.setCellValue("Item Name");
        
        headerCell = headerRow.createCell(6);
        headerCell.setCellValue("Quantity");
        
         headerCell = headerRow.createCell(7);
        headerCell.setCellValue("Description");
        
         headerCell = headerRow.createCell(8);
        headerCell.setCellValue("Rate");

         headerCell = headerRow.createCell(9);
        headerCell.setCellValue("VAT Code");
        
         headerCell = headerRow.createCell(10);
        headerCell.setCellValue("VAT Amount");
    }
 
    public static void writeDataLines(ResultSet result, XSSFWorkbook workbook,
            XSSFSheet sheet) throws SQLException {
        int rowCount = 1;
        while (result.next()) {
          //  String V1 = "",V2 = "",V3 = "",V4 = "",V5 = "",V6 = "",V7 = "",V8 = "",V9 = "",V10 = "";
          String V1 ,V2 ,V3 ,V4 ,V5 ,V6 ,V7 ;
          double V8,V9,V10;
            for(int i = 1;i<5;i++)
            {
             V1 = result.getString("deL_date");
             V2 = result.getString("clearername");
             V3 = result.getString("del_serial");
             V4 = result.getString("ppd");           
             V5 = result.getString("clean");
             V6 = result.getString("food");
             V7 = GetItemname(i);//result.getString("item");
             V8 = GetItemrate(i);
             V9 = result.getDouble("elect");
            V10 = result.getDouble("deposit");
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
            cell.setCellValue(V7); 
//            
            cell = row.createCell(columnCount++);
            cell.setCellValue(V5); 
            
             cell = row.createCell(columnCount++);
            cell.setCellValue(V6);
            
             cell = row.createCell(columnCount++);
            cell.setCellValue(V7);
            
             cell = row.createCell(columnCount++);
            cell.setCellValue(V8);
            
             cell = row.createCell(columnCount++);
            cell.setCellValue(V9);

            cell = row.createCell(columnCount++);
            cell.setCellValue(V10);
            }
        }
        JOptionPane.showMessageDialog(null,"Data Exported" ,"" , JOptionPane.INFORMATION_MESSAGE);
        try{
        Runtime.getRuntime().exec("rundll32 url.dll,FileProtocolHandler Delexport.xlsx");
        }catch(IOException e){JOptionPane.showMessageDialog(null,e);}
;
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
                itemname = "food";
                break;
            default:
                break;
        }
            return itemname;
    }
      private static double GetItemrate(int x){
          double itemrate = '0';
          try {
    Connection conn=Connect.ConnectDB();
    Statement stmt1 = conn.createStatement();    //select from barcode inner join item
    //  String rq1 = "select item_qnt,item_units from items where item_id ="+item_i+"";  //should find by name ?
     String rq1 = "select * from delivery"; 
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
                itemrate = rs1.getDouble("food");
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

