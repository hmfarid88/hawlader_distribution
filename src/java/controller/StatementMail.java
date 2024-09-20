/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DB.Database;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Acer
 */
public class StatementMail extends HttpServlet {

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
         Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class",
                "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
         Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("levelupdistributionhouse@gmail.com", "A016440s");//Put your email id and password here
            }
        });
        String retailer = request.getParameter("retailer");
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs=null;   
        try {
          con = Database.getConnection();
          String query="select EMAIL from retailer_info where R_NAME=?";
          ps=con.prepareStatement(query);
          ps.setString(1, retailer);
          rs=ps.executeQuery();
          rs.next();
          String mailto=rs.getString(1);
           if(mailto.equals("No")){
               out.println("<h3>Retailer's Email Not Found</h3>");
          }else{
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress("levelupdistributionhouse@gmail.com"));//change accordingly
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(mailto));
           
            message.setSubject("Statement From Vivo");
            
        MimeBodyPart messageBodyPart = new MimeBodyPart();
       
        Multipart multipart = new MimeMultipart();
       
        String file = "D:\\Level Up\\Backup File\\RetailerStatement.pdf";
      
        String fileName = "RetailerStatement.pdf";
       
        DataSource source = new FileDataSource(file);
       
        messageBodyPart.setDataHandler(new DataHandler(source));
      
        messageBodyPart.setFileName(fileName);
       
        multipart.addBodyPart(messageBodyPart);
      
        message.setContent(multipart);

            //send message
            Transport.send(message);
            File f=new File("D:\\Level Up\\Backup File\\RetailerStatement.pdf");
           
            f.delete();
         
            out.println("<h3>Email Sent Successfully</h3>");
           }   }
        catch (Exception e) {
//            throw new RuntimeException(e);
            out.println("<h3>Check Your Internet Connection and Ensure Expected Files Are Downloaded in Backup Folder.</h3>");
        }finally{
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
