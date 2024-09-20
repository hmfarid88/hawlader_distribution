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
                                
                                <li style="margin-left: 20px"><a href="accountant.jsp"><span class="fa fa-home"></span> Home</a></li>
                                <li><a data-toggle="collapse" data-target="#demo2"  href="#">Adjustment-Receive</a> </li>
                                <li>
                                    <div style="margin: 10px 0" id="demo2" class="collapse">
                                   <form class=" form-inline" method="POST" action="PricedropAdjust">
                                <select   name="modelsino"  class="form-control input-sm"  required="" >
                            <option value="">Select Model</option>
                            <%
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs=null;
                                try {
                                    con = Database.getConnection();
                                    String query = "select SI_NO, MODEL from price_drop where (((PREV_PRICE-NEW_PRICE)*QTY)-RECEV)>0";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                            %>
                            <option value="<%= rs.getInt("SI_NO")%>"><%= rs.getString("MODEL")%></option>
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
                            <input style="max-width: 115px"  type="number" class="form-control input-sm" name="amount" value="" required="" placeholder="Amount">
                            <input type="submit"  class="btn btn-primary btn-sm" value="Ok">
                    </form>
                                    </div>  
                                </li>
                                
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li style=" margin-right: 50px; margin-top: 15px"><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li> 
                                <li> <a name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>

                        </div>

                    </nav>
            
            <br><div id="div_print">
                <center>
                    <h3>Price Drop List </h3>
                    <h4><script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                    <hr>
                    <table  border="2" id="mobiletable" class=" table-striped table-responsive" width="95%" >
                        <thead>
                            <tr style="background-color: #CCCCCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Model</th>
                                <th style="text-align: center">Qty</th>
                                <th style="text-align: center">Prev Price</th>
                                <th style="text-align: center">New Price</th>
                                <th style="text-align: center">Adjustment</th>
                                <th style="text-align: center">Received</th>
                                <th style="text-align: center">Balance</th>
                                <th style="text-align: center">Drop Date</th>
                                
                            </tr>
                        </thead> 
                        <%
                                
                            try {
                                con = Database.getConnection();
                                String query = "select MODEL, QTY, PREV_PRICE, NEW_PRICE, RECEV, DATE from price_drop where PREV_PRICE !=NEW_PRICE";
                                ps = con.prepareStatement(query);
                                rs = ps.executeQuery();
                                while (rs.next()) {
                        %>
                        <tbody id="myTable">
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= rs.getString("MODEL")%></td>
                            <th style="text-align: center"><%= rs.getInt("QTY")%></th>
                            <td style="text-align: center"><%= rs.getFloat("PREV_PRICE")%></td>
                            <td style="text-align: center"><%= rs.getFloat("NEW_PRICE")%></td>
                            <th style="text-align: center"><%= (rs.getFloat("PREV_PRICE")-rs.getFloat("NEW_PRICE"))*rs.getInt("QTY") %></th>
                            <th style="text-align: center"><%= rs.getFloat("RECEV")%></th>
                            <th style="text-align: center"><%= ((rs.getFloat("PREV_PRICE")-rs.getFloat("NEW_PRICE"))*rs.getInt("QTY"))-rs.getFloat("RECEV") %></th>
                            <td style="text-align: center"><%= rs.getString("DATE")%></td>
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
                                <td style="text-align: center"></td>
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"></td>
                                <th style="text-align: center"></th>
                              
                            </tr>
                        </tfoot>
                        
                   </table>
                </center>
            </div><br>
            <%@include file = "footerpage.jsp" %> 
        </div>
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
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
        </script>
       
        <% } %>
    </body>
</html>
