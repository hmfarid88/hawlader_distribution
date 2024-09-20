<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
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
         <style>
            fieldset.scheduler-border {
    border: 1px groove white ;
    padding: 0 1.4em 1.4em 1.4em ;
    margin: 0 0 1.5em 0;
    -webkit-box-shadow:  0px 0px 0px 0px #000;
    box-shadow:  0px 0px 0px 0px #000;
}

legend.scheduler-border {
    width:inherit; 
    padding:0 10px; /* To give a bit of padding on the left and right */
    border-bottom:none;
}
        </style>
    </head>
    <body>


        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
    
    <div id="main" class="container-fluid" style="background-color: #030303">

        <center>
            <div class="panel panel-primary" style="background-color: #030303; color: #ffffff">
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
                            <li id="hmbtn"><a href="accountant.jsp" ><span class="glyphicon glyphicon-home"></span> Home</a></li>
                            
                        </ul>
                        <ul class="nav navbar-nav navbar-right">

                            <li style="margin-top: 10px; margin-right: 30px">
                                <form method="POST" action="OrderbackServlet" class="form-inline">
                                    <label>Order Delete</label>
                                    <input type="text" name="rollback" class="form-control input-sm" placeholder="Input IMEI" required="">
                                <input type="submit" class="btn btn-success btn-sm" value="OK"> 
                                </form>
                            </li>
                        </ul>
                    </div>
                </nav>
                
                  <div class="panel-body">
                    <h3 class="text-center">Create Order</h3>
                    <div class="row">
                        <div style="margin-right: 10%" class=" pull-right">  
                            <label>SR NAME : ${srname}</label>
                                                       
                        </div>
                        <div style="margin-left: 10%" class=" pull-left">
                            <h4>DATE: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                        </div>
                    </div>
                    
                      <hr> 
                    <div class="row">
                        <div class="col-sm-1">
                            
                        </div>
                        <div class="col-sm-10">
                            <div class="row">
                                <div class="col-sm-6">
                                    <br> 
                                    <form id="saleform" method="POST" action="OrderEntreServlet" class="form-inline" >
                                        <input type="hidden" name="srname" value="${srname}">
                                        <label>Mobile IMEI</label><br>
                                        <input type="text" style="max-width: 80%" maxlength="15" minlength="15" pattern="[0-9]{15}"  class="form-control input-sm" name="imei" id="imei" value="" required="" autofocus="" >
                                        <input type="submit" id="submit"  value="OK" class="btn btn-primary btn-sm">
                                       
                                    </form>
                                </div>
                                                                                   
                                <br>
                                <div class="col-sm-6">
                                    <form method="POST" action="OrderEntreServlet">
                                       <input type="hidden" name="srname" value="${srname}">
                                       <label>Add Manually</label><br>
                                        <select style=" max-width: 60%" class="form-control select2"  onchange="this.form.submit()"  name="imei" value=""  required="">
                                            <option>Select Mobile IMEI</option>
                                            <%                                                
                                            
                                               Connection con = null;
                                               PreparedStatement ps = null;
                                               ResultSet rs=null;  
                                                try {
                                                    con = Database.getConnection();
                                                    String query = "select IMEI, MODEL from stock order by MODEL ";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                            %>

                                            <option  value="<%= rs.getString("IMEI")%>" ><%= rs.getString("MODEL")%> (<%= rs.getString("IMEI")%>)</option>
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

                                    </form>

                                </div>
                                                          
                            </div>
                            <div class="row">
                                <br>
                                <table  border="1" width="100%" id="myTables" class="table-responsive" >
                                    <thead>
                                        <tr>
                                            <th class="text-center">SN</th>
                                            <th class="text-center">Products</th>
                                            <th class="text-center">Qty</th>
                                            <th class="text-center">Price</th>
                                            <th class="text-center">Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <%

                                            try {
                                                con = Database.getConnection();
                                                String query = "select MODEL, PRODUCT_ID, COLOR, PRICE from order_list where DATE=CURDATE() and SR_NAME=(select SR_NAME from order_list order by SI_NO desc limit 1)";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {

                                        %>  

                                        <tr>
                                            <td style="text-align: center"> </td>
                                            <td>
                                    <center>
                                        <%= rs.getString("MODEL")%> , <%= rs.getString("COLOR")%> , <%= rs.getString("PRODUCT_ID")%>
                                    </center>
                                    </td>
                                    <th><center>1</center></th>
                                    <th Style="width:70px ">
                                    <center><%= rs.getFloat("PRICE") %></center>
                                    </th>
                                   
                                    <td><center>
                                        <form method="POST" action="OrderbackServlet">
                                            <input type="hidden" name="rollback" id="rollback" value="<%= rs.getString("PRODUCT_ID")%>" >
                                            <button id="productdel"  type="submit" ><span style=" color: red" class="fa fa-trash-o"></span></button>
                                        </form>

                                    </center></td>

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
                                            <th style="text-align: center; color: red">TOTAL</th> 
                                            <td style="text-align: center; color: red"></td> 
                                            <td style="text-align: center; color: red"></td> 
                                            <th></th> 
                                        </tr>
                                    </tfoot>
                                </table> 

                            </div>  
                            <br>

                        </div>
                        <div class="col-sm-1"></div>
                    </div>
                    <form id="saleform" method="POST" action="order_voucher.jsp" name="myForm" >
                       <div class="row">  
                           <div class="col-sm-4"></div>
                           <div class="col-sm-4">
                               <input type="hidden" name="srname" value="${srname}">
                               
                            </div>
                                <div class="col-sm-4"></div>
                                        </div>
                          
                            <input type="hidden" name="orderid" value="${orderid}" >
                            <div class="row">
                                <br><br>
                                <div class="col-sm-4"></div>
                                <div class="col-sm-4">
                                    <input type="submit" id="okvo" class="btn btn-success" value="Print Voucher" >
                                </div>
                                <div class="col-sm-4"></div>
                            </div>
                        </form> 
                     <script>
                            $(document).ready(function () {
                                $("#saleform").submit(function () {
                                    if (this.beenSubmitted)
                                        return false;
                                    else
                                        this.beenSubmitted = true;
                                });
                            });
                        </script>
                       
                    </div>
                 </div>
                            <%@include file = "footerpage.jsp" %> 
                </center> 
            </div>
                            
                           <script>
                            $(document).ready(function () {        
                            $(function() {
                            $('#imei').on('keypress', function(e) {
                            if (e.which === 32)
                             return false;
                                 });
                             });
                            });
                       </script>
                       <script>
   $('.select2').select2();
                       </script>
<script>
        $(document).ready(function () {
            $("#productdel").show(function () {
                $("#hmbtn").hide();
             });
               });
    </script>
    <script>
        $(document).ready(function () {
            $("#okvo").hide();
            $("#productdel").show(function () {
                $("#hmbtn").hide();
                $("#okvo").show();
            });
            
        });
    </script>
   
    <script>
                            history.pushState(null, document.title, location.href);
                            window.addEventListener('popstate', function (event)
                            {
                                history.pushState(null, document.title, location.href);
                            });
    </script>
    <script>
       $(document).ready(function () { 
     $('#dis').keyup(function (ev) {
        var d=document.getElementById("dis").value; 
        if (d>0) {
             document.getElementById("disnote").required = true;  
           }else{
             document.getElementById("disnote").required = false;   
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
            $('#myTables tr').each(function (index) {
                $(this).find('td:nth-child(1)').html(index - 1 + 1);
            });
        };
        addSerialNumber();
    </script>
    

    <script src="js/bootstrap.min.js"></script>
   
    <% }%>
</body>
</html>
