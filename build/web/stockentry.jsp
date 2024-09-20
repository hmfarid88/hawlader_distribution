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
    <div class="container-fluid">
        <div class="panel panel-primary" style="background-color: #CCCCCC" >
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
                        <li><a href="accountant.jsp" ><span class="fa fa-home"></span> Home</a></li>
                        <li> <a href="model_colorEntry.jsp" ><span class="fa fa-cog"></span> Settings</a></li>
                        <li><a href="totalStock.jsp"><span class="fa fa-sticky-note"></span> Stock-Details</a> </li>
                        <li><a href="#"><input type="checkbox" id="check" value=""> Multiple Entry</a></li>
                       
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li style=" margin-right: 50px; margin-top: 15px"><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li>
                        <li><a id="pdf" href="#"><span class="fa fa-file-pdf-o"> PDF</span></a></li>
                        <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                    </ul>
                </div>

            </nav>
            <div class="panel-body">

                <div class="container">
                    <div class="row">
                    <div class="col-sm-6">
                            <center>
                                <h2>Mobile-Stock-Entry</h2><hr style="background-color: green">
                                <table class="table" >
                                    <col width="30">
                                    <col width="30">
                                    <col width="40">
                                    <tbody>
                                        <tr>
                                            <td>
                                                <form  method="POST" action="Model_Price_Servlet">
                                                    <select onchange="this.form.submit()"  name="mdl"  class="form-control select2" style="width: 100%"  required="" >
                                                        <option value="">Select Model</option>
                                                        <%
                                                            Connection con = null;
                                                            PreparedStatement ps = null;
                                                            ResultSet rs=null;
                                                            try {
                                                                con = Database.getConnection();
                                                                String query = "select MODEL from model_price ";
                                                                ps = con.prepareStatement(query);
                                                                rs = ps.executeQuery();
                                                                while (rs.next()) {
                                                        %>
                                                        <option  value="<%= rs.getString("MODEL")%>">  <%= rs.getString("MODEL")%>  </option>
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
                                                
                                            </td>
                                            <td>
                                                <form  method="POST" action="Color_showServlet">
                                                    <select onchange="this.form.submit()"   name="color" class="form-control select2" style="width: 100%" required="">
                                                        <option  value="">Select Color</option>
                                                        <%
                                                            try {
                                                                con = Database.getConnection();
                                                                String query = "select COLOR from color_entry ";
                                                                ps = con.prepareStatement(query);
                                                                rs = ps.executeQuery();
                                                                while (rs.next()) {
                                                        %>
                                                        <option  value="<%= rs.getString("COLOR")%>"> <%= rs.getString("COLOR")%></option>

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
                                               
                                            </td>
                                            <td> 
                                                <form method="POST" action="Vendor_ShowServlet">
                                                    <select onchange="this.form.submit()"  name="vendor"  class="form-control select2" style="width: 100%"  required="">
                                                        <option value="">Select Vendor</option>
                                                        <%
                                                            try {
                                                                con = Database.getConnection();
                                                                String query = "select VENDOR_NAME from vendor ";
                                                                ps = con.prepareStatement(query);
                                                                rs = ps.executeQuery();
                                                                while (rs.next()) {
                                                        %>
                                                        <option value="<%= rs.getString("VENDOR_NAME")%>"><%= rs.getString("VENDOR_NAME")%></option>
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
                                                
                                            </td>
                                        </tr>
                                        <tr>

                                            <td>
                                                <form  method="POST" action="Area_Show_Servlet">
                                                    <select onchange="this.form.submit()"  name="area"  class="form-control select2" style="width: 100%"  required="" >
                                                        <option value="">Select Area</option>
                                                        <%
                                                            
                                                            try {
                                                                con = Database.getConnection();
                                                                String query = "select AREA from area ";
                                                                ps = con.prepareStatement(query);
                                                                rs = ps.executeQuery();
                                                                while (rs.next()) {
                                                        %>
                                                        <option  value="<%= rs.getString("AREA")%>">  <%= rs.getString("AREA")%>  </option>
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
                                                
                                            </td>
                                            <td>
                                                <form  method="POST" action="Store_showServlet">
                                                    <select onchange="this.form.submit()"   name="store" class="form-control select2" style="width: 100%" required="">
                                                        <option  value="">Select Store</option>
                                                        <%
                                                            try {
                                                                con = Database.getConnection();
                                                                String query = "select STORE from store ";
                                                                ps = con.prepareStatement(query);
                                                                rs = ps.executeQuery();
                                                                while (rs.next()) {
                                                        %>
                                                        <option  value="<%= rs.getString("STORE")%>"> <%= rs.getString("STORE")%></option>

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
                                               
                                            </td>
                                            <td> 
                                                <form method="POST" action="Boss_ShowServlet">
                                                    <select onchange="this.form.submit()"  name="boss"  class="form-control select2" style="width: 100%"  required="">
                                                        <option value="">Select Boss</option>
                                                        <%
                                                            try {
                                                                con = Database.getConnection();
                                                                String query = "select BOSS from boss ";
                                                                ps = con.prepareStatement(query);
                                                                rs = ps.executeQuery();
                                                                while (rs.next()) {
                                                        %>
                                                        <option value="<%= rs.getString("BOSS")%>"><%= rs.getString("BOSS")%></option>
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
                                                
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>

                                   <form id="single"  method="POST" action="MstockServlet" >
                                   <table class="table" >
                                        <col width="50%">
                                        <col width="50%">
                                        <tbody>
                                            <tr>
                                                <td><label>MODEL  NO :</label></td>
                                                <td> <input type="text" name="model" id="model"  value="${MODEL}"  class="form-control" required="" readonly="" ></td>
                                            </tr>
                                            <tr>
                                                <td><label>PURCHASE'S  PRICE:</label></td>
                                                <td><input type="number" name="pprice" id="pprice"  value="${PURCH}" class="form-control" required="" readonly=""></td>

                                            </tr>
                                            <tr>
                                                <td><label>SALE PRICE:</label></td>   
                                                <td><input type="number" name="sprice" id="sprice"  value="${SALE}" class="form-control" required="" readonly=""></td>

                                            </tr>

                                            <tr>
                                                <td><label>COLOR  :</label></td>
                                                <td> <input type="text" name="color" id="clor" value="${COLOR}" class="form-control" required="" readonly=""></td>

                                            </tr>
                                            <tr>
                                                <td><label>VENDOR NAME  :</label></td>
                                                <td> <input type="text" name="vname" id="vname" value="${VENDOR}" class="form-control" required="" readonly=""></td>

                                            </tr>
                                            <tr>
                                                <td><label>AREA NAME  :</label></td>
                                                <td> <input type="text" name="area" id="vname" value="${AREA}" class="form-control" required="" readonly=""></td>

                                            </tr>
                                            <tr>
                                                <td><label>STORE NAME  :</label></td>
                                                <td> <input type="text" name="store" id="vname" value="${STORE}" class="form-control" required="" readonly=""></td>

                                            </tr>
                                            <tr>
                                                <td><label>BOSS NAME  :</label></td>
                                                <td> <input type="text" name="boss" id="vname" value="${BOSS}" class="form-control" required="" readonly=""></td>

                                            </tr>

                                            <tr>
                                                <td><label>IMEI :</label> </td>
                                                <td>
                                                    <input type="text"  maxlength="15" minlength="15" pattern="[0-9]{15}" name="imei" id="imei" value="" autofocus="" autocomplete="off" class="form-control imei" required="" >
                                                </td>
                                               
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td><input type="submit"  class="btn btn-sm btn-primary" id="submit"  value="Entry">
                                                    <input type="reset" class="btn btn-sm btn-primary"  value="Reset"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                             </form>
                           <form id="multiple"  method="POST"  action="MultiMstockServlet" >
                                   <table class="table" >
                                        <col width="50%">
                                        <col width="50%">
                                        <tbody>
                                            <tr>
                                                <td><label>MODEL  NO :</label></td>
                                                <td> <input type="text" name="model" id="model"  value="${MODEL}"  class="form-control" required="" readonly="" ></td>
                                            </tr>
                                            <tr>
                                                <td><label>PURCHASE'S  PRICE:</label></td>
                                                <td><input type="number" name="pprice" id="pprice"  value="${PURCH}" class="form-control" required="" readonly=""></td>

                                            </tr>
                                            <tr>
                                                <td><label>SALE PRICE:</label></td>   
                                                <td><input type="number" name="sprice" id="sprice"  value="${SALE}" class="form-control" required="" readonly=""></td>

                                            </tr>

                                            <tr>
                                                <td><label>COLOR  :</label></td>
                                                <td> <input type="text" name="color" id="clor" value="${COLOR}" class="form-control" required="" readonly=""></td>

                                            </tr>
                                            <tr>
                                                <td><label>VENDOR NAME  :</label></td>
                                                <td> <input type="text" name="vname" id="vname" value="${VENDOR}" class="form-control" required="" readonly=""></td>

                                            </tr>
                                            <tr>
                                                <td><label>AREA NAME  :</label></td>
                                                <td> <input type="text" name="area" id="vname" value="${AREA}" class="form-control" required="" readonly=""></td>

                                            </tr>
                                            <tr>
                                                <td><label>STORE NAME  :</label></td>
                                                <td> <input type="text" name="store" id="vname" value="${STORE}" class="form-control" required="" readonly=""></td>

                                            </tr>
                                            <tr>
                                                <td><label>BOSS NAME  :</label></td>
                                                <td> <input type="text" name="boss" id="vname" value="${BOSS}" class="form-control" required="" readonly=""></td>

                                            </tr>

                                            <tr>
                                                <td><label>IMEI :</label> </td>
                                                <td>
                                                 
                                                    <input type="text"  maxlength="15" minlength="15" pattern="[0-9]{15}" name="imei1" id="imei" value="" autofocus="" autocomplete="off" class="form-control imei" required="" >
                                                    <input type="text"  maxlength="15" minlength="15" pattern="[0-9]{15}" name="imei2" id="imei" value="" autofocus="" autocomplete="off" class="form-control imei" required="" >
                                                    <input type="text"  maxlength="15" minlength="15" pattern="[0-9]{15}" name="imei3" id="imei" value="" autofocus="" autocomplete="off" class="form-control imei" required="" >
                                                    <input type="text"  maxlength="15" minlength="15" pattern="[0-9]{15}" name="imei4" id="imei" value="" autofocus="" autocomplete="off" class="form-control imei" required="" >
                                                    <input type="text"  maxlength="15" minlength="15" pattern="[0-9]{15}" name="imei5" id="imei" value="" autofocus="" autocomplete="off" class="form-control imei" required="" >
                                                    <input type="text"  maxlength="15" minlength="15" pattern="[0-9]{15}" name="imei6" id="imei" value="" autofocus="" autocomplete="off" class="form-control imei" required="" >
                                                    <input type="text"  maxlength="15" minlength="15" pattern="[0-9]{15}" name="imei7" id="imei" value="" autofocus="" autocomplete="off" class="form-control imei" required="" >
                                                    <input type="text"  maxlength="15" minlength="15" pattern="[0-9]{15}" name="imei8" id="imei" value="" autofocus="" autocomplete="off" class="form-control imei" required="" >
                                                    <input type="text"  maxlength="15" minlength="15" pattern="[0-9]{15}" name="imei9" id="imei" value="" autofocus="" autocomplete="off" class="form-control imei" required="" >
                                                    <input type="text"  maxlength="15" minlength="15" pattern="[0-9]{15}" name="imei10" id="imei" value="" autofocus="" autocomplete="off" class="form-control imei" required="" >
                                                   
                                                </td>
                                               
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td><input type="submit"  class="btn btn-sm btn-primary" id="submit2"  value="Entry">
                                                    <input type="reset" class="btn btn-sm btn-primary"  value="Reset"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                             </form>
                      
                         <script>
                            $(document).ready(function () {
                                $("#single").submit(function () {
                                    if (this.beenSubmitted)
                                        return false;
                                    else
                                        this.beenSubmitted = true;
                                });
                                $("#multiple").submit(function () {
                                    if (this.beenSubmitted)
                                        return false;
                                    else
                                        this.beenSubmitted = true;
                                });
                           
                            $(function() {
                            $('.imei').on('keypress', function(e) {
                            if (e.which === 32)
                             return false;
                                 });
                             });
        });
                        </script>
                        <script>
                     $(function(){
    var test = localStorage.input === 'true'? true: false;
    $("#check").prop('checked', test || false);
   });
$("#check").on('change', function() {
    localStorage.input = $(this).is(':checked');
    console.log($(this).is(':checked'));
});
                        </script>
                                                     
                                <script>
$(document).ready(function(){
  if ($("#check").is(":checked")) {
                $("#multiple").show();
                $("#single").hide();
            } else {
                $("#single").show();
                $("#multiple").hide();
            }
        $("#check").click(function () {
        if ($("#check").is(":checked")) {
                $("#multiple").show();
                $("#single").hide();
            } else {
                $("#single").show();
                $("#multiple").hide();
            }
});
});
                                </script>
                            </center>
                        </div>
                        <div id="div_print" class="col-sm-6">
                            <center>
                            <h3 class="text-primary">Stock Summary</h3>
                            <h4>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h4>
                            </center>
                            <hr>
                            <div class="row">
                                <center>
                                    <div class="col-sm-2"></div>
                                    <div class="col-sm-4">
                                        <%
                                            try {
                                                con = Database.getConnection();                                              
                                                String query = "select count(IMEI) as qnt, sum(SELL_PRICE) as totlprice from stock ";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                                    request.setAttribute("qty", rs.getInt("qnt"));
                                                    request.setAttribute("tlprice", rs.getInt("totlprice"));
                                                }
                                            } catch (Exception ex) {
                                            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                        %>
                                        <label><b>Stock Quantity : </b></label><input type="text" size="5px" class="text-center form-control" value="${qty} PS " readonly="" style="background-color: #030303; color: #ffffff">  
                                    </div>
                                    <div class="col-sm-4">
                                        <label> <b>Stock Amount :  </b></label><input type="text" size="15px" class="text-center form-control" value="${tlprice} TK "  readonly="" style="background-color: #030303; color: #ffffff">
                                    </div>
                                    <div class="col-sm-2"></div>
                                </center>
                            </div><br>
                            <div class="row">

                                <center>
                              <!--<div style="background-image: url('img/levelupbg.png')!important; background-repeat: no-repeat !important; background-size: 300px 150px !important; background-position: 50% 50% !important;">-->
                                  <table border="2" id="mobiletable" class=" table-condensed table-responsive" width="95%" style="background-color: #ffffff" >
                                        <thead>
                                            <tr style="background-color:#030303; color: #ffffff">
                                                <th style="text-align: center">Model</th>
                                                <th style="text-align: center">Color</th>
                                                <th style="text-align: center">Qty</th>
                                                <th style="text-align: center">Sale Price</th>
                                                <th style="text-align: center">Cost Price</th>
                                                <th style="text-align: center">Date</th>
                                            </tr>
                                        </thead> 
                                        <tbody id="myTable">
                                        <%
                                            try {
                                                con = Database.getConnection();                           
                                                String query = "select MODEL, COLOR, sum(QTY) as ime, PURCHASE_PRICE, SELL_PRICE, DATE from stock  group by MODEL, COLOR, PURCHASE_PRICE";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                        %>
                                        <tr>

                                            <td style="text-align: center"><%= rs.getString("MODEL")%></td>
                                            <td style="text-align: center"><%= rs.getString("COLOR")%></td>
                                            <th style="text-align: center"><%= rs.getString("ime")%></th>
                                            <th style="text-align: center"><%= rs.getFloat("SELL_PRICE")%></th>
                                            <th style="text-align: center"><%= rs.getFloat("PURCHASE_PRICE")%></th>
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
                                             <tr style="background-color: #030303; color: #ffffff">
                                                 <th style="text-align: center"></th>
                                                 <th style="text-align: center">TOTAL</th>
                                                 <td style="text-align: center"></td>
                                                 <td style="text-align: center"></td>
                                                 <td style="text-align: center"></td> 
                                                 <th style="text-align: center"></th>
                                             </tr>
                                            </tfoot>
                                    </table>
                                    </div>
                                                                      
                                </center>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file = "footerpage.jsp" %> 
    </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
        <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
        <script src="js/bootstrap.min.js"></script>

   <script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
     $('#mobiletable thead th').each(function(i) {
                calculateColumn(i);
            });
            function calculateColumn(index) {
            var total = 0;
            $('#mobiletable tr').each(function() {
                var value = parseInt($('th:visible', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#mobiletable tfoot td').eq(index).text(total);
        } 
  });
});
</script>
<script>
    $('.select2').select2();
    </script>
<script>
        $(document).ready(function() {
            $('#mobiletable thead th').each(function(i) {
                calculateColumn(i);
            });
        });

        function calculateColumn(index) {
            var total = 0;
            $('#mobiletable tr').each(function() {
                var value = parseInt($('th', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('#mobiletable tfoot td').eq(index).text(total);
        }
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
 
     pdf.save("StockSummary.pdf");
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
    <script>
                                    history.pushState(null, document.title, location.href);
                                    window.addEventListener('popstate', function (event)
                                    {
                                        history.pushState(null, document.title, location.href);
                                    });
    </script>

    <% }%>
</body>
</html>
