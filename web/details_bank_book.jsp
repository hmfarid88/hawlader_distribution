
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
        <body id="main">
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
            <%
                String bank = request.getParameter("bank");
                request.setAttribute("bank", bank);
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                
                 try {
                    con = Database.getConnection();
                    String query = "select TYPE, AMOUNT, BRANCH, PAYER, BALANCE, DATE from bank_transition where  BANK=? and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) order by SI_NO";
                   
                    ps = con.prepareStatement(query);
                    ps.setString(1, bank);
                    rs = ps.executeQuery();
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
                                <li><a data-toggle="collapse" data-target="#datewise" href="#">Datewise</a></li>
                                <li>
                                    <div id="datewise" class="collapse" style="margin: 10px 15px">
                                        <form method="POST" action="datewise_bank_book.jsp" class="form-inline">
                                            <input type="hidden" name="bank" value="${bank}">
                                            <input type="date" name="date1" autocomplete="off" class="form-control input-sm" placeholder="Start Date" required=""> To
                                            <input type="date" name="date2" autocomplete="off" class="form-control input-sm" placeholder="End Date" required="">
                                            <input type="submit" value="OK" class="btn btn-primary btn-sm">
                                        </form>
                                    </div>
                                </li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul> 
                        </div>
                    </nav>
                </header>

                <div id="div_print" style="font-family: fontawesome">
                    <center>
                        <h3>Bank Ledger</h3>
                        <h3>Bank Name : ${bank}</h3>
                        <h4><div id="date"> </div> </h4>
                    </center>
               <div style="background-image: url('img/levelupbg.png')!important; background-repeat: no-repeat !important; background-size: 300px 150px !important; background-position: 50% 50% !important;">
                    <table  border="2" width="100%" class="table-condensed table-responsive">
                        <thead>
                            <tr style="background-color: #CCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Date</th>
                                <th style="text-align: center">Transaction Type</th>
                                <th style="text-align: center">Branch</th>
                                <th style="text-align: center">Payer/Withdrawer</th>
                                <th style="text-align: center">Amount</th>
                                <th style="text-align: center">Balance</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%   
                                while (rs.next()) {
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs.getString("DATE")%></td>
                                <td style="text-align: center"><%= rs.getString("TYPE")%></td>
                                <td style="text-align: center"><%= rs.getString("BRANCH")%></td>
                                <td style="text-align: center"><%= rs.getString("PAYER")%></td>
                                <td style="text-align: center"><%= rs.getDouble("AMOUNT")%></td>
                                <td style="text-align: center"><%= rs.getDouble("BALANCE") %></td>
                            </tr>
                           
                            <%  }
                                } catch (SQLException ex) {
                                    ex.printStackTrace();
                                 }finally {
  
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                         }
                                %>
                         
                            
                        </tbody>
                    </table>
</div>
                </div>
            </div>
            <br><br>
            <%@include file = "footerpage.jsp" %>
            <script src="js/jquery-3.1.1.min.js"></script>
            <script src="js/bootstrap.min.js"></script>
            
            <script>
                                    window.onload = function () {
                                        var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
                                        ;
                                        var date = new Date();

                                        document.getElementById('date').innerHTML = months[date.getMonth()] + ' ' + date.getFullYear();
                                    };
            </script>
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
