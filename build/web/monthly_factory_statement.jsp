
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="DB.Database"%>
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
                                        <form method="POST" action="datewise_factory_statement.jsp" class="form-inline">
                                            <input type="date" name="date1" autocomplete="off" class="form-control input-sm" placeholder="Start Date" required=""> To
                                            <input type="date" name="date2" autocomplete="off" class="form-control input-sm" placeholder="End Date" required="">
                                            <input type="submit" value="OK" class="btn btn-primary btn-sm">
                                        </form>
                                    </div>
                                </li>                                                             
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><input style="border-color: green; width: 90%; margin: 10px 15px" class="form-control input-sm" id="myInput1" type="text" placeholder="Search..."></li>
                            <li><a  href="#" name="b_print"  onClick="printdiv('div_print1')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                        </ul> 
                    </div>
                </nav>
            </header>
            
            <div class="row">
                <div class="col-sm-12">
                    
                                <div id="div_print1">
                                <center>
                                    <h4> HUA SHENG COMMERCIAL BD LTD</h4>
                                    <h5>11 KDA Avenue, Nowshin Tower(5th Floor), Khulna.</h5>
                                    <h4><b>Hawlader Distribution House (Munshiganj)</b></h4>
                                    <h4>Ledger Account</h4>
                                    01 No A.K Chawdhury Bahban<br>
                                    Sadar Road, Munshigang<br>
                                    Contact Person: Rana 01554444477, 01739444477
                                    <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                                    
                                </center>
                                    
                        <table id="producttable" border="2" width="100%" class="table-condensed table-responsive">
                            <thead>
                                <tr style="background-color: #CCCCCC">
                                    <th style="text-align: center">SN</th>
                                    <th style="text-align: center">Date</th>
                                    <th style="text-align: center">Model</th>
                                    <th style="text-align: center">Qty</th>
                                    <th style="text-align: center">Rate</th>
                                    <th style="text-align: center">Total</th>
                                    <th style="text-align: center">Payment</th>
                                    <th style="text-align: center">Type</th>
                                    <th style="text-align: center">Balance</th>
                                </tr>
                            </thead>
                            <tbody id="myTable">
                               <%
                                      Connection con = null;
                                      PreparedStatement ps = null;
                                      ResultSet rs = null;
                                      ResultSet rs1 = null;       
            try {
                con = Database.getConnection();
                String query = "select SI_NO, MODEL, QTY, RATE, PAYMENT, PAY_TYPE, DATE from company_statement where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
                ps = con.prepareStatement(query);
                rs = ps.executeQuery();
                while (rs.next()) {
                int sino=rs.getInt(1);
                String query1="select sum(QTY*RATE), sum(PAYMENT) from company_statement where SI_NO<?";
                ps = con.prepareStatement(query1);
                ps.setInt(1, sino);
                rs1 = ps.executeQuery();
                                   
                                  while (rs1.next()) {    
                               %>
                               <tr>
                                   <td style="text-align: center"></td>
                                   <td style="text-align: center"><%= rs.getString("DATE")%> </td>
                                   <td style="text-align: center"><%= rs.getString("MODEL")%></td>
                                   <th style="text-align: center"><%= rs.getInt("QTY") %></th>
                                   <td style="text-align: center"><%= rs.getLong("RATE")%></td>
                                   <th style="text-align: center"><%= rs.getInt("QTY")*rs.getLong("RATE") %></th>
                                   <th style="text-align: center"><%= rs.getLong("PAYMENT")%></th>
                                   <td style="text-align: center"><%= rs.getString("PAY_TYPE")%></td>
                                   <td style="text-align: center"><%= ((rs1.getLong(2)+rs.getLong("PAYMENT"))-(rs1.getLong(1)+(rs.getInt("QTY")*rs.getLong("RATE")))) %></td>
                               </tr>
                               <% }}
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
                            <tfoot>
                                <tr style="background-color: #CCC">
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center">TOTAL</th>
                                    <td style="text-align: center"></td>
                                    <th style="text-align: center"></th>
                                    <td style="text-align: center"></td>
                                    <td style="text-align: center"></td>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center"></th>
                                </tr> 
                            </tfoot>
                        </table>
                       </div>
                              
                       </div>
                            </div>
                  
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
                                $('#producttable tr').each(function (index) {
                                    $(this).find('td:nth-child(1)').html(index - 1 + 1);
                                });
                            };

                            addSerialNumber();
            </script>
         
            <script>
$(document).ready(function(){
  $("#myInput1").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
    $('#producttable thead th').each(function(i) {
                calculateColumn(i);
            });
            function calculateColumn(index) {
            var total = 0;
            $('#producttable tr').each(function() {
                var value = parseInt($('th:visible', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#producttable tfoot td').eq(index).text(total);
        } 
  });
});
</script>
     <script>
        $(document).ready(function() {
            $('#producttable thead th').each(function(i) {
                calculateColumn(i);
            });
            function calculateColumn(index) {
            var total = 0;
            $('#producttable tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#producttable tfoot td').eq(index).text(total);
        }
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
