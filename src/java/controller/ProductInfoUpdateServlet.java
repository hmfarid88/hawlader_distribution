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
public class ProductInfoUpdateServlet extends HttpServlet {

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
        
        String model=request.getParameter("model");
        String color=request.getParameter("color");
        String himei=request.getParameter("himei");
        Float pprice=Float.parseFloat(request.getParameter("pprice"));
        Float sprice=Float.parseFloat(request.getParameter("sprice"));
        String vendor=request.getParameter("vendor");
        Connection con = null;
        PreparedStatement ps = null;
       
        try {
                con = Database.getConnection();
               
                    String query1 = "update stock set  MODEL=?, COLOR=?, IMEI=?, PURCHASE_PRICE=?, SELL_PRICE=?, VENDOR=? where IMEI=?";
                ps = con.prepareStatement(query1);
                ps.setString(1, model);
                ps.setString(2, color);
                ps.setString(3, himei);
                ps.setFloat(4, pprice);
                ps.setFloat(5, sprice);
                ps.setString(6, vendor);
                ps.setString(7, himei);
                
                int x = ps.executeUpdate();
                if (x > 0) {
                    String upquery="update vendor_stock set PRODUCT=?, PRODUCT_ID=?, PURCHASE_PRICE=?, SALE_PRICE=?, VENDOR=? where PRODUCT_ID=?";
                    ps = con.prepareStatement(upquery);
                    ps.setString(1, model);
                    ps.setString(2, himei);
                    ps.setFloat(3, pprice);
                    ps.setFloat(4, sprice);
                    ps.setString(5, vendor);
                    ps.setString(6, himei);
                    ps.executeUpdate();
                    response.sendRedirect("totalStock.jsp");
                } else {
                    out.println("Product Info is not Updated");
                } 

            } catch (SQLException ex) {

            }finally {
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
