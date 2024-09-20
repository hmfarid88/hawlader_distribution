/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DB.Database;
import java.io.IOException;
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
public class RetailerSelectServler extends HttpServlet {

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
        String retailer = request.getParameter("retailer");

        try {
            Connection con = Database.getConnection();
            String query = "select R_NAME, LIMIT_AMOUNT from retailer_info where  R_NAME =? ";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, retailer);
            ResultSet rs = ps.executeQuery();
            rs.next();

            Float limit = rs.getFloat("LIMIT_AMOUNT");

            String totalpricevalu = "select sum(PRICE-DISCOUNT) from mobilesell where RETAILER=?";
            ps = con.prepareStatement(totalpricevalu);
            ps.setString(1, retailer);
            ResultSet rs1 = ps.executeQuery();
            rs1.next();
            Float provalue = rs1.getFloat(1);
            String payment = "select sum(AMOUNT) as totalpay from customer_pay where RETAILER=?";
            ps = con.prepareStatement(payment);
            ps.setString(1, retailer);
            ResultSet rs2 = ps.executeQuery();
            rs2.next();
            Float pay = rs2.getFloat("totalpay");

            Float finallimit = (pay + limit) - provalue;
            request.getSession().setAttribute("RETAIL", rs.getString("R_NAME"));
            request.getSession().setAttribute("LAMOUNT", finallimit);
            response.sendRedirect("symmobilesell.jsp");

        } catch (SQLException ex) {
            ex.printStackTrace();

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
