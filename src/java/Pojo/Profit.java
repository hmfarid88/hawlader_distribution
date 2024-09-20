/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Pojo;

import DB.Database;
import Model.SaleModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class Profit {
    
    public SaleModel DailyTotalSale(){
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rs3 = null;
        ResultSet rs4 = null;
        ResultSet rs5 = null;
        SaleModel sml=null;
        try {
            con = Database.getConnection();
            String query = "select sum(QUANTITY), sum(GRAND_TOTAL) from paymentinfo where DATE=CURDATE()";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            rs.next();
            String query1="select sum(PRICE-DISCOUNT) from  mobilesell where RETAILER in(select distinct R_NAME from retailer_info)";
            ps = con.prepareStatement(query1);
            rs1 = ps.executeQuery();
            rs1.next();
            String query2="select sum(AMOUNT) from  customer_pay where RETAILER in(select distinct R_NAME from retailer_info)";
            ps = con.prepareStatement(query2);
            rs2 = ps.executeQuery();
            rs2.next();
            String query3="select sum(AMOUNT) from  demo_transaction where TR_TYPE='Receive'";
            ps = con.prepareStatement(query3);
            rs3 = ps.executeQuery();
            rs3.next();
            String query4="select sum(AMOUNT) from  demo_transaction where TR_TYPE='Payment'";
            ps = con.prepareStatement(query4);
            rs4 = ps.executeQuery();
            rs4.next();
            String query5="select sum(AMOUNT) from  additionaldis where RETAILER in(select distinct R_NAME from retailer_info)";
            ps = con.prepareStatement(query5);
            rs5 = ps.executeQuery();
            rs5.next();
             sml=new SaleModel(); 
             sml.setDtsqty(rs.getInt(1));
             sml.setDtsp(rs.getLong(2));
             sml.setRtbalance(rs1.getLong(1)-rs2.getLong(1)-rs5.getLong(1));
             sml.setDemoblance(rs4.getLong(1)-rs3.getLong(1));
             
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs5 != null) rs5.close(); rs5=null; } catch (SQLException ex2) { }
  try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
  try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
  try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return sml;
    }
    
  public List<SaleModel> TargetShow() {
        List<SaleModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select FACTORY_NAME, COM_NAME, AMOUNT, START_DATE, END_DATE from fac_commission where YEAR(END_DATE) = YEAR(CURRENT_DATE()) AND MONTH(END_DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                SaleModel sm = new SaleModel();
                sm.setTrfname(rs.getString(1));
                sm.setTrname(rs.getString(2));
                sm.setTramount(rs.getDouble(3));
                sm.setStdate(rs.getString(4));
                sm.setEnddate(rs.getString(5));
                list.add(sm);
            }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    }     
     
     public List<SaleModel> MonthlyCostShow() {
        List<SaleModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select COST_NAME, AMOUNT, DATE from cost where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                SaleModel sm = new SaleModel();
               sm.setCostname(rs.getString(1));
               sm.setCostamount(rs.getFloat(2));
               sm.setCostdate(rs.getString(3));
                list.add(sm);
            }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    }     
    public SaleModel TotalCost(){
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        SaleModel sml=null;
        try {
            con = Database.getConnection();
            String query = "select sum(AMOUNT) from cost where  YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             sml=new SaleModel(); 
             sml.setTotalcost(rs.getLong(1));
    }
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return sml;
    }
    public List<SaleModel> MonthlyEmpCostShow() {
        List<SaleModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select EMP_NAME, COST_NAME, AMOUNT, DATE from emp_cost where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                SaleModel sm = new SaleModel();
               sm.setEmpname(rs.getString(1));
               sm.setEmpcost(rs.getString(2));
               sm.setEmpcostamount(rs.getFloat(3));
               sm.setEmpcostdate(rs.getString(4));
                list.add(sm);
            }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    }     
     public SaleModel TotalEmpCost(){
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        SaleModel sml=null;
        try {
            con = Database.getConnection();
            String query = "select sum(AMOUNT) from emp_cost where  YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             sml=new SaleModel(); 
             sml.setTotalempcost(rs.getLong(1));
    }
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return sml;
    }
     public SaleModel DailyretailerPay(){
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        SaleModel sml=null;
        try {
            con = Database.getConnection();
            String query = "select sum(AMOUNT) from customer_pay where  DATE=CURDATE()";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             sml=new SaleModel(); 
             sml.setDailyrtpay(rs.getLong(1));
    }
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return sml;
    }
}
