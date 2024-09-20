<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Hawlader</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/jquery-ui.css">
        <link rel="icon" type="image/png" href="img/favicon.ico">
    </head>
    <body id="main" style="background-color: #030303; color: #ffffff">
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
        <header>
            <nav style="margin: 0 auto" class="navbar navbar-inverse">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar"> 
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav">
                        <li><a href="accountant.jsp"><span class="fa fa-home"> Home</span></a></li>
                        <li><a data-toggle="collapse" data-target="#datewise" href="#">Datewise</a></li>
                                <li>
                                    <div id="datewise" class="collapse" style="margin: 10px 15px">
                                        <form method="POST" action="datewise_cash_book.jsp" class="form-inline">
                                            <input type="date" name="date1" autocomplete="off" class="form-control input-sm" placeholder="Select Date" required="">
                                            <input type="submit" value="OK" class="btn btn-primary btn-sm">
                                        </form>
                                    </div>
                                </li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a id="pdf" href="#"><span class="fa fa-file-pdf-o"> PDF</span></a></li>
                        <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                    </ul> 
                </div>
            </nav>
        </header>

        <div class="row">

            <div class="col-sm-12">
                <div id="div_print" style="background-color: #030303; color: #ffffff">
                    <center>
                        <h3 style="font-family: fontawaesome" class="text-primary text-center"><b>Cash-Book</b></h3>
                        <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                   
                        <table  border="2" width="90%" class="table-bordered table-responsive" >
                            <thead>
                                <tr>
                                    <th style="text-align: center">Description</th>
                                    <th style="text-align: center">Debit</th>
                                    <th style="text-align: center">Credit</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
        Connection con = null;
        PreparedStatement ps = null;
        
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rs3 = null;
        ResultSet rs4 = null;
        ResultSet rs5 = null;
        ResultSet rs6 = null;
        ResultSet rs8 = null;
        ResultSet rs9 = null;
        ResultSet rs99 = null;
        ResultSet rs10 = null;
        ResultSet rs11 = null; 
        ResultSet rs12 = null;
        ResultSet rs13 = null;
        ResultSet rs14 = null;
        ResultSet rs15 = null;
        ResultSet rs16 = null;
        ResultSet rs17 = null;
        ResultSet rs19 = null;
       
        try {
            con = Database.getConnection();
            String query = "select AMOUNT from netbalance where DATE !=CURDATE() order by SI_NO DESC LIMIT 1";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            rs.next();
            Long openbalance=rs.getLong(1);
            request.setAttribute("opblance", openbalance);
            String query1 = "select sum(AMOUNT) from cash_debit where DATE=CURDATE()";
            ps = con.prepareStatement(query1);
            rs1 = ps.executeQuery();
            rs1.next();
            Long cashdebit=rs1.getLong(1);
            
            String query2 = "select sum(AMOUNT) from customer_pay where DATE=CURDATE()";
            ps = con.prepareStatement(query2);
            rs2 = ps.executeQuery();
            rs2.next();
            Long retpay=rs2.getLong(1);
            
            String query3 = "select sum(RECEIVE) from proprietor_cost where DATE=CURDATE() ";
            ps = con.prepareStatement(query3);
            rs3 = ps.executeQuery();
            rs3.next();
            Long prorecv=rs3.getLong(1);
            
            String query4 = "select sum(AMOUNT) from cash_credit where DATE=CURDATE()";
            ps = con.prepareStatement(query4);
            rs4 = ps.executeQuery();
            rs4.next();
            Long cashcredit=rs4.getLong(1);
            
            String query5 = "select sum(AMOUNT) from company_payment where DATE=CURDATE()";
            ps = con.prepareStatement(query5);
            rs5 = ps.executeQuery();
            rs5.next();
            Long compay=rs5.getLong(1);
            
            String query6 = "select sum(AMOUNT) from cost where DATE=CURDATE()";
            ps = con.prepareStatement(query6);
            rs6 = ps.executeQuery();
            rs6.next();
            Long cost=rs6.getLong(1);
                                    
            String query8 = "select sum(AMOUNT) from emp_cost where DATE=CURDATE() ";
            ps = con.prepareStatement(query8);
            rs8 = ps.executeQuery();
            rs8.next();
            Long empcost=rs8.getLong(1);
            
            String query9 = "select sum(PAYMENT) from proprietor_cost where DATE=CURDATE() ";
            ps = con.prepareStatement(query9);
            rs9 = ps.executeQuery();
            rs9.next();
            Long propay=rs9.getLong(1);
            
            String query99 = "select sum(AMOUNT) from customer_pay where PAY_TYPE='Bank' and DATE=CURDATE()";
            ps = con.prepareStatement(query99);
            rs99 = ps.executeQuery();
            rs99.next();
            Long retbankpay=rs99.getLong(1);
           
            Long totaldebit=openbalance+cashdebit+retpay+prorecv;
            Long totalcredit=cashcredit+compay+cost+empcost+propay+retbankpay;
            Long netbalance=totaldebit-totalcredit; 
            request.setAttribute("totaldbt", totaldebit);
            request.setAttribute("totalcrd", totalcredit);
            request.setAttribute("netbl", netbalance);
            String balanceup = "update netbalance set AMOUNT=? where  DATE=CURDATE() ";
            ps = con.prepareStatement(balanceup);
            ps.setLong(1, netbalance);
            int b = ps.executeUpdate();
            if (b > 0) {

            } else {
                String balancein = "insert into netbalance (AMOUNT, DATE) values (?,CURDATE())";
                ps = con.prepareStatement(balancein);
                ps.setLong(1, netbalance);
                ps.executeUpdate();
            }      
            String dbt = "select DEBIT_NAME, AMOUNT from cash_debit where DATE=CURDATE()";
            ps = con.prepareStatement(dbt);
            rs10 = ps.executeQuery();
            String dbt1="select RETAILER, AMOUNT, PAY_TYPE from customer_pay where DATE=CURDATE()";
            ps = con.prepareStatement(dbt1);
            rs11 = ps.executeQuery();
            String dbt2="select PROP_NAME, PAY_NAME, RECEIVE from proprietor_cost where DATE=CURDATE() and PAY_NAME='Receive'";
            ps = con.prepareStatement(dbt2);
            rs12 = ps.executeQuery();
            String crd = "select CREDIT_NAME, AMOUNT from cash_credit where DATE=CURDATE()";
            ps = con.prepareStatement(crd);
            rs13 = ps.executeQuery();
            String crd1="select COMPANY_NAME, AMOUNT, PAY_TYPE from company_payment where DATE=CURDATE()";
            ps = con.prepareStatement(crd1);
            rs14 = ps.executeQuery();
            String crd2="select COST_NAME, NOTE, AMOUNT from cost where DATE=CURDATE()";
            ps = con.prepareStatement(crd2);
            rs15 = ps.executeQuery();
            String crd3="select EMP_NAME, COST_NAME, AMOUNT from emp_cost where DATE=CURDATE()";
            ps = con.prepareStatement(crd3);
            rs16 = ps.executeQuery();
            String crd4="select PROP_NAME, PAY_NAME, PAYMENT from proprietor_cost where DATE=CURDATE() and PAY_NAME='Payment'";
            ps = con.prepareStatement(crd4);
            rs17 = ps.executeQuery();
            String crd5="select RETAILER, AMOUNT from customer_pay where PAY_TYPE='Bank' and DATE=CURDATE()";
            ps = con.prepareStatement(crd5);
            rs19 = ps.executeQuery();
                                %>
                                <tr>
                                    <th style="text-align: center">Opening Balance</th>
                                    <th style="text-align: center">${opblance}</th>
                                    <td></td>
                                </tr>
                                <%
                                   
                               while (rs10.next()) {
            
                                %>
                                <tr>   
                                    <td style="text-align: center">(DR) <%=rs10.getString(1) %></td> 
                                    <td style="text-align: center"><%= rs10.getLong(2) %></td> 
                                    <td></td> 
                                </tr>
                                <%
                                   }
                               while (rs11.next()) {
            
                                %>
                                <tr>   
                                    <td style="text-align: center"><%=rs11.getString(1) %> (Payment Type <%=rs11.getString(3) %>)</td> 
                                    <td style="text-align: center"><%= rs11.getLong(2) %></td> 
                                    <td></td> 
                                </tr>
                                <%
                                   }
                               while (rs12.next()) {
            
                                %>
                                <tr>   
                                    <td style="text-align: center"><%=rs12.getString(2) %> from <%=rs12.getString(1) %></td> 
                                    <td style="text-align: center"><%= rs12.getLong(3) %></td> 
                                    <td></td> 
                                </tr>
                             
                                <%  }
                                   while (rs13.next()) {
                                %>
                                <tr>
                                    <td style="text-align: center">(CR) <%=rs13.getString(1) %></td> 
                                    <td></td>
                                    <td style="text-align: center"><%=rs13.getLong(2)%></td> 
                                </tr>
                                <%  }
                                   while (rs14.next()) {
                                %>
                                <tr>
                                    <td style="text-align: center"><%=rs14.getString(1) %> (Payment Type <%=rs14.getString(3) %>)</td> 
                                    <td></td>
                                    <td style="text-align: center"><%=rs14.getLong(2)%></td> 
                                </tr>
                                <%  }
                                   while (rs15.next()) {
                                %>
                                <tr>
                                    <td style="text-align: center"><%=rs15.getString(1) %> (<%=rs15.getString(2) %>)</td> 
                                    <td></td>
                                    <td style="text-align: center"><%=rs15.getLong(3)%></td> 
                                </tr>
                                <%  }
                                   while (rs16.next()) {
                                %>
                                <tr>
                                    <td style="text-align: center"><%=rs16.getString(1) %> For <%=rs16.getString(2) %></td> 
                                    <td></td>
                                    <td style="text-align: center"><%=rs16.getLong(3)%></td> 
                                </tr>
                                <%  }
                                   while (rs17.next()) {
                                %>
                                <tr>
                                    <td style="text-align: center"><%=rs17.getString(2) %> to <%=rs17.getString(1) %></td> 
                                    <td></td>
                                    <td style="text-align: center"><%=rs17.getLong(3)%></td> 
                                </tr>
                                 <%  }
                                   while (rs19.next()) {
                                %>
                                <tr>
                                    <td style="text-align: center"> <%=rs19.getString(1) %> by Bank</td> 
                                    <td></td>
                                    <td style="text-align: center"><%=rs19.getLong(2)%></td> 
                                </tr>
                                <%
                               }  
}catch (SQLException ex) {
            ex.printStackTrace();
           
            }finally {
try { if (rs19 != null) rs19.close(); } catch (SQLException ex2) { }
try { if (rs17 != null) rs17.close(); } catch (SQLException ex2) { }
try { if (rs16 != null) rs16.close(); } catch (SQLException ex2) { }
try { if (rs15 != null) rs15.close(); } catch (SQLException ex2) { }
try { if (rs14 != null) rs14.close(); } catch (SQLException ex2) { }
try { if (rs13 != null) rs13.close(); } catch (SQLException ex2) { }
try { if (rs12 != null) rs12.close(); } catch (SQLException ex2) { }  
try { if (rs11 != null) rs11.close(); } catch (SQLException ex2) { }
try { if (rs10 != null) rs10.close(); } catch (SQLException ex2) { }
try { if (rs99 != null) rs99.close(); } catch (SQLException ex2) { }
try { if (rs9 != null) rs9.close(); } catch (SQLException ex2) { }
  try { if (rs8 != null) rs8.close(); } catch (SQLException ex2) { }
  try { if (rs6 != null) rs6.close();  } catch (SQLException ex2) { }
  try { if (rs5 != null) rs5.close();  } catch (SQLException ex2) { }
  try { if (rs4 != null) rs4.close();  } catch (SQLException ex2) { }
  try { if (rs3 != null) rs3.close();  } catch (SQLException ex2) { }
  try { if (rs2 != null) rs2.close();  } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); } catch (SQLException ex2) { }
  try { if (rs != null) rs.close();  } catch (SQLException ex2) { }
  try { if (ps != null) ps.close();  } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }       
        }
                                %>


                                <tr style="border-bottom-color: black">

                                    <th style="text-align: center;border-left-style: hidden"></th>
                                    <th style="text-align: center;border-left-style: hidden"><u>${totaldbt}</u></th>
                                    <th style="text-align: center;border-left-style: hidden;border-right-style: hidden"><u>${totalcrd}</u></th>
                                </tr>
                                <tr style="border-style: hidden">
                                    <th style="text-align: center;border-style: hidden">Nit Balance</th>
                                    <th id="netbl" style="text-align: center;border-style: hidden"><u>${netbl}</u></th>
                                    <th style="text-align: center;border-style: hidden"></th>
                                </tr>

                            </tbody>
                        </table>
                 
                    </center>
                </div>
            </div>

        </div>

        <br><br><br><br>
        <%@include file = "footerpage.jsp" %>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
        <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script language="javascript">
    	$('#pdf').click(function () {
    var HTML_Width = $("#div_print").width();
 var HTML_Height = $("#div_print").height();
 var top_left_margin = 15;
 var PDF_Width = HTML_Width+(top_left_margin*2);
 var PDF_Height = (PDF_Width*1.5)+(top_left_margin*2);
 var canvas_image_width = HTML_Width;
 var canvas_image_height = HTML_Height;
 
 var totalPDFPages = Math.ceil(HTML_Height/PDF_Height)-1;
 
 
 html2canvas($("#div_print")[0],{allowTaint:true}).then(function(canvas) {
 canvas.getContext('2d');
 
 console.log(canvas.height+"  "+canvas.width);
 
 
 var imgData = canvas.toDataURL("image/jpeg", 1.0);
 var pdf = new jsPDF('p', 'pt',  [PDF_Width, PDF_Height]);
     pdf.addImage(imgData, 'JPG', top_left_margin, top_left_margin,canvas_image_width,canvas_image_height);
 
 
 for (var i = 1; i <= totalPDFPages; i++) { 
 pdf.addPage(PDF_Width, PDF_Height);
 pdf.addImage(imgData, 'JPG', top_left_margin, -(PDF_Height*i)+(top_left_margin*4),canvas_image_width,canvas_image_height);
 }
 
     pdf.save("CashBook.pdf");
        });
});
</script>
        <script language="javascript">
                            function printdiv(printpage)
                            {
                                var headstr = "<html><head><title></title></head><body>";
                                var footstr = "</body>";
                                var newstr = document.all.item(printpage).innerHTML;
                                var oldstr = document.body.innerHTML;
                                document.body.innerHTML = headstr + newstr + footstr;
                                window.print();
                                document.body.innerHTML = oldstr;
                                return false;
                            }
        </script>
<% } %>
    </body>
</html>
