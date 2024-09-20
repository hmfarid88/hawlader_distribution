
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
        <title></title>
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
            String date1 = request.getParameter("date1");
            String date2 = request.getParameter("date2");
            request.setAttribute("date1", date1);
            request.setAttribute("date2", date2);
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs0 = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            ResultSet rs2 = null;
            ResultSet rs3 = null;
            try {
                con = Database.getConnection();
                String query0 = "select distinct COMPANY_NAME, ADDRESS, PHONE_NUMBER, EMAIL from companyinfo ";
                                                ps = con.prepareStatement(query0);
                                                rs0 = ps.executeQuery();
                                                rs0.next();
                 request.setAttribute("comname", rs0.getString(1));
                 request.setAttribute("comadd", rs0.getString(2));
                 request.setAttribute("comphone", rs0.getString(3));
                 request.setAttribute("comemail", rs0.getString(4));
                String query="select sum(VALUE-PAYMENT) from retailer_statement where DATE<? and RETAILER=?";
                ps = con.prepareStatement(query);
                ps.setString(1, date1);
                ps.setString(2, retailer);
                rs = ps.executeQuery();
                rs.next();
                request.setAttribute("preblance", rs.getLong(1));
               
                String query1="select OWNER from retailer_info where R_NAME=?";
                ps = con.prepareStatement(query1);
                ps.setString(1, retailer);
                rs1 = ps.executeQuery();
                rs1.next();
                request.setAttribute("owner", rs1.getString(1));
                                                
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
                             <li><a href="retailer_ledger.jsp"><span class="fa fa-backward"> Back to Ledger</span></a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a id="pdf" href="#"><span class="fa fa-file-pdf-o"> PDF</span></a></li>
                            
                             <li> <a  href="#" id="excel"><span class="fa fa-download"></span> Excel</a>  </li>
                            <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                        </ul> 
                    </div>
                </nav>
            </header>
            
            <div class="row">
                <br><form method="post" action="StatementMail" class="pull-right" style="margin-right: 10%">
                                            <input type="hidden" name="retailer" value="${retailer}" >
                                            <input type="submit" value="Send Mail">
                                        </form>
                <div class="col-sm-12">
                    <div id="div_print">
                        <center>
                            <h2><b>${comname}</b></h2>
                            <h4>${comadd}</h4>
                            <h4>Phone: ${comphone}</h4>
                            <h4>E-Mail: ${comemail}</h4>
                            <h4><b> Retailer Name : ${retailer}</b></h4>
                            <h4> <b>Owner Name : ${owner}</b></h4>
                            <h4><b>Statement Date : ${date1} TO ${date2}</b></h4>
                        </center>
                         
                        
                        <center>
                                                  
                        <table border="2" class="table-condensed table-responsive">
                            <thead>
                                <tr style="background-color: #CCCCCC; height: 30px">
                                    <th style="text-align: center; width: 200px">Date</th>
                                    <th style="text-align: center; width: 200px">Invoice No</th>
                                    <th style="text-align: center; width: 80px">Quantity</th>
                                    <th style="text-align: center; width: 100px">Product Value</th>
                                    <th style="text-align: center; width: 100px">Payment</th>
                                    <th style="text-align: center; width: 100px">Payment Type</th>
                                    <th style="text-align: center; width: 150px">Balance</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                                <tr>
                                    <td style="text-align: center"><b>${date1}</b> </td>
                                    <td style="text-align: center"><b>Previous Balance</b></td>
                                    <td style="text-align: center"></td>
                                    <td style="text-align: center"></td>
                                    <td style="text-align: center"></td>
                                    <td style="text-align: center"></td>
                                    <td style="text-align: center"><b>${preblance}</b></td>
                                </tr>
                                <%
                            
                String query3 = "select SI_NO, DATE, INVOICE, QTY, VALUE, PAYMENT, NOTE  from retailer_statement where RETAILER=? and DATE between '"+ date1 +"' and '"+ date2 +"' order by SI_NO ";
                ps = con.prepareStatement(query3);
                ps.setString(1, retailer);
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                int sino=rs2.getInt(1);
               String bl="select sum(VALUE-PAYMENT) from retailer_statement where RETAILER=? and SI_NO<? ";             
               ps = con.prepareStatement(bl);                  
               ps.setString(1, retailer);
               ps.setInt(2, sino);
               rs3 = ps.executeQuery();
               while (rs3.next()) {
    
%>
                                 <tr>
                                    <td style="text-align: center"> <%= rs2.getString(2) %></td>
                                    <td style="text-align: center">
                                        <form method="POST" action="searched_invoice.jsp">
                                            <input type="hidden" name="invono" value="<%= rs2.getString(3) %>" >
                                            <input type="submit" class="form-control" style=" height: 25px; border: none" value="<%= rs2.getString(3) %>" >
                                        </form>
                                        </td>
                                    <th style="text-align: center"><%= rs2.getInt(4) %></th>
                                    <th style="text-align: center"><%= rs2.getLong(5) %></th>
                                    <th style="text-align: center"><%= rs2.getLong(6) %></th>
                                    <td style="text-align: center"><%= rs2.getString("NOTE") %></td>
                                    <th style="text-align: center"><%= rs3.getLong(1)+rs2.getLong(5)-rs2.getLong(6) %></th>
                                </tr>
      
                                <% }} %>
                            </tbody>
                            <tfoot>
                                <tr style="background-color: #CCCCCC; height: 30px">
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center">TOTAL</th>
                                    <td style="text-align: center"></td>
                                    <td style="text-align: center"></td>
                                    <td style="text-align: center"></td>
                                    <th style="text-align: center"></th>
                                    <th style="text-align: center"></th>
                                </tr>
                            </tfoot>
                        </table>
                        
                        </center>
                            <br>
                                                                                
                                <%
                                 } catch (SQLException ex) {
                                    ex.printStackTrace();
                                 }finally {
try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }        
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
try { if (rs0 != null) rs0.close(); rs0=null; } catch (SQLException ex2) { }
try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                         }
                                %>
                                                     
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
	export_table_to_csv(html, "Retailer_Statement.csv");
});
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
 
     pdf.save("RetailerStatement.pdf");
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
