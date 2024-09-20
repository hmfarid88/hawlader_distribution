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
                        
                        <li> <a href="accountant.jsp"><span class="fa fa-home"></span> Home</a></li>
                    </ul>
                </div>
            </nav>

            <center>
                <div class="panel panel-primary" style="width: 100%; background-color: #CDCBCB">

                    <div class="panel-body">
                        <h3 class="text-primary" ><strong>Product Info</strong></h3>
                        <div class="col-sm-12">
                            <form method="POST" action="ProductInfoUpdateServlet">

                                <table border="1px" width="70%" class="table-responsive table-condensed">
                                    <%
                                        String ime=request.getParameter("imei");
                                        Connection con = null;
                                        PreparedStatement ps = null;
                                        ResultSet rs=null;

                                        try {
                                            con = Database.getConnection();
                                            String query = "select MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, VENDOR from stock where IMEI=? ";
                                            ps=con.prepareStatement(query);
                                            ps.setString(1, ime);
                                            rs = ps.executeQuery();
                                            while (rs.next()) {
                                    %>
                                   <tr>
                                        <td>IMEI:</td>
                                        <td><input type="text" class="form-control"  value="<%= rs.getString("IMEI")%>" readonly="" ></td>
                                        <input type="hidden" class="form-control" name="himei" value="<%= rs.getString("IMEI")%> " >
                                    </tr>
                                    <tr>
                                        <td>MODEL :</td>
                                        <td><input type="text" class="form-control" name="model" value="<%= rs.getString("MODEL")%>" required="" ></td>
                                    </tr>
                                    <tr>
                                        <td>COLOR :</td>
                                        <td><input type="text" class="form-control" name="color" value="<%= rs.getString("COLOR")%>" required></td>
                                    </tr>
                                    
<!--                                    <tr>
                                        <td>NEW IMEI:</td>
                                        <td><input type="text" class="form-control" name="imei" value="No" ></td>
                                        
                                    </tr>-->
                                    <tr>
                                        <td>PURCHASE PRICE :</td>
                                        <td><input type="text" class="form-control" name="pprice" value="<%= rs.getFloat("PURCHASE_PRICE")%>" required></td>
                                    </tr>
                                    <tr>
                                        <td>SALE PRICE :</td>
                                        <td><input type="text" class="form-control" name="sprice" value="<%= rs.getFloat("SELL_PRICE")%> " required="" ></td>
                                    </tr>
                                    <tr>
                                        <td>VENDOR :</td>
                                        <td><input type="text" class="form-control" name="vendor" value="<%= rs.getString("VENDOR")%> " required="" ></td>
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
                                    <tr>
                                        <td></td>
                                        <td>
                                            <input type="submit" name="" value="Update" class="btn btn-success" >
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>

                    </div>

                </div>
                <%@include file = "footerpage.jsp" %> 
            </center>
        </div>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery-3.1.1.min.js"></script>
        
             
        <% } %>
    </body>
</html>
