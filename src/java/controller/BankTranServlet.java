/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DB.Database;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Acer
 */
public class BankTranServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String type=request.getParameter("type");
        String at=" at ";
        String from=" from ";
        Float amount=Float.parseFloat(request.getParameter("amount"));
        String bank=request.getParameter("bank");
        String branch=request.getParameter("branch");
        String payer=request.getParameter("payer");
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs=null;
        ResultSet rs1=null; 
        ResultSet rs11=null; 
        ResultSet rs12=null; 
        ResultSet rs13=null; 
        ResultSet rs2=null;
            try {
                con = Database.getConnection();
                if(type.equals("Withdraw")){
                String deposit="select sum(AMOUNT) from bank_transition where TYPE='Deposit' and BANK='"+ bank +"'";
                ps = con.prepareStatement(deposit);
                rs=ps.executeQuery();
                rs.next();
                Long totaldepo=rs.getLong(1);
                String withdrw="select sum(AMOUNT) from bank_transition where TYPE='Withdraw' and BANK='"+ bank +"'";
                ps = con.prepareStatement(withdrw);
                rs1=ps.executeQuery();
                rs1.next();
                Long totalwithd=rs1.getLong(1);
                Long balance=totaldepo-totalwithd;
                if(balance<amount){
                    out.println("<center><br><h2>Sorry, Insufficient Bank Balance !</h2></center>"); 
                }else{
                    String query="insert into bank_transition (TYPE, AMOUNT, BANK, BRANCH, PAYER, DATE) values"
                        + "(?,?,?,?,?,CURDATE())";
                ps = con.prepareStatement(query);
                ps.setString(1, type);
                ps.setFloat(2, amount);
                ps.setString(3, bank);
                ps.setString(4, branch);
                ps.setString(5, payer);
                int b = ps.executeUpdate();
                    if (b > 0) {
                        String maxsi="select MAX(SI_NO) from bank_transition where BANK='"+ bank +"'";
                         ps = con.prepareStatement(maxsi);
                         rs11=ps.executeQuery();
                         rs11.next();
                         int maxsino=rs11.getInt(1);
                         String ldeposit="select sum(AMOUNT) from bank_transition where TYPE='Deposit' and BANK='"+ bank +"'";
                ps = con.prepareStatement(ldeposit);
                rs12=ps.executeQuery();
                rs12.next();
                Long ltotaldepo=rs12.getLong(1);
                String lwithdrw="select sum(AMOUNT) from bank_transition where TYPE='Withdraw' and BANK='"+ bank +"'";
                ps = con.prepareStatement(lwithdrw);
                rs13=ps.executeQuery();
                rs13.next();
                Long ltotalwithd=rs13.getLong(1);
                Long lbalance=ltotaldepo-ltotalwithd;
                String blup="update bank_transition set BALANCE=? where SI_NO=?";
                ps = con.prepareStatement(blup);
                ps.setLong(1, lbalance);
                ps.setInt(2, maxsino);
                ps.executeUpdate();
                        String cashdebit="insert into cash_debit(DEBIT_NAME, AMOUNT, DATE) values(?,?, CURDATE())";
                        ps = con.prepareStatement(cashdebit);
                        ps.setString(1, type+from+bank);
                        ps.setFloat(2, amount);
                        ps.executeUpdate();
                        response.sendRedirect("accountant.jsp");
                    }else{
                        out.println("Transaction is not Success !");
                    } } }else{
                    String nbalance="select AMOUNT from netbalance order by SI_NO DESC limit 1";
                    ps = con.prepareStatement(nbalance);
                    rs2=ps.executeQuery();
                    rs2.next();
                    Long lbalance=rs2.getLong(1);
            if(lbalance<amount){
              out.println("<center><br><h2>Sorry, Insufficient Cash Balance !</h2></center>");  
            }else{
                    String query="insert into bank_transition (TYPE, AMOUNT, BANK, BRANCH, PAYER, DATE) values"
                        + "(?,?,?,?,?,CURDATE())";
                ps = con.prepareStatement(query);
                ps.setString(1, type);
                ps.setFloat(2, amount);
                ps.setString(3, bank);
                ps.setString(4, branch);
                ps.setString(5, payer);
                int b = ps.executeUpdate();
                    if (b > 0) {
                        String maxsi="select MAX(SI_NO) from bank_transition where BANK='"+ bank +"'";
                         ps = con.prepareStatement(maxsi);
                         rs11=ps.executeQuery();
                         rs11.next();
                         int maxsino=rs11.getInt(1);
                         String ldeposit="select sum(AMOUNT) from bank_transition where TYPE='Deposit' and BANK='"+ bank +"'";
                ps = con.prepareStatement(ldeposit);
                rs12=ps.executeQuery();
                rs12.next();
                Long ltotaldepo=rs12.getLong(1);
                String lwithdrw="select sum(AMOUNT) from bank_transition where TYPE='Withdraw' and BANK='"+ bank +"'";
                ps = con.prepareStatement(lwithdrw);
                rs13=ps.executeQuery();
                rs13.next();
                Long ltotalwithd=rs13.getLong(1);
                Long llbalance=ltotaldepo-ltotalwithd;
                String blup="update bank_transition set BALANCE=? where SI_NO=?";
                ps = con.prepareStatement(blup);
                ps.setLong(1, llbalance);
                ps.setInt(2, maxsino);
                ps.executeUpdate();
                        String cashcredit="insert into cash_credit(CREDIT_NAME, AMOUNT, DATE) values(?,?, CURDATE())";
                        ps = con.prepareStatement(cashcredit);
                        ps.setString(1, type+at+bank);
                        ps.setFloat(2, amount);
                        ps.executeUpdate();
                        response.sendRedirect("accountant.jsp");
                    }else{
                        out.println("Transaction is not Success !");
                }
            }  }  } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs2 != null) rs2.close(); } catch (SQLException ex2) { }
   try { if (rs1 != null) rs1.close(); } catch (SQLException ex2) { }
   try { if (rs11 != null) rs11.close(); } catch (SQLException ex2) { }
   try { if (rs12 != null) rs12.close(); } catch (SQLException ex2) { }
   try { if (rs13 != null) rs13.close(); } catch (SQLException ex2) { }
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
