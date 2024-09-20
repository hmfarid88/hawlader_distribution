
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
    <body id="">
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
            <div class="row">
                <div class="col-sm-12">
                    <div id="div_print">
                    <center>
                        <h3 style="font-family: fontawesome"><b>Pending Email</b></h3>
                        <h4><b>Date : <script> document.write(new Date().toLocaleDateString('en-GB'));</script> </b></h4>
                        <h4>Email Type: Distribution</h4>
                    </center>
                    <table border="2" width="100%" class="table-condensed table-responsive">
                        <thead>
                            <tr style="background-color: #CCCCCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Date</th>
                                <th style="text-align: center">Retailer</th>
                                <th style="text-align: center">Qty</th>
                                <th style="text-align: center">Value</th>
                                <th style="text-align: center">Due</th>
                                <th style="text-align: center">Email Address</th>
                                <th style="text-align: center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                             <%
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs = null;
                                try{
                                    con = Database.getConnection();
                                    String query="select SI_NO, RETAILER, QTY, AMOUNT, DUE, EMAIL, DATE from re_email_sale";
                                    ps=con.prepareStatement(query);
                                    rs=ps.executeQuery();
                                    while (rs.next()) {
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs.getString("DATE") %></td>
                                <td style="text-align: center"><%= rs.getString("RETAILER") %></td>
                                <td style="text-align: center"><%= rs.getInt("QTY") %></td>
                                <td style="text-align: center"><%= rs.getLong("AMOUNT") %></td>
                                <td style="text-align: center"><%= rs.getLong("DUE") %></td>
                                <td style="text-align: center"><%= rs.getString("EMAIL") %></td>
                                <td style="text-align: center">
                                    <form method="post" action="ResendDistMail">
                                        <input type="hidden" name="sino" value="<%= rs.getInt("SI_NO") %>" >
                                        <input type="submit" class="btn btn-success btn-sm" value="Resend">
                                    </form>
                                </td>
                            </tr>
                            <% }
}catch (SQLException ex) {
            ex.printStackTrace();
}finally {

try { if (rs != null) rs.close();  } catch (SQLException ex2) { }
try { if (ps != null) ps.close();  } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }       
        }
           
                            %>
                        </tbody>
                    </table><br>
                    <center> <h4>Email Type: Payment</h4></center>
                        <table border="2" width="100%" class="table-condensed table-responsive">
                        <thead>
                            <tr style="background-color: #CCCCCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Date</th>
                                <th style="text-align: center">Retailer</th>
                                <th style="text-align: center">Amount</th>
                                <th style="text-align: center">Due</th>
                                <th style="text-align: center">Email Address</th>
                                <th style="text-align: center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                             <%
                               
                                try{
                                    con = Database.getConnection();
                                    String query="select SI_NO, RETAILER, AMOUNT, DUE, EMAIL, DATE from re_email_pay";
                                    ps=con.prepareStatement(query);
                                    rs=ps.executeQuery();
                                    while (rs.next()) {
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs.getString("DATE") %></td>
                                <td style="text-align: center"><%= rs.getString("RETAILER") %></td>
                                <td style="text-align: center"><%= rs.getString("AMOUNT") %></td>
                                <td style="text-align: center"><%= rs.getString("DUE") %></td>
                                <td style="text-align: center"><%= rs.getString("EMAIL") %></td>
                                <td style="text-align: center">
                                    <form method="post" action="ResendPayMail">
                                        <input type="hidden" name="sino" value="<%= rs.getInt("SI_NO") %>" >
                                        <input type="submit" class="btn btn-success btn-sm" value="Resend">
                                    </form>
                                </td>
                            </tr>
                            <% }
}catch (SQLException ex) {
            ex.printStackTrace();
}finally {

try { if (rs != null) rs.close();  } catch (SQLException ex2) { }
try { if (ps != null) ps.close();  } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }       
        }
           
                            %>
                        </tbody>
                    </table>
                    </div>
                </div>
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
