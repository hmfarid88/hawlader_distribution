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
public class DelUpServlet extends HttpServlet {

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
        
        int sino=Integer.parseInt(request.getParameter("sino"));
        
        String retler=request.getParameter("retler");
        String dnote=request.getParameter("dnote");
        String tno=request.getParameter("tno");
        String tport=request.getParameter("tport");
        int qty=Integer.parseInt(request.getParameter("qty"));
        Float rate=Float.parseFloat(request.getParameter("rate"));
        Float trent=Float.parseFloat(request.getParameter("trent"));
        Float valu=qty*rate;
        Connection con=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        ResultSet rs1=null;
        ResultSet rs2=null;
        ResultSet rs3=null;
        try{
            con=Database.getConnection();
            String query="select sum(BALANCE) from  order_delevery where ORDER_NAME=? and SI_NO =?";
            ps = con.prepareStatement(query);
            ps.setString(1, retler);
            ps.setInt(2, sino);
            rs = ps.executeQuery();
            rs.next();
            Float bl=rs.getFloat(1);
            String query1="select PRODUCT_NAME, QTY, PURSE_RATE, RATE from  order_delevery where SI_NO=?";
            ps = con.prepareStatement(query1);
            ps.setInt(1, sino);
            rs1 = ps.executeQuery();
            rs1.next();
            String proname=rs1.getString(1);
            int oldqty=rs1.getInt(2);
            Float prsrate=rs1.getFloat(3);
            Float oldrate=rs1.getFloat(4);
            Float oldvalue=oldqty*oldrate;
            Float newbl=(bl-oldvalue)+valu;
            
            String update="update order_delevery set NOTE=?, QTY=?, RATE=?, BALANCE=?, TRUCK_NO=?, RENT=? where SI_NO=?";
            ps = con.prepareStatement(update);
            ps.setString(1, dnote);
            ps.setInt(2, qty);
            ps.setFloat(3, rate);
            ps.setDouble(4, newbl);
            ps.setString(5, tno);
            ps.setFloat(6, trent);
            ps.setInt(7, sino);
            ps.executeUpdate();
            
            String tnssi="select MAX(SI_NO) from transport_pay where TRANSPORT_NAME=? order by SI_NO DESC limit 1";
                 ps = con.prepareStatement(tnssi);
                 ps.setString(1, tport);
                 rs2=ps.executeQuery();
                 rs2.next();
                 int tsi=rs2.getInt(1);
                 String trnsbl="select RENT, sum(BALANCE) from transport_pay where TRANSPORT_NAME=? and SI_NO=?";
                 ps = con.prepareStatement(trnsbl);
                 ps.setString(1, tport);
                 ps.setInt(2, tsi);
                 rs3=ps.executeQuery();
                 rs3.next();
                 Double lastrent=rs3.getDouble(1);
                 Double lastbl=rs3.getDouble(2);
                 Double newtbl=(lastrent+lastbl)-trent;
                 String tportup="update transport_pay set TRUCK_NO=?, QTY=?, RENT=?, BALANCE=? where SI_NO=?";
                 ps = con.prepareStatement(tportup);
                 ps.setString(1, tno);
                 ps.setInt(2, qty);
                 ps.setFloat(3, trent);
                 ps.setDouble(4, newtbl);
                 ps.setInt(5, tsi);
                 int a=ps.executeUpdate();
           if(a>0){
               if(qty>oldqty){
                   int newqty=qty-oldqty;
                   String stockup = "update product_stock set QUANTITY=QUANTITY-? where  PRODUCT_NAME=? and PURSE_PRICE=?";
                        ps = con.prepareStatement(stockup);
                        ps.setInt(1, newqty);
                        ps.setString(2, proname);
                        ps.setFloat(3, prsrate);
                        ps.executeUpdate();
                        response.sendRedirect("delivery_up.jsp");
               }else{
                  int newqty=oldqty-qty;
                   String stockup = "update product_stock set QUANTITY=QUANTITY+? where  PRODUCT_NAME=? and PURSE_PRICE=?";
                        ps = con.prepareStatement(stockup);
                        ps.setInt(1, newqty);
                        ps.setString(2, proname);
                        ps.setFloat(3, prsrate);
                        ps.executeUpdate(); 
                        response.sendRedirect("delivery_up.jsp");
               }
               
           }else{
              
           }
          }catch (Exception ex) {
              ex.printStackTrace();
            }finally {
    try { if (rs3 != null) rs3.close(); } catch (SQLException ex2) { }
    try { if (rs2 != null) rs2.close(); } catch (SQLException ex2) { }
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
        
            Connection con = null;
            PreparedStatement ps = null;
                    try {
                con = Database.getConnection();
                    String query="update reserve_stock set PRODUCT_NAME='PCC', QUANTITY=(select sum(QUANTITY) from  product_stock where PRODUCT_NAME='PCC'), PURSE_PRICE=(select sum(PURSE_PRICE) from product_stock where PRODUCT_NAME='PCC') where PRODUCT_NAME='PCC' and DATE=CURDATE()";
                    ps = con.prepareStatement(query);
                    int x=ps.executeUpdate();
                   
                    if(x>0){
                    
                    }else{
                        String query2="insert into reserve_stock (PRODUCT_NAME, QUANTITY, PURSE_PRICE, DATE) values"
                        + "('PCC',(select sum(QUANTITY) from  product_stock where PRODUCT_NAME='PCC'),(select sum(PURSE_PRICE) from product_stock where PRODUCT_NAME='PCC'),CURDATE())";
                        ps = con.prepareStatement(query2);
                        ps.executeUpdate();
                    
                    }
                                
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }
      try {
                con = Database.getConnection();
                    String query1="update reserve_stock set PRODUCT_NAME='PC', QUANTITY=(select sum(QUANTITY) from  product_stock where PRODUCT_NAME='PC'), PURSE_PRICE=(select sum(PURSE_PRICE) from product_stock where PRODUCT_NAME='PC') where PRODUCT_NAME='PC' and DATE=CURDATE()";
                    ps = con.prepareStatement(query1);
                    int y=ps.executeUpdate(); 
                    if(y>0){
                    
                    }else{
                                              
                         String query3="insert into reserve_stock (PRODUCT_NAME, QUANTITY, PURSE_PRICE, DATE) values"
                        + "('PC',(select sum(QUANTITY) from  product_stock where PRODUCT_NAME='PC'),(select sum(PURSE_PRICE) from product_stock where PRODUCT_NAME='PC'),CURDATE())";
                        ps = con.prepareStatement(query3);
                        ps.executeUpdate();
                    }
                                
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }   
        
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
