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
                        <li><a href="#" data-toggle="collapse" data-target="#mview" >Monthly View</a></li>
                        <li>
                                <div id="mview" class="collapse" style="margin: 10px 15px">
                                    <form method="POST" action="monthly_retail_ledger.jsp" class="form-inline">
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
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li style=" margin-right: 50px; margin-top: 15px"><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li>
                        <li><a id="pdf" href="#"><span class="fa fa-file-pdf-o"> PDF</span></a></li>
                        <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                    </ul> 
                </div>
            </nav>
        </header>

        <div id="div_print">
            <center>
                <h3>Retailer Ledger</h3>
                <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
            </center>
            <div style="background-image: url('img/levelupbg.png')!important; background-repeat: no-repeat !important; background-size: 300px 150px !important; background-position: 50% 50% !important;">
            <table  border="2" width="100%" class="table-condensed table-responsive">
                <thead>
                    <tr style="background-color: #CCC">
                        <th style="text-align: center">SN</th>
                        <th style="text-align: center">Retailer</th>
                        <th style="text-align: center">Qty</th>
                        <th style="text-align: center">Total Price</th>
                        <th style="text-align: center">As One Today</th>
                        <th style="text-align: center">Total Payment</th>
                        <th style="text-align: center">Balance</th>
                        <th style="text-align: center">Details</th>
                    </tr>
                </thead>
                <tbody id="myTable">
                    <%
                        AccountPojo ap=new AccountPojo();
                        List<StockModel> list = ap.RetailerLedger();
                        for (StockModel sml : list) {
                    %>
                    <tr>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"><%= sml.getRetiler()%></td>
                        <th style="text-align: center"><%= sml.getDelivery()%></th>
                        <th style="text-align: center"><%= sml.getTotalprice()%></th>
                        <th style="text-align: center"><%= sml.getCurpay()%></th>
                        <th style="text-align: center"><%= sml.getTotalpay()%></th>
                        <th style="text-align: center"><%= sml.getRetailerbalance()%></th>
                        
                        <td style="text-align: center">
                            <form method="POST" action="dtails_retLedger.jsp">
                                <input type="hidden" name="retailer" value="<%= sml.getRetiler()%>">
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
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
                        <td style="text-align: center"></td>
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
                            <form method="POST" action="RtpayUpdateServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Payment Name</label>
                                        <select style=" width: 90%" class="form-control input-sm" name="rtpsi" required="">
                                            <option value="">Select Payment</option>
                                            <%
                                                DeletePojo dp = new DeletePojo();
                                                List<DeleteModel> list2 = dp.RetlerPayUp();
                                                for (DeleteModel dm : list2) {
                                            %>
                                            <option value="<%= dm.getRtpaysi()%>"><%= dm.getRetailer()%>, <%= dm.getRtpayname()%>(<%= dm.getRtpayamount()%>)</option>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
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
    	$('#pdf').click(function () {
    var HTML_Width = $("#div_print").width();
 var HTML_Height = $("#div_print").height();
 var top_left_margin = 15;
 var PDF_Width = HTML_Width+(top_left_margin*2);
 var PDF_Height = (PDF_Width*1.5)+(top_left_margin*2);
 var canvas_image_width = HTML_Width;
 var canvas_image_height = HTML_Height;
 
 var totalPDFPages = Math.ceil(HTML_Height/PDF_Height)-1;
 
 
 html2canvas($("#div_print")[0],{allowTaint:true}).then(function(canvas) {
 canvas.getContext('2d');
 
 console.log(canvas.height+"  "+canvas.width);
 
 
 var imgData = canvas.toDataURL("image/jpeg", 1.0);
 var pdf = new jsPDF('p', 'pt',  [PDF_Width, PDF_Height]);
     pdf.addImage(imgData, 'JPG', top_left_margin, top_left_margin,canvas_image_width,canvas_image_height);
 
 
 for (var i = 1; i <= totalPDFPages; i++) { 
 pdf.addPage(PDF_Width, PDF_Height);
 pdf.addImage(imgData, 'JPG', top_left_margin, -(PDF_Height*i)+(top_left_margin*4),canvas_image_width,canvas_image_height);
 }
 
     pdf.save("RetailerLedger.pdf");
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
    <% }%>
</body>
</html>
