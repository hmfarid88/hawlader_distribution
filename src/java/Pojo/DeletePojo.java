
package Pojo;

import DB.Database;
import Model.DeleteModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class DeletePojo {
 public List<DeleteModel> Stockentrytoday() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, PRODUCT_NAME, QUANTITY, PURSE_PRICE  from factory_stock order by SI_NO DESC limit 1";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setSino(rs.getInt(1));
             dm.setProduct(rs.getString(2));
             dm.setQty(rs.getInt(3));
             dm.setRate(rs.getFloat(4));
             list.add(dm);
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
  public List<DeleteModel> EmpcostDel() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, EMP_NAME, COST_NAME, AMOUNT  from emp_cost where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setEmpsi(rs.getInt(1));
             dm.setEmpname(rs.getString(2));
             dm.setEmpcost(rs.getString(3));
             dm.setEmpamount(rs.getFloat(4));
             list.add(dm);
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
  
  public List<DeleteModel> RetlerPayUp() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query1 = "select SI_NO, RETAILER, PAY_TYPE, AMOUNT  from customer_pay where DATE=CURDATE()";
            ps = con.prepareStatement(query1);
            rs = ps.executeQuery();
            while (rs.next()) {
            DeleteModel dm=new DeleteModel();
            dm.setRtpaysi(rs.getInt(1));
            dm.setRetailer(rs.getString(2));
            dm.setRtpayname(rs.getString(3));
            dm.setRtpayamount(rs.getFloat(4));
             list.add(dm);
            } 
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close();} catch (SQLException ex2) { }
  try { if (ps != null) ps.close();} catch (SQLException ex2) { }
  try { if (con != null) con.close();} catch (SQLException ex2) { }
}
            return list;
    }
  public List<DeleteModel> FactoryPayUp() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            
            String query1 = "select SI_NO, COMPANY_NAME, PAY_TYPE, AMOUNT from company_payment where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query1);
            rs = ps.executeQuery();
            while (rs.next()) {
            DeleteModel dm=new DeleteModel();
            dm.setFacpaysi(rs.getInt(1));
            dm.setCompany(rs.getString(2));
            dm.setFacpayname(rs.getString(3));
            dm.setFacpayamount(rs.getFloat(4));
             list.add(dm);
            } 
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close();} catch (SQLException ex2) { }
  try { if (ps != null) ps.close();} catch (SQLException ex2) { }
  try { if (con != null) con.close();} catch (SQLException ex2) { }
}
            return list;
    }
  
  public List<DeleteModel> OfficecostDel() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, COST_NAME, AMOUNT  from cost where DATE=CURDATE()";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setOffcostsi(rs.getInt(1));
             dm.setOffcostname(rs.getString(2));
             dm.setOffcostamount(rs.getFloat(3));
             list.add(dm);
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
  public List<DeleteModel> PropricostDel() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, PAY_NAME, PAYMENT, RECEIVE  from proprietor_cost where DATE=CURDATE()";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setProsi(rs.getInt(1));
             dm.setPropayname(rs.getString(2));
             dm.setPropay(rs.getFloat(3));
             dm.setProrecv(rs.getFloat(4));
             list.add(dm);
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
  
  public List<DeleteModel> BanktransiDel() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, TYPE, AMOUNT, BANK  from bank_transition where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setBanksi(rs.getInt(1));
             dm.setBank(rs.getString(4));
             dm.setBanktype(rs.getString(2));
             dm.setBankamount(rs.getFloat(3));
             list.add(dm);
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
  public List<DeleteModel> demotransiDel() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, TR_TYPE, REMARK, AMOUNT from demo_transaction where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setDemosi(rs.getInt(1));
             dm.setDemotype(rs.getString(2));
             dm.setDemoremark(rs.getString(3));
             dm.setDemoamount(rs.getFloat(4));
             list.add(dm);
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
  public List<DeleteModel> DebitDel() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, DEBIT_NAME, AMOUNT  from cash_debit where DATE=CURDATE()";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setDebitsi(rs.getInt(1));
             dm.setDebitname(rs.getString(2));
             dm.setDebitamount(rs.getFloat(3));
             list.add(dm);
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
  
  public List<DeleteModel> CreditDel() {
        List<DeleteModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, CREDIT_NAME, AMOUNT  from cash_credit where DATE=CURDATE()";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             DeleteModel dm=new DeleteModel();
             dm.setCreditsi(rs.getInt(1));
             dm.setCreditname(rs.getString(2));
             dm.setCreditamount(rs.getFloat(3));
             list.add(dm);
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
  
  
}
