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
public class CompanypayServlet extends HttpServlet {

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
        
        String factory=request.getParameter("factory");
        String note=request.getParameter("note");
        String paytype=request.getParameter("paytype");
        String bank=request.getParameter("bank");
        String branch=request.getParameter("branch");
        String cheque=request.getParameter("cheque");
        String payer=request.getParameter("payer");
        Float amount=Float.parseFloat(request.getParameter("amount")) ;
    
       Connection con = null;
       PreparedStatement ps=null;
       ResultSet rs=null;
       ResultSet rs1=null;
       ResultSet rs11=null;
       ResultSet rs12=null;
       ResultSet rs13=null;
       
       try{
            con = Database.getConnection();
            if(paytype.equals("Bank") && bank.equals("")){
            out.println("<center><br><h2>Sorry, Select any Bank and try again !</h2></center>"); 
            }else if(paytype.equals("Bank") && bank.equals(bank)){
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
                    String query="insert into company_payment(COMPANY_NAME, PAY_TYPE, AMOUNT, BANK_NAME, BRANCE_NAME, CHEQUE_NO, PAYER, DATE) values(?,?,?,?,?,?,?,CURDATE())";
             ps = con.prepareStatement(query);
             ps.setString(1, factory);
             ps.setString(2, paytype+"("+note+")");
             ps.setFloat(3, amount);
             ps.setString(4, bank);
             ps.setString(5, branch);
             ps.setString(6, cheque);
             ps.setString(7, payer);
             int a = ps.executeUpdate();
             if (a > 0) {
             String query1="insert into bank_transition (TYPE, AMOUNT, BANK, BRANCH, PAYER, DATE) values"
                        + "(?,?,?,?,?,CURDATE())";
                ps = con.prepareStatement(query1);
                ps.setString(1, "Withdraw");
                ps.setFloat(2, amount);
                ps.setString(3, bank);
                ps.setString(4, branch);
                ps.setString(5, factory+"("+note+")");
                ps.executeUpdate();
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
                 String cashdebit = "insert into cash_debit(DEBIT_NAME, AMOUNT, DATE) values(?,?, CURDATE())";
                 ps = con.prepareStatement(cashdebit);
                 ps.setString(1, "Withdraw from" + " " + bank);
                 ps.setFloat(2, amount);
                 ps.executeUpdate();
                String comstate="insert into company_statement (COMPANY, PAYMENT, PAY_TYPE, DATE) values (?,?,?,CURDATE())";
              ps = con.prepareStatement(comstate);
              ps.setString(1, factory);
              ps.setFloat(2, amount); 
              ps.setString(3, paytype+"("+note+")");
              ps.executeUpdate();
                 response.sendRedirect("accountant.jsp");
            } else {
                out.println("Sorry! Transaction is not Success");
                }
                }
            }else{
            String nbalance="select AMOUNT from netbalance order by SI_NO DESC limit 1";
            ps = con.prepareStatement(nbalance);
            rs=ps.executeQuery();
            rs.next();
            Long lbalance=rs.getLong(1);
            if(lbalance<amount){
              out.println("<center><br><h2>Sorry, Insufficient Balance !</h2></center>");  
            }else{
             String query="insert into company_payment(COMPANY_NAME, PAY_TYPE, AMOUNT, BANK_NAME, BRANCE_NAME, CHEQUE_NO, PAYER, DATE) values(?,?,?,?,?,?,?,CURDATE())";
             ps = con.prepareStatement(query);
             ps.setString(1, factory);
             ps.setString(2, paytype+"("+note+")");
             ps.setFloat(3, amount);
             ps.setString(4, bank);
             ps.setString(5, branch);
             ps.setString(6, cheque);
             ps.setString(7, payer);
             int a = ps.executeUpdate();
             if (a > 0) {
             String comstate="insert into company_statement (COMPANY, PAYMENT, PAY_TYPE, DATE) values (?,?,?,CURDATE())";
             ps = con.prepareStatement(comstate);
              ps.setString(1, factory);
              ps.setFloat(2, amount); 
              ps.setString(3, paytype+"("+note+")");
             ps.executeUpdate();
                 response.sendRedirect("accountant.jsp");
            } else {
                out.println("Sorry! Transaction is not Success");

        }  } } }
        catch(Exception ex){
            ex.printStackTrace();
        }finally {
      try { if (rs13 != null) rs13.close(); rs13=null; } catch (SQLException ex2) { }
           try { if (rs12 != null) rs12.close(); rs12=null; } catch (SQLException ex2) { }
           try { if (rs11 != null) rs11.close(); rs11=null; } catch (SQLException ex2) { }
           try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
      try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
      try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
      try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
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
