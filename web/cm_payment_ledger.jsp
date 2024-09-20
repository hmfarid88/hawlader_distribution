<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DB.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
                                <li style=" margin-right: 50px; margin-top: 15px"><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li> 
                                <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul> 
                        </div>
                    </nav>
                </header>

                <div id="div_print">
                    <%
                                        Connection con = null;
                                        PreparedStatement ps = null;
                                        ResultSet rs = null;
                                        ResultSet rss = null;
                                        ResultSet rs1 = null;
                                        ResultSet rs2 = null;
                                        try {
                                            con = Database.getConnection();
                                            String recv = "select max(SI_NO), PROP_NAME, PRINCIPAL, RATE from cm_payment group by PROP_NAME";
                                            ps = con.prepareStatement(recv);
                                            rs = ps.executeQuery();
                                           while(rs.next()){
                                            int sino = rs.getInt(1);
                                            String lp=rs.getString(2);
                                            String principal="select PRINCIPAL, RATE from cm_payment where SI_NO=?";
                                            ps = con.prepareStatement(principal);
                                            ps.setInt(1, sino);
                                            rss = ps.executeQuery();
                                            while(rss.next()){
                                            Float prin=rss.getFloat(1);
                                            Float rate=rss.getFloat(2);
                                            String dd="select DATE from cm_payment where SI_NO='"+ sino +"' and PROP_NAME='"+ lp +"'";
                                            ps = con.prepareStatement(dd);
                                            rs1 = ps.executeQuery();
                                           while(rs1.next()){
                                            String date = rs1.getString(1);
                                            String datedif = "SELECT DATEDIFF(CURDATE(), '" + date + "') AS DateDiff from cm_payment";
                                            ps = con.prepareStatement(datedif);
                                            rs2 = ps.executeQuery();
                                            while(rs2.next()){
                                            int ddif = rs2.getInt("DateDiff");
                                            String dayupdate = "update cm_payment set DAYS='" + ddif + "', INTEREST='"+ (prin*rate*ddif)/3000000 +"' where SI_NO='" + sino + "' and PROP_NAME='"+ lp +"'";
                                            ps = con.prepareStatement(dayupdate);
                                            ps.executeUpdate();
                                            }}}}  }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                            %>
                    <center>
                        <h3>Call Money Ledger</h3>
                        <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                    </center>
                
                    <table id="lgr"  border="2" width="100%" class="table-condensed table-responsive">
                        <thead>
                            <tr style="background-color: #CCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Loan Person</th>
                                <th style="text-align: center">Principal</th>
                                <th style="text-align: center">Interest</th>
                                <th style="text-align: center">Balance</th>
                                <th style="text-align: center">Details</th>
                            </tr>
                        </thead>
                        <tbody id="myTable">
                            
                            <%
                            try {
                                            con = Database.getConnection();
                                            String lnprsn="select PROP_NAME, sum(PAYMENT-RECEIVE), sum(INTEREST), sum(INTE_PAY), sum(INTE_RECV) from cm_payment group by PROP_NAME";
                                            ps=con.prepareStatement(lnprsn);
                                            rs=ps.executeQuery();
                                            while(rs.next()){
                                               
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs.getString("PROP_NAME") %></td>
                                <th style="text-align: center"><%= rs.getLong(2) %></th>
                                <th style="text-align: center"><%= rs.getLong(3)+rs.getLong(4)-rs.getLong(5) %></th>
                                <th style="text-align: center"><%= (rs.getLong(2)+rs.getLong(3))+(rs.getLong(4)-rs.getLong(5)) %></th>
                                <td style="text-align: center">
                                    <form method="post" action="details_cm_payment_ledger.jsp">
                                        <input type="hidden" name="propritor" value="<%= rs.getString("PROP_NAME") %>">
                                        <input type="submit" value="Details" class="btn btn-info btn-sm">
                                    </form>
                                </td>
                            </tr>
                            <% }
}catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
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
                                <th style="text-align: center"></th>
                             
                            </tr>
                        </tfoot>
                    </table>

                </div>
            </div>
            <br><br>
            <%@include file = "footerpage.jsp" %>

            <script src="js/jquery-3.1.1.min.js"></script>
            <script src="js/bootstrap.min.js"></script>
         
            <script language="javascript">
                var addSerialNumber = function () {
                    var i = 0;
                    $('#lgr tr').each(function (index) {
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
     <script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
    $('table thead th').each(function(i) {
                calculateColumn(i);
            });
            function calculateColumn(index) {
            var total = 0;
            $('table tr').each(function() {
                var value = parseInt($('th:visible', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('table tfoot td').eq(index).text(total);
        } 
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
