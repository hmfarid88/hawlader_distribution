/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
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
public class MailSendServlet extends HttpServlet {

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
        String to = "tofayel.rana@gmail.com";
        
      
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class",
                "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("info.iyadsoft@gmail@gmail.com", "dlzryywcpgsgwykn");//Put your email id and password here
            }
        });
//compose message
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress("info.iyadsoft@gmail@gmail.com"));//change accordingly
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                       
            message.setSubject("Report From Hawlader Distribution");
            
        MimeBodyPart messageBodyPart = new MimeBodyPart();
        MimeBodyPart messageBodyPart1 = new MimeBodyPart();
        MimeBodyPart messageBodyPart2 = new MimeBodyPart();
        MimeBodyPart messageBodyPart3 = new MimeBodyPart();
        
        Multipart multipart = new MimeMultipart();
       
        String file = "D:\\Backup\\CashBook.pdf";
        String file1 = "D:\\Backup\\CurrentInfo.pdf";
        String file2 = "D:\\Backup\\RetailerLedger.pdf";
        String file3 = "D:\\Backup\\StockSummary.pdf";
        String fileName = "Cash Book.pdf";
        String fileName1 = "Current Info.pdf";
        String fileName2 = "Retailer Ledger.pdf";
        String fileName3 = "Stock Summary.pdf";
        DataSource source = new FileDataSource(file);
        DataSource source1 = new FileDataSource(file1);
        DataSource source2 = new FileDataSource(file2);
        DataSource source3 = new FileDataSource(file3);
        messageBodyPart.setDataHandler(new DataHandler(source));
        messageBodyPart1.setDataHandler(new DataHandler(source1));
        messageBodyPart2.setDataHandler(new DataHandler(source2));
        messageBodyPart3.setDataHandler(new DataHandler(source3));
        messageBodyPart.setFileName(fileName);
        messageBodyPart1.setFileName(fileName1);
        messageBodyPart2.setFileName(fileName2);
        messageBodyPart3.setFileName(fileName3);
        multipart.addBodyPart(messageBodyPart);
        multipart.addBodyPart(messageBodyPart1);
        multipart.addBodyPart(messageBodyPart2);
        multipart.addBodyPart(messageBodyPart3);
        message.setContent(multipart);

            //send message
            Transport.send(message);
            File f=new File("D:\\Backup\\CashBook.pdf");
            File f1=new File("D:\\Backup\\CurrentInfo.pdf");
            File f2=new File("D:\\Backup\\RetailerLedger.pdf");
            File f3=new File("D:\\Backup\\StockSummary.pdf");
            f.delete();
            f1.delete();
            f2.delete();
            f3.delete();
            out.println("<h3>Email Sent Successfully</h3>");
        } catch (MessagingException e) {
//            throw new RuntimeException(e);
            out.println("<h3>Check Your Internet Connection and Ensure Expected Files Are Downloaded in Backup Folder.</h3>");
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
