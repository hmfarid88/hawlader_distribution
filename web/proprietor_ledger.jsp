
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DB.Database"%>
<%@page import="Model.EmpModel"%>
<%@page import="java.util.List"%>
<%@page import="Pojo.AccountPojo"%>
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
                    <center>
                        <h3>Proprietor Ledger</h3>
                        <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                    </center>
                 <div style="background-image: url('img/levelupbg.png')!important; background-repeat: no-repeat !important; background-size: 300px 150px !important; background-position: 50% 50% !important;">
                    <table id="lgr"  border="2" width="100%" class="table-condensed table-responsive">
                        <thead>
                            <tr style="background-color: #CCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Proprietor Name</th>
                                <th style="text-align: center">Proprietor Type</th>
                                <th style="text-align: center">Receive</th>
                                <th style="text-align: center">Payment</th>
                                <th style="text-align: center">Balance</th>
                                <th style="text-align: center">Details</th>
                            </tr>
                        </thead>
                        <tbody id="myTable">
                            <%
                                AccountPojo ap = new AccountPojo();
                                List<EmpModel> list = ap.ProprietorLedger();
                                for (EmpModel ac : list) {
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= ac.getPropname()%></td>
                                <td style="text-align: center"><%= ac.getProtype()%></td>
                                <th style="text-align: center"><%= ac.getProrecvamount()%></th>
                                <th style="text-align: center"><%= ac.getPropayamount()%></th>
                                <th style="text-align: center"><%= ac.getProrecvamount()- ac.getPropayamount()%></th>
                                <td style="text-align: center">
                                    <form method="POST" action="details_proprietor_ledger.jsp">
                                        <input type="hidden" name="propritor" value="<%= ac.getPropname()%>">
                                        <input type="submit" value="Details" class="btn btn-info btn-sm">
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                            
                        </tbody>
                        <tfoot>
                            <tr style="background-color: #CCC">
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center">Total</th>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"></td>
                                <th style="text-align: center"></th>
                            </tr>
                        </tfoot>
                    </table>
</div>
                            <br>
                    <h3 class="text-center text-primary">Capital Details</h3>
                     <table  border="2" width="100%" class=" table table-striped table-responsive">
                        <thead>
                            <tr style="background-color: #CCC">
                                <td style="text-align: center">SN</td>
                                <td style="text-align: center">Description</td>
                                <td style="text-align: center">Amount</td>
                                
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
                                    ResultSet rs7 = null;
                                    ResultSet rs8 = null;
                                    ResultSet rs9 = null;
                                    try {
                                        con = Database.getConnection();
                                        String query="select sum(SELL_PRICE) from stock";
                                        ps=con.prepareStatement(query);
                                        rs=ps.executeQuery();
                                        rs.next();
                                        request.setAttribute("totalstock", rs.getLong(1));
                                        String query1="select sum(PRICE), sum(DISCOUNT) from mobilesell";
                                        ps=con.prepareStatement(query1);
                                        rs1=ps.executeQuery();
                                        rs1.next();
                                        request.setAttribute("totalsellprice", rs1.getLong(1));
                                        request.setAttribute("totaldis", rs1.getLong(2));
                                        String query2="select AMOUNT from netbalance order by SI_NO DESC limit 1";
                                        ps=con.prepareStatement(query2);
                                        rs2=ps.executeQuery();
                                        rs2.next();
                                        request.setAttribute("lastbl", rs2.getLong(1));
                                        String query3="select sum(AMOUNT) from bank_transition where TYPE='Deposit'";
                                        ps=con.prepareStatement(query3);
                                        rs3=ps.executeQuery();
                                        rs3.next();
                                        request.setAttribute("totaldeposit", rs3.getLong(1));
                                        String query4="select sum(AMOUNT) from bank_transition where TYPE='Withdraw'";
                                        ps=con.prepareStatement(query4);
                                        rs4=ps.executeQuery();
                                        rs4.next();
                                        request.setAttribute("totalwithdraw", rs4.getLong(1));
                                        String query5="select sum(AMOUNT) from customer_pay";
                                        ps=con.prepareStatement(query5);
                                        rs5=ps.executeQuery();
                                        rs5.next();
                                        request.setAttribute("totalcpay", rs5.getLong(1));
                                        String query6="select sum(AMOUNT) from company_payment";
                                        ps=con.prepareStatement(query6);
                                        rs6=ps.executeQuery();
                                        rs6.next();
                                        request.setAttribute("totalpay", rs6.getLong(1));
                                        String query7="select sum(PURCHASE_PRICE) from vendor_stock";
                                        ps=con.prepareStatement(query7);
                                        rs7=ps.executeQuery();
                                        rs7.next();
                                        request.setAttribute("totalpprice", rs7.getLong(1));
                                       
                                        String query9="select sum(AMOUNT) from fixed_invest";
                                        ps=con.prepareStatement(query9);
                                        rs9=ps.executeQuery();
                                        rs9.next();
                                        request.setAttribute("totalinvest", rs9.getLong(1));



}catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
           }       %>
                           
           <tr>
               <td style="text-align: center">1</td>
               <td style="text-align: center">Stock Value</td>
               <td style="text-align: center">${totalstock}</td>
           </tr>
           <tr>
               <td style="text-align: center">2</td>
               <td style="text-align: center">Retailer Due</td>
               <td style="text-align: center">${totalsellprice-(totaldis+totalcpay)}</td>
           </tr>
           <tr>
               <td style="text-align: center">3</td>
               <td style="text-align: center">Cash Value</td>
               <td style="text-align: center">${lastbl}</td>
           </tr>
           <tr>
               <td style="text-align: center">4</td>
               <td style="text-align: center">Bank Deposit</td>
               <td style="text-align: center">${totaldeposit-totalwithdraw}</td>
           </tr>
           <tr>
               <td style="text-align: center">5</td>
               <td style="text-align: center">Company Due</td>
               <td style="text-align: center">${totalpay-totalpprice}</td>
           </tr>
           <tr>
               <td style="text-align: center">6</td>
               <td style="text-align: center">Fixed Invest</td>
               <td style="text-align: center">${totalinvest}</td>
           </tr>
           <tr style="background-color: #CCC">
               <td style="text-align: center"></td>
               <td style="text-align: center">TOTAL</td>
               <td style="text-align: center">${totalstock+(totalsellprice-(totaldis+totalcpay))+lastbl+(totaldeposit-totalwithdraw)+(totalpprice-totalpay)+totalinvest}</td>
           </tr>
                           
                        </tbody>
                        <tfoot>
                            
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
