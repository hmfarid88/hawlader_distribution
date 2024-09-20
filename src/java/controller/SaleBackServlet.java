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
public class SaleBackServlet extends HttpServlet {

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
        String soldime=request.getParameter("soldime");
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs0=null;
            ResultSet rs=null;
            ResultSet rs1=null;
            ResultSet rs2=null;
                       
            try {
                con = Database.getConnection();
                String stock = "select count(*) as imeei from stock where  IMEI=?";
                ps = con.prepareStatement(stock);
                ps.setString(1, soldime);
                rs0 = ps.executeQuery();
                rs0.next();
                int y = rs0.getInt("imeei");
                 if (y > 0) {
                      out.println("<h3>This Product is already in stock!</h3>");
                 }else{
                  
                String query = "insert into stock (MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, VENDOR, AREA, STORE, BOSS, DATE) select  MODEL,"
                        + " COLOR, PRODUCT_ID, COST_PRICE, STOCK_RATE, VENDOR, AREA, STORE, BOSS, STOCK_DATE from mobilesell where PRODUCT_ID=?";
                ps = con.prepareStatement(query);
                ps.setString(1, soldime);
                int a = ps.executeUpdate();
                if (a < 1) {
                    out.println("<h3>Sorry ! Invalid Product ID</h3>");
                } else {
                    String query1 = "insert into sale_back (MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, RETAILER, SALE_DATE, BACK_DATE) select  MODEL,"
                        + " COLOR, PRODUCT_ID, COST_PRICE, STOCK_RATE, RETAILER, SELL_DATE, CURDATE() from mobilesell where PRODUCT_ID=?";
                    ps = con.prepareStatement(query1);
                    ps.setString(1, soldime);
                    ps.executeUpdate();
                    String query11="select CUSTOMER_ID, RETAILER, MODEL from mobilesell where PRODUCT_ID=?";
                    ps = con.prepareStatement(query11);
                    ps.setString(1, soldime);
                    rs=ps.executeQuery();
                    rs.next();
                    int cid=rs.getInt("CUSTOMER_ID");
                    String retailer=rs.getString("RETAILER");
                    String model=rs.getString("MODEL");
                    String queryqty="select QUANTITY from paymentinfo where CUSTOMER_ID=?";
                    ps = con.prepareStatement(queryqty);
                    ps.setInt(1, cid);
                    rs1=ps.executeQuery();
                    rs1.next();
                    int slqty=rs1.getInt("QUANTITY");
                    if(slqty>1){
                        String pricequery = "select PRICE from mobilesell where PRODUCT_ID=?";
                        ps = con.prepareStatement(pricequery);
                        ps.setString(1, soldime);
                        rs2 = ps.executeQuery();
                        rs2.next();
                        Float price = rs2.getFloat("PRICE");
                        
                        String update = "update paymentinfo set TOTAL=TOTAL-?, GRAND_TOTAL=GRAND_TOTAL-?, QUANTITY=QUANTITY-1 where CUSTOMER_ID=?";
                        ps = con.prepareStatement(update);
                        ps.setFloat(1, price);
                        ps.setFloat(2, price);
                        ps.setInt(3, cid);
                        ps.executeUpdate();
                        
                        String rtstate = "insert into retailer_statement (DATE, RETAILER, PAYMENT, NOTE)values (CURDATE(), ?,?,?)";
                        ps = con.prepareStatement(rtstate);
                        ps.setString(1, retailer);
                        ps.setFloat(2, price);
                        ps.setString(3, "Sale Back" + model + soldime);
                        ps.executeUpdate();
                        
                        String delete = "delete from mobilesell where PRODUCT_ID=?";
                        ps = con.prepareStatement(delete);
                        ps.setString(1, soldime);
                        ps.executeUpdate();
                        response.sendRedirect("symsellview.jsp");
                      
                    }else{
                        String pricequery = "select PRICE from mobilesell where PRODUCT_ID=?";
                        ps = con.prepareStatement(pricequery);
                        ps.setString(1, soldime);
                        rs2 = ps.executeQuery();
                        rs2.next();
                        Float price = rs2.getFloat("PRICE");
                        
                        String rtstate = "insert into retailer_statement (DATE, RETAILER, PAYMENT, NOTE)values (CURDATE(), ?,?,?)";
                        ps = con.prepareStatement(rtstate);
                        ps.setString(1, retailer);
                        ps.setFloat(2, price);
                        ps.setString(3, "Sale Back" + model + soldime);
                        ps.executeUpdate();
                        
                        String delete = "delete from mobilesell where PRODUCT_ID=?";
                        ps = con.prepareStatement(delete);
                        ps.setString(1, soldime);
                        ps.executeUpdate();
                        
                        String paydelete = "delete from paymentinfo where CUSTOMER_ID=?";
                        ps = con.prepareStatement(paydelete);
                        ps.setInt(1, cid);
                        ps.executeUpdate();
                        
                        response.sendRedirect("symsellview.jsp");
                    }
                }}
    }catch (SQLException ex) {
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
