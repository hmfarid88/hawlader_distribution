
<%@page import="Model.AdminModel"%>
<%@page import="Pojo.AdminPojo"%>
<%@page import="Model.Accountant"%>
<%@page import="java.util.List"%>
<%@page import="Pojo.AccountPojo"%>
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
                           <li><a href="retailer_payment.jsp" > Retailer Payment</a></li> 
                        </ul>
                    </div>
                </nav>
                
                  <div class="panel-body">
                    <h3 class="text-center">Product Distribution</h3>
                    <div class="row">
                        <div style="margin-right: 10%" class=" pull-right">  
                            <label>Invoice No :</label>
                            <%
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs=null;
                                try {
                                    con = Database.getConnection();
                                    String query = "SELECT MAX(CUSTOMER_ID) AS ID FROM customerinfo GROUP BY CUSTOMER_ID";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                                        request.setAttribute("iid", rs.getInt("ID"));
                                    }
                                } catch (Exception ex) {

                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

                            %>
                            <input type="text" style="color:#030303"  value="NOV2018${iid+1}" readonly="" >
                        </div>
                        <div style="margin-left: 10%" class=" pull-left">
                            <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                        </div>
                    </div><br>
                    <div class="row">
                        <div class="col-sm-6">
                            <h3>Retailer Name : ${RETAIL}</h3>
                        </div>
                        <div class="col-sm-6">
                            <h3>Limit : ${LAMOUNT}</h3>
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
                                    <form id="saleform" method="POST" action="SellEntryServlet" class="form-inline" >
                                        <input type="hidden" name="cid" value="${iid+1}">
                                        <label>Mobile IMEI</label><br>
                                        <input type="hidden" name="limit" value="${LAMOUNT}">
                                        <input type="text" style="max-width: 80%" maxlength="15" minlength="15" pattern="[0-9]{15}"  class="form-control input-sm" name="imei" id="imei" value="" required="" autofocus="" >
                                        <input type="submit" id="submit"  value="OK" class="btn btn-primary btn-sm">
                                       
                                    </form>
                                </div>
                                                                                   
                                <br>
                                <div class="col-sm-6">
                                    <form method="POST" action="SellEntryServlet">
                                       <input type="hidden" name="cid" value="${iid+1}">
                                       <input type="hidden" name="limit" value="${LAMOUNT}">
                                        <label>Add Manually</label><br>
                                        <select style=" max-width: 60%" class="form-control select2"  onchange="this.form.submit()"  name="imei" value=""  required="">
                                            <option>Select Mobile IMEI</option>
                                            <%                                                
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
                                            <th class="text-center">Rate</th>
                                            <th class="text-center">Discount</th>
                                            <th class="text-center">Sub Total</th>
                                            <th class="text-center">Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <%

                                            try {
                                                con = Database.getConnection();
                                                String query = "select  MODEL, PRODUCT_ID, COLOR, PRICE, DISCOUNT, DIS_NOTE from mobilesell where CUSTOMER_ID=(select max(CUSTOMER_ID) from customerinfo)+1 ";
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
                                    <td>
                                    <center>1</center>
                                    </td>
                                    <td Style="width:70px ">
                                    <center><%= rs.getFloat("PRICE") %></center>
                                    </td>
                                    <td style="width: 70px">
                                    <center>
                                        <form  method="POST" action="MdiscountServlet" class=" form-inline">
                                            <input type="hidden" name="imei" value="<%= rs.getString("PRODUCT_ID")%>">
                                            <input type="number" Style="width:70px;text-align: center; color: #030303" name="discount" value="<%= rs.getFloat("DISCOUNT") %>" required="">
                                            <input type="text" name="note" title="Discount Note" Style="width:70px;text-align: center; color: #030303" value="<%= rs.getString("DIS_NOTE") %>" placeholder="Note">
                                            <input type="submit" class="btn btn-success btn-xs" value="OK">
                                        </form>

                                    </center>
                                    </td>
                                    <td>
                                    <center> <%= rs.getFloat("PRICE")-rs.getFloat("DISCOUNT") %></center>
                                    </td>
                                    <td><center>
                                        <form method="POST" action="MsalerolbackServlet">
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
                                </table> 

                            </div>  
                            <br>

                        </div>
                        <div class="col-sm-1"></div>
                    </div>
                    <form id="saleform" method="POST" action="PaymentServlet" name="myForm" >
                       <div class="row">  
                         <div class="col-sm-2">
                                <input type="hidden" name="customername" value="${RETAIL}">
                            </div>
                            <div class="col-sm-5">

                                <fieldset class="scheduler-border">
                                    <legend style=" color: #ffffff" class="scheduler-border">Other-Information</legend>
                                    <div class="row">
                                        <div class="col-sm-2"> </div>
                                            <div class="col-sm-8"> 
                                               
                                            </div>
                                    <div class="col-sm-2"> </div>
                                    </div><br>
                                                <div class="row">
                                        <div class="col-sm-2"> </div>
                                            <div class="col-sm-8"> 
                                                <label><b>Select SR :</b></label><br>
                                                <select  class="form-control select2" name="srname" required="" >
                                    <option value="">Select-SR</option>
                                    <%
                                         try {
                                                con = Database.getConnection();
                                                String query = "select  E_NAME from employee_info where DESIGANATION='Sales Representative' ";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString("E_NAME")%>"> <%= rs.getString("E_NAME")%></option>
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
                                            </div>
                                    <div class="col-sm-2"> </div>
                                    </div>
                                   
                                </fieldset>

                            </div>

                            <div class="col-sm-3">
                                
                                <div class="row">
                                    <table border="1" width="95%" class="table-responsive" >
                                        <tr>
                                            <td width="50%"><label>Total-Product:</label></td>
                                            <%
                                                try {
                                                    con = Database.getConnection();
                                                    String query = "SELECT COUNT(PRODUCT_ID) AS MQNT FROM mobilesell where CUSTOMER_ID=(select max(CUSTOMER_ID) from customerinfo)+1";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                                        request.setAttribute("mqnt", rs.getInt("MQNT"));
                                                    }
                                                } catch (Exception ex) {

                                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                
                                            %>
                                            <td><input type="text"  class="form-control input-sm" name="qunt" value="${mqnt}" readonly="" style=" background-color: #000; color: #fff"  ></td>
                                        </tr>
                                        <tr>
                                            <td><label>Total-Price:</label></td>
                                            <%
                                                try {
                                                    con = Database.getConnection();
                                                    String query = "SELECT SUM(PRICE) AS MOBTOTAL, sum(DISCOUNT) as dis FROM mobilesell where  CUSTOMER_ID=(select max(CUSTOMER_ID) from customerinfo)+1";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                                        request.setAttribute("mototal", rs.getFloat("MOBTOTAL"));
                                                        request.setAttribute("modis", rs.getFloat("dis"));
                                                    }
                                                } catch (Exception ex) {

                                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                
                                            %>
                                            <td><input type="text" class="form-control input-sm" name="total" style=" background-color: #000; color: #fff"   value="${mototal}" readonly="" ></td>

                                        </tr>
                                        <tr>
                                            <td><label>Discount:</label></td>
                                            <td><input type="text"  class="form-control input-sm"  name="totaldis" style=" background-color: #000; color: #fff"  value="${modis}" readonly=""  ></td>
                                        </tr>
                                        <tr>
                                            <%
                                                try {
                                                    con = Database.getConnection();
                                                    String query = "select VAT_RATE from vat ";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                                        request.setAttribute("vrate", rs.getInt("VAT_RATE"));
                                                    }
                                                } catch (Exception ex) {

                                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                            %>
                                            <td><label> VAT (${vrate} %) :</label> </td>

                                            <td><input type="text"  class="form-control input-sm" style=" background-color: #000; color: #fff"   name="vat" value="${(mototal*vrate)/100}" readonly="" ></td>
                                        </tr>
                                        <tr>
                                            <td><label>Grand Total :</label></td>
                                            <td><input type="text"  class="form-control input-sm" style=" background-color: #000; color: #fff"  name="grandtotal" value="${(mototal-modis)+((mototal*vrate)/100)}" readonly="" ></td>
                                        </tr>
                                        <tr>
                                            <td><label>Additional Discount :</label></td>
                                            <td><input type="text" id="dis"  class="form-control input-sm" name="addis" value="0" style=" background-color: #000; color: #fff" ></td>
                                        </tr>
                                        <tr>
                                            <td><label>Discount Note :</label></td>
                                            <td><input type="text" id="disnote"  class="form-control input-sm" name="addisnote" style=" background-color: #000; color: #fff" ></td>
                                        </tr>
                                    </table>
                                </div>

                            </div>
                                        <div class="col-sm-2">

                                        </div>
                                        </div>
                            <%
                                try {
                                    con = Database.getConnection();
                                    String query = "SELECT MAX(CUSTOMER_ID) AS ID FROM customerinfo";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                                        request.setAttribute("iiedd", rs.getInt("ID"));
                                    }
                                } catch (Exception ex) {

                                }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                            %>
                            <input type="hidden" name="customerid" value="${iiedd+1}" >
                            <div class="row">
                                <br><br>
                                <div class="col-sm-4"></div>
                                <div class="col-sm-4">
                                    <input type="submit" id="okvo" class="btn btn-success" value="OK" >
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
