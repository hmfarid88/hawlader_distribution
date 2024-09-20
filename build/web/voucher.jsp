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
                    <li> <a data-toggle="modal" data-target="#retailerselect" href="#"><span class="fa fa-window-restore"></span> More Distribution</a></li>
                    
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
                            <p style=" font-size: 20px"><u><strong>Invoice/Bill</strong></u></p>
                            <table style=" margin-left: 5px"  width="100%" class="table-responsive">

                                <tr style=" border-bottom-style: hidden">
                                    <td style="border-right-style: hidden; font-size: 12px" width="50%">
                                        <%
                                            
                                            try {
                                                con = Database.getConnection();
                                                String query = "select distinct SR_NAME, DATE  from paymentinfo where CUSTOMER_ID=(select MAX(CUSTOMER_ID) from customerinfo )";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                                    request.setAttribute("srname", rs.getString("SR_NAME"));
                                                    request.setAttribute("saledate", rs.getString("DATE"));
                                                }
                                            } catch (Exception ex) {
                                            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                        %>
                                      <label>DATE : ${saledate}</label>   
                                    </td>

                                    <td style="font-size: 12px;">
                                        <%
                                            try {
                                                con = Database.getConnection();
                                                String query = "SELECT MAX(CUSTOMER_ID) AS ID FROM customerinfo";
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
                                        <label style="margin-left: 120px">INVOICE NO : NOV2018${iid}</label>

                                    </td>
                                </tr>
                                <tr style=" border-bottom-style: hidden">
                                    <td style="border-right-style: hidden;font-size: 12px">

                                        <%                                            
                                            try {
                                                con = Database.getConnection();
                                                String query = "select C_NAME from customerinfo where CUSTOMER_ID=(select MAX(CUSTOMER_ID) from customerinfo)";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                                
                                        %>
                                        <p class="text-uppercase"><strong> RETAILER NAME :  <%= rs.getString("C_NAME")%></strong></p>

                                    </td>
                                    <td><label class="text-uppercase" style="font-size: 12px; margin-left: 120px"> SR NAME : ${srname}</label></td>
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
                            </table>
                           
                            <table border="1" width="100%" class="myTables"  cellspace="1px" >
                                <thead>
                                    <tr style="font-size: 13px">
                                <th style="border-left-style: hidden"><center>SN</center></th>
                                <th><center>Description</center></th>
                                <th><center>Qty</center></th>
                                <th><center>Unit</center></th>
                                <th style="border-right-style: hidden"><center>Total</center></th>
                                </tr>
                                </thead>
                                <tbody>

                                    <%
                                        try {
                                            con = Database.getConnection();
                                            String query = "select  PRODUCT_ID, MODEL, COLOR, PRICE from mobilesell where  CUSTOMER_ID=(select MAX(CUSTOMER_ID) from customerinfo)";
                                            ps = con.prepareStatement(query);
                                            rs = ps.executeQuery();
                                            while (rs.next()) {
                                                
                                    %>

                                    <tr class="text-uppercase"  style="border-bottom-color: #CCC; font-size: 12px">

                                        <td style="text-align: center; border-left-style: hidden ">  </td>

                                        <td style="text-align: center"> <%= rs.getString("MODEL")%>(<%= rs.getString("COLOR")%>), IMEI <%= rs.getString("PRODUCT_ID")%> </td>

                                        <td><center>1</center></td>
                                <td><center><%= rs.getFloat("PRICE")%></center></td> 
                                <td style="border-right-style: hidden"><center><%= rs.getFloat("PRICE")%></center></td> 


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
                            
                                <table style="margin-left: 468px; border-right-style: hidden; border-top-style: hidden; font-size: 14px; border-bottom-color: #CCC;" border="1" width="33%">
                                    
                                <%
                                    try {
                                        con = Database.getConnection();
                                        String query = "select TOTAL, DISCOUNT, VAT, GRAND_TOTAL from paymentinfo where  CUSTOMER_ID=(select MAX(CUSTOMER_ID) from customerinfo)";
                                        ps = con.prepareStatement(query);
                                        rs = ps.executeQuery();
                                        while (rs.next()) {
                                        request.setAttribute("ttotal",rs.getFloat("TOTAL") );
                                        request.setAttribute("dis",rs.getFloat("DISCOUNT") );
                                        request.setAttribute("vvat",rs.getFloat("VAT") );
                                        request.setAttribute("gtotal",rs.getFloat("GRAND_TOTAL") );
                                        
                                     }
                                    } catch (Exception ex) {
                                    }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                %>

                             
                                <tr> <th>TOTAL :</th><th style="width: 74px"> ${ttotal}</th></tr>
                                                                             
                                            <tr> <th>DISCOUNT : <table>
                                    
                                                        <tr>
                                                            <%
                                        try {
                                            con = Database.getConnection();
                                            String query = "select MODEL, count(PRODUCT_ID) from mobilesell where  CUSTOMER_ID=(select MAX(CUSTOMER_ID) from customerinfo) and DISCOUNT>0 group by MODEL";
                                            ps = con.prepareStatement(query);
                                            rs = ps.executeQuery();
                                            while (rs.next()) {
                                                %>
                                                <td style="font-size: 12px">  <%= rs.getString(1) %>, <%= rs.getInt(2) %> ps</td>
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
                                                            <%
                                        try {
                                            con = Database.getConnection();
                                            String query = "select NOTE from additionaldis where  CUSTOMER_ID=(select MAX(CUSTOMER_ID) from customerinfo)";
                                            ps = con.prepareStatement(query);
                                            rs = ps.executeQuery();
                                            while (rs.next()) {
                                                %>
                                                <td style="font-size: 12px">  <%= rs.getString(1) %> </td>
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
                                        </table>
                                  
                                    </th><th> ${dis}</th></tr>
                                                                                                     
                                       <%
                                    try {
                                        con = Database.getConnection();
                                        String query = "select VAT_RATE from vat ";
                                        ps = con.prepareStatement(query);
                                        rs = ps.executeQuery();
                                        while (rs.next()) {
                                %>
                                <tr>    <th> VAT  (<%= rs.getInt("VAT_RATE")%>%) :</th><th> ${vvat}</th></tr>


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
                           ResultSet rs1=null;
                           ResultSet rs2=null;
                           ResultSet rs3=null;
                           ResultSet rs4=null;
                               try {
                                        con = Database.getConnection();
                                        String query = "select C_NAME from customerinfo where CUSTOMER_ID=(select MAX(CUSTOMER_ID) from customerinfo)";
                                        ps = con.prepareStatement(query);
                                        rs = ps.executeQuery();
                                        rs.next();
                                        String retailer=rs.getString(1);
                                        String totalpricevalu = "select sum(PRICE), sum(DISCOUNT) from mobilesell where RETAILER=?";
                                        ps = con.prepareStatement(totalpricevalu);
                                        ps.setString(1, retailer);
                                        rs1 = ps.executeQuery();
                                        rs1.next();
                                        
                                        String payment="select sum(AMOUNT) as totalpay from customer_pay where RETAILER=?";
                                        ps = con.prepareStatement(payment);
                                        ps.setString(1, retailer);
                                        rs2 = ps.executeQuery();
                                        rs2.next();
                                        String grtotal = "select GRAND_TOTAL from paymentinfo where  CUSTOMER_ID=(select MAX(CUSTOMER_ID) from customerinfo)";
                                        ps = con.prepareStatement(grtotal);
                                        rs3=ps.executeQuery();
                                        rs3.next();
                                        String additional="select sum(AMOUNT) from additionaldis where RETAILER=? ";
                                        ps = con.prepareStatement(additional);
                                        ps.setString(1, retailer);
                                        rs4 = ps.executeQuery(); 
                                        rs4.next();
                                        Long additionaldis=rs4.getLong(1);
                                        Long totalpay=rs2.getLong("totalpay");
                                        Long totalvalu=rs1.getLong(1);
                                        Long totaldis=rs1.getLong(2);
                                        Long totalsub=totalpay+totaldis+additionaldis;
                                        Long bl=totalvalu-totalsub;
                                        Long grandtotal=rs3.getLong(1);
                                        Long prevbl=bl-grandtotal;
                                        request.setAttribute("balance", bl);
                                        
                                        String up="update paymentinfo set PREV_BL=? where CUSTOMER_ID=(select MAX(CUSTOMER_ID) from customerinfo)";
                                        ps = con.prepareStatement(up);
                                        ps.setDouble(1, prevbl);
                                        ps.executeUpdate();
                           %>
                           <%
                           } catch (Exception ex) {
                                    }finally {
try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }   
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                           %>
                               
                           <tr><th>GRAND TOTAL :</th> <th>${gtotal}</th></tr>
                           <tr>  <th>PREVIOUS BALANCE :</th><th> ${balance-gtotal}</th></tr>
                           <tr>   <th>NIT PAYABLE :</th><th> ${balance}</th>     </tr>
                           <tr>   <th>PAYMENT :</th><th> </th>     </tr>
                               
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
 <div id="retailerselect" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Retailer-Info</h4>
                </div>
                <div class="modal-body">
                                           
                        <div class="container-fluid">
                            <div class="col-sm-6">
                              <form method="POST" action="RetailerSelectServler">
                                
                                  <select style="width: 100%"  class="form-control select2" onchange="this.form.submit()"  name="retailer" required="" >
                                    <option value="">Select-Retailer</option>
                                    <%
                                        AccountPojo ap = new AccountPojo();
                                        List<Accountant> list003 = ap.retailerView();
                                        for (Accountant ac : list003) {
                                    %>
                                    <option value="<%= ac.getRetailer()%>"> <%= ac.getRetailer()%></option>
                                    <%}%>

                                  </select><br><br>
                                <input type="submit" class="btn btn-info btn-sm" value="GO">
                            </form>
                            </div>
                                                               
                        </div>
               
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
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
    $('.select2').select2();
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
