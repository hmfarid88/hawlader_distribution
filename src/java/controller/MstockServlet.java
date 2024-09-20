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
public class MstockServlet extends HttpServlet {

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
       
        String imei = request.getParameter("imei");
       
            String model = request.getParameter("model");
            String color = request.getParameter("color");
            String vendor = request.getParameter("vname");
            String area = request.getParameter("area");
            String store = request.getParameter("store");
            String boss = request.getParameter("boss");
            Float pprice = Float.parseFloat(request.getParameter("pprice"));
            Float sprice = Float.parseFloat(request.getParameter("sprice"));
   
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            ResultSet rss=null;
            try {
                con = Database.getConnection();
                String query = "select count(*) as imeei from stock where IMEI=?";
                ps = con.prepareStatement(query);
                ps.setString(1, imei);
                rs = ps.executeQuery();
                rs.next();
                int a = rs.getInt("imeei");
                String queryy = "select count(*) as imeei from vendor_stock where  PRODUCT_ID=?";
                ps = con.prepareStatement(queryy);
                ps.setString(1, imei);
                rss = ps.executeQuery();
                rss.next();
                int p = rss.getInt("imeei");
                if (a > 0) {
                   out.println("<h3>This Product is already in stock!</h3>");
                }else if(p>0){
                  out.println("<h3>This Product is already in Company stock!</h3>");         
                } else {
                    String query1 = "insert into stock (MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, VENDOR, AREA, STORE, BOSS, DATE)"
                            + "values (?,?,?,?,?,?,?,?,?, CURDATE())";
                    ps = con.prepareStatement(query1);
                    ps.setString(1, model);
                    ps.setString(2, color);
                    ps.setString(3, imei);
                    ps.setFloat(4, pprice);
                    ps.setFloat(5, sprice);
                    ps.setString(6, vendor);
                    ps.setString(7, area);
                    ps.setString(8, store);
                    ps.setString(9, boss);
                    int b = ps.executeUpdate();
                    if (b > 0) {
                        String query2="insert into vendor_stock (PRODUCT, PRODUCT_ID, PURCHASE_PRICE, SALE_PRICE, VENDOR, DATE)"
                                + "values (?,?,?,?,?, CURDATE())";
                    ps = con.prepareStatement(query2);
                    ps.setString(1, model);
                    ps.setString(2, imei);
                    ps.setFloat(3, pprice);
                    ps.setFloat(4, sprice);
                    ps.setString(5, vendor);
                    int c = ps.executeUpdate();
                    if(c>0){
                        String companystatement="update company_statement set QTY=QTY+1 where COMPANY=? and MODEL=? and RATE=? and DATE=CURDATE()";
                        ps = con.prepareStatement(companystatement);
                        ps.setString(1, vendor);
                        ps.setString(2, model);
                        ps.setFloat(3, pprice);
                        int x=ps.executeUpdate();
                        if(x>0){
                        response.sendRedirect("stockentry.jsp");
                        }else{
                            String companyinsert="insert into company_statement (COMPANY, MODEL, QTY, RATE, DATE) values (?,?,'1',?, CURDATE())";
                        ps = con.prepareStatement(companyinsert);
                        ps.setString(1, vendor);
                        ps.setString(2, model);
                        ps.setFloat(3, pprice);
                        ps.executeUpdate();
                        response.sendRedirect("stockentry.jsp");
                        }
                    }else{
                        out.println("Product is not Entryed"); 
                    }
                    } else {
                        out.println("Product is not Entryed");
                    }
                    
                } 

            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rss != null) rss.close(); } catch (SQLException ex2) { }
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
