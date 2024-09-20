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
public class PaymentServlet extends HttpServlet {

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
        
            String srname=request.getParameter("srname");
            String cname = request.getParameter("customername");
            String qnt = request.getParameter("qunt");
            Float total = Float.parseFloat(request.getParameter("total"));
            Float discount = Float.parseFloat(request.getParameter("totaldis"));
            Float vat = Float.parseFloat(request.getParameter("vat"));
            Float addis = Float.parseFloat(request.getParameter("addis"));
            String adnote = request.getParameter("addisnote");
            Float grandtotal = Float.parseFloat(request.getParameter("grandtotal"));
            String customerid = request.getParameter("customerid");
            String invo = "NOV2018";
            String invoice = invo + customerid;

            Connection con = null;
            PreparedStatement ps = null;
            try {
                con = Database.getConnection();
                String query = "insert into paymentinfo (TOTAL, DISCOUNT, VAT, GRAND_TOTAL, QUANTITY, CUSTOMER_ID, INVOICE_NO, SR_NAME, DATE ) values (?,?,?,?,?,?,?,?,CURDATE())";
                ps = con.prepareStatement(query);

                ps.setFloat(1, total);
                ps.setFloat(2, discount+addis);
                ps.setFloat(3, vat);
                ps.setFloat(4, grandtotal-addis);
                ps.setString(5, qnt);
                ps.setString(6, customerid);
                ps.setString(7, invoice);
                ps.setString(8, srname);

                int a = ps.executeUpdate();
                if (a > 0) {
                    String query1 = "insert into customerinfo (C_NAME, AREA_NAME, BOSS_NAME, DATE) select R_NAME, ADDRESS, OWNER, CURDATE() from retailer_info where R_NAME=?";
                    ps = con.prepareStatement(query1);
                    ps.setString(1, cname);
                    int b = ps.executeUpdate();
                    if(b>0){
                    String up="update mobilesell set SR_NAME=?, RETAILER=? where CUSTOMER_ID=?";
                    ps = con.prepareStatement(up);
                    ps.setString(1, srname);
                    ps.setString(2, cname);
                    ps.setString(3, customerid);
                    int x=ps.executeUpdate();
                    if(x>0){
                    
                        String statement="insert into retailer_statement(DATE, INVOICE, RETAILER, QTY, VALUE) values (CURDATE(),?,?,?,?)";
                    ps = con.prepareStatement(statement);
                    ps.setString(1, invoice);
                    ps.setString(2, cname);
                    ps.setString(3, qnt);
                    ps.setFloat(4, grandtotal);
                    ps.executeUpdate();
                    if(addis>0){
                      String additional="insert into additionaldis (RETAILER, INVOICENO, CUSTOMER_ID, NOTE, AMOUNT, DATE) values (?,?,?,?,?,CURDATE())";
                    ps = con.prepareStatement(additional);   
                    ps.setString(1, cname);
                    ps.setString(2, invoice);
                    ps.setString(3, customerid);
                    ps.setString(4, adnote);
                    ps.setFloat(5, addis);
                    ps.executeUpdate();  
                    String addstatement="insert into retailer_statement(DATE, RETAILER, PAYMENT, NOTE)values(CURDATE(),?,?,?)";
                ps = con.prepareStatement(addstatement);
                ps.setString(1, cname);
                ps.setFloat(2, addis);
                ps.setString(3, "Additional Discount"+adnote);
                ps.executeUpdate();
                    }
                    response.sendRedirect("voucher.jsp");
                    }}
                } else {
                    out.println("Sorry! Entry is not Success");
                }
            } catch (SQLException ex) {
                  out.println("<h3>Sorry! Sale Process is not completed try again</h3>");
            }finally {
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
        
        PrintWriter out = response.getWriter();
         String cname = request.getParameter("customername");
         String qnt = request.getParameter("qunt");
         Float grandtotal = Float.parseFloat(request.getParameter("grandtotal"));
         Long addis = Long.parseLong(request.getParameter("addis"));
               
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
//compose message
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs=null;   
        ResultSet rs1=null;
        ResultSet rs2=null;
        ResultSet rs3=null;
try {
          con = Database.getConnection();
          String query="select EMAIL from retailer_info where R_NAME=?";
          ps=con.prepareStatement(query);
          ps.setString(1, cname);
          rs=ps.executeQuery();
          rs.next();
          String mailto=rs.getString(1);
           if(mailto.equals("No")){
              
          }else{
          String query1="select sum(PRICE-DISCOUNT) from mobilesell where RETAILER=?";
          ps=con.prepareStatement(query1);
          ps.setString(1, cname);
          rs1=ps.executeQuery();
          rs1.next();
          Long totalvalue=rs1.getLong(1);
          String query2="select sum(AMOUNT) from customer_pay where RETAILER=?";
          ps=con.prepareStatement(query2);
          ps.setString(1, cname);
          rs2=ps.executeQuery();
          rs2.next();
          Long totalpay=rs2.getLong(1);
          String additional="select sum(AMOUNT) from additionaldis where RETAILER=? ";
                                        ps = con.prepareStatement(additional);
                                        ps.setString(1, cname);
                                        rs3 = ps.executeQuery(); 
                                        rs3.next();
                                        Long additionaldis=rs3.getLong(1);
          Long due=totalvalue-totalpay-additionaldis;
          String rtdue=String.valueOf(due);
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress("tofayelahamed.rana2@gmail.com"));//change accordingly
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(mailto));
            message.setSubject("Hawlader Distribution (Product Distribution Report)");
            StringBuilder sb = new StringBuilder();
            sb.append("From Hawlader Distribution House").append(System.lineSeparator());
            sb.append("Dear,").append(System.lineSeparator());
            sb.append(cname).append(System.lineSeparator());
            sb.append("Your purchase product quantity is "+qnt).append(System.lineSeparator());
            sb.append("Your purchase product value is TK "+(grandtotal-addis)).append(System.lineSeparator());
            sb.append("Your current Due is TK "+rtdue).append(System.lineSeparator());
            sb.append("(If something is wrong, please inform the house urgently)").append(System.lineSeparator());
            sb.append("Thanking You").append(System.lineSeparator());
            sb.append("HAWLADER DISTRIBUTION HOUSE");
            message.setText(sb.toString());
                       //send message
            Transport.send(message);
           }
                 } catch (Exception e) {
try { 
    
     String query="select EMAIL from retailer_info where R_NAME=?";
          ps=con.prepareStatement(query);
          ps.setString(1, cname);
          rs=ps.executeQuery();
          rs.next();
          String mailto=rs.getString(1);
          String query1="select sum(PRICE-DISCOUNT) from mobilesell where RETAILER=?";
          ps=con.prepareStatement(query1);
          ps.setString(1, cname);
          rs1=ps.executeQuery();
          rs1.next();
          Long totalvalue=rs1.getLong(1);
          String query2="select sum(AMOUNT) from customer_pay where RETAILER=?";
          ps=con.prepareStatement(query2);
          ps.setString(1, cname);
          rs2=ps.executeQuery();
          rs2.next();
          Long totalpay=rs2.getLong(1);
          String additional="select sum(AMOUNT) from additionaldis where RETAILER=? ";
                                        ps = con.prepareStatement(additional);
                                        ps.setString(1, cname);
                                        rs3 = ps.executeQuery(); 
                                        rs3.next();
                                        Long additionaldis=rs3.getLong(1);
          Long due=totalvalue-totalpay-additionaldis;
          String reemail="insert into re_email_sale(RETAILER, QTY, AMOUNT, DUE, EMAIL, DATE) values (?,?,?,?,?, CURDATE())";
          ps=con.prepareStatement(reemail);
          ps.setString(1, cname);
          ps.setString(2, qnt);
          ps.setFloat(3, grandtotal-addis);
          ps.setLong(4, due);
          ps.setString(5, mailto);
          ps.executeUpdate(); 
 } 
 catch (Exception ex2){}
        }finally {
   try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
   try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
   try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
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
