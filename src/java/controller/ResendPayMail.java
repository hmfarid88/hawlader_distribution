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
import java.util.Properties;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Acer
 */
public class ResendPayMail extends HttpServlet {

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
        int sino=Integer.parseInt(request.getParameter("sino"));
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class",
                "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("tofayelahamed.rana2@gmail.com", "Tofayelahamed444477");//Put your email id and password here
            }
        });
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            try {
                con = Database.getConnection();
                String query = "select  RETAILER, AMOUNT, DUE, NOTE from re_email_pay where SI_NO=?";
                ps = con.prepareStatement(query);
                ps.setInt(1, sino);
                rs = ps.executeQuery();
                rs.next();
                String retailer = rs.getString(1);
                Float amount = rs.getFloat(2);
                Float due = rs.getFloat(3);
                String note=rs.getString(4);
                String query1 = "select EMAIL from retailer_info where R_NAME=?";
                ps = con.prepareStatement(query1);
                ps.setString(1, retailer);
                rs1 = ps.executeQuery();
                rs1.next();
                String mailto = rs1.getString(1);
                 if(mailto.equals("No")){
              out.println("<h3>Sorry, set Retailer's email address and try again !</h3>");
          }else{
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress("tofayelahamed.rana2@gmail.com"));//change accordingly
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(mailto));
            message.setSubject("Hawlader Distribution (Retailer Payment Report)");
            StringBuilder sb = new StringBuilder();
            sb.append("From Hawlader Distribution House").append(System.lineSeparator());
            sb.append("Dear,").append(System.lineSeparator());
            sb.append(retailer).append(System.lineSeparator());
            sb.append("Your current payment is TK "+amount).append(System.lineSeparator());
            sb.append("Your payment type: "+note).append(System.lineSeparator());
            sb.append("Your current Due is TK "+due).append(System.lineSeparator());
            sb.append("(If something is wrong, please inform the house urgently)").append(System.lineSeparator());
            sb.append("Thanking You").append(System.lineSeparator());
            sb.append("HAWLADER DISTRIBUTION HOUSE");
            message.setText(sb.toString());
                       //send message
            Transport.send(message);
            String delete="delete from re_email_pay where SI_NO=?";
            ps = con.prepareStatement(delete);
            ps.setInt(1, sino);
            ps.executeUpdate();
            response.sendRedirect("pending_mail.jsp");
                 }
                                     } catch (Exception ex) {
                  out.println("<h3>Sorry! Check internet connection and try again.</h3>");
                  try { 
                  String query = "select  RETAILER, AMOUNT, DUE, NOTE from re_email_pay where SI_NO=?";
                ps = con.prepareStatement(query);
                ps.setInt(1, sino);
                rs = ps.executeQuery();
                rs.next();
                String retailer = rs.getString(1);
                Long amount = rs.getLong(2);
                Long due = rs.getLong(3);
                String note=rs.getString(4);
                String query1 = "select EMAIL from retailer_info where R_NAME=?";
                ps = con.prepareStatement(query1);
                ps.setString(1, retailer);
                rs1 = ps.executeQuery();
                rs1.next();
                String mailto = rs1.getString(1);
                  String reemail="insert into re_email_pay(RETAILER, AMOUNT, DUE, EMAIL, NOTE, DATE) values (?,?,?,?,?, CURDATE())";
          ps=con.prepareStatement(reemail);
          ps.setString(1, retailer);
          ps.setLong(2, amount);
          ps.setLong(3, due);
          ps.setString(4, mailto);
          ps.setString(5, note);
          ps.executeUpdate(); 
          String delete="delete from re_email_pay where SI_NO=?";
            ps = con.prepareStatement(delete);
            ps.setInt(1, sino);
            ps.executeUpdate();
                  }catch (Exception ex2){}
            }finally {
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
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
