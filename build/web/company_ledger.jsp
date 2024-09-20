
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
                        <li><a href="#" data-toggle="modal" data-target="#payinfo" >Payment Update</a></li>
                        
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                    </ul> 
                </div>
            </nav>
        </header>

        <div id="div_print" style="font-family: fontawesome">
            <center>
                <h3>Company Ledger</h3>
                <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
            </center>
<div style="background-image: url('img/levelupbg.png')!important; background-repeat: no-repeat !important; background-size: 300px 150px !important; background-position: 50% 50% !important;">
            <table  border="2" width="100%" class="table-condensed table-responsive">
                <thead>
                    <tr style="background-color: #CCC">
                        <th style="text-align: center">SN</th>
                        <th style="text-align: center">Company</th>
                        <th style="text-align: center">Qty</th>
                        <th style="text-align: center">Total Price</th>
                        <th style="text-align: center">Total Payment</th>
                        <th style="text-align: center">Balance</th>
                        <th style="text-align: center">Details</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        AccountPojo ap=new AccountPojo();
                        List<StockModel> list = ap.FactoryLedger();
                        for (StockModel sml : list) {
                    %>
                    <tr>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"><%= sml.getFactory()%></td>
                        <td style="text-align: center"><%= sml.getStockqty()%></td>
                        <td style="text-align: center"><%= sml.getStockprice()%></td>
                        <td style="text-align: center"><%= sml.getStockpay()%></td>
                        <th style="text-align: center"><%= sml.getCompanybalance()%></th>
                        
                        <td style="text-align: center">
                            <form method="POST" action="dtails_facLedger.jsp">
                                <input type="hidden" name="retailer" value="<%= sml.getFactory()%>">
                                <input type="submit" value="Details">
                            </form>
                        </td>
                    </tr>
                    
                    <% } %>
                    
                </tbody>
                <tfoot>
                   <tr style="background-color: #CCC">
                        <th style="text-align: center"></th>
                        <th style="text-align: center">TOTAL</th>
                        <th style="text-align: center"></th>
                        <th style="text-align: center"></th>
                        <th style="text-align: center"></th>
                        <td style="text-align: center"></td>
                        <th style="text-align: center"></th>
                     </tr> 
                </tfoot>
            </table>
</div>
        </div>
    </div>
    <div id="payinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Payment Info Update</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="FacpayUpdateServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Payment Name</label>
                                        <select style=" width: 90%" class="form-control input-sm" name="facpsi" required="">
                                            <option value="">Select Payment</option>
                                            <%
                                                DeletePojo dp = new DeletePojo();
                                                List<DeleteModel> list2 = dp.FactoryPayUp();
                                                for (DeleteModel dm : list2) {
                                            %>
                                            <option value="<%= dm.getFacpaysi()%>"><%= dm.getCompany()%>, <%= dm.getFacpayname()%>(<%= dm.getFacpayamount()%>)</option>
                                            <% } %>
                                        </select>
                                    </div>
                                    
                                    <div class="col-sm-6">
                                        <label>Set Amount</label>
                                        <input type="number" style=" width: 90%" class="form-control input-sm" name="amount" required="">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="GO">
                            </form>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
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
