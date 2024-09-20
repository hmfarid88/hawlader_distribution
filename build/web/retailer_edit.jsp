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
                        <h3 class="text-primary" ><strong>Retailer Info</strong></h3>
                        <div class="col-sm-12">
                            <form method="POST" action="RetailerInfoUpdateServlet">

                                <table border="1px" width="70%" class="table-responsive table-condensed">
                                   
                                    <tr>
                                        <td>Retailer Name :</td>
                                        <td><input type="text" class="form-control" name="retailer" value="${rname}" required="" >
                                            <input type="hidden" name="oldretailer" value="${rname}">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Owner Name :</td>
                                        <td><input type="text" class="form-control" name="owner" value="${owner} " required="" ></td>
                                    </tr>
                                    <tr>
                                        <td>Address :</td>
                                        <td><input type="text" class="form-control" name="address" value="${address}" required></td>
                                    </tr>
                                    <tr>
                                        <td>Phone Number :</td>
                                        <td><input type="text" class="form-control" name="number" value="${mnumber}" required></td>
                                    </tr>
                                      <tr>
                                        <td>Email Address :</td>
                                        <td><input type="text" class="form-control" name="email" value="${email}" required></td>
                                    </tr>                               
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
        
               <script>
            history.pushState(null, document.title, location.href);
            window.addEventListener('popstate', function (event)
            {
                history.pushState(null, document.title, location.href);
            });
        </script>
        <% } %>
    </body>
</html>
