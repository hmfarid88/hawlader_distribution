
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
        <%
            String retailer = request.getParameter("retailer");
            request.setAttribute("retailer", retailer);
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            ResultSet rs2 = null;
            ResultSet rs3 = null;
            
            try {
                con = Database.getConnection();
                String query = "select PRODUCT, PRODUCT_ID, PURCHASE_PRICE, DATE from vendor_stock where VENDOR=? and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
                ps = con.prepareStatement(query);
                ps.setString(1, retailer);
                rs = ps.executeQuery();
               
                String query1 = "select sum(PURCHASE_PRICE) from vendor_stock where VENDOR=?";
                ps = con.prepareStatement(query1);
                ps.setString(1, retailer);
                rs1 = ps.executeQuery();
                rs1.next();
                request.setAttribute("total", rs1.getLong(1));
                                
                String query2="select PAY_TYPE, AMOUNT, DATE from company_payment where COMPANY_NAME=? and YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
                ps = con.prepareStatement(query2);
                ps.setString(1, retailer);
                rs2 = ps.executeQuery();
                
                String query3="select sum(AMOUNT) from company_payment where COMPANY_NAME=?";
                ps = con.prepareStatement(query3);
                ps.setString(1, retailer);
                rs3 = ps.executeQuery();
                rs3.next();
                request.setAttribute("totalpay", rs3.getLong(1));
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
                                        <form method="POST" action="datewise_factory_ledger.jsp" class="form-inline">
                                            <input type="hidden" name="retailer" value="${param.retailer}">
                                            <input type="date" name="date1" autocomplete="off" class="form-control input-sm" placeholder="Start Date" required=""> To
                                            <input type="date" name="date2" autocomplete="off" class="form-control input-sm" placeholder="End Date" required="">
                                            <input type="submit" value="OK" class="btn btn-primary btn-sm">
                                        </form>
                                    </div>
                                </li>                                                             
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                           <li> <a  href="#" id="excel"><span class="fa fa-download"></span> Excel</a>  </li>   
                        </ul> 
                    </div>
                </nav>
            </header>
            
            <div class="row">
                <div class="col-sm-12">
                    
                        <ul class="nav nav-tabs">
                            <li class="active"><a data-toggle="tab" href="#proinfo">Product Info</a></li>
                            <li><a data-toggle="tab" href="#payinfo">Payment Info</a></li>
                        </ul>
                        <div class="tab-content">
                            <div id="proinfo" class="tab-pane fade in active"><br>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <a  href="#" name="b_print"  onClick="printdiv('div_print1')"><span class="glyphicon glyphicon-print"></span> Print</a>
                                    </div>
                                    <div class="col-sm-6"></div>
                                    <div class="col-sm-3">
                                        <input style="border-color: green; width: 90%" class="form-control input-sm" id="myInput1" type="text" placeholder="Search...">
                                    </div>
                                </div>
                                <div id="div_print1">
                                <center>
                                    <h3><b>Company Ledger</b></h3>
                                    <h4> Company Name : ${retailer}</h4>
                                    <h4>Product Info</h4>
                                    <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                                    <h4>Balance : ${totalpay-total}</h4>
                                </center>
                                    
                       <div style="background-image: url('img/levelupbg.png')!important; background-repeat: no-repeat !important; background-size: 300px 150px !important; background-position: 50% 50% !important;">
                                <table id="producttable" border="2" width="100%" class="table-condensed table-responsive">
                            <thead>
                                <tr style="background-color: #CCCCCC">
                                    <th style="text-align: center">SN</th>
                                    <th style="text-align: center">Model</th>
                                    <th style="text-align: center">Product ID</th>
                                    <th style="text-align: center">Qty</th>
                                    <th style="text-align: center">Price</th>
                                    <th style="text-align: center">Date</th>

                                </tr>
                            </thead>
                            <tbody id="myTable1">
                               <%
                                  while (rs.next()) {
                               %>
                               <tr>
                                   <td style="text-align: center"></td>
                                   <td style="text-align: center"><%= rs.getString(1)%> </td>
                                   <td style="text-align: center"><%= rs.getString(2)%></td>
                                   <th style="text-align: center">1</th>
                                   <th style="text-align: center"><%= rs.getFloat(3)%></th>
                                   <td style="text-align: center"><%= rs.getString(4)%></td>
                               </tr>
                               <% } %>
                             
                            </tbody>
                            <tfoot>
                                <tr style="background-color: #CCC">
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center">TOTAL</th>
                                    <td style="text-align: center"></td>
                                    <td style="text-align: center"></td>
                                    <th style="text-align: center"></th>
                                </tr> 
                            </tfoot>
                        </table>
                       </div>
                               <br>
                       </div>
                            </div>
                               <div id="payinfo" class="tab-pane fade"><br>
                                  <div class="row">
                                    <div class="col-sm-3">
                                        <a  href="#" name="b_print"  onClick="printdiv('div_print2')"><span class="glyphicon glyphicon-print"></span> Print</a>
                                    </div>
                                    <div class="col-sm-6"></div>
                                    <div class="col-sm-3">
                                        <input style="border-color: green; width: 90%" class="form-control input-sm" id="myInput2" type="text" placeholder="Search...">
                                    </div>
                                </div>
                                <div id="div_print2">
                                <center>
                                    <h3><b>Company Ledger</b></h3>
                                    <h4> Company Name : ${retailer}</h4>
                                    <h4>Payment Info</h4>
                                    <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                                    <h4>Balance : ${totalpay-total}</h4>
                                </center>
                                <div style="background-image: url('img/levelupbg.png')!important; background-repeat: no-repeat !important; background-size: 300px 150px !important; background-position: 50% 50% !important;">
                                <table id="paytable" border="2" width="100%" class="table-condensed table-responsive">
                            <thead>
                                <tr style="background-color: #CCCCCC">
                                    <th style="text-align: center">SN</th>
                                    <th style="text-align: center">Payment Type</th>
                                    <th style="text-align: center">Amount</th>
                                    <th style="text-align: center">Date</th>
                                          
                                </tr>
                            </thead>
                            <tbody id="myTable2">
                               <%
                                  while (rs2.next()) {
                               %>
                                <tr>
                                    <td style="text-align: center"></td>
                                    <td style="text-align: center"><%= rs2.getString(1)%> </td>
                                    <th style="text-align: center"><%= rs2.getFloat(2) %></th>
                                    <td style="text-align: center"><%= rs2.getString(3) %></td>
                                </tr>
                               <% }
                               } catch (SQLException ex) {
                                    ex.printStackTrace();
                                 }finally {
      
try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { } 
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
            <script language="javascript">
                            var addSerialNumber = function () {
                                var i = 0;
                                $('#paytable tr').each(function (index) {
                                    $(this).find('td:nth-child(1)').html(index - 1 + 1);
                                });
                            };

                            addSerialNumber();
            </script>
            <script>
$(document).ready(function(){
  $("#myInput1").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable1 tr").filter(function() {
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
    <script>
$(document).ready(function(){
  $("#myInput2").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable2 tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
    $('#paytable thead th').each(function(i) {
                calculateColumn(i);
            });
            function calculateColumn(index) {
            var total = 0;
            $('#paytable tr').each(function() {
                var value = parseInt($('th:visible', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#paytable tfoot td').eq(index).text(total);
        } 
  });
});
</script>
     <script>
        $(document).ready(function() {
            $('#paytable thead th').each(function(i) {
                calculateColumn(i);
            });
        });

        function calculateColumn(index) {
            var total = 0;
            $('#paytable tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#paytable tfoot td').eq(index).text(total);
        }
    </script>  
    <script>
            function download_csv(csv, filename) {
    var csvFile;
    var downloadLink;

    // CSV FILE
    csvFile = new Blob([csv], {type: "text/csv"});

    // Download link
    downloadLink = document.createElement("a");

    // File name
    downloadLink.download = filename;

    // We have to create a link to the file
    downloadLink.href = window.URL.createObjectURL(csvFile);

    // Make sure that the link is not displayed
    downloadLink.style.display = "none";

    // Add the link to your DOM
    document.body.appendChild(downloadLink);

    // Lanzamos
    downloadLink.click();
}

function export_table_to_csv(html, filename) {
	var csv = [];
	var rows = document.querySelectorAll("table tr");
	
    for (var i = 0; i < rows.length; i++) {
		var row = [], cols = rows[i].querySelectorAll("td, th");
		
        for (var j = 0; j < cols.length; j++) 
            row.push(cols[j].innerText);
        
		csv.push(row.join(","));		
	}

    // Download CSV
    download_csv(csv.join("\n"), filename);
}

document.querySelector("#excel").addEventListener("click", function () {
    var html = document.querySelector("table").outerHTML;
	export_table_to_csv(html, "Company_Ledger.csv");
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
