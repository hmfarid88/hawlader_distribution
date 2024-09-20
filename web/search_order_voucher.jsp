<%@page import="Model.Accountant"%>
<%@page import="java.util.List"%>
<%@page import="Pojo.AccountPojo"%>
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
         <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
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
    <div id="main" class="container-fluid" style="background-color: #CCCCCC">
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
                <ul  class="nav navbar-nav navbar-right">
                    <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                </ul> 
            </div>

        </nav>

        <div class="row">
            <div class="col-sm-2">
                 
            </div>

            <div class="col-sm-8">

                <div id="div_print"><br>
                    <center>

                        <div style=" width: 700px; height: 100%; border-color: black" class="panel">

                            <table>
                                <tr>
                                    <td style="width: 17%"><img src="img/helogo.png" class="img-responsive" style="height: 100px; width: 100px;"></td>
                                    <td style="text-align: center">


                                        <%
                                            String srname=request.getParameter("srname");
                                            String date=request.getParameter("date");
                                            Connection con = null;
                                            PreparedStatement ps = null;
                                            ResultSet rs=null;
                                            try {
                                                con = Database.getConnection();
                                                String query = "select distinct COMPANY_NAME, ADDRESS, PHONE_NUMBER, EMAIL from companyinfo ";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                        %>
                                        <p style=" font-size: 30px;margin-top: 5px; color: #8c8c8c;"><b><%= rs.getString("COMPANY_NAME")%></b></p>
                                        <p style="font-size: 15px"><%= rs.getString("ADDRESS")%><br>
                                            <span class="glyphicon glyphicon-phone-alt"></span> <%= rs.getString("PHONE_NUMBER")%><br>
                                            E-mail :<%= rs.getString("EMAIL")%> 

                                        </p>
                                        <%
                                                }
                                            } catch (Exception ex) {
                                            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                        %>
                                    </td>
                                </tr>
                            </table>
                            <p style=" font-size: 20px"><u><strong>Order List</strong></u></p>
                            <table style=" margin-left: 5px"  width="100%" class="table-responsive">

                                <tr style=" border-bottom-style: hidden">
                                    <td style="border-right-style: hidden; font-size: 12px" width="50%">
                                      
                                      <label>DATE : ${param.date}</label>   
                                    </td>
                                   <td><label class="text-uppercase" style="font-size: 12px; margin-left: 120px"> SR NAME : ${param.srname}</label></td>
                                </tr>
                              
                            </table>
                           
                            <table id="dist" border="1" width="100%" class="myTables"  cellspace="1px" >
                                <thead>
                                    <tr style="font-size: 13px">
                                <th style="border-left-style: hidden"><center>SN</center></th>
                                <th><center>Description</center></th>
                                <th><center>Qty</center></th>
                                <th><center>Price</center></th>
                                </tr>
                                </thead>
                                <tbody>

                                    <%
                                        try {
                                            con = Database.getConnection();
                                            String query = "select PRODUCT_ID, MODEL, COLOR, PRICE from order_list where  SR_NAME='"+srname+"' and DATE='"+date+"'";
                                            ps = con.prepareStatement(query);
                                            rs = ps.executeQuery();
                                            while (rs.next()) {
                                                
                                    %>

                                    <tr class="text-uppercase"  style="border-bottom-color: #CCC; font-size: 12px">

                                        <td style="text-align: center; ">  </td>

                                        <td style="text-align: center"> <%= rs.getString("MODEL")%>(<%= rs.getString("COLOR")%>), IMEI <%= rs.getString("PRODUCT_ID")%> </td>

                                        <th><center>1</center></th>
                                <th><center><%= rs.getFloat("PRICE")%></center></th> 
                               
                                <%
                                        }
                                    } catch (Exception ex) {

                                    }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                %>
                                </tr>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <th></th>
                                        <th style="text-align: center">TOTAL</th>
                                        <td style="text-align: center"></td>
                                        <td style="text-align: center"></td>
                                    </tr>
                                </tfoot>
                            </table>
                                <br>
                                <table border="1" width="100%">
                                <tr style="border-style: hidden"><td style="font-size: 15px"><label style="margin-left: 10px">Signature: . . . . . . . . . . . .</label></td></tr>
                            </table>
                        </div>

                    </center>

                </div>
            </div>

            <div class="col-sm-2"></div>              
        </div>
      
    </div>
    
    <script src="js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
   <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
    <script language="javascript">
                       var addSerialNumber = function () {
                           var i = 0;
                           $('.myTables tr').each(function (index) {
                               $(this).find('td:nth-child(1)').html(index - 1 + 1);
                           });
                       };

                       addSerialNumber();
    </script>
    <script language="javascript">
        var addSerialNumber = function () {
            var i = 0;
            $('#myTable tr').each(function (index) {
                $(this).find('td:nth-child(1)').html(index - 1 + 1);
            });
        };

        addSerialNumber();
    </script>
   <script>
        $(document).ready(function() {
            $('#dist thead th').each(function(i) {
                calculateColumn(i);
            });
        });

        function calculateColumn(index) {
            var total = 0;
            $('#dist tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#dist tfoot td').eq(index).text(total);
        }
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
    
    <% }%>
</body>
</html>
