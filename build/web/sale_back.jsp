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
                    <table> <h3>Sale Back Details </h3>
                        <h4><script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4></table>
                    
                    <table  border="2" id="mobiletable" class=" table-striped table-responsive" width="100%" >
                        <thead>
                            <tr style="background-color: #CCCCCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Model</th>
                                <th style="text-align: center">Color</th>
                                <th style="text-align: center">IMEI</th>
                                <th style="text-align: center">Qty</th>
                                <th style="text-align: center">Purchase Price</th>
                                <th style="text-align: center">Sale Price</th>
                                <th style="text-align: center">Retailer</th>
                                <th style="text-align: center">Sale Date</th>
                                <th style="text-align: center">Back Date</th>
                               
                            </tr>
                        </thead> 
                        <%
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs=null;
                            
                            try {
                                con = Database.getConnection();
                                String query = "select MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, RETAILER, SALE_DATE, BACK_DATE from sale_back;";
                                ps = con.prepareStatement(query);
                                rs = ps.executeQuery();
                                while (rs.next()) {
                        %>
                        <tbody id="myTable">
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= rs.getString("MODEL")%></td>
                            <td style="text-align: center"><%= rs.getString("COLOR")%></td>
                            <td style="text-align: center"><%= rs.getString("IMEI")%></td>
                            <th style="text-align: center">1</th>
                            <th style="text-align: center"><%= rs.getFloat("PURCHASE_PRICE")%></th>
                            <th style="text-align: center"><%= rs.getFloat("SELL_PRICE")%></th>
                            <td style="text-align: center"><%= rs.getString("RETAILER")%></td>
                            <td style="text-align: center"><%= rs.getString("SALE_DATE")%></td>
                            <td style="text-align: center"><%= rs.getString("BACK_DATE")%></td>
                                                       
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
                                <td style="text-align: center"></td>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"></td>
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
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
