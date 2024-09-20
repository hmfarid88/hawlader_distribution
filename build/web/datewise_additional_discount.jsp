
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.Accountant"%>
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
                                <li><a data-toggle="collapse" data-target="#datewise" href="#">Datewise</a></li>
                                <li>
                                    <div id="datewise" class="collapse" style="margin: 10px 15px">
                                        <form method="POST" action="datewise_adjust_ledger.jsp" class="form-inline">
                                            <input type="date" name="date1" autocomplete="off" class="form-control input-sm" placeholder="Start Date" required=""> To
                                            <input type="date" name="date2" autocomplete="off" class="form-control input-sm" placeholder="End Date" required="">
                                            <input type="submit" value="OK" class="btn btn-primary btn-sm">
                                        </form>
                                    </div>
                                </li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li style=" margin-right: 50px; margin-top: 15px"><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li> 
                                <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul> 
                        </div>
                    </nav>
                </header>

                <div id="div_print">
                    <center>
                        <h3>Additional Discount</h3>
                        <center><h5><b>Date : ${param.date1} TO ${param.date2} </b></h5></center>
                    </center>

                    <table  border="2" width="100%" class="table-striped table-responsive">
                        <thead>
                            <tr style="background-color: #CCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Retailer</th>
                                <th style="text-align: center">Invoice No</th>
                                <th style="text-align: center">Note</th>
                                <th style="text-align: center">Amount</th>
                                <th style="text-align: center">Date</th>
                            </tr>
                        </thead>
                        <tbody id="myTable">
                            <%
                                   String date1 = request.getParameter("date1");
                                   String date2 = request.getParameter("date2");
                                   request.setAttribute("date1", date1);
                                   request.setAttribute("date2", date2);
                                   Connection con = null;
                                   PreparedStatement ps = null;
                                   ResultSet rs = null;
                                try {
            con = Database.getConnection();
            String query = "select RETAILER, INVOICENO, NOTE, AMOUNT, DATE from additionaldis where DATE between '" + date1 + "' and '" + date2 + "'";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs.getString(1) %></td>
                                <td style="text-align: center"><%= rs.getString(2) %></td>
                                <td style="text-align: center"><%= rs.getString(3) %></td>
                                <th style="text-align: center"><%= rs.getLong(4) %></th>
                                <td style="text-align: center"><%= rs.getString(5) %></td>
                            </tr>
                            <%
                             }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}    
                            %>
                           </tbody>
                           <tfoot>
                                <tr style="background-color: #CCC">
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center">TOTAL</th>
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
