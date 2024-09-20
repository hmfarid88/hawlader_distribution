
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

        <div id="main" class="container">
            <center>
                <div class="panel panel-primary">
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
                                
                            </ul>
                           <ul class="nav navbar-nav navbar-right">
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>

                        </div>

                    </nav>
                    <div class="panel-body"> 

                        <div class="row">
                            <div class="col-sm-12">
                                <div id="div_print">
                                    <center>
                                        <h4>View Searched Product</h4>   
                                        <h5>Search Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script> </h5>
                                        <hr>
                                        <div id="noproduct"><h4>Sorry No Product Found For This Input</h4></div>
                                        <table border="2" class=" table-condensed table-responsive" width="70%" >
                                            <tbody>
                                                <%
                                                    String imei = request.getParameter("imei");

                                                    Connection con = null;
                                                    PreparedStatement ps = null;
                                                    ResultSet rs=null;
                                                    try {
                                                        con = Database.getConnection();
                                                        String query = "select PRODUCT_ID, CUSTOMER_ID, MODEL, COLOR, COST_PRICE, PRICE, DISCOUNT, VENDOR, RETAILER,"
                                                                + " STOCK_DATE, SELL_DATE  from mobilesell where PRODUCT_ID='" + imei + "' ";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {

                                                %>
                                                <tr id="productshow"><th>Product Condition </th><td>Sold to <b><%= rs.getString("RETAILER") %></b></td></tr>
                                                <tr> <th>Model</th> <td><%= rs.getString("MODEL")%></td></tr>
                                                <tr> <th>Color</th> <td><%= rs.getString("COLOR")%></td></tr>
                                                <tr> <th>IMEI</th> <td><%= rs.getString("PRODUCT_ID")%></td></tr>
                                                <tr> <th>Purchase Price</th> <td><%= rs.getFloat("COST_PRICE")%></td></tr>
                                                <tr> <th>Sale Price</th> <td><%= rs.getFloat("PRICE")%> </td></tr>
                                                <tr> <th>Discount</th> <td><%= rs.getFloat("DISCOUNT")%> </td></tr>
                                                <tr> <th>Vendor</th> <td><%= rs.getString("VENDOR")%></td></tr>
                                                <tr> <th>Stock Date</th> <td><%= rs.getString("STOCK_DATE")%></td></tr>
                                                <tr> <th>Sale Date</th> <td><%= rs.getString("SELL_DATE")%></td></tr>

                                                <%
                                                        }
                                                    } catch (Exception ex) {
                                                    }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                %>
                                               

                                                <%
                                                    try {
                                                        con = Database.getConnection();
                                                        String query = "select  MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, VENDOR,"
                                                                + " DATE  from stock where IMEI='" + imei + "' ";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                %>
                                                <tr id="productshow"><th>Product Condition </th><td>Stored in Stock</td></tr>
                                                <tr> <th>Model</th> <td><%= rs.getString("MODEL")%></td></tr>
                                                <tr> <th>Color</th> <td><%= rs.getString("COLOR")%></td></tr>
                                                <tr> <th>IMEI</th> <td><%= rs.getString("IMEI")%></td></tr>
                                                <tr> <th>Purchase Price</th> <td><%= rs.getFloat("PURCHASE_PRICE")%></td></tr>
                                                <tr> <th>Sale Price</th> <td><%= rs.getFloat("SELL_PRICE")%> </td></tr>
                                                <tr> <th>Vendor</th> <td><%= rs.getString("VENDOR")%></td></tr>
                                                <tr> <th>Stock Date</th> <td><%= rs.getString("DATE")%></td></tr>


                                                <%
                                                        }
                                                    } catch (Exception ex) {

                                                    }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                %>
                                                 <%
                                                    try {
                                                        con = Database.getConnection();
                                                        String query = "select  MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, VENDOR,"
                                                                + " DATE  from stock_delete where IMEI='" + imei + "' ";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        while (rs.next()) {
                                                %>
                                                <tr id="productshow"><th>Product Condition </th><td>Stored in Delete Stock</td></tr>
                                                <tr> <th>Model</th> <td><%= rs.getString("MODEL")%></td></tr>
                                                <tr> <th>Color</th> <td><%= rs.getString("COLOR")%></td></tr>
                                                <tr> <th>IMEI</th> <td><%= rs.getString("IMEI")%></td></tr>
                                                <tr> <th>Purchase Price</th> <td><%= rs.getFloat("PURCHASE_PRICE")%></td></tr>
                                                <tr> <th>Sale Price</th> <td><%= rs.getFloat("SELL_PRICE")%> </td></tr>
                                                <tr> <th>Vendor</th> <td><%= rs.getString("VENDOR")%></td></tr>
                                                <tr> <th>Delete Date</th> <td><%= rs.getString("DATE")%></td></tr>


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
                                        </table>

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
        <script src="js/jquery-3.1.1.min.js"></script>
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
                                            $(document).ready(function () {
                                                $("#productshow").show(function () {
                                                    $("#noproduct").hide();
                                                });
                                            });
        </script>
     

<% } %>

    </body>
</html>
