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
public class MultiMstockServlet extends HttpServlet {

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
       
        String imei1 = request.getParameter("imei1");
        String imei2 = request.getParameter("imei2");
        String imei3 = request.getParameter("imei3");
        String imei4 = request.getParameter("imei4");
        String imei5 = request.getParameter("imei5");
        String imei6 = request.getParameter("imei6");
        String imei7 = request.getParameter("imei7");
        String imei8 = request.getParameter("imei8");
        String imei9 = request.getParameter("imei9");
        String imei10 = request.getParameter("imei10");
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
                String query = "select count(*) as imeei from stock where IMEI=? or IMEI=? or IMEI=? or IMEI=? or IMEI=? or IMEI=? or IMEI=? or IMEI=? or IMEI=? or IMEI=?";
                ps = con.prepareStatement(query);
                ps.setString(1, imei1);
                ps.setString(2, imei2);
                ps.setString(3, imei3);
                ps.setString(4, imei4);
                ps.setString(5, imei5);
                ps.setString(6, imei6);
                ps.setString(7, imei7);
                ps.setString(8, imei8);
                ps.setString(9, imei9);
                ps.setString(10, imei10);
                rs = ps.executeQuery();
                rs.next();
                int a = rs.getInt("imeei");
                String queryy = "select count(*) as imeei from vendor_stock where  PRODUCT_ID=? or PRODUCT_ID=? or PRODUCT_ID=? or PRODUCT_ID=? or PRODUCT_ID=? or PRODUCT_ID=? or PRODUCT_ID=? or PRODUCT_ID=? or PRODUCT_ID=? or PRODUCT_ID=?";
                ps = con.prepareStatement(queryy);
                ps.setString(1, imei1);
                ps.setString(2, imei2);
                ps.setString(3, imei3);
                ps.setString(4, imei4);
                ps.setString(5, imei5);
                ps.setString(6, imei6);
                ps.setString(7, imei7);
                ps.setString(8, imei8);
                ps.setString(9, imei9);
                ps.setString(10, imei10);
                
                rss = ps.executeQuery();
                rss.next();
                int p = rss.getInt("imeei");
                if (a > 0) {
                   out.println("<h3>This Product is already in stock!</h3>");
                }else if(p>0){
                  out.println("<h3>This Product is already in Company stock!</h3>");         
                } else {

                    String query0 = "insert into stock (MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, VENDOR, AREA, STORE, BOSS, DATE)"
                            + "values ('"+ model +"','"+ color +"','"+ imei1 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"','"+ area +"','"+ store +"','"+ boss +"', CURDATE()),"
                            + "('"+ model +"','"+ color +"','"+ imei2 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"','"+ area +"','"+ store +"','"+ boss +"', CURDATE()),"
                            + "('"+ model +"','"+ color +"','"+ imei3 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"','"+ area +"','"+ store +"','"+ boss +"', CURDATE()),"
                            + "('"+ model +"','"+ color +"','"+ imei4 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"','"+ area +"','"+ store +"','"+ boss +"', CURDATE()),"
                            + "('"+ model +"','"+ color +"','"+ imei5 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"','"+ area +"','"+ store +"','"+ boss +"', CURDATE()),"
                            + "('"+ model +"','"+ color +"','"+ imei6 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"','"+ area +"','"+ store +"','"+ boss +"', CURDATE()),"
                            + "('"+ model +"','"+ color +"','"+ imei7 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"','"+ area +"','"+ store +"','"+ boss +"', CURDATE()),"
                            + "('"+ model +"','"+ color +"','"+ imei8 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"','"+ area +"','"+ store +"','"+ boss +"', CURDATE()),"
                            + "('"+ model +"','"+ color +"','"+ imei9 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"','"+ area +"','"+ store +"','"+ boss +"', CURDATE()),"
                            + "('"+ model +"','"+ color +"','"+ imei10 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"','"+ area +"','"+ store +"','"+ boss +"', CURDATE())";
                    ps = con.prepareStatement(query0);
                    int b= ps.executeUpdate();
                    if (b > 0) {
                        String query010="insert into vendor_stock (PRODUCT, PRODUCT_ID, PURCHASE_PRICE, SALE_PRICE, VENDOR, DATE)"
                                + "values ('"+ model +"','"+ imei1 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"', CURDATE()),"
                                + "('"+ model +"','"+ imei2 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"', CURDATE()),"
                                + "('"+ model +"','"+ imei3 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"', CURDATE()),"
                                + "('"+ model +"','"+ imei4 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"', CURDATE()),"
                                + "('"+ model +"','"+ imei5 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"', CURDATE()),"
                                + "('"+ model +"','"+ imei6 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"', CURDATE()),"
                                + "('"+ model +"','"+ imei7 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"', CURDATE()),"
                                + "('"+ model +"','"+ imei8 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"', CURDATE()),"
                                + "('"+ model +"','"+ imei9 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"', CURDATE()),"
                                + "('"+ model +"','"+ imei10 +"','"+ pprice +"','"+ sprice +"','"+ vendor +"', CURDATE())";
                    ps = con.prepareStatement(query010);
                    int l=ps.executeUpdate();
                    if(l>0){
                      String companystatement="update company_statement set QTY=QTY+10 where COMPANY=? and MODEL=? and RATE=? and DATE=CURDATE()";
                        ps = con.prepareStatement(companystatement);
                        ps.setString(1, vendor);
                        ps.setString(2, model);
                        ps.setFloat(3, pprice);
                        int x=ps.executeUpdate();
                        if(x>0){
                        response.sendRedirect("stockentry.jsp");
                        }else{
                            String companyinsert="insert into company_statement (COMPANY, MODEL, QTY, RATE, DATE) values (?,?,'10',?, CURDATE())";
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
              out.println("<h3>Duplicate IMEI is not Entryed</h3>");
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
