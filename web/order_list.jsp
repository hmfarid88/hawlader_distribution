
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
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
        <script src="js/jquery-3.1.1.min.js"></script>
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
        <center>
            <div class="panel panel-primary">
                <nav style="margin: 0 auto" class="navbar navbar-inverse ">
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
                           <li style="margin-top: 13px">
                            
                                <form method="POST" action="search_order_voucher.jsp" class="form-inline">
                                    <label style="color: white">Order Voucher</label>
                                    <input type="date" class="form-control input-sm" name="date" required="">
                                     <select style=" max-width: 60%" class="form-control select2"   name="srname" value=""  required="">
                                            <option>Select SR</option>
                                            <%                                                
                                            
                                               Connection con = null;
                                               PreparedStatement ps = null;
                                               ResultSet rs=null;  
                                                try {
                                                    con = Database.getConnection();
                                                    String query = "select distinct SR_NAME from order_list";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                            %>

                                            <option  value="<%= rs.getString("SR_NAME")%>" ><%= rs.getString("SR_NAME")%> </option>
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
                                
                                <input type="submit" class="btn btn-success btn-sm" value="OK"> 
                                </form>
                            </li>
                           <li style=" margin: 15px 60px "><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li>
                           <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                       </ul>

                    </div>

                </nav>
                <div class="panel-body"> 

                    <div class="row">
                        <div class="col-sm-12">
                            <div id="div_print">
                                <center>
                                    <h3>Order Report</h3>
                                    <h4>Date: ${param.date}</h4>
                                    <hr>
                                  <table border="2" class=" table-condensed table-responsive" width="100%" id="mobiletable" >
                                        <thead>
                                            <tr>
                                                <th style="text-align: center">SN</th>
                                                <th style="text-align: center">IMEI</th>
                                                <th style="text-align: center">Model</th>
                                                <th style="text-align: center">Color</th>
                                                <th style="text-align: center">Qty</th>
                                                <th style="text-align: center">Price</th>
                                                <th style="text-align: center">SR Name</th>
                                            </tr>
                                        </thead> 
                                        <tbody id="myTable">
                                            <%
                                                String date=request.getParameter("date");
                                                
                                                try {
                                                    con = Database.getConnection();
                                                    String query = "select PRODUCT_ID, MODEL, COLOR, PRICE, SR_NAME from order_list where DATE ='"+ date +"'";
                                                    ps=con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                                   
                                            %>
                                            <tr>
                                                <td style="text-align: center"></td>
                                                <td style="text-align: center"><%= rs.getString("PRODUCT_ID")%></td>
                                                <td style="text-align: center"><%= rs.getString("MODEL")%></td>
                                                <td style="text-align: center"><%= rs.getString("COLOR")%></td>
                                                <th style="text-align: center">1</th>
                                                <th style="text-align: center"><%= rs.getFloat("PRICE")%></th>
                                                <td style="text-align: center"><%= rs.getString("SR_NAME")%></td>
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
                                                <th style="text-align: center">TOTAL</th>
                                                <td style="text-align: center"></td>
                                                <td style="text-align: center"></td>
                                                <th style="text-align: center"></th>
                                            </tr>
                                        </tfoot>

                                    </table><br>
                                  
                                </center>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </center>
        <%@include file = "footerpage.jsp" %> 
    </div>
   
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
   
    <% }%>
</body>
</html>
