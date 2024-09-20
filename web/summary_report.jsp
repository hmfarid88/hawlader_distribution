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
        <link rel="icon" type="image/png" href="img/favicon.ico">
    </head>
    <body style=" background-color: #030303; color: #ffffff">

        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
               <div id="main" class="container-fluid">
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
                               
                                <li style="margin-left: 20px"><a href="accountant.jsp"><span class="fa fa-home"></span> Home</a></li>
                                
                           </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li><a id="pdf" href="#"><span class="fa fa-file-pdf-o"> PDF</span></a></li>
                                <li> <a href="#" name="b_print"  onClick="printdiv('div_print')" ><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul>
                        </div>
                    </nav>
                    <%
                        String date = request.getParameter("date");
                        Connection con = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;

                    %>
                                <div class="row">
                            <div id="div_print" style=" background-color: #030303; color: #ffffff">
                                <center>
                                    <h3>Report Summary </h3>
                                    <h4>Level-Up(Vivo)</h4>
                                    <h4>${param.date}</h4>
                                    <table border="2" class=" table-condensed table-responsive" width="40%">
                                   
                                     <%
                                            
                                         try {
                                                        con = Database.getConnection();
                                                        String query = "select sum(QTY), sum(PURCHASE_PRICE) from stock where DATE<='"+ date +"'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("stockqty", rs.getInt(1));
                                                        request.setAttribute("stockvalue", rs.getLong(2));
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
                                                        String query = "select count(*) as qty, sum(COST_PRICE) from mobilesell where STOCK_DATE<='"+ date +"' and SELL_DATE>='"+ date +"'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("saleqty", rs.getInt("qty"));
                                                        request.setAttribute("salevalue", rs.getLong(2));
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
                                                        String query = "select sum(PRICE) from mobilesell where SELL_DATE<='"+ date +"'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                       
                                                        request.setAttribute("totalsalevalue", rs.getLong(1));
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
                                                        String query = "select count(*) as qty, sum(PRICE) from mobilesell where SELL_DATE='"+ date +"'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("distqty", rs.getInt(1));
                                                        request.setAttribute("distvalue", rs.getFloat(2));
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
                                                        String query = "select sum(AMOUNT) from customer_pay where DATE='"+ date +"'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("custpay", rs.getFloat(1));
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
                                                        String query = "select sum(AMOUNT) from customer_pay where DATE<='"+ date +"'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("totalcustpay", rs.getLong(1));
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
                                                        String query = "select  sum(qty), sum(PURCHASE_PRICE) from vendor_stock where DATE='"+ date +"'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("liftingqty", rs.getInt(1));
                                                        request.setAttribute("liftingvalue", rs.getFloat(2));
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
                                                        String query = "select sum(PURCHASE_PRICE) from vendor_stock where DATE<='"+ date +"'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        
                                                        request.setAttribute("totalliftingvalue", rs.getFloat(1));
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
                                                        String query = "select sum(AMOUNT) from company_payment where DATE ='"+ date +"'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("companypay", rs.getFloat(1));
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
                                                        String query = "select sum(AMOUNT) from company_payment where DATE<='"+ date +"'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("totalcompanypay", rs.getFloat(1));
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
                                                        String query = "select sum(AMOUNT) from cost where DATE ='"+ date +"'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("cost", rs.getFloat(1));
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
                                                        String query = "select AMOUNT from netbalance where DATE ='"+ date +"'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                        request.setAttribute("cash", rs.getFloat(1));
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
                                                        String query = "select sum(AMOUNT) from bank_transition where TYPE = 'Deposit' and DATE<='"+ date +"'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                       request.setAttribute("totaldeposit", rs.getLong(1));
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
                                                        String query = "select sum(AMOUNT) from bank_transition where TYPE = 'Withdraw' and DATE<='"+ date +"'";
                                                        ps = con.prepareStatement(query);
                                                        rs = ps.executeQuery();
                                                        rs.next();
                                                       request.setAttribute("totalwith", rs.getLong(1));
 } catch (Exception ex) {
                                                        }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
                                                    }
                                     %>
                                            <tr>
                                                <td style="text-align: center"><b>Stock </b></td><td style="text-align: center"><b>${stockqty+saleqty} PS | ${stockvalue+salevalue} TK</b></td>
                                            </tr>       
                                            <tr>
                                                <td style="text-align: center"><b>Lifting </b></td><td style="text-align: center"><b>${liftingqty} PS | ${liftingvalue} TK</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>Distribution</b></td><td style="text-align: center"><b>${distqty} PS | ${distvalue} TK</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>Retailer Payment</b></td><td style="text-align: center"><b>${custpay} TK</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>Retailer Due</b></td><td style="text-align: center"><b>${totalsalevalue-totalcustpay} TK</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>Company Payment</b></td><td style="text-align: center"><b>${companypay} TK</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>Company Due</b></td><td style="text-align: center"><b>${totalliftingvalue-totalcompanypay} TK</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>Expense</b></td><td style="text-align: center"><b>${cost} TK</b></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center"><b>Cash Balance</b></td><td style="text-align: center"><b>${cash} TK</b></td>
                                            </tr>
                                             <tr>
                                                <td style="text-align: center"><b>Bank Balance</b></td><td style="text-align: center"><b>${totaldeposit-totalwith} TK</b></td>
                                            </tr>
                                           
                                    
                                            </table><br><br>
                                        </center>
                            </div>
                        </div><br><br>
                                        
    
    <%@include file = "footerpage.jsp" %> 
</div>
       <script src="js/bootstrap.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
    <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>   
      
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
 
     pdf.save("ReportSummary.pdf");
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
       
        <% } %>
    </body>
</html>
