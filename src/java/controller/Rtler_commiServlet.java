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
public class Rtler_commiServlet extends HttpServlet {

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
        
        String rtname=request.getParameter("retailer");
        String note=request.getParameter("note");
        Float amount=Float.parseFloat(request.getParameter("amount"));
                
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs=null;
        ResultSet rs1=null;       
        try{
            con = Database.getConnection();
            String query="insert into rtler_commission (RETAILER_NAME, NOTE, AMOUNT, DATE) values (?,?,?, CURDATE())";
            ps = con.prepareStatement(query);
            ps.setString(1, rtname);
            ps.setString(2, note);
            ps.setFloat(3, amount);
            int a=ps.executeUpdate();
            if(a>0){
                String sino = "select MAX(SI_NO) from  order_delevery where ORDER_NAME=? order by SI_NO DESC limit 1";
                ps = con.prepareStatement(sino);
                ps.setString(1, rtname);
                rs = ps.executeQuery();
                rs.next();
                int rtno = rs.getInt(1);
                String bl="select sum(BALANCE) from order_delevery where SI_NO=?";
                ps = con.prepareStatement(bl);
                ps.setInt(1, rtno);
                rs1=ps.executeQuery();
                rs1.next();
                Float bln=rs1.getFloat(1);
                Float newbln=bln-amount;
                String update = "insert into order_delevery (ORDER_NAME, BALANCE, COMMISSION, COMI_NOTE, DATE) values(?,?,?,?, CURDATE())";
                ps = con.prepareStatement(update);
                ps.setString(1, rtname);
                ps.setFloat(2, newbln);
                ps.setFloat(3, amount);
                ps.setString(4, note);
                
                ps.executeUpdate();
                response.sendRedirect("retailer_ledger.jsp");
            }else{
                out.println("Commission is not Added!");
            }
            
            
            }catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs1 != null) rs1.close(); } catch (SQLException ex2) { }
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
