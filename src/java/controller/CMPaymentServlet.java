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
public class CMPaymentServlet extends HttpServlet {

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
        String name=request.getParameter("name");
        String lperson=request.getParameter("lperson");
        Float amount=Float.parseFloat(request.getParameter("amount")) ;
    
       Connection con = null;
       PreparedStatement ps=null;
       ResultSet rs0=null; 
       ResultSet rs=null;  
       ResultSet rs1=null;
       ResultSet rs2=null;
        try{
            con = Database.getConnection();
            if(name.equals("Receive")){
              String find="select count(*) from cm_payment where PROP_NAME='"+ lperson +"'";
              ps = con.prepareStatement(find);
              rs0=ps.executeQuery();
              rs0.next();
              int p=rs0.getInt(1);
              if(p>0){
                String recv="select SI_NO, PRINCIPAL, DATE from cm_payment where SI_NO in(select max(SI_NO) from cm_payment where PROP_NAME='"+ lperson +"')";
              ps = con.prepareStatement(recv);
              rs=ps.executeQuery();
              rs.next();
              int sino=rs.getInt(1);
              
              Float prin=rs.getFloat(2);
              String date=rs.getString(3);
              String datedif="SELECT DATEDIFF(CURDATE(), '"+ date +"') AS DateDiff from cm_payment";
              ps = con.prepareStatement(datedif);
              rs1=ps.executeQuery();
              rs1.next();
              int ddif=rs1.getInt("DateDiff");
              String ratee="select IPL from proprietor_info where P_NAME='"+ lperson +"'";
              ps = con.prepareStatement(ratee);
              rs2=ps.executeQuery();
              rs2.next();
              Float rate=rs2.getFloat(1);
              String receventry="insert into cm_payment (PROP_NAME, RECEIVE, PRINCIPAL, RATE, DATE) values (?,?,?,?, CURDATE())";
              ps = con.prepareStatement(receventry);
              ps.setString(1, lperson);
              ps.setFloat(2, amount);
              ps.setFloat(3, prin-amount);
              ps.setFloat(4, rate);
              ps.executeUpdate();
              String dayupdate="update cm_payment set DAYS=?, INTEREST=? where SI_NO=?";
              ps = con.prepareStatement(dayupdate);
              ps.setInt(1, ddif);
              ps.setFloat(2, (prin*rate*ddif)/3000000);
              ps.setInt(3, sino);
              ps.executeUpdate();
              String query="insert into cash_debit(DEBIT_NAME, AMOUNT, DATE) values(?,?, CURDATE())";
             ps = con.prepareStatement(query);
             ps.setString(1, "Loan receive" + lperson);
             ps.setFloat(2, amount);
             ps.executeUpdate();
              response.sendRedirect("accountant.jsp");
              }else{
                  String ratee="select IPL from proprietor_info where P_NAME='"+ lperson +"'";
              ps = con.prepareStatement(ratee);
              rs2=ps.executeQuery();
              rs2.next();
              Float rate=rs2.getFloat(1);
                  String receventry="insert into cm_payment (PROP_NAME, RECEIVE, PRINCIPAL, RATE, DATE) values (?,?,?,?, CURDATE())";
              ps = con.prepareStatement(receventry);
              ps.setString(1, lperson);
              ps.setFloat(2, amount);
              ps.setFloat(3, 0-amount);
              ps.setFloat(4, rate);
              ps.executeUpdate();
              String query="insert into cash_debit(DEBIT_NAME, AMOUNT, DATE) values(?,?, CURDATE())";
             ps = con.prepareStatement(query);
             ps.setString(1, "Loan receive" + lperson);
             ps.setFloat(2, amount);
             ps.executeUpdate();
              response.sendRedirect("accountant.jsp");
              }
            }else if(name.equals("Payment")){
                    String nbalance="select AMOUNT from netbalance order by SI_NO DESC limit 1";
                    ps = con.prepareStatement(nbalance);
                    rs1=ps.executeQuery();
                    rs1.next();
                    Long lbalance=rs1.getLong(1);
            if(lbalance<amount){
              out.println("<center><br><h2>Sorry, Insufficient Balance !</h2></center>");  
            }else{ 
                String find="select count(*) from cm_payment where PROP_NAME='"+ lperson +"'";
              ps = con.prepareStatement(find);
              rs0=ps.executeQuery();
              rs0.next();
              int p=rs0.getInt(1);
              if(p>0){
                String recv="select SI_NO, PRINCIPAL, DATE from cm_payment where SI_NO in(select max(SI_NO) from cm_payment where PROP_NAME='"+ lperson +"')";
              ps = con.prepareStatement(recv);
              rs=ps.executeQuery();
              rs.next();
              int sino=rs.getInt(1);
             
              Float prin=rs.getFloat(2);
              String date=rs.getString(3);
              String datedif="SELECT DATEDIFF(CURDATE(), '"+ date +"') AS DateDiff from cm_payment";
              ps = con.prepareStatement(datedif);
              rs1=ps.executeQuery();
              rs1.next();
              int ddif=rs1.getInt("DateDiff");
              String ratee="select IPL from proprietor_info where P_NAME='"+ lperson +"'";
              ps = con.prepareStatement(ratee);
              rs2=ps.executeQuery();
              rs2.next();
              Float rate=rs2.getFloat(1);
              String receventry="insert into cm_payment (PROP_NAME, PAYMENT, PRINCIPAL, RATE, DATE) values (?,?,?,?, CURDATE())";
              ps = con.prepareStatement(receventry);
              ps.setString(1, lperson);
              ps.setFloat(2, amount);
              ps.setFloat(3, prin+amount);
              ps.setFloat(4, rate);
              ps.executeUpdate();
              String dayupdate="update cm_payment set DAYS=?, INTEREST=? where SI_NO=?";
              ps = con.prepareStatement(dayupdate);
              ps.setInt(1, ddif);
              ps.setFloat(2, (prin*rate*ddif)/3000000);
              ps.setInt(3, sino);
              ps.executeUpdate();
              String query="insert into cash_credit(CREDIT_NAME, AMOUNT, DATE) values(?,?, CURDATE())";
             ps = con.prepareStatement(query);
             ps.setString(1, "Loan payment" + lperson);
             ps.setFloat(2, amount);
             ps.executeUpdate();
              response.sendRedirect("accountant.jsp");
              }else{
                 String ratee="select IPL from proprietor_info where P_NAME='"+ lperson +"'";
              ps = con.prepareStatement(ratee);
              rs2=ps.executeQuery();
              rs2.next();
              Float rate=rs2.getFloat(1);
              String receventry="insert into cm_payment (PROP_NAME, PAYMENT, PRINCIPAL, RATE, DATE) values (?,?,?,?, CURDATE())";
              ps = con.prepareStatement(receventry);
              ps.setString(1, lperson);
              ps.setFloat(2, amount);
              ps.setFloat(3, amount);
              ps.setFloat(4, rate);
              ps.executeUpdate(); 
              String query="insert into cash_credit(CREDIT_NAME, AMOUNT, DATE) values(?,?, CURDATE())";
             ps = con.prepareStatement(query);
             ps.setString(1, "Loan payment" + lperson);
             ps.setFloat(2, amount);
             ps.executeUpdate();
              response.sendRedirect("accountant.jsp");
              }
            }
          
            }else if(name.equals("Interest Receive")){
                String find="select count(*) from cm_payment where PROP_NAME='"+ lperson +"'";
              ps = con.prepareStatement(find);
              rs0=ps.executeQuery();
              rs0.next();
              int p=rs0.getInt(1);
              if(p>0){
                String recv="select SI_NO, PRINCIPAL, RATE, DATE from cm_payment where SI_NO in(select max(SI_NO) from cm_payment where PROP_NAME='"+ lperson +"')";
              ps = con.prepareStatement(recv);
              rs=ps.executeQuery();
              rs.next();
              int sino=rs.getInt(1);
              Float prin=rs.getFloat(2);
              Float rate=rs.getFloat(3);
              String date=rs.getString(4);
              String datedif="SELECT DATEDIFF(CURDATE(), '"+ date +"') AS DateDiff from cm_payment";
              ps = con.prepareStatement(datedif);
              rs1=ps.executeQuery();
              rs1.next();
              int ddif=rs1.getInt("DateDiff");
              String dayupdate="update cm_payment set DAYS=?, INTEREST=? where SI_NO=?";
              ps = con.prepareStatement(dayupdate);
              ps.setInt(1, ddif);
              ps.setFloat(2, (prin*rate*ddif)/3000000);
              ps.setInt(3, sino);
              ps.executeUpdate();
              String receventry="insert into cm_payment (PROP_NAME, PRINCIPAL, RATE, INTE_RECV, DATE) values (?,?,?,?, CURDATE())";
              ps = con.prepareStatement(receventry);
              ps.setString(1, lperson);
              ps.setFloat(2, prin);
              ps.setFloat(3, rate);
              ps.setFloat(4, amount);
              ps.executeUpdate();
              String query="insert into cash_debit(DEBIT_NAME, AMOUNT, DATE) values(?,?, CURDATE())";
             ps = con.prepareStatement(query);
             ps.setString(1, "Loan interest from" + lperson);
             ps.setFloat(2, amount);
             ps.executeUpdate();
             ps.executeUpdate();
              response.sendRedirect("accountant.jsp");
              }else{
                 out.println("<h3>Sorry! This propritor's has no transaction.</h3>"); 
              }
            }else if(name.equals("Interest Payment")){
                String nbalance="select AMOUNT from netbalance order by SI_NO DESC limit 1";
                    ps = con.prepareStatement(nbalance);
                    rs1=ps.executeQuery();
                    rs1.next();
                    Long lbalance=rs1.getLong(1);
            if(lbalance<amount){
              out.println("<center><br><h2>Sorry, Insufficient Balance !</h2></center>");  
            }else{ 
                 String find="select count(*) from cm_payment where PROP_NAME='"+ lperson +"'";
              ps = con.prepareStatement(find);
              rs0=ps.executeQuery();
              rs0.next();
              int p=rs0.getInt(1);
              if(p>0){
                String recv="select SI_NO, PRINCIPAL, RATE, DATE from cm_payment where SI_NO in(select max(SI_NO) from cm_payment where PROP_NAME='"+ lperson +"')";
              ps = con.prepareStatement(recv);
              rs=ps.executeQuery();
              rs.next();
              int sino=rs.getInt(1);
              Float prin=rs.getFloat(2);
              Float rate=rs.getFloat(3);
              String date=rs.getString(4);
              String datedif="SELECT DATEDIFF(CURDATE(), '"+ date +"') AS DateDiff from cm_payment";
              ps = con.prepareStatement(datedif);
              rs1=ps.executeQuery();
              rs1.next();
              int ddif=rs1.getInt("DateDiff");
              String dayupdate="update cm_payment set DAYS=?, INTEREST=? where SI_NO=?";
              ps = con.prepareStatement(dayupdate);
              ps.setInt(1, ddif);
              ps.setFloat(2, (prin*rate*ddif)/3000000);
              ps.setInt(3, sino);
              ps.executeUpdate();
              String receventry="insert into cm_payment (PROP_NAME, PRINCIPAL, RATE, INTE_PAY, DATE) values (?,?,?,?, CURDATE())";
              ps = con.prepareStatement(receventry);
              ps.setString(1, lperson);
              ps.setFloat(2, prin);
              ps.setFloat(3, rate);
              ps.setFloat(4, amount);
              ps.executeUpdate();
              String query="insert into cost(COST_NAME, NOTE, AMOUNT, DATE) values(?,?,?, CURDATE())";
             ps = con.prepareStatement(query);
             ps.setString(1, "Interest Payment");
             ps.setString(2, lperson);
             ps.setFloat(3, amount);
             ps.executeUpdate();
              response.sendRedirect("accountant.jsp");
              }else{
                 out.println("<h3>Sorry! This propritor's has no transaction.</h3>"); 
              }
            }
            }
           
            }
        catch(Exception ex){
            
        }finally {
   try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
   try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (rs0 != null) rs0.close(); rs0=null; } catch (SQLException ex2) { }
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
