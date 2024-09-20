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
public class StockRateUpdate extends HttpServlet {

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
         
        String model=request.getParameter("mname");
        Float pprice=Float.parseFloat(request.getParameter("pprice"));
        Float sprice=Float.parseFloat(request.getParameter("sprice"));
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs=null;

            try {
                con = Database.getConnection();
                String modelquery="select MODEL, PURCHASE_PRICE, count(IMEI) from stock where MODEL=? group by MODEL";
                ps = con.prepareStatement(modelquery);
                ps.setString(1, model);
                rs=ps.executeQuery();
                rs.next();
                String oldmodel=rs.getString(1);
                Float oldprice=rs.getFloat(2);
                int qty=rs.getInt(3);
                String pricedrop="insert into price_drop (MODEL, QTY, PREV_PRICE, NEW_PRICE, DATE) values(?,?,?,?, CURDATE())";
                ps = con.prepareStatement(pricedrop);
                ps.setString(1, oldmodel);
                ps.setInt(2, qty);
                ps.setFloat(3, oldprice);
                ps.setFloat(4, pprice);
                ps.executeUpdate();
                String query = "update stock set PURCHASE_PRICE=?, SELL_PRICE=? where  MODEL=? ";
                ps = con.prepareStatement(query);
                ps.setFloat(1, pprice);
                ps.setFloat(2, sprice);
                ps.setString(3, model);
                int a = ps.executeUpdate();
                if (a > 0) {
                    response.sendRedirect("totalStock.jsp");
                } else {
                    out.println("Price is not Updated");
                }
            } catch (SQLException ex) {
            }finally{
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
