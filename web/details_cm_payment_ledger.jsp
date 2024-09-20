
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
            <%
            
            String propritor=request.getParameter("propritor");
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
                   
        try {
            con = Database.getConnection();
            String query = "select SI_NO, PAYMENT, RECEIVE, PRINCIPAL, DAYS, RATE, INTEREST, INTE_RECV, INTE_PAY, DATE from cm_payment where PROP_NAME=?";
            ps = con.prepareStatement(query);
            ps.setString(1, propritor);
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
                                
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul> 
                        </div>
                    </nav>
                </header>

                <div id="div_print">
                    <center>
                        <h3>Details Call Money Ledger</h3>
                        <h4>Loan Person: ${param.propritor}</h4>
                        <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                    </center>

                    <table  border="2" width="100%" class="table-condensed table-responsive">
                        <thead>
                            <tr style="background-color: #CCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Date</th>
                                <th style="text-align: center">Payment</th>
                                <th style="text-align: center">Receive</th>
                                <th style="text-align: center">Principal</th>
                                <th style="text-align: center">Duration(Days)</th>
                                <th style="text-align: center">RPL</th>
                                <th style="text-align: center">Interest</th>
                                <th style="text-align: center">Interest Receive</th>
                                <th style="text-align: center">Interest Payment</th>
                                <th style="text-align: center">Balance</th>
                                
                            </tr>
                        </thead>
                        <tbody>
                            <%
                              while(rs.next()){
                                 int sino=rs.getInt("SI_NO");
                                  String query1 = "select sum(INTEREST), sum(INTE_PAY-INTE_RECV) from cm_payment where PROP_NAME=? and SI_NO<=?";
            ps = con.prepareStatement(query1);
            ps.setString(1, propritor);
            ps.setInt(2, sino);
            rs1 = ps.executeQuery(); 
            while(rs1.next()){
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs.getString("DATE")%></td>
                                <td style="text-align: center"><%= rs.getFloat("PAYMENT")%></td>
                                <td style="text-align: center"><%= rs.getFloat("RECEIVE")%></td>
                                <td style="text-align: center"><%= rs.getLong("PRINCIPAL")%></td>
                                <td style="text-align: center"><%= rs.getInt("DAYS")%></td>
                                <td style="text-align: center"><%= rs.getLong("RATE")%></td>
                                <td style="text-align: center"><%= rs.getFloat("INTEREST") %></td>
                                <td style="text-align: center"><%= rs.getFloat("INTE_RECV")%></td>
                                <td style="text-align: center"><%= rs.getFloat("INTE_PAY")%></td>
                                <td style="text-align: center"><%= (rs.getLong("PRINCIPAL")+rs1.getLong(1))+rs1.getLong(2) %></td>
                                
                                
                            </tr>
                            <% }} %>
                            
                             <%
                                } catch (SQLException ex) {
                                    ex.printStackTrace();
                                 }finally {
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }           
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                         }
                                %>
                        </tbody>
                       
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
