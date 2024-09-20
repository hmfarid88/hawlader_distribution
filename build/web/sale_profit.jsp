
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.SaleModel"%>
<%@page import="java.util.List"%>
<%@page import="Pojo.Profit"%>
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
                            <li><a data-toggle="collapse" data-target="#datewise" href="#">Monthly View</a></li>
                            <li>
                                <div id="datewise" class="collapse" style="margin: 10px 15px">
                                    <form method="POST" action="datewise_sale_profit.jsp" class="form-inline">
                                       <select name="month" class="form-control input-sm" required="">
                                            <option class="active" value=""> Select Month</option>
                                            <option value="1">January</option>
                                            <option value="2">February</option>
                                            <option value="3">March</option>
                                            <option value="4">April</option>
                                            <option value="5">May</option>
                                            <option value="6">June</option>
                                            <option value="7">July</option>
                                            <option value="8">August</option>
                                            <option value="9">September</option>
                                            <option value="10">October</option>
                                            <option value="11">November</option>
                                            <option value="12">December</option>
                                        </select>
                                        <select name="year" class="form-control input-sm" required="">
                                            <option value=""> Select Year</option>
                                            <option value="2019">2019</option>
                                            <option value="2020">2020</option>
                                            <option value="2021">2021</option>
                                            <option value="2022">2022</option>
                                            <option value="2023">2023</option>
                                            <option value="2024">2024</option>
                                            <option value="2025">2025</option>
                                        </select>
                                        <input type="submit" value="GO" class="btn btn-primary btn-sm">
                                    </form>
                                </div>
                            </li>
                            <li><a data-toggle="modal" data-target="#profitwithdraw" href="#">Profit Withdraw</a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li style=" margin: 15px 60px "><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li>
                            <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                        </ul> 
                    </div>
                </nav>
            </header>

            <div id="div_print" style="font-family: fontawesome">
                <center>
                    <h3>Profit Report</h3>
                    <center><h4><div id="date"> </div> </h4></center>
                </center>
                <div style="background-image: url('img/levelupbg.png')!important; background-repeat: no-repeat !important; background-size: 300px 150px !important; background-position: 50% 50% !important;">
                <table id="regprofit" border="2" width="100%" class="table-striped table-responsive">
                    <thead>
                        <tr style="background-color: #CCC">
                            <th style="text-align: center">SN</th>
                            <th style="text-align: center">Stock Date</th>
                            <th style="text-align: center">Product</th>
                            <th style="text-align: center">Qty</th>
                            <th style="text-align: center">Purchase Rate</th>
                            <th style="text-align: center">Sale Rate</th>
                            <th style="text-align: center">Unit Profit</th>
                            <th style="text-align: center">Total Profit</th>
                        </tr>
                    </thead>
                    <tbody id="myTable">
                        <%
                            Connection con = null;
                            PreparedStatement ps = null;
                            
                            ResultSet rs1 = null;
                            ResultSet rs2 = null;
                            ResultSet rs3 = null;
                            ResultSet rs4 = null;
                            ResultSet rs5 = null;
                            ResultSet rs6 = null;
                            ResultSet rs7 = null;
                            ResultSet rs8 = null;
                            ResultSet rs = null;
                            try {
                                con = Database.getConnection();
                                    String totalsale = "select sum(PURCHASE_PRICE), sum(SALE_PRICE) from vendor_stock where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
                                    ps = con.prepareStatement(totalsale);
                                    rs1 = ps.executeQuery();
                                    rs1.next();
                                    request.setAttribute("totalbuy", rs1.getLong(1));
                                    request.setAttribute("totalsale", rs1.getLong(2));
                                    String commi = "select sum(AMOUNT) from fac_commission where  YEAR = YEAR(CURRENT_DATE()) AND MONTH = MONTH(CURRENT_DATE())";
                                    ps = con.prepareStatement(commi);
                                    rs2 = ps.executeQuery();
                                    rs2.next();
                                    request.setAttribute("totalcommi", rs2.getLong(1));
                                    String totalcost = "select sum(AMOUNT) from cost where  YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
                                    ps = con.prepareStatement(totalcost);
                                    rs3 = ps.executeQuery();
                                    rs3.next();
                                    request.setAttribute("totalcost", rs3.getLong(1));
                                    String totalemp = "select sum(AMOUNT) from emp_cost where  YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
                                    ps = con.prepareStatement(totalemp);
                                    rs4 = ps.executeQuery();
                                    rs4.next();
                                    request.setAttribute("totalemp", rs4.getLong(1));
                                    String discount = "select sum(DISCOUNT) from mobilesell where  YEAR(SELL_DATE) = YEAR(CURRENT_DATE()) AND MONTH(SELL_DATE) = MONTH(CURRENT_DATE())";
                                    ps = con.prepareStatement(discount);
                                    rs5 = ps.executeQuery();
                                    rs5.next();
                                    request.setAttribute("totaldis", rs5.getLong(1));
                                    String additional = "select sum(AMOUNT) from additionaldis where  YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
                                    ps = con.prepareStatement(additional);
                                    rs6 = ps.executeQuery();
                                    rs6.next();
                                    request.setAttribute("additionaldis", rs6.getLong(1));
                                    String proreturn = "select sum(SELL_PRICE-PURCHASE_PRICE) from stock_delete where YEAR(STDATE) <= YEAR(CURRENT_DATE()) AND MONTH(STDATE) != MONTH(CURRENT_DATE()) AND  YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
                                    ps = con.prepareStatement(proreturn);
                                    rs7 = ps.executeQuery();
                                    rs7.next();
                                    String loanint = "select sum(INTE_RECV) from cm_payment where  YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
                                    ps = con.prepareStatement(loanint);
                                    rs8 = ps.executeQuery();
                                    rs8.next();
                                    request.setAttribute("loaninterest", rs8.getLong(1));
                                    String query = "select PRODUCT, PURCHASE_PRICE, SALE_PRICE, DATE, sum(QTY) as qty from vendor_stock where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE()) group by PRODUCT, DATE";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                while (rs.next()) {
                        %>
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= rs.getString("DATE")%></td>
                            <td style="text-align: center"><%= rs.getString("PRODUCT")%></td>
                            <th style="text-align: center"><%= rs.getInt("qty")%></th>
                            <td style="text-align: center"><%= rs.getFloat("PURCHASE_PRICE")%></td>
                            <td style="text-align: center"><%= rs.getFloat("SALE_PRICE")%></td>
                            <td style="text-align: center"><%= rs.getFloat("SALE_PRICE")-rs.getFloat("PURCHASE_PRICE") %></td>
                            <th style="text-align: center"><%= (rs.getFloat("SALE_PRICE")-rs.getFloat("PURCHASE_PRICE")) * rs.getInt("qty") %></th>
                        </tr>
                        <% 
 
                                                     }
                                                } catch (Exception ex) {
                                                }finally {
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }   
try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }   
try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }   
try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }  
try { if (rs5 != null) rs5.close(); rs5=null; } catch (SQLException ex2) { }
try { if (rs6 != null) rs6.close(); rs6=null; } catch (SQLException ex2) { } 
try { if (rs7 != null) rs7.close(); rs7=null; } catch (SQLException ex2) { }
try { if (rs8 != null) rs8.close(); rs8=null; } catch (SQLException ex2) { }
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                        %>
                        
                    </tbody>
                    <tfoot>
                        <tr style="background-color: #CCCCCC">
                            <th style="text-align: center"></th> 
                            <th style="text-align: center"></th> 
                            <th style="text-align: center">TOTAL</th> 
                            <td style="text-align: center"></td> 
                            <th style="text-align: center"></th> 
                            <th style="text-align: center"></th> 
                            <th style="text-align: center"></th> 
                            <td style="text-align: center"></td> 
                        </tr>
                    </tfoot>
                  </table> 
                </div>
                        <h4 class="text-center"><b>NIT PROFIT</b></h4>
                        <table border="2" width="100%" class="table-condensed table-responsive">
                            <tr>
                                <th style="text-align: center">PRODUCT'S PROFIT</th> 
                                <td style="text-align: center">${totalsale-totalbuy}</td> 
                                <td style="text-align: center">${((totalsale-totalbuy)*100)/totalbuy} %</td> 
                            </tr>
                            <tr>
                                <th style="text-align: center">(+) COMPANY COMMISSION</th> 
                                <td style="text-align: center">${totalcommi}</td> 
                                <td style="text-align: center"><a href="#">Details(View from Report)</a></td> 
                            </tr>
                            <tr>
                                <th style="text-align: center">(+) LOAN INTEREST</th> 
                                <td style="text-align: center">${loaninterest}</td> 
                                <td style="text-align: center"><a href="#">Details(View from Ledger)</a></td> 
                            </tr>
                            <tr>
                                <th style="text-align: center">(-) OFFICE COST</th> 
                                <td style="text-align: center">${totalcost}</td> 
                                <td style="text-align: center"><a href="expense_ledger.jsp">Details</a></td> 
                            </tr>
                            <tr>
                                <th style="text-align: center">(-) EMPLOYEE COST</th> 
                                <td style="text-align: center">${totalemp}</td> 
                                <td style="text-align: center"><a href="expenseinfo.jsp">Details</a></td> 
                            </tr>
                            <tr>
                                <th style="text-align: center">(-) DISCOUNT</th> 
                                <td style="text-align: center">${totaldis}</td> 
                                <td style="text-align: center"><a href="symmonthly_mobile_sell.jsp">Details</a></td> 
                            </tr>
                            <tr>
                                <th style="text-align: center">(-) ADDITIONAL DISCOUNT</th> 
                                <td style="text-align: center">${additionaldis}</td> 
                                <td style="text-align: center"><a href="additional_discount.jsp">Details</a></td> 
                            </tr>
                            <tr>
                                <th style="text-align: center">(-) PRODUCT RETURN</th> 
                                <td style="text-align: center">${proreturn}</td> 
                                <td style="text-align: center"><a href="m_delete_stock.jsp">Details</a></td> 
                            </tr>
                            <tr style="background-color: #CCC">
                                <th style="text-align: center">NIT PROFIT</th> 
                                <td style="text-align: center">${((totalsale-totalbuy)+totalcommi+loaninterest)-(totalcost+totalemp+totaldis+additionaldis+proreturn)}</td> 
                                <td style="text-align: center"></td> 
                            </tr>
                        </table>
                        
            </div>

        </div>
        <br><br>
        <div id="profitwithdraw" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Profit withdraw-Info</h4>
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Profit-Withdraw</legend>
                        <div class="container-fluid">
                            <form method="POST" action="ProfitWithdrawServlet">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Month</label>
                                        <select name="month" class="form-control input-sm" required="">
                                            <option class="active" value=""> Select Month</option>
                                            <option value="1">January</option>
                                            <option value="2">February</option>
                                            <option value="3">March</option>
                                            <option value="4">April</option>
                                            <option value="5">May</option>
                                            <option value="6">June</option>
                                            <option value="7">July</option>
                                            <option value="8">August</option>
                                            <option value="9">September</option>
                                            <option value="10">October</option>
                                            <option value="11">November</option>
                                            <option value="12">December</option>
                                        </select>
                                        
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Year</label>
                                        <select name="year" class="form-control input-sm" required="">
                                            <option value=""> Select Year</option>
                                            <option value="2019">2019</option>
                                            <option value="2020">2020</option>
                                            <option value="2021">2021</option>
                                            <option value="2022">2022</option>
                                            <option value="2023">2023</option>
                                            <option value="2024">2024</option>
                                            <option value="2025">2025</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Amount :</label>
                                        <input  type="number" class="form-control input-sm" value="" name="amount" required="">
                                    </div>
                                </div><br>
                               
                                <div class="row">
                                    <div class="col-sm-6">
                                        <input type="submit"  class="btn btn-success btn-sm" value="OK"> 
                                        <input type="reset"  class="btn btn-info btn-sm" value="Reset"> 
                                    </div>
                                </div>

                            </form>
                        </div>
                        
                    </fieldset>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
        <%@include file = "footerpage.jsp" %>

        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script>
                        $(document).ready(function () {
                            $('form').submit(function () {
                                if (this.beenSubmitted)
                                    return false;
                                else
                                    this.beenSubmitted = true;
                            });
                        });
                    </script>
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
                            $('#regprofit tr').each(function (index) {
                                $(this).find('td:nth-child(1)').html(index - 1 + 1);
                            });
                        };

                        addSerialNumber();
        </script>
        
       <script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
    $('#regprofit thead th').each(function(i) {
                calculateColumn(i);
            });
            function calculateColumn(index) {
            var total = 0;
            $('#regprofit tr').each(function() {
                var value = parseInt($('th:visible', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#regprofit tfoot td').eq(index).text(total);
        } 
  });
});
</script>
     <script>
        $(document).ready(function() {
            $('#regprofit thead th').each(function(i) {
                calculateColumn(i);
            });
        });

        function calculateColumn(index) {
            var total = 0;
            $('#regprofit tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#regprofit tfoot td').eq(index).text(total);
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
<% } %>
    </body>
</html>
