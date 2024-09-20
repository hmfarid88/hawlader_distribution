<%@page import="DB.Database"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="Model.DeleteModel"%>
<%@page import="Pojo.DeletePojo"%>
<%@page import="Model.Accountant"%>
<%@page import="Model.StockModel"%>
<%@page import="java.util.List"%>
<%@page import="Pojo.AccountPojo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Hawlader</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="icon" type="image/png" href="img/favicon.ico">
    </head>
    <body id="main">
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
    <div class="container-fluid">
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
                        
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        
                        <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                    </ul> 
                </div>
            </nav>
        </header>

        <div id="div_print">
            <%
            int year = Integer.parseInt(request.getParameter("year"));
        int month = Integer.parseInt(request.getParameter("month"));
        request.setAttribute("yer", year);
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs0 = null;
        ResultSet rs = null;
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        ResultSet rs3 = null;
        ResultSet rs4 = null; 
        ResultSet rs6 = null;
        ResultSet rs7 = null;
        try {
            con = Database.getConnection();
            String mont = "select MONTHNAME(SELL_DATE) from mobilesell where YEAR(SELL_DATE) = '"+ year +"' AND MONTH(SELL_DATE) = '"+ month +"'";
                                    ps = con.prepareStatement(mont);
                                    rs0=ps.executeQuery();
                                    rs0.next();
                                    request.setAttribute("mnth", rs0.getString(1));
                                    }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  
  try { if (rs0 != null) rs0.close(); rs0=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
            %>
            <center>
                <h3>Retailer Wise Distribution Report</h3>
                <h4> ${mnth} ${yer}  </h4>
                <h5>Report Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h5>
               
            <table  border="2" width="90%" class="table-striped table-responsive">
                <thead>
                    <tr style="background-color: #CCC">
                        <th style="text-align: center">SN</th>
                        <th style="text-align: center">Retailer</th>
                        <th style="text-align: center">Qty</th>
                        <th style="text-align: center">Total Value</th>
                        <th style="text-align: center">Total Payment</th>
                        <th style="text-align: center">Due Value</th>
                        <th style="text-align: center">Present Balance</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <%
        
        try {
            con = Database.getConnection();
            String queryretiler="select distinct R_NAME from retailer_info order by R_NAME";
            ps = con.prepareStatement(queryretiler);
            rs = ps.executeQuery();
            while (rs.next()) {
             String retailer=rs.getString(1);
                      
            String query = "select count(PRODUCT_ID) as qty, sum(PRICE) as totalprice, sum(DISCOUNT) as dis from mobilesell where  RETAILER=? and YEAR(SELL_DATE) = '"+ year +"' AND MONTH(SELL_DATE) = '"+ month +"'";
            ps = con.prepareStatement(query);
            ps.setString(1, retailer);
            rs1 = ps.executeQuery(); 
            while(rs1.next()){
             
             String payment="select sum(AMOUNT) as totalpay from customer_pay where RETAILER=?";
             ps = con.prepareStatement(payment);
            ps.setString(1, retailer);
            rs2 = ps.executeQuery(); 
            while(rs2.next()){
             
              String monthpay="select sum(AMOUNT) from customer_pay where RETAILER=? and YEAR(DATE) = '"+ year +"' AND MONTH(DATE) = '"+ month +"'";
             ps = con.prepareStatement(monthpay);
            ps.setString(1, retailer);
            rs3 = ps.executeQuery(); 
            while(rs3.next()){
             
              String totalpricevalu="select sum(PRICE), sum(DISCOUNT) from mobilesell where RETAILER=?";
              ps = con.prepareStatement(totalpricevalu);
            ps.setString(1, retailer);
            rs4 = ps.executeQuery(); 
            while(rs4.next()){
            
                String additional="select sum(AMOUNT) from additionaldis where RETAILER=? ";
             ps = con.prepareStatement(additional);
            ps.setString(1, retailer);
            rs6 = ps.executeQuery(); 
            while(rs6.next()){
                
                String additionaldis="select sum(AMOUNT) from additionaldis where RETAILER=? and YEAR(DATE) = '"+ year +"' AND MONTH(DATE) = '"+ month +"'";
             ps = con.prepareStatement(additionaldis);
            ps.setString(1, retailer);
            rs7 = ps.executeQuery(); 
            while(rs7.next()){
                    %>
                    <tr>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"><%= rs.getString(1) %></td>
                        <th style="text-align: center"><%= rs1.getInt("qty") %></th>
                        <th style="text-align: center"><%= rs1.getLong(2)-rs1.getLong(3)-rs7.getLong(1) %></th>
                        <th style="text-align: center"><%= rs3.getLong(1) %></th>
                        <th style="text-align: center"><%= rs1.getLong(2)-rs1.getLong(3)-rs7.getLong(1)-rs3.getLong(1) %></th>
                        <th style="text-align: center"><%= rs4.getLong(1)-rs4.getLong(2)-rs2.getLong(1)-rs6.getLong(1) %></th>
                    </tr>
                    
                    <% } } } } } } }
}catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs7 != null) rs7.close(); rs7=null; } catch (SQLException ex2) { }
  try { if (rs6 != null) rs6.close(); rs6=null; } catch (SQLException ex2) { }
  try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
  try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
  try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (rs0 != null) rs0.close(); rs0=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                    %>
                    
                </tbody>
                <tfoot>
                   <tr style="background-color: #CCC">
                        <th style="text-align: center"></th>
                        <th style="text-align: center">TOTAL</th>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                    </tr> 
                </tfoot>
            </table>
        </center>
        </div>
    </div>
    
    <br><br>
    <%@include file = "footerpage.jsp" %>

    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
   
    <script language="javascript">
                        var addSerialNumber = function () {
                            var i = 0;
                            $('table tr').each(function (index) {
                                $(this).find('td:nth-child(1)').html(index - 1 + 1);
                            });
                        };

                        addSerialNumber();
    </script>
    <script>
        $(document).ready(function() {
            $('table thead th').each(function(i) {
                calculateColumn(i);
            });
        });

        function calculateColumn(index) {
            var total = 0;
            $('table tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('table tfoot td').eq(index).text(total);
        }
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
    <% }%>
</body>
</html>
