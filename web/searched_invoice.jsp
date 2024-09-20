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
                    <ul class="nav navbar-nav navbar-right">
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>
                </div>

            </nav>


            <div class="row">

                <div class="col-sm-3"></div>
                <div class="col-sm-6">

                    <div id="div_print"><br>
                        <center>
                            <div class="panel" style="width: 700px; height: 100%; border-color: black" >
                                <table>
                                    <tr>
                                        <td style="width: 17%"><img src="img/helogo.png" class="img-responsive" style="height: 100px; width: 100px;"></td>
                                        <td style="text-align: center">


                                            <%
                                                String invono = request.getParameter("invono");
                                                request.setAttribute("invono", invono);
                                                Connection con = null;
                                                PreparedStatement ps = null;
                                                ResultSet rs1=null;
                                                ResultSet rs=null;
                                                try {
                                                    con = Database.getConnection();
                                                    String query = "select distinct COMPANY_NAME, ADDRESS, PHONE_NUMBER, EMAIL from companyinfo ";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    while (rs.next()) {
                                            %>
                                            <p style=" font-size: 30px;margin-top: 5px; color: #8c8c8c;"><%= rs.getString("COMPANY_NAME")%></p>
                                            <p style="font-size: 15px"><%= rs.getString("ADDRESS")%><br>
                                                <span class="glyphicon glyphicon-phone-alt"></span> <%= rs.getString("PHONE_NUMBER")%><br>
                                                E-mail: <%= rs.getString("EMAIL")%> 

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
                                                <%
                                                try {
                                                    con = Database.getConnection();
                                                    String cidquery="select CUSTOMER_ID, SR_NAME, DATE from paymentinfo where INVOICE_NO=?";
                                                    ps = con.prepareStatement(cidquery);
                                                    ps.setString(1, invono);
                                                    rs1 = ps.executeQuery();
                                                    rs1.next();
                                                    request.setAttribute("srname", rs1.getString("SR_NAME"));
                                                    request.setAttribute("date", rs1.getString("DATE"));
                                                    int cid=rs1.getInt(1);
                                                    String query = "select C_NAME from customerinfo where CUSTOMER_ID='" + cid + "'";
                                                    ps = con.prepareStatement(query);
                                                    rs = ps.executeQuery();
                                                    rs.next();
                                                    request.setAttribute("cname", rs.getString("C_NAME"));
                                        } catch (Exception ex) {
                                        }finally {
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }   
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                                 %>
                                    <tr style=" border-bottom-style: hidden; font-size: 12px">
                                        <td style="border-right-style: hidden" width="50%"><label>DATE: ${date} </label> </td>
                                         
                                        <td><label style="margin-left: 120px">INVOICE NO : ${invono}</label></td>

                                    </tr>
                                    <tr style=" border-bottom-style: hidden; font-size: 12px">
                                        <td style="border-right-style: hidden">
                                          
                                           
                                         <p class="text-uppercase"><strong>RETAILER NAME:  ${cname}</strong></p>

                                        </td>
                                         <td><label class="text-uppercase" style="font-size: 12px; margin-left: 120px"> SR NAME : ${srname}</label></td>
                                    </tr>
                                    <tr style="font-size: 12px">
                                        <td style="border-right-style: hidden">
                                        
                                        </td>
                                        <td></td>
                                 
                                       </tr>
                                </table>
                               
                                <table  border="1" width="100%" class="myTables" cellspace="1px" >
                                    <thead>
                                    <tr style="font-size: 12px">
                                    <th style="border-left-style: hidden"><center>SN</center></th>
                                    <th><center>Description</center></th>
                                    <th><center>Qty</center></th>
                                    <th><center>Rate</center></th>
                                    <th style="border-right-style: hidden"><center>Total</center></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                 
                                        <%
                                            try {
                                                con = Database.getConnection();
                                                String query = "select  PRODUCT_ID, MODEL, COLOR, PRICE from mobilesell where  INVOICE_NO='" + invono + "'";
                                                ps = con.prepareStatement(query);
                                                rs = ps.executeQuery();
                                                while (rs.next()) {
                                        %>
                                   <tr class="text-uppercase" style="border-bottom-color: #CCC; font-size: 12px">
                                            <td style="text-align: center; border-left-style: hidden">  </td>

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
                                <table style="margin-left: 460px; border-right-style: hidden; border-top-style: hidden; font-size: 14px; border-bottom-color: #CCC;" border="1" width="34%">
                                    
                                    <%
                                        try {
                                            con = Database.getConnection();
                                            String query = "select TOTAL, DISCOUNT, VAT, GRAND_TOTAL, PREV_BL from paymentinfo where  INVOICE_NO='" + invono + "'";
                                            ps = con.prepareStatement(query);
                                            rs = ps.executeQuery();
                                            while (rs.next()) {
                                        request.setAttribute("tootal",rs.getFloat("TOTAL") );
                                        request.setAttribute("dis",rs.getFloat("DISCOUNT") );
                                        request.setAttribute("vaat",rs.getFloat("VAT") );
                                        request.setAttribute("gtootal",rs.getFloat("GRAND_TOTAL") );
                                        request.setAttribute("prebl",rs.getFloat("PREV_BL") );
                                                                              
                                      }
                                        } catch (Exception ex) {                       
                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                    %>

                                    <tr> <th>  TOTAL : </th> <th style="width: 70px">${tootal}</th></tr>
                                    <tr><th>DISCOUNT :
                                        <table>
                                    
                                                        <tr>
                                                            <%
                                        try {
                                            con = Database.getConnection();
                                            String query = "select MODEL, count(PRODUCT_ID) from mobilesell where  INVOICE_NO='" + invono + "' and DISCOUNT>0 group by MODEL";
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
                                            String query = "select NOTE from additionaldis where  INVOICENO='" + invono + "'";
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
                                        </th> <th>${dis}</th></tr>
                                    <tr><th>VAT : </th><th>${vaat}</th></tr> 
                                    <tr><th>GRAND TOTAL :</th><th> ${gtootal}</th></tr>
                                    <tr><th>PREVIOUS BALANCE :</th><th> ${prebl}</th></tr>
                                    <tr><th>NIT PAYABLE : </th><th>${prebl+gtootal}</th></tr>
                                    <tr><th>PAYMENT : </th><th></th></tr>
                                </table>
                               <table border="1" width="100%">
                                <tr style="border-style: hidden"><td style="font-size: 15px"><label style="margin-left: 10px">Signature: . . . . . . . . . . . .</label></td></tr>
                               </table>
                                  
                            </div>
                        </center>
                    </div>
                </div>
                <div class="col-sm-3"></div>                  
            </div>                
            
        </div>
      
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
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
