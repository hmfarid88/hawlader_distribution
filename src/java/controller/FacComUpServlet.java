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
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Acer
 */
public class FacComUpServlet extends HttpServlet {

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
        int facsi=Integer.parseInt(request.getParameter("facsi"));
        String type=request.getParameter("type");
        Float amount=Float.parseFloat(request.getParameter("amount"));
        Connection con=null;
        PreparedStatement ps=null;
        
        try{
            con=Database.getConnection();
           
                if(type.equals("Plus")){
                
                String up="update fac_commission set AMOUNT=AMOUNT+? where  SI_NO=?";
                ps=con.prepareStatement(up);
                ps.setFloat(1, amount);
                ps.setInt(2, facsi);
                int a=ps.executeUpdate();
                if(a>0){
                 response.sendRedirect("accountant.jsp");
                }else{
                 out.println("Update is not completed !");
                }
            }else{
            String up="update fac_commission set AMOUNT=AMOUNT-? where  SI_NO=?";
                ps=con.prepareStatement(up);
                ps.setFloat(1, amount);
                ps.setInt(2, facsi);
                int a=ps.executeUpdate();
                if(a>0){
                response.sendRedirect("accountant.jsp");
                }else{
                    out.println("Update is not completed !");
                }
            }
        }catch (Exception ex) {
              ex.printStackTrace();
            }finally {
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
