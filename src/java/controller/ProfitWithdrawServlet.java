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
public class ProfitWithdrawServlet extends HttpServlet {

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
        String month=request.getParameter("month"); 
        String year=request.getParameter("year"); 
        Double amount=Double.parseDouble(request.getParameter("amount"));
        String pw="Profit withdraw,";
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            ResultSet rs1=null;
            ResultSet rs2=null;
            ResultSet rs3=null;
            ResultSet rs4=null;
            ResultSet rs5=null;
            try {
                con = Database.getConnection();
                String nbalance="select AMOUNT from netbalance order by SI_NO DESC limit 1";
            ps = con.prepareStatement(nbalance);
            rs=ps.executeQuery();
            rs.next();
            Long lbalance=rs.getLong(1);
            if(lbalance<amount){
              out.println("<center><br><h2>Sorry, Insufficient Balance !</h2></center>");  
            }else{
                                    String totalsale = "select sum(PURCHASE_PRICE), sum(SALE_PRICE) from vendor_stock where YEAR(DATE) = '"+ year +"' AND MONTH(DATE) = '"+ month +"'";
                                    ps = con.prepareStatement(totalsale);
                                    rs1 = ps.executeQuery();
                                    rs1.next();
                                    Long totalbuy=rs1.getLong(1);
                                    Long totalsle=rs1.getLong(2);
                                    
                                    String commi = "select sum(AMOUNT) from fac_commission where  MONTH=? and YEAR=?";
                                    ps = con.prepareStatement(commi);
                                    ps.setString(1, month);
                                    ps.setString(2, year);
                                    rs2 = ps.executeQuery();
                                    rs2.next();
                                    Long totalcommi=rs2.getLong(1);
                                    
                                    String totalcost = "select sum(AMOUNT) from cost where  YEAR(DATE) = '"+ year +"' AND MONTH(DATE) = '"+ month +"'";
                                    ps = con.prepareStatement(totalcost);
                                    rs3 = ps.executeQuery();
                                    rs3.next();
                                    Long totlcost=rs3.getLong(1);
                                    
                                    String totalemp = "select sum(AMOUNT) from emp_cost where  YEAR(DATE) = '"+ year +"' AND MONTH(DATE) = '"+ month +"'";
                                    ps = con.prepareStatement(totalemp);
                                    rs4 = ps.executeQuery();
                                    rs4.next();
                                    Long totalempcost=rs4.getLong(1);
                                    String totalwithdraw="select sum(AMOUNT) from profit_withdraw where MONTH=? and YEAR=?";
                                    ps = con.prepareStatement(totalwithdraw);
                                    ps.setString(1, month);
                                    ps.setString(2, year);
                                    rs5 = ps.executeQuery();
                                    rs5.next();
                                    Long totalwith=rs5.getLong(1);
                                    Long netprofit=(totalsle+totalcommi)-(totalbuy+totlcost+totalempcost+totalwith);
                                    if(netprofit<amount){
                                       out.println("<center><br><h2>Sorry, Insufficient Profit !</h2></center>");   
                                    }else{
                String query="insert into profit_withdraw(MONTH, YEAR, AMOUNT, DATE) value (?,?,?,CURDATE())";
                ps = con.prepareStatement(query);
                ps.setString(1, month);
                ps.setString(2, year);
                ps.setDouble(3, amount);
                int b = ps.executeUpdate();
                    if (b > 0) {
                        String query1="insert into cash_credit(CREDIT_NAME, AMOUNT, DATE) values (?,?,CURDATE())";
                        ps = con.prepareStatement(query1);
                        ps.setString(1,pw+month+year);
                        ps.setDouble(2, amount);
                        ps.executeUpdate();
                        response.sendRedirect("sale_profit.jsp");
                    }else{
                        out.println("Transaction is not Entryed");
                    }
            } }
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs5 != null) rs5.close(); } catch (SQLException ex2) { }
   try { if (rs4 != null) rs4.close(); } catch (SQLException ex2) { }
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
