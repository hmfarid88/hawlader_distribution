/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Pojo;

import DB.Database;
import Model.CashModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class CashBook {
   public CashModel DailyCashShow(){
       
        Connection con = null;
        PreparedStatement ps = null;
        CashModel cm=null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rs3 = null;
        ResultSet rs4 = null;
        ResultSet rs5 = null;
        ResultSet rs6 = null;
        ResultSet rs8 = null;
        ResultSet rs9 = null;
        ResultSet rs99 = null;
       
        
        try {
            con = Database.getConnection();
            String query = "select AMOUNT from netbalance where DATE !=CURDATE() order by SI_NO DESC LIMIT 1";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            rs.next();
            Long openbalance=rs.getLong(1);
            
            String query1 = "select sum(AMOUNT) from cash_debit where DATE=CURDATE()";
            ps = con.prepareStatement(query1);
            rs1 = ps.executeQuery();
            rs1.next();
            Long cashdebit=rs1.getLong(1);
            
            String query2 = "select sum(AMOUNT) from customer_pay where DATE=CURDATE()";
            ps = con.prepareStatement(query2);
            rs2 = ps.executeQuery();
            rs2.next();
            Long retpay=rs2.getLong(1);
            
            String query3 = "select sum(RECEIVE) from proprietor_cost where DATE=CURDATE() ";
            ps = con.prepareStatement(query3);
            rs3 = ps.executeQuery();
            rs3.next();
            Long prorecv=rs3.getLong(1);
            
            String query4 = "select sum(AMOUNT) from cash_credit where DATE=CURDATE()";
            ps = con.prepareStatement(query4);
            rs4 = ps.executeQuery();
            rs4.next();
            Long cashcredit=rs4.getLong(1);
            
            String query5 = "select sum(AMOUNT) from company_payment where DATE=CURDATE()";
            ps = con.prepareStatement(query5);
            rs5 = ps.executeQuery();
            rs5.next();
            Long compay=rs5.getLong(1);
            
            String query6 = "select sum(AMOUNT) from cost where DATE=CURDATE()";
            ps = con.prepareStatement(query6);
            rs6 = ps.executeQuery();
            rs6.next();
            Long cost=rs6.getLong(1);
                                    
            String query8 = "select sum(AMOUNT) from emp_cost where DATE=CURDATE() ";
            ps = con.prepareStatement(query8);
            rs8 = ps.executeQuery();
            rs8.next();
            Long empcost=rs8.getLong(1);
            
            String query9 = "select sum(PAYMENT) from proprietor_cost where DATE=CURDATE() ";
            ps = con.prepareStatement(query9);
            rs9 = ps.executeQuery();
            rs9.next();
            Long propay=rs9.getLong(1);
            
            String query99 = "select sum(AMOUNT) from customer_pay where PAY_TYPE='Bank' and DATE=CURDATE()";
            ps = con.prepareStatement(query99);
            rs99 = ps.executeQuery();
            rs99.next();
            Long retbankpay=rs99.getLong(1);
            
            Long totaldebit=openbalance+cashdebit+retpay+prorecv;
            Long totalcredit=cashcredit+compay+cost+empcost+propay+retbankpay;
            Long netbalance=totaldebit-totalcredit;
            

            cm=new CashModel();
            cm.setOpenbalance(openbalance);
            cm.setTotaldebit(totaldebit);
            cm.setTotalcredit(totalcredit);
            cm.setNetbalance(netbalance);
            
            String balanceup = "update netbalance set AMOUNT=? where  DATE=CURDATE() ";
            ps = con.prepareStatement(balanceup);
            ps.setLong(1, netbalance);
            int b = ps.executeUpdate();
            if (b > 0) {

            } else {
                String balancein = "insert into netbalance (AMOUNT, DATE) values (?,CURDATE())";
                ps = con.prepareStatement(balancein);
                ps.setLong(1, netbalance);
                ps.executeUpdate();
            }
            
        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs99 != null) rs99.close(); } catch (SQLException ex2) { }
  try { if (rs9 != null) rs9.close(); } catch (SQLException ex2) { }
  try { if (rs8 != null) rs8.close(); } catch (SQLException ex2) { }
  try { if (rs6 != null) rs6.close();  } catch (SQLException ex2) { }
  try { if (rs5 != null) rs5.close();  } catch (SQLException ex2) { }
  try { if (rs4 != null) rs4.close();  } catch (SQLException ex2) { }
  try { if (rs3 != null) rs3.close();  } catch (SQLException ex2) { }
  try { if (rs2 != null) rs2.close();  } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); } catch (SQLException ex2) { }
  try { if (rs != null) rs.close();  } catch (SQLException ex2) { }
  try { if (ps != null) ps.close();  } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return cm;
   } 
 public List<CashModel> DebitShow() {
        List<CashModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select DEBIT_NAME, AMOUNT from cash_debit where DATE=CURDATE()"
                    + "UNION ALL select RETAILER, AMOUNT from customer_pay where PAY_TYPE='Cash' and DATE=CURDATE()"
                    + "UNION ALL select PAY_NAME, RECEIVE from proprietor_cost where DATE=CURDATE() and PAY_NAME='Receive'";
                  
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                CashModel cm = new CashModel();
                cm.setDebitname(rs.getString(1));
                cm.setDebitamount(rs.getLong(2));
                
                list.add(cm);
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

 public List<CashModel> CreditShow() {
        List<CashModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select CREDIT_NAME, AMOUNT from cash_credit where DATE=CURDATE()"
                    + "UNION ALL select COMPANY_NAME, AMOUNT from company_payment where PAY_TYPE='Cash' and DATE=CURDATE()"
                    + "UNION ALL select COST_NAME, AMOUNT from cost where DATE=CURDATE()"
                    + "UNION ALL select EMP_NAME, AMOUNT from emp_cost where DATE=CURDATE()"
                    + "UNION ALL select PAY_NAME, PAYMENT from proprietor_cost where DATE=CURDATE() and PAY_NAME='Payment'";
                  
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                CashModel cm = new CashModel();
                cm.setCrname(rs.getString(1));
                cm.setCramount(rs.getLong(2));
                
                list.add(cm);
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
 
 public List<CashModel> BankLedger() {
        List<CashModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
               
        try {
            con = Database.getConnection();
            String tname="select BANK_NAME from bank_name";
            ps = con.prepareStatement(tname);
            rs = ps.executeQuery();
            while (rs.next()) {
            String bank=rs.getString(1);
            String query = "select sum(AMOUNT) from bank_transition where TYPE='Deposit' and BANK=? ";
            ps = con.prepareStatement(query);
            ps.setString(1, bank);
            rs1 = ps.executeQuery();
            while (rs1.next()) {
            Long deposit1=rs1.getLong(1);
            String withdraw = "select sum(AMOUNT) from bank_transition where TYPE='Withdraw' and BANK=? ";
            ps = con.prepareStatement(withdraw);
            ps.setString(1, bank);
            rs2 = ps.executeQuery();
            while (rs2.next()) {
            Long withdraw1=rs2.getLong(1);
                        
            Long tdeposit=deposit1;
            Long twithdraw=withdraw1;
            Long balance=tdeposit-twithdraw;
            CashModel ac=new CashModel();
             ac.setBankname(rs.getString(1));
             ac.setDeposit(tdeposit);
             ac.setWithdraw(twithdraw);
             ac.setBalance(balance);
             
             list.add(ac);
            } } }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  
  try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    } 
   
 public CashModel bankBlance(){
     CashModel cm=null;   
     Connection con = null;
     PreparedStatement ps = null;
     ResultSet rs = null; 
     ResultSet rs1 = null;
    
     try {
            con = Database.getConnection();
            String bankbl="select sum(Amount) as totaldeposit from bank_transition where TYPE='Deposit'";
            ps = con.prepareStatement(bankbl);
            rs=ps.executeQuery();
            rs.next();
            Long deposittotal=rs.getLong("totaldeposit");
            
            String bankwit="select sum(Amount) as totalwith from bank_transition where TYPE='Withdraw'";
            ps = con.prepareStatement(bankwit);
            rs1=ps.executeQuery();
            rs1.next();
            Long withtotal=rs1.getLong("totalwith");
            
            Long bankbalance=deposittotal-withtotal;
            cm=new CashModel();
            cm.setBankbalance(bankbalance);
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
   try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return cm;
   } 
 public CashModel propritorBlance(){
     CashModel cm=null;   
     Connection con = null;
     PreparedStatement ps = null;
     ResultSet rs = null; 
     ResultSet rs1 = null;
     ResultSet rs2 = null;
     try {
            con = Database.getConnection();

            String bankwit="select sum(PAYMENT) from proprietor_cost where TYPE='Type B'";
            ps = con.prepareStatement(bankwit);
            rs1=ps.executeQuery();
            rs1.next();
            Long paytotal=rs1.getLong(1);
            String bankwitt="select sum(RECEIVE) from proprietor_cost where TYPE='Type B'";
            ps = con.prepareStatement(bankwitt);
            rs2=ps.executeQuery();
            rs2.next();
            Long recvtotal=rs2.getLong(1);
            Long propblance=recvtotal-paytotal;
            cm=new CashModel();
            cm.setPropblance(propblance);
             }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return cm;
   } 
 
}
