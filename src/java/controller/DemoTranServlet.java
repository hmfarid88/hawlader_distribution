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
public class DemoTranServlet extends HttpServlet {

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
        String from=" from ";
        Float amount=Float.parseFloat(request.getParameter("amount"));
        String remark=request.getParameter("remark");
                        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs=null;
               
            try {
                con = Database.getConnection();
                if(type.equals("Payment")){
              String nbalance="select AMOUNT from netbalance order by SI_NO DESC limit 1";
                    ps = con.prepareStatement(nbalance);
                    rs=ps.executeQuery();
                    rs.next();
                    Long lbalance=rs.getLong(1);
            if(lbalance<amount){
              out.println("<center><br><h2>Sorry, Insufficient Balance !</h2></center>");  
            }else{
                    String query="insert into demo_transaction(TR_TYPE, REMARK, AMOUNT, DATE) values"
                        + "(?,?,?,CURDATE())";
                ps = con.prepareStatement(query);
                ps.setString(1, type);
                ps.setString(2, remark);
                ps.setFloat(3, amount);
                int b = ps.executeUpdate();
                    if (b > 0) {
                        String cashcredit="insert into cash_credit(CREDIT_NAME, AMOUNT, DATE) values(?,?, CURDATE())";
                        ps = con.prepareStatement(cashcredit);
                        ps.setString(1, type+from+remark);
                        ps.setFloat(2, amount);
                        ps.executeUpdate();
                        response.sendRedirect("accountant.jsp");
                    }else{
                        out.println("Transaction is not Success !");
                }
            }   
            }else{
                   
                    String query="insert into demo_transaction (TR_TYPE, REMARK, AMOUNT, DATE) values"
                        + "(?,?,?,CURDATE())";
                ps = con.prepareStatement(query);
                ps.setString(1, type);
                ps.setString(2, remark);
                ps.setFloat(3, amount);
                int b = ps.executeUpdate();
                    if (b > 0) {
                        String cashdebit="insert into cash_debit(DEBIT_NAME, AMOUNT, DATE) values(?,?, CURDATE())";
                        ps = con.prepareStatement(cashdebit);
                        ps.setString(1, type+from+remark);
                        ps.setFloat(2, amount);
                        ps.executeUpdate();
                        response.sendRedirect("accountant.jsp");
                        
                    }else{
                        out.println("Transaction is not Success !");
                     } 
                    
                             }  } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
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
