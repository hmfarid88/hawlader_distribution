package Pojo;
import DB.Database;
import Model.Accountant;
import Model.EmpModel;
import Model.StockModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class AccountPojo {

    public List<Accountant> retailerView() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select R_NAME from retailer_info order by R_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             Accountant ac=new Accountant();
             ac.setRetailer(rs.getString(1));
             list.add(ac);
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
    public List<Accountant> proprietorView() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select P_NAME from proprietor_info order by P_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             Accountant ac=new Accountant();
             ac.setProprietor(rs.getString(1));
             list.add(ac);
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
    
    public List<Accountant> CostNameView() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select COST_NAME from cost_name order by COST_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             Accountant ac=new Accountant();
             ac.setExpense(rs.getString(1));
             list.add(ac);
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
 public List<Accountant> FactoryView() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select VENDOR_NAME from vendor order by VENDOR_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             Accountant ac=new Accountant();
             ac.setFactory(rs.getString(1));
             list.add(ac);
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
 public List<Accountant> BankShow() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select BANK_NAME from bank_name order by BANK_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             Accountant act=new Accountant();
             act.setBank(rs.getString(1));
                        
             list.add(act);
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

 
 public StockModel TotalStock(){
        StockModel stm=null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        try {
            con = Database.getConnection();
            String query="select count(IMEI), sum(SELL_PRICE) from stock";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            rs.next();
            String query1="select sum(PURCHASE_PRICE) from vendor_stock";
            ps = con.prepareStatement(query1);
            rs1 = ps.executeQuery();
            rs1.next();
            Long totalprice=rs1.getLong(1);
            String query2="select sum(AMOUNT) from company_payment";
            ps = con.prepareStatement(query2);
            rs2 = ps.executeQuery();
            rs2.next();
            Long totalpay=rs2.getLong(1);
            Long balance=totalpay-totalprice;
            stm=new StockModel();
            stm.setTotalqty(rs.getInt(1));
            stm.setTotalvalu(rs.getLong(2));
            stm.setCompanybl(balance);
                     
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs2 != null) rs2.close(); } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
  try { if (con != null) con.close(); } catch (SQLException ex2) { }
}
        return stm;    
        
 }
 
 public List<StockModel> RetailerLedger() {
        List<StockModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rs3 = null;
        ResultSet rs4 = null; 
        ResultSet rs5 = null;
        ResultSet rs6 = null;
        ResultSet rs7 = null;
        
        try {
            con = Database.getConnection();
            String queryretiler="select distinct R_NAME from retailer_info order by R_NAME";
            ps = con.prepareStatement(queryretiler);
            rs = ps.executeQuery();
            while (rs.next()) {
             String retailer=rs.getString(1);
                      
            String query = "select count(PRODUCT_ID) as qty, sum(PRICE) as totalprice, sum(DISCOUNT) as dis from mobilesell where  RETAILER=? and YEAR(SELL_DATE) = YEAR(CURRENT_DATE()) AND MONTH(SELL_DATE) = MONTH(CURRENT_DATE())";
            ps = con.prepareStatement(query);
            ps.setString(1, retailer);
            rs1 = ps.executeQuery(); 
            while(rs1.next()){
             Long qty=rs1.getLong("qty");
             Long totalprice=rs1.getLong("totalprice");
             Long dis=rs1.getLong("dis");
             
             String payment="select sum(AMOUNT) as totalpay from customer_pay where RETAILER=?";
             ps = con.prepareStatement(payment);
            ps.setString(1, retailer);
            rs2 = ps.executeQuery(); 
            while(rs2.next()){
              Long totalpay=  rs2.getLong("totalpay");
              String monthpay="select sum(AMOUNT) from customer_pay where RETAILER=? and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
             ps = con.prepareStatement(monthpay);
            ps.setString(1, retailer);
            rs3 = ps.executeQuery(); 
            while(rs3.next()){
              Long monthlypay=rs3.getLong(1);
              String totalpricevalu="select sum(PRICE), sum(DISCOUNT) from mobilesell where RETAILER=?";
              ps = con.prepareStatement(totalpricevalu);
            ps.setString(1, retailer);
            rs4 = ps.executeQuery(); 
            while(rs4.next()){
                String dailypay="select sum(AMOUNT) from customer_pay where RETAILER=? and DATE = CURDATE()";
             ps = con.prepareStatement(dailypay);
            ps.setString(1, retailer);
            rs5 = ps.executeQuery(); 
            while(rs5.next()){
                String additional="select sum(AMOUNT) from additionaldis where RETAILER=? ";
             ps = con.prepareStatement(additional);
            ps.setString(1, retailer);
            rs6 = ps.executeQuery(); 
            while(rs6.next()){
                String additionaldis="select sum(AMOUNT) from additionaldis where RETAILER=? and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
             ps = con.prepareStatement(additionaldis);
            ps.setString(1, retailer);
            rs7 = ps.executeQuery(); 
            while(rs7.next()){
              
             Long totalvalu=rs4.getLong(1);
             Long totaldis=rs4.getLong(2)+rs6.getLong(1);
             Long totalsub=totalpay+totaldis;
             StockModel stm=new StockModel();
             stm.setRetiler(retailer);
             stm.setDelivery(qty);
             stm.setTotalprice(totalprice-dis-rs7.getLong(1));
             stm.setTotalpay(monthlypay);
             stm.setRetailerbalance(totalvalu-totalsub);
             stm.setCurpay(rs5.getLong(1));
             list.add(stm);
             } } } } }}}}
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs7 != null) rs7.close(); rs7=null; } catch (SQLException ex2) { }
  try { if (rs6 != null) rs6.close(); rs6=null; } catch (SQLException ex2) { }
  try { if (rs5 != null) rs5.close(); rs5=null; } catch (SQLException ex2) { }
  try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
  try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
  try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    } 
   public List<StockModel> FactoryLedger() {
        List<StockModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rs3 = null;
        ResultSet rs4 = null;
        try {
            con = Database.getConnection();
            String vendorquery="select distinct VENDOR_NAME from vendor order by VENDOR_NAME";
            ps = con.prepareStatement(vendorquery);
            rs = ps.executeQuery();
            while (rs.next()) {
             String vendor=rs.getString(1);
             String query="select count(PRODUCT_ID) as qty, sum(PURCHASE_PRICE) as totalprice from vendor_stock where VENDOR=? and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
             ps=con.prepareStatement(query);
             ps.setString(1, vendor);
             rs1=ps.executeQuery();
             while(rs1.next()){
             Long qty=rs1.getLong("qty");
             Long totalprice=rs1.getLong("totalprice");
             String payment="select sum(AMOUNT) as totalpay from company_payment where COMPANY_NAME=? and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
             ps = con.prepareStatement(payment);
            ps.setString(1, vendor);
            rs2 = ps.executeQuery(); 
            while(rs2.next()){
              Long totalpay=  rs2.getLong("totalpay");
              String totalvalue="select sum(PURCHASE_PRICE) from vendor_stock where VENDOR=?";
             ps=con.prepareStatement(totalvalue);
             ps.setString(1, vendor);
             rs3=ps.executeQuery();
             while(rs3.next()){
             Long allvalu=rs3.getLong(1);
             
             String paymenttotal="select sum(AMOUNT) from company_payment where COMPANY_NAME=?";
             ps = con.prepareStatement(paymenttotal);
            ps.setString(1, vendor);
            rs4 = ps.executeQuery(); 
            while(rs4.next()){
             Long allpay=rs4.getLong(1);
             Long allbalance=allpay-allvalu;
             StockModel stm=new StockModel();
             stm.setFactory(vendor);
             stm.setStockqty(qty);
             stm.setStockprice(totalprice);
             stm.setStockpay(totalpay);
             stm.setCompanybalance(allbalance);
             list.add(stm);
             } } } } }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
  try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
  try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    }  
  
  
    public List<Accountant> ExpenseLedger() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        try {
            con = Database.getConnection();
            String query = "select COST_NAME, NOTE, AMOUNT, DATE from cost where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) order by DATE, COST_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             
             Accountant stm=new Accountant();
             stm.setCostname(rs.getString(1));
             stm.setExnote(rs.getString(2));
             stm.setCostamount(rs.getFloat(3));
             stm.setCostdate(rs.getString(4));
            
             list.add(stm);
            }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    } 
   public Accountant TotalExpense(){
        Accountant stm=null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
                
         try {
            con = Database.getConnection();
            String costtotal="select sum(AMOUNT) from cost where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
             ps = con.prepareStatement(costtotal);
             rs = ps.executeQuery();
             rs.next();
             stm=new Accountant();
             stm.setCosttotal(rs.getDouble(1));
            
           
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return stm;    
    }
   public List<Accountant> MonthlyDebitLedger() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = Database.getConnection();
            String query = "select DEBIT_NAME, AMOUNT, DATE from cash_debit where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) order by DATE, DEBIT_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             
             Accountant stm=new Accountant();
             stm.setDebitname(rs.getString(1));
             stm.setDebitamount(rs.getLong(2));
             stm.setDebitdate(rs.getString(3));
            
             list.add(stm);
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
   public Accountant TotalDebit(){
        Accountant stm=null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
                
         try {
            con = Database.getConnection();
            String costtotal="select sum(AMOUNT) from cash_debit where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
             ps = con.prepareStatement(costtotal);
             rs = ps.executeQuery();
             rs.next();
             stm=new Accountant();
             stm.setTotaldebt(rs.getLong(1));
            
           
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return stm;    
    }
   
   public List<Accountant> MonthlyCreditLedger() {
        List<Accountant> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        try {
            con = Database.getConnection();
            String query = "select CREDIT_NAME, AMOUNT, DATE from cash_credit where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) order by DATE, CREDIT_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             
             Accountant stm=new Accountant();
             stm.setCreditname(rs.getString(1));
             stm.setCreditamount(rs.getLong(2));
             stm.setCreditdate(rs.getString(3));
            
             list.add(stm);
            }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    } 
   public Accountant TotalCredit(){
        Accountant stm=null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
                
         try {
            con = Database.getConnection();
            String costtotal="select sum(AMOUNT) from cash_credit where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
             ps = con.prepareStatement(costtotal);
             rs = ps.executeQuery();
             rs.next();
             stm=new Accountant();
             stm.setTotalcredit(rs.getLong(1));
            
           
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return stm;    
    }
    
    
    public List<EmpModel> ProprietorLedger() {
        List<EmpModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        try {
            con = Database.getConnection();
            String pro="select P_NAME, TYPE from proprietor_info where TYPE='Type A' or TYPE='Type B'";
            ps = con.prepareStatement(pro);
            rs=ps.executeQuery();
            while (rs.next()) {
             String prop=rs.getString(1);
            String query = "select  sum(PAYMENT), sum(RECEIVE) from proprietor_cost where PROP_NAME=?";
            ps = con.prepareStatement(query);
            ps.setString(1, prop);
            rs1 = ps.executeQuery();
            while (rs1.next()) {
            
             EmpModel em=new EmpModel();
             em.setPropname(rs.getString(1));
             em.setProtype(rs.getString(2));
             em.setPropayamount(rs1.getLong(1));
             em.setProrecvamount(rs1.getLong(2));
                       
             list.add(em);
            }}
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    } 
    
   
}
