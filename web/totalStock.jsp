<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.io.File"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <body>
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
        <div id="main" class="container-fluid">
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
                                <li><a href="accountant.jsp"><span class="fa fa-home"></span> Home</a></li>
                                <li><a data-toggle="collapse" data-target="#demo2"  href="#"><span class="fa fa-edit"></span> Price Update</a> </li>
                                <li>
                                    <div style="margin: 10px 0" id="demo2" class="collapse">
                                   <form class=" form-inline" method="POST" action="StockRateUpdate">
                                <select   name="mname"  class="form-control input-sm"  required="" >
                            <option value="">Select Model</option>
                            <%
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs=null;
                                try {
                                    con = Database.getConnection();
                                    String query = "select distinct MODEL from stock ";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getString("MODEL")%>"><%= rs.getString("MODEL")%></option>
                            <%
                                    }
                                } catch (Exception ex) {
                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                            %>

                        </select>
                            <input style="max-width: 115px"  type="number" class="form-control input-sm" name="pprice" value="" required="" placeholder="Purhase Price">
                <input style="max-width: 115px" type="number" class="form-control input-sm" name="sprice" value="" required="" placeholder="Sale Price">
                <input type="submit"  class="btn btn-primary btn-sm" value="Ok">
                    </form>
                                    </div>  
                                </li>
                                <li><a href="#" data-toggle="collapse" data-target="#demo" ><span class="fa fa-trash"></span> Stock-Delete</a> </li>
                        <li>
                            <div style="margin: 10px 0" id="demo" class="collapse" >
                                <form method="POST" action="stock_rollback.jsp" class="form-inline"> 
                                    <select class=" form-control" name="cause" required="">
                                        <option value="">Cause</option>
                                        <option value="Return">Company Return</option>
                                        <option value="Mistake">Mistake</option>
                                    </select>
                                    <input type="text" size="10px" name="rollback" id="imei" class="form-control"  placeholder="Input IMEI " value="" required="" >
                                    <input type="submit" id="ok" class="btn btn-primary btn-sm" value="OK">
                                </form>  
                            </div>
                        </li>
                        <li><a data-toggle="collapse" data-target="#productedit"  href="#"><span class="fa fa-address-book"></span> Edit Product</a> </li>
                          <li>
                            <div style="margin: 10px 0" id="productedit" class="collapse" >
                                <form method="POST" action="stock_edit.jsp" class="form-inline"> 
                                    <input type="text" size="20px" name="imei" class="form-control"  placeholder="Input IMEI " value="" required="" >
                                    <input type="submit" id="ok" class="btn btn-primary btn-sm" value="OK">
                                </form>  
                            </div>
                        </li>      
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li style=" margin-right: 50px; margin-top: 15px"><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li> 
                                <li><a href="#" id="excel"><span class="fa fa-download"></span> Excel</a></li>
                                <li> <a name="b_print" href="#"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>

                        </div>

                    </nav>
            
            <br><div id="div_print">
                <div style="background-image: url('img/levelupbg.png')!important; background-repeat: no-repeat !important; background-size: 300px 150px !important; background-position: 50% 50% !important;">
                <center>
                    <table> <h3>Stock Details </h3>
                        <h4><script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4></table>
                    <hr>
                    <table  border="2" id="mobiletable" class=" table-striped table-responsive" width="100%" >
                        <thead>
                            <tr style="background-color: lightblue">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Entry Date</th>
                                <th style="text-align: center">Area</th>
                                <th style="text-align: center">Store Name</th>
                                <th style="text-align: center">Boss Name</th>
                                <th style="text-align: center">Phone Model</th>
                                <th style="text-align: center">Color</th>
                                <th style="text-align: center">Qty</th>
                                <th style="text-align: center">IMEI</th>
                                <th style="text-align: center">Vendor</th>
                                <th style="text-align: center">Purchase Price</th>
                                <th style="text-align: center">Sale Price</th>
                              
                            </tr>
                        </thead> 
                        <%
                           String demo="Demo";
                            try {
                                con = Database.getConnection();
                                String query = "select MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, VENDOR, AREA, STORE, BOSS, DATE from stock where MODEL not like '%"+ demo +"%' order by MODEL";
                                ps = con.prepareStatement(query);
                                rs = ps.executeQuery();
                                while (rs.next()) {
                        %>
                        <tbody id="myTable">
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= rs.getString("DATE")%></td>
                            <td style="text-align: center"><%= rs.getString("AREA")%></td>
                            <td style="text-align: center"><%= rs.getString("STORE")%></td>
                            <td style="text-align: center"><%= rs.getString("BOSS")%></td>
                            <td style="text-align: center"><%= rs.getString("MODEL")%></td>
                            <td style="text-align: center"><%= rs.getString("COLOR")%></td>
                            <th style="text-align: center">1</th>
                            <td style="text-align: center"><%= rs.getString("IMEI")%></td>
                            <td style="text-align: center"><%= rs.getString("VENDOR")%></td>
                            <th style="text-align: center"><%= rs.getString("PURCHASE_PRICE")%></th>
                            <th style="text-align: center"><%= rs.getString("SELL_PRICE")%></th>
                           
                        </tr>

                        <%
                                }
                            } catch (Exception ex) {
                            }finally {
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
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center">TOTAL</th>
                                <td style="text-align: center"></td>
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"></td>
                            </tr>
                        </tfoot>
                        
                   </table>
               </center>
                </div>
            </div><br>
            <%@include file = "footerpage.jsp" %> 
        </div>
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
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
	export_table_to_csv(html, "Stock_Details.csv");
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
                             var addSerialNumber = function () {
                                 var i = 0;
                                 $('#mobiletable tr').each(function (index) {
                                     $(this).find('td:nth-child(1)').html(index - 1 + 1);
                                 });
                             };

                             addSerialNumber();
                             $(function() {
                            $('#imei').on('keypress', function(e) {
                            if (e.which === 32)
                             return false;
                                 });
                             });
        </script>
       
        <% } %>
    </body>
</html>
