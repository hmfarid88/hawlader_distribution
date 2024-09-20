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
public class BanktranDelServlet extends HttpServlet {

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
        
        int transi=Integer.parseInt(request.getParameter("transi"));
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs=null;
        ResultSet rs1=null;
            try {
                con = Database.getConnection();
                String type="select TYPE, AMOUNT, BANK from bank_transition where SI_NO=?";
                ps = con.prepareStatement(type);
                ps.setInt(1, transi);
                rs=ps.executeQuery();
                rs.next();
                String paytype=rs.getString("TYPE");
                Float amount=rs.getFloat("AMOUNT");
                String bank=rs.getString("BANK");
                if(paytype.equals("Deposit")){
                    String query="insert into cash_debit(DEBIT_NAME, AMOUNT, DATE) values(?,?, CURDATE())";
             ps = con.prepareStatement(query);
             ps.setString(1, "Deposit return from" +bank);
             ps.setFloat(2, amount);
             int a = ps.executeUpdate();
             if(a>0){
                 String dquery = "delete from bank_transition where SI_NO=? ";
                ps = con.prepareStatement(dquery);
                ps.setInt(1, transi);
                ps.executeUpdate();
                response.sendRedirect("accountant.jsp");
                } else {
                    out.println("Transaction is not deleted");
                }
                }else{
                String nbalance="select AMOUNT from netbalance order by SI_NO DESC limit 1";
            ps = con.prepareStatement(nbalance);
            rs1=ps.executeQuery();
            rs1.next();
            Long lbalance=rs1.getLong(1);
            if(lbalance<amount){
              out.println("<center><br><h2>Sorry, Insufficient Balance !</h2></center>");  
            }else{
                    String query="insert into cash_credit(CREDIT_NAME, AMOUNT, DATE) values(?,?, CURDATE())";
            ps = con.prepareStatement(query);
             ps.setString(1, "Withdraw return from" +bank);
             ps.setFloat(2, amount);
             int a = ps.executeUpdate();
             if (a > 0) {
                String dquery = "delete from bank_transition where SI_NO=? ";
                ps = con.prepareStatement(dquery);
                ps.setInt(1, transi);
                ps.executeUpdate();
                response.sendRedirect("accountant.jsp");
                }else {
                    out.println("Transaction is not deleted");
                }
                    
            }  } 
                
                 } catch (SQLException ex) {

            }finally {
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
