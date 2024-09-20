
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


public class RetailerpayServlet extends HttpServlet {

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
        
        String rtname=request.getParameter("rtname");
        Float amount=Float.parseFloat(request.getParameter("amount"));
        String paytype=request.getParameter("paytype");
        String cby=request.getParameter("cby");
        String bank=request.getParameter("bank");
        String branch=request.getParameter("branch");
        String payer=request.getParameter("payer");
        String adjustnote=request.getParameter("adjustnote");
        String factory=request.getParameter("factory");
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs11=null;
        ResultSet rs12=null;
        ResultSet rs13=null;
        ResultSet rs14=null;      
        try{
            con = Database.getConnection();
            if(paytype.equals("Bank") && bank.equals("")){
                out.println("<center><br><h2>Sorry, Select any Bank and try again !</h2></center>");
            }else if(paytype.equals("Adjustment") && adjustnote.equals("")){
                out.println("<center><br><h2>Sorry, Fill Adjust Note and try again !</h2></center>");
                }else if(paytype.equals("Adjustment") && factory.equals("")){
                 out.println("<center><br><h2>Sorry, Select Company and try again !</h2></center>");   
            }else if(paytype.equals("Adjustment") && adjustnote.equals(adjustnote) && factory.equals(factory)){
                 String query="insert into customer_pay (RETAILER, PAY_TYPE, AMOUNT, COLLECTED_BY, BANK_NAME, BRANCH, PAYER, NOTE, DATE) values (?,?,?,?,?,?,?,?,CURDATE())";
            ps=con.prepareStatement(query);
            ps.setString(1, rtname);
            ps.setString(2, paytype);
            ps.setFloat(3, amount);
            ps.setString(4, cby);
            ps.setString(5, bank);
            ps.setString(6, branch);
            ps.setString(7, payer);
            ps.setString(8, adjustnote);
            int a=ps.executeUpdate();
            if(a>0){
            String maxid="select MAX(SI_NO) from customer_pay";
                ps = con.prepareStatement(maxid);
                rs14=ps.executeQuery();
                rs14.next();
                int maxpayid=rs14.getInt(1);
                String statement="insert into retailer_statement (DATE, RETAILER, PAYMENT, NOTE, PAYID)values(CURDATE(),?,?,?,?)";
                ps = con.prepareStatement(statement);
                ps.setString(1, rtname);
                ps.setFloat(2, amount);
                ps.setString(3, paytype+","+adjustnote);
                ps.setInt(4, maxpayid);
                ps.executeUpdate();
                String query1="insert into company_payment(COMPANY_NAME, PAY_TYPE, AMOUNT, DATE) values(?,?,?,CURDATE())";
             ps = con.prepareStatement(query1);
             ps.setString(1, factory);
             ps.setString(2, paytype+"," +rtname+","+adjustnote);
             ps.setFloat(3, amount);
             ps.executeUpdate();
             String comstate="insert into company_statement (COMPANY, PAYMENT, PAY_TYPE, DATE) values (?,?,?,CURDATE())";
              ps = con.prepareStatement(comstate);
              ps.setString(1, factory);
              ps.setFloat(2, amount); 
              ps.setString(3, paytype+"("+adjustnote+")");
              ps.executeUpdate();
             String query2="insert into adjustment(RETAILER, NOTE, AMOUNT, DATE) values(?,?,?,CURDATE())";
             ps = con.prepareStatement(query2);
             ps.setString(1, rtname);
             ps.setString(2, paytype+"," +rtname+","+adjustnote);
             ps.setFloat(3, amount);
             ps.executeUpdate();
             response.sendRedirect("retailer_payment.jsp");

            }else{
               out.println("Payment is not Updated !"); 
                }
            }else if(paytype.equals("Bank") && bank.equals(bank)){
            String query="insert into customer_pay (RETAILER, PAY_TYPE, AMOUNT, COLLECTED_BY, BANK_NAME, BRANCH, PAYER, DATE) values (?,?,?,?,?,?,?,CURDATE())";
            ps=con.prepareStatement(query);
            ps.setString(1, rtname);
            ps.setString(2, paytype);
            ps.setFloat(3, amount);
            ps.setString(4, cby);
            ps.setString(5, bank);
            ps.setString(6, branch);
            ps.setString(7, payer);
            int a=ps.executeUpdate();
            if(a>0){
            String query1="insert into bank_transition (TYPE, AMOUNT, BANK, BRANCH, PAYER, DATE) values"
                        + "(?,?,?,?,?,CURDATE())";
                ps = con.prepareStatement(query1);
                ps.setString(1, "Deposit");
                ps.setFloat(2, amount);
                ps.setString(3, bank);
                ps.setString(4, branch);
                ps.setString(5, rtname);
                ps.executeUpdate();
                String maxsi="select MAX(SI_NO) from bank_transition where BANK='"+ bank +"'";
                         ps = con.prepareStatement(maxsi);
                         rs11=ps.executeQuery();
                         rs11.next();
                         int maxsino=rs11.getInt(1);
                         String ldeposit="select sum(AMOUNT) from bank_transition where TYPE='Deposit' and BANK='"+ bank +"'";
                ps = con.prepareStatement(ldeposit);
                rs12=ps.executeQuery();
                rs12.next();
                Long ltotaldepo=rs12.getLong(1);
                String lwithdrw="select sum(AMOUNT) from bank_transition where TYPE='Withdraw' and BANK='"+ bank +"'";
                ps = con.prepareStatement(lwithdrw);
                rs13=ps.executeQuery();
                rs13.next();
                Long ltotalwithd=rs13.getLong(1);
                Long lbalance=ltotaldepo-ltotalwithd;
                String blup="update bank_transition set BALANCE=? where SI_NO=?";
                ps = con.prepareStatement(blup);
                ps.setLong(1, lbalance);
                ps.setInt(2, maxsino);
                ps.executeUpdate();
                String maxid="select MAX(SI_NO) from customer_pay";
                ps = con.prepareStatement(maxid);
                rs14=ps.executeQuery();
                rs14.next();
                int maxpayid=rs14.getInt(1);
                String statement="insert into retailer_statement (DATE, RETAILER, PAYMENT, NOTE, PAYID)values(CURDATE(),?,?,?,?)";
                ps = con.prepareStatement(statement);
                ps.setString(1, rtname);
                ps.setFloat(2, amount);
                ps.setString(3, paytype);
                ps.setInt(4, maxpayid);
                ps.executeUpdate();
                response.sendRedirect("retailer_payment.jsp");

            }else{
               out.println("Payment is not Updated !"); 
                }
            }else{
            String query="insert into customer_pay (RETAILER, PAY_TYPE, AMOUNT, COLLECTED_BY, BANK_NAME, BRANCH, PAYER, DATE) values (?,?,?,?,?,?,?,CURDATE())";
            ps=con.prepareStatement(query);
            ps.setString(1, rtname);
            ps.setString(2, paytype);
            ps.setFloat(3, amount);
            ps.setString(4, cby);
            ps.setString(5, bank);
            ps.setString(6, branch);
            ps.setString(7, payer);
            int a=ps.executeUpdate();
            if(a>0){
            String maxid="select MAX(SI_NO) from customer_pay";
                ps = con.prepareStatement(maxid);
                rs14=ps.executeQuery();
                rs14.next();
                int maxpayid=rs14.getInt(1);
                String statement="insert into retailer_statement (DATE, RETAILER, PAYMENT, NOTE, PAYID)values(CURDATE(),?,?,?,?)";
                ps = con.prepareStatement(statement);
                ps.setString(1, rtname);
                ps.setFloat(2, amount);
                ps.setString(3, paytype);
                ps.setInt(4, maxpayid);
                ps.executeUpdate();
                
                response.sendRedirect("retailer_payment.jsp");

            }else{
               out.println("Payment is not Updated !"); 
                }
                 
            }  }catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs14 != null) rs14.close(); } catch (SQLException ex2) { }
   try { if (rs13 != null) rs13.close(); } catch (SQLException ex2) { }
   try { if (rs12 != null) rs12.close(); } catch (SQLException ex2) { }
   try { if (rs11 != null) rs11.close(); } catch (SQLException ex2) { }
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
        
        PrintWriter out = response.getWriter();
        String retailer=request.getParameter("rtname");
        String amount=request.getParameter("amount");
        String paytype=request.getParameter("paytype");
        String adjustnote=request.getParameter("adjustnote");
         
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
          ps.setString(1, retailer);
          rs=ps.executeQuery();
          rs.next();
          String mailto=rs.getString(1);
          if(mailto.equals("No")){
              
          }else{
          String query1="select sum(PRICE-DISCOUNT) from mobilesell where RETAILER=?";
          ps=con.prepareStatement(query1);
          ps.setString(1, retailer);
          rs1=ps.executeQuery();
          rs1.next();
          Long totalvalue=rs1.getLong(1);
          String query2="select sum(AMOUNT) from customer_pay where RETAILER=?";
          ps=con.prepareStatement(query2);
          ps.setString(1, retailer);
          rs2=ps.executeQuery();
          rs2.next();
          Long totalpay=rs2.getLong(1);
          String additional="select sum(AMOUNT) from additionaldis where RETAILER=? ";
                                        ps = con.prepareStatement(additional);
                                        ps.setString(1, retailer);
                                        rs3 = ps.executeQuery(); 
                                        rs3.next();
                                        Long additionaldis=rs3.getLong(1);
          Long due=totalvalue-totalpay-additionaldis;
          String rtdue=String.valueOf(due);
        
          MimeMessage message = new MimeMessage(session);
            
            message.setFrom(new InternetAddress("tofayelahamed.rana2@gmail.com"));//change accordingly
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(mailto));
            message.setSubject("HAWLADER DISTRIBUTION (Retailer Payment Report)");
            StringBuilder sb = new StringBuilder();
            sb.append("From Hawlader Distribution House").append(System.lineSeparator());
            sb.append("Dear,").append(System.lineSeparator());
            sb.append(retailer).append(System.lineSeparator());
            sb.append("Your current payment is TK "+amount).append(System.lineSeparator());
            sb.append("Your payment type: "+paytype);
            sb.append(adjustnote).append(System.lineSeparator());
            sb.append("Your current Due is TK "+rtdue).append(System.lineSeparator());
            sb.append("(If something is wrong, please inform the house urgently)").append(System.lineSeparator());
            sb.append("Thanking You").append(System.lineSeparator());
            sb.append("HAWLADER DISTRIBUTION HOUSE");
            message.setText(sb.toString());

           Transport.send(message);
          }
} catch (Exception  ex) { 

 try { 
    
     String query="select EMAIL from retailer_info where R_NAME=?";
          ps=con.prepareStatement(query);
          ps.setString(1, retailer);
          rs=ps.executeQuery();
          rs.next();
          String mailto=rs.getString(1);
          String query1="select sum(PRICE-DISCOUNT) from mobilesell where RETAILER=?";
          ps=con.prepareStatement(query1);
          ps.setString(1, retailer);
          rs1=ps.executeQuery();
          rs1.next();
          Long totalvalue=rs1.getLong(1);
          String query2="select sum(AMOUNT) from customer_pay where RETAILER=?";
          ps=con.prepareStatement(query2);
          ps.setString(1, retailer);
          rs2=ps.executeQuery();
          rs2.next();
          Long totalpay=rs2.getLong(1);
          String additional="select sum(AMOUNT) from additionaldis where RETAILER=? ";
                                        ps = con.prepareStatement(additional);
                                        ps.setString(1, retailer);
                                        rs3 = ps.executeQuery(); 
                                        rs3.next();
                                        Long additionaldis=rs3.getLong(1);
     Long due=totalvalue-totalpay-additionaldis;
     String reemail="insert into re_email_pay(RETAILER, AMOUNT, DUE, EMAIL, NOTE, DATE) values (?,?,?,?,?, CURDATE())";
     ps = con.prepareStatement(reemail);
     ps.setString(1, retailer);
     ps.setString(2, amount);
     ps.setLong(3, due);
     ps.setString(4, mailto);
     ps.setString(5, paytype+"," +adjustnote);
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
