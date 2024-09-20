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
public class PropitercostServlet extends HttpServlet {

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
        String name=request.getParameter("name");
        String propname=request.getParameter("propname");
        Float amount=Float.parseFloat(request.getParameter("amount")) ;
    
       Connection con = null;
       PreparedStatement ps=null;
       ResultSet rs0=null;  
       ResultSet rs=null;  
       ResultSet rs1=null;
       ResultSet rs2=null;
        try{
            con = Database.getConnection();
            String protype="select TYPE from proprietor_info where P_NAME=?";
            ps = con.prepareStatement(protype);
            ps.setString(1, propname);
            rs0=ps.executeQuery();
            rs0.next();
            String type=rs0.getString(1);
            if(name.equals("Payment")){
            String nbalance="select AMOUNT from netbalance order by SI_NO DESC limit 1";
                    ps = con.prepareStatement(nbalance);
                    rs=ps.executeQuery();
                    rs.next();
                    Long lbalance=rs.getLong(1);
            if(lbalance<amount){
              out.println("<center><br><h2>Sorry, Insufficient Balance !</h2></center>");  
            }else{
                String query="insert into proprietor_cost(PROP_NAME, TYPE, PAY_NAME, PAYMENT, DATE) values(?,?,?,?, CURDATE())";
            ps = con.prepareStatement(query);
            ps.setString(1, propname);
            ps.setString(2, type);
            ps.setString(3, name);
            ps.setDouble(4, amount);
            int a = ps.executeUpdate();
             if (a > 0) {
            String propay="select sum(PAYMENT), sum(RECEIVE) from proprietor_cost where PROP_NAME=?";
            ps = con.prepareStatement(propay);
            ps.setString(1, propname);
            rs1=ps.executeQuery();
            rs1.next();
            Long totalpay=rs1.getLong(1);
            Long totalrecv=rs1.getLong(2);
            Long bl=totalrecv-totalpay;
            String maxsi="select MAX(SI_NO) from proprietor_cost where PROP_NAME=?";
            ps = con.prepareStatement(maxsi);
            ps.setString(1, propname);
            rs2=ps.executeQuery();
            rs2.next();
            int maxsino=rs2.getInt(1);
            String update="update proprietor_cost set BALANCE=? where SI_NO=?";
            ps = con.prepareStatement(update);
            ps.setLong(1, bl);
            ps.setInt(2, maxsino);
            ps.executeUpdate();
                response.sendRedirect("accountant.jsp");
            } else {
                out.println("Sorry! Entry is not Success");
            } }
        }else{
                String query = "insert into proprietor_cost(PROP_NAME, TYPE, PAY_NAME, RECEIVE, DATE) values(?,?,?,?, CURDATE())";
                ps = con.prepareStatement(query);
                ps.setString(1, propname);
                ps.setString(2, type);
                ps.setString(3, name);
                ps.setDouble(4, amount);

                int a = ps.executeUpdate();
                if (a > 0) {
            String propay="select sum(PAYMENT), sum(RECEIVE) from proprietor_cost where PROP_NAME=?";
            ps = con.prepareStatement(propay);
            ps.setString(1, propname);
            rs1=ps.executeQuery();
            rs1.next();
            Long totalpay=rs1.getLong(1);
            Long totalrecv=rs1.getLong(2);
            Long bl=totalrecv-totalpay;
            String maxsi="select MAX(SI_NO) from proprietor_cost where PROP_NAME=?";
            ps = con.prepareStatement(maxsi);
            ps.setString(1, propname);
            rs2=ps.executeQuery();
            rs2.next();
            int maxsino=rs2.getInt(1);
            String update="update proprietor_cost set BALANCE=? where SI_NO=?";
            ps = con.prepareStatement(update);
            ps.setLong(1, bl);
            ps.setInt(2, maxsino);
            ps.executeUpdate();
                    response.sendRedirect("accountant.jsp");
                } else {
                    out.println("Sorry! Entry is not Success");
                }
            }
        
        
        
        }
        catch(Exception ex){
            
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
