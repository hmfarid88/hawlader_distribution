
<%@page import="Model.AdminModel"%>
<%@page import="java.util.List"%>
<%@page import="Pojo.AdminPojo"%>
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
    <body id="">
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
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul> 
                        </div>
                    </nav>
                </header>
            <div class="row">
                <div class="col-sm-12">
                    <div id="div_print">
                    <center>
                        <h3 style="font-family: fontawesome"><b>Employee's Info</b></h3>
                        <h5><b>Date : <script> document.write(new Date().toLocaleDateString('en-GB'));</script> </b></h5>
                    </center>
                    <table border="2" width="100%" class="table-condensed table-responsive">
                        <thead>
                            <tr style="background-color: #CCCCCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Employee Name</th>
                                <th style="text-align: center">Father's Name</th>
                                <th style="text-align: center">Address</th>
                                <th style="text-align: center">Phone Number</th>
                                <th style="text-align: center">Designation</th>
                            </tr>
                        </thead>
                        <tbody>
                             <%
                                AdminPojo ap = new AdminPojo();
                                List<AdminModel> list = ap.EmpShow();
                                for (AdminModel am : list) {
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= am.getEname() %></td>
                                <td style="text-align: center"><%= am.getFname() %></td>
                                <td style="text-align: center"><%= am.getEmpaddress() %></td>
                                <td style="text-align: center"><%= am.getEmpphone() %></td>
                                <td style="text-align: center"><%= am.getEmpdesi() %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
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
                                $('table tr').each(function (index) {
                                    $(this).find('td:nth-child(1)').html(index - 1 + 1);
                                });
                            };

                            addSerialNumber();
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
