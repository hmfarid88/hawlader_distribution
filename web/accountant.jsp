<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.DeleteModel"%>
<%@page import="Pojo.DeletePojo"%>
<%@page import="Model.CashModel"%>
<%@page import="Pojo.CashBook"%>
<%@page import="Model.AdminModel"%>
<%@page import="Pojo.AdminPojo"%>
<%@page import="Model.SaleModel"%>
<%@page import="Pojo.Profit"%>
<%@page import="Model.StockModel"%>
<%@page import="java.util.List"%>
<%@page import="Model.Accountant"%>
<%@page import="Pojo.AccountPojo"%>
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
        <script src="js/angular.min.js"></script>
        <script src="js/jquery-3.1.1.min.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
        <link rel="icon" type="image/png" href="img/favicon.ico">
       <link rel="preconnect" href="https://fonts.googleapis.com">
       <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
       <link href="https://fonts.googleapis.com/css2?family=Fascinate&display=swap" rel="stylesheet">
        </head>
       <body ng-app="myApp" ng-controller="myCtrl"> 
     <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
      
         <div id="main" style="background-color:#030303; color: #ffffff">
             <div class="container">
                 <center>
                 <table>
                     <tr>
                         <td><center><img src="img/helogo.png" style="height: 90px; width: 90px;" class="img-responsive"></center></td>
                         <td><center><h1 style="font-family: sans-serif ; margin-left: 20px;font-size: 60px; font-family: 'Fascinate', cursive; "><b>HAWLADER DISTRIBUTION</b></h1></center></td>
                     </tr>
                 </table>
                 </center>
             </div>
      <br>
        <nav class="navbar navbar-inverse">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar"> 
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div class="collapse navbar-collapse" id="myNavbar">
                <ul class="nav navbar-nav">
                    <li id="drop"><a href="#"><i class="fa fa-sticky-note"></i> Report-View</a>
                        <div id="dropdown">
                            <a href="totalStock.jsp">Stock Report</a> 
                            <a href="symsellview.jsp">Distribution Report</a>
                            <a id="pr" href="sale_profit.jsp">Profit Report</a> 
                            <a href="expenseinfo.jsp">Employee Expense</a>
                            <a href="m_delete_stock.jsp">Deleted Stock</a>
                            <a id="fi" href="fixed_invest.jsp">Fixed Invest</a>
                            <a href="additional_discount.jsp">Additional Discount</a>
                            <a data-toggle="modal" data-target="#faccommission" href="#">Commission Report</a>
                            <a data-toggle="modal" data-target="#orderlist" href="#">Order Report</a>
                        </div>
                    </li>
                    <li><a href="cash_book.jsp"><span class="fa fa-book"></span> Cash-Book</a></li>
                    <li id="drop"><a href="#"><i class="fa fa-address-card-o"></i> Ledger-Book</a>
                        <div id="dropdown">
                            <a href="retailer_ledger.jsp">Retailer-Ledger</a>
                            <a href="company_ledger.jsp">Company-Ledger</a>
                            <a href="monthly_factory_statement.jsp">Company-Statement</a>
                            <a href="expense_ledger.jsp">Office-Ledger</a>
                            <a href="debit_ledger.jsp">Debit-Ledger</a>
                            <a href="credit_ledger.jsp">Credit-Ledger</a>
                            <a href="adjust_ledger.jsp">Adjustment-Ledger</a>
                            <a href="bank_book.jsp">Bank-Ledger</a>
                            <a href="monthly_vat_view.jsp">Vat-Ledger</a>
                            <a id="prow" href="profit_withdraw.jsp">Profit-Withdraw</a>
                            <a id="pl" href="proprietor_ledger.jsp">Proprietor-Ledger</a>
                            <a data-toggle="modal" data-target="#reportsummary" href="#">Report Summary</a>
                            <a id="cmd" href="cm_payment_ledger.jsp">Call Money Ledger</a>
                            <a href="demo_tr_ledger.jsp">Demo-Ledger</a>
                            <a href="price_drop.jsp">Price Drop-Ledger</a>
                            <a href="sale_back.jsp">Sale-Back-Ledger</a>
                        </div>
                    </li>
                    <li id="drop"><a href="#"><i class="fa fa-exchange"></i> Transaction</a>
                        <div id="dropdown">
                            <a id="cd" data-toggle="modal" data-target="#cdinfo" href="#">Cash-Debit</a>
                            <a id="cc" data-toggle="modal" data-target="#crdinfo" href="#">Cash-Credit</a>
                            <a data-toggle="modal" data-target="#costinfo" href="#">Office-Cost</a>
                            <a data-toggle="modal" data-target="#pminfo" href="#">Company-Pay</a>
                            <a data-toggle="modal" data-target="#empinfo" href="#">Employee-Pay</a>
                            <a data-toggle="modal" data-target="#bnktrnsi" href="#">Bank Transaction</a>
                            <a data-toggle="modal" data-target="#targetcomision" href="#">Commission Entry</a>
                            <a data-toggle="modal" data-target="#propitercost" href="#">Proprietor Pay</a>
                            <a data-toggle="modal" data-target="#cmpayment" href="#">Call Money</a>
                            <a data-toggle="modal" data-target="#fixedinvest" href="#">Fixed Invest</a>
                            <a data-toggle="modal" data-target="#demotransaction" href="#">Demo Transaction</a>
                        </div>
                    </li>
                    <li id="drop"><a href="#"><i class="fa fa-address-book-o"></i> Participants</a>
                        <div id="dropdown">
                            <a href="retailerlist.jsp">Retailer</a>
                            <a href="employeelist.jsp">Employee</a>
                            <a href="proprietor_list.jsp">Proprietor</a>
                        </div>
                    </li>
                            <li id="drop">
                                <a href="#"> <span class="fa fa-search"></span> Search</a>
                                <div  id="dropdown" class=" dropdown-menu">
                                    <a  data-toggle="collapse" data-target="#dvshow" href="#">Product</a>
                                    <a data-toggle="collapse" data-target="#nmdivshow" href="#">Invoice</a>
                                    <a  href="voucher.jsp">Last Invoice</a>
                                    <a  href="pending_mail.jsp">Pending Email</a>
                                </div>
                            </li>  
                            <li>
                                <div style="margin:15px 6px; background-" id="dvshow" class="collapse">
                                    <form class="form-inline" method="POST" action="search_product.jsp" >
                                        <input type="text" autocomplete="off" class="form-control" size="8px" name="imei"   value="" placeholder="Input IMEI" required="" >
                                        <input type="submit" class="btn btn-primary btn-sm" value="OK">
                                        <input type="button" class="btn btn-primary btn-sm" data-toggle="collapse" data-target="#dvshow" value="Cancel">
                                    </form>
                                </div>
                            </li>
                            <li>
                                <div style="margin:15px 6px" id="nmdivshow" class=" collapse" >
                                    <form class="form-inline" method="POST" action="searched_invoice.jsp" >
                                        <input type="text" autocomplete="off" class="form-control" size="8px" name="invono" value="" placeholder="Invoich No" required="" >
                                        <input type="submit" class="btn btn-primary btn-sm" value="OK">
                                        <input type="button" class="btn btn-primary btn-sm"  data-toggle="collapse" data-target="#nmdivshow" value="Cancel">
                                    </form>
                                </div>
                            </li>
                      <li id="drop"><a href="#"><i class="fa fa-cogs"></i> Settings</a>
                        <div id="dropdown">
                            <a data-toggle="modal" data-target="#rtinfo" href="#">Retailer</a>
                            <a data-toggle="modal" data-target="#empadd" href="#">Employee</a>
                            <a data-toggle="modal" data-target="#propadd" href="#">Proprietor</a>
                            <a data-toggle="modal" data-target="#factoryinfo" href="#">Cost-Name</a>
                            <a data-toggle="modal" data-target="#bankinfo" href="#">Add Bank</a>
                            <a data-toggle="modal" data-target="#vatinfo" href="#">Add Vat</a>
                            <a data-toggle="modal" data-target="#admininfo" href="#">Admin Portal</a>
                            <a href="company_info.jsp">Level-up</a>
                            <a data-toggle="modal" data-target="#ainfo" href="#">Edit Account</a>
                            <a  href="mail_send.jsp">Mail Report</a>
                            <a  href="data_backup.jsp">Data Backup</a>
                        </div>
                    </li>
                  
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li id="drop"><a href="#"><i class="fa fa-outdent"></i> Output</a>
                        <div id="dropdown">
                         <a id="pdf" href="#"><span class="fa fa-file-pdf-o"> PDF</span></a>    
                         <a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a>
                        </div>
                        </li>
                       
                    <li><a id="lout" href="LogoutServlet"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                </ul> 
            </div>
        </nav>
      <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            try {
                con = Database.getConnection();
                String query="select ACTION from hide_show where ITEM='Profit Ledger'";
                ps = con.prepareStatement(query);
                rs=ps.executeQuery();
                rs.next();
                request.setAttribute("plstatus", rs.getString(1));
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }
            try {
                con = Database.getConnection();
                String query="select ACTION from hide_show where ITEM='Proprietor Ledger'";
                ps = con.prepareStatement(query);
                rs=ps.executeQuery();
                rs.next();
                request.setAttribute("prostatus", rs.getString(1));
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }
            try {
                con = Database.getConnection();
                String query="select ACTION from hide_show where ITEM='Fixed Invest'";
                ps = con.prepareStatement(query);
                rs=ps.executeQuery();
                rs.next();
                request.setAttribute("fistatus", rs.getString(1));
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }
            try {
                con = Database.getConnection();
                String query="select ACTION from hide_show where ITEM='Profit Withdraw Ledger'";
                ps = con.prepareStatement(query);
                rs=ps.executeQuery();
                rs.next();
                request.setAttribute("pwstatus", rs.getString(1));
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }
            try {
                con = Database.getConnection();
                String query="select ACTION from hide_show where ITEM='Cash Debit'";
                ps = con.prepareStatement(query);
                rs=ps.executeQuery();
                rs.next();
                request.setAttribute("cdstatus", rs.getString(1));
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }
            try {
                con = Database.getConnection();
                String query="select ACTION from hide_show where ITEM='Cash Credit'";
                ps = con.prepareStatement(query);
                rs=ps.executeQuery();
                rs.next();
                request.setAttribute("ccstatus", rs.getString(1));
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }
            try {
                con = Database.getConnection();
                String query="select ACTION from hide_show where ITEM='CMC'";
                ps = con.prepareStatement(query);
                rs=ps.executeQuery();
                rs.next();
                request.setAttribute("cmcstatus", rs.getString(1));
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }
            
try {
                con = Database.getConnection();
                String query="select ACTION from hide_show where ITEM='CMD'";
                ps = con.prepareStatement(query);
                rs=ps.executeQuery();
                rs.next();
                request.setAttribute("cmdstatus", rs.getString(1));
            } catch (Exception ex) {
              ex.printStackTrace();
            }finally {
   try { if (rs != null) rs.close(); } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); } catch (SQLException ex2) { }
   try { if (con != null) con.close(); } catch (SQLException ex2) { }
    }
            %>
      <input type="text" style="display: none" id="advalue" value="${plstatus}" >
      <input type="text" style="display: none" id="prostatus" value="${prostatus}" >
      <input type="text" style="display: none" id="fistatus" value="${fistatus}" >
      <input type="text" style="display: none" id="pwstatus" value="${pwstatus}" >
      <input type="text" style="display: none" id="cdstatus" value="${cdstatus}" >
      <input type="text" style="display: none" id="ccstatus" value="${ccstatus}" >
      <input type="text" style="display: none" id="cmcstatus" value="${cmcstatus}" >
      <input type="text" style="display: none" id="cmdstatus" value="${cmdstatus}" >
     <div class="row">
            <div class="col-sm-12">
              
                    <div id="div_print" style=" background-color: #030303">
                       <center>
                       
                        <h3>Date: <script> document.write(new Date().toLocaleDateString('en-GB'));</script></h3>
                         
                                   <%
                                        AccountPojo ap = new AccountPojo();
                                        Profit pf = new Profit();
                                        CashBook cb = new CashBook();
                                        CashModel cm = cb.DailyCashShow();
                                        SaleModel sml = pf.DailyTotalSale();
                                        SaleModel drp=pf.DailyretailerPay();
                                        StockModel stm = ap.TotalStock();
                                        CashModel bbl=cb.bankBlance();
                                        CashModel probl=cb.propritorBlance();

                                    %>
                       
                            <div class="row">
                                <div  class="col-sm-5">
                                    <table border="2" width="90%" style="font-size: 15px" class=" table-condensed table-responsive text-center" >
                                        <tr><td>Stock Qty</td><td><%= stm.getTotalqty() %></td></tr> 
                                        <tr><td>Stock Value</td><td><%= stm.getTotalvalu() %></td></tr> 
                                        <tr><td>Distribution Qty</td><td><%= sml.getDtsqty() %></td></tr>
                                        <tr><td>Distribution Value </td><td><%= sml.getDtsp() %></td></tr>
                                        <tr><td>Retailer Balance</td><td><%= sml.getRtbalance() %></td></tr>
                                        <tr><td>Company Balance</td><td><%= stm.getCompanybl() %></td></tr>
                                    </table>
                                   
                                </div>
                                    <div  class="col-sm-2">
                                        <center>
                            <h2>{{theTime}}</h2>
                            <script type="text/javascript">
                                        document.write("<center><font size=+2 style='color: white;'>");
                                        var day = new Date();
                                        var hr = day.getHours();
                                        if (hr >= 0 && hr < 12) {
                                            document.write("Good Morning!");
                                        } else if (hr === 12) {
                                            document.write("Good Noon!");
                                        } else if (hr >= 12 && hr <= 16) {
                                            document.write("Good Afternoon!");
                                        } else {
                                            document.write("Good Evening!");
                                        }
                                        document.write("</font></center>");
                            </script>
                        </center>
                                    </div>  
                                <div  class="col-sm-5">
                                     <table border="2" width="90%" style="font-size: 15px" class=" table-condensed table-responsive text-center" >
                                         <tr><td>Cash Value</td><td id="bl"><%= cm.getNetbalance()%></td></tr> 
                                        <tr><td>Bank Value</td><td><%= bbl.getBankbalance()%></td></tr> 
                                        <tr><td>Cash & Bank</td><td><%= cm.getNetbalance()+ bbl.getBankbalance() %></td></tr>
                                        <tr><td>Retailer Payment</td><td><%= drp.getDailyrtpay() %></td></tr>
                                        <tr><td>Demo Balance</td><td><%= sml.getDemoblance() %></td></tr>
                                        <tr><td>Type B Balance</td><td><%= probl.getPropblance() %></td></tr>
                                     </table>
                                </div>
                               
                            </div>
                                     <br>        
                    </center> 
                    </div>
                
                
                                <div class="panel-body">
                        <div  class="col-sm-3">
                            </div>
                        <div  class="col-sm-6">
                            <fieldset class="scheduler-border" style=" border-color: #ffffff">
                            <legend style="font-family: fontawesome; color: #ffffff" class="scheduler-border">Input-Area</legend>
                            <div  class="col-sm-2"></div>
                            <div  class="col-sm-8">
                                <a href="stockentry.jsp"><button style="background-color: #030303" type="button" class="btn btn-primary form-control">Product Entry</button></a><br>
                                <br>
                                <a data-toggle="modal" data-target="#retailerselect" href="#"><button style="background-color: #030303" type="button" class="btn btn-primary form-control">Distribution</button></a><br>
                                <br>
                                <a href="retailer_payment.jsp"><button style="background-color: #030303" type="button" class="btn btn-primary form-control">Retailer Payment</button></a><br>
                                <br> 
                                <a data-toggle="modal" data-target="#srselect" href="#"><button style="background-color: #030303" type="button" class="btn btn-primary form-control">Order Create</button></a><br>
                            </div>
                           <div  class="col-sm-2"></div>
                        </fieldset>
                        </div>
                        <div  class="col-sm-3"></div>
                    </div>
                
            </div>

        </div>
                                 <br><br><br><br>
    <%@include file = "footerpage.jsp" %>
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
    <div id="srselect" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">SR-Info</h4>
                </div>
                <div class="modal-body">
                                           
                        <div class="container-fluid">
                            <div class="col-sm-6">
                              <form method="POST" action="SrSelectServlet">
                                
                                  <select style="width: 100%"  class="form-control select2" onchange="this.form.submit()"  name="sr" required="" >
                                   <option value="">Select-Employee</option>
                                            <%
                                                AdminPojo app = new AdminPojo();
                                                List<AdminModel> listam12 = app.EmpShow();
                                                for (AdminModel am : listam12) {
                                            %>
                                            <option value="<%= am.getEname()%>"> <%= am.getEname()%></option>
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
     <div id="rtinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Retailer-Info</h4>
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Add-Retailer</legend>
                        <div class="container-fluid">
                            <form method="POST" action="RetailerStockServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Retailer Name :</label>
                                        <input style="width: 90%"  type="text" class="form-control input-sm" value="" name="rtname" required="" >
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Mobile Number :</label>
                                        <input style="width: 90%"  type="text" class="form-control input-sm" value="" name="mnumber" required="">
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Area :</label>
                                        <input style="width: 90%"  type="text" class="form-control input-sm" value="" name="address" required="">
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Owner/Boss Name :</label>
                                        <input style="width: 90%"  type="text" class="form-control input-sm" value="" name="owner" required="">
                                    </div>
                                </div><br>
                               
                                <div class="row">
                                    <div class="col-sm-6">
                                        <input type="submit"  class="btn btn-success btn-sm" value="OK"> 
                                        <input type="reset"  class="btn btn-info btn-sm" value="Reset"> 
                                    </div>
                                </div>

                            </form>
                        </div><hr style=" background-color: green">
                        <div class="container-fluid">
                            <div class="col-sm-6">
                              <form method="POST" action="RetailerSelectServlet">
                                <label>Update Retailer :</label>
                                <select style="width: 100%" class="form-control select2" name="retailer" required="" >
                                    <option value="">Select-Retailer</option>
                                    <%
                                        List<Accountant> list03 = ap.retailerView();
                                        for (Accountant ac : list03) {
                                    %>
                                    <option value="<%= ac.getRetailer()%>"> <%= ac.getRetailer()%></option>
                                    <%}%>

                                </select><br><br>
                                <input type="submit" class="btn btn-info btn-sm" value="GO">
                            </form>
                            </div>
                                    <div class="col-sm-6">
                                        <form method="POST" action="RetailerDelServlet">
                                <label>Delete Retailer :</label>
                                <select style="width: 100%" class="form-control select2" name="retailer" required="" >
                                    <option value="">Select-Retailer</option>
                                    <%
                                        List<Accountant> list033 = ap.retailerView();
                                        for (Accountant ac : list033) {
                                    %>
                                    <option value="<%= ac.getRetailer()%>"> <%= ac.getRetailer()%></option>
                                    <%}%>

                                </select><br><br>
                                <input type="submit" class="btn btn-danger btn-sm" value="Delete">
                            </form>
                                    </div>       
                            
                        </div>
                    </fieldset>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
<div id="propadd" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Proprietor-Info</h4>
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Add-Proprietor</legend>
                        <div class="container-fluid">
                            <form method="POST" action="ProprietorServlet">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Proprietor Name :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="propname" required="" >
                                    </div>
                                     <div class="col-sm-4">
                                        <label>Proprietor Type :</label>
                                        <select  class="form-control input-sm" name="type" required="" >
                                          <option value="">Select-Type</option>
                                          <option value="Type A">Type A</option>
                                          <option value="Type B">Type B(Without Interest)</option>
                                          <option value="Type C">Type C</option>
                                         
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                       <label>Interest Per Lack</label>
                                       <input  type="number" class="form-control input-sm" value="" name="ipl" required="" >
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Mobile Number :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="mnumber" required="">
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Address :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="address" required="">
                                    </div>
                                </div><br>
                               
                                <div class="row">
                                    <div class="col-sm-6">
                                        <input type="submit"  class="btn btn-success btn-sm" value="OK"> 
                                        <input type="reset"  class="btn btn-info btn-sm" value="Reset"> 
                                    </div>
                                </div>

                            </form><br>
                             <div class="row">
                            <div class="col-sm-10">
                                        <form method="POST" action="PropDelServlet">
                                <label>Delete Proprietor :</label>
                                 <select style=" width: 80%" class="form-control" name="propname" required="">
                                            <option value="">Select Proprietor</option>
                                           <%
                                        List<Accountant> list008 = ap.proprietorView();
                                        for (Accountant ac : list008) {
                                    %>
                                    <option value="<%= ac.getProprietor()%>"> <%= ac.getProprietor()%></option>
                                    <%}%>
                                        </select><br>
                                <input type="submit" class="btn btn-danger btn-sm" value="Delete">
                            </form>
                                    </div>     
                             </div>
                        </div>
                        
                    </fieldset>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>

    <div id="ainfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Account-Info</h4>
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Update-Account</legend>
                        <form method="POST" action="AccIDPassUpServlet">
                            <div class="row">
                                <div class="col-sm-4">
                                    <label>Current-ID</label>
                                    <input type="text" class="form-control input-sm" name="cid" required="">
                                </div>
                                <div class="col-sm-4">
                                    <label>Current-Password</label>
                                    <input type="password" class="form-control input-sm" name="cpass" required="">
                                </div>
                                <div class="col-sm-4">
                                    <label>Phone Number</label>
                                    <input type="text" class="form-control input-sm" name="mnumber" required="">
                                </div>
                            </div><br>
                            <div class="row">
                                <div class="col-sm-6">
                                    <label>New-ID</label>
                                    <input type="text" class="form-control input-sm" name="newid" required="">
                                </div> 
                                <div class="col-sm-6">
                                    <label>New-Password</label>
                                    <input type="password" class="form-control input-sm" name="newpass" required="">
                                </div>
                            </div><br>
                            <input type="submit" class="btn btn-success btn-sm" value="Update">
                        </form>
                    </fieldset>  

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
    <div id="admininfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                   
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Admin Login</legend>
                        <form method="POST" action="AdminLoginServlet">
                           
                            <div class="row">
                                <div class="col-sm-6">
                                    <label>User ID</label>
                                    <input type="text" class="form-control input-sm" name="userid" required="">
                                </div> 
                                <div class="col-sm-6">
                                    <label>Password</label>
                                    <input type="password" maxlength="6" minlength="6" pattern="[0-9]{6}" class="form-control input-sm" name="password" required="">
                                </div>
                            </div><br>
                            <input type="submit" class="btn btn-success btn-sm" value="GO">
                        </form>
                    </fieldset>  

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
   <div id="propitercost" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Proprietor-Transaction</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="PropitercostServlet">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Transaction Type</label>
                                        <select style=" width: 90%" class="form-control" name="name" required="">
                                            <option value="">Select Item</option>
                                            <option value="Payment">Payment</option>
                                            <option value="Receive">Receive</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Proprietor Name</label>
                                        <select style=" width: 90%" class="form-control" name="propname" required="">
                                            <option value="">Select Proprietor</option>
                                           <%
                                       
        try {
            con = Database.getConnection();
            String query = "select P_NAME from proprietor_info where TYPE ='Type A' or TYPE ='Type B'";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString("P_NAME") %>"> <%= rs.getString("P_NAME")%></option>
                                    <%}
                                    }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                    %>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Amount</label>
                                        <input type="number" id="rate1" autocomplete="off" style=" width: 80%" class="form-control input-sm" name="amount" required="">
                                        <input type="text" style=" width: 80%" id="total1" readonly="">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="OK">
                            </form><hr style="background-color: green">
                            <form method="POST" action="ProTrDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Proprietor Transaction-Delete</label>
                                        <select  name="transi" class="form-control" required="">
                                            <option value="">Select-Item</option>
                                            <%
                                            DeletePojo dp=new DeletePojo();
                                            List<DeleteModel>dele1=dp.PropricostDel();
                                            for(DeleteModel dm:dele1){
                                            %>
                                            <option value="<%= dm.getProsi() %>"><%= dm.getPropayname() %>(<%= dm.getPropay() %>/<%= dm.getProrecv() %>)</option>
                                            <% } %>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
                                    </div>
                                </div>
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
                                        
    <div id="cmreceive" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Call Money Receive</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="CMrecvServlet">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Transaction Type</label>
                                        <select style=" width: 90%" class="form-control" name="name" required="">
                                            <option value="">Select Item</option>
                                            <option value="Payment">Payment</option>
                                            <option value="Receive">Receive</option>
                                            <option value="Interest">Interest</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Loan Person</label>
                                        <select style=" width: 90%" class="form-control" name="lperson" required="">
                                            <option value="">Select Person</option>
                                           <%
                                       
        try {
            con = Database.getConnection();
            String query = "select P_NAME from proprietor_info where TYPE='Type C'";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString("P_NAME") %>"> <%= rs.getString("P_NAME")%></option>
                                    <%}
                                    }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                    %>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Amount</label>
                                        <input type="number" id="rate111" autocomplete="off" style=" width: 80%" class="form-control input-sm" name="amount" required="">
                                        <input type="text" style=" width: 80%" id="total1l" readonly="">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="OK">
                            </form><hr style="background-color: green">
                            <form method="POST" action="ProTrDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>C.M Transaction-Delete</label>
                                        <select  name="transi" class="form-control" required="">
                                            <option value="">Select-Item</option>
                                            <%
                                            List<DeleteModel>dele2=dp.PropricostDel();
                                            for(DeleteModel dm:dele2){
                                            %>
                                            <option value="<%= dm.getProsi() %>"><%= dm.getPropayname() %>(<%= dm.getPropay() %>/<%= dm.getProrecv() %>)</option>
                                            <% } %>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
                                    </div>
                                </div>
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
 <div id="cmpayment" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Call Money Transaction</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="CMPaymentServlet">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Transaction Type</label>
                                        <select style=" width: 90%" class="form-control" name="name" required="">
                                            <option value="">Select Item</option>
                                            <option value="Payment">Payment</option>
                                            <option value="Receive">Receive</option>
                                            <option value="Interest Payment">Interest Payment</option>
                                            <option value="Interest Receive">Interest Receive</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Loan Person</label>
                                        <select style=" width: 90%" class="form-control" name="lperson" required="">
                                            <option value="">Select Person</option>
                                           <%
                                       
        try {
            con = Database.getConnection();
            String query = "select P_NAME from proprietor_info where TYPE='Type C'";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                                    %>
                                    <option value="<%= rs.getString("P_NAME") %>"> <%= rs.getString("P_NAME")%></option>
                                    <%}
                                    }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                                    %>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Amount</label>
                                        <input type="number" id="cmprate" autocomplete="off" style=" width: 80%" class="form-control input-sm" name="amount" required="">
                                        <input type="text" style=" width: 80%" id="cmptotal" readonly="">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="OK">
                            </form><hr style="background-color: green">
                            <form method="POST" action="ProTrDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>C.M Transaction-Delete</label>
                                        <select  name="transi" class="form-control" required="">
                                            <option value="">Select-Item</option>
                                            <%
                                            List<DeleteModel>dele3=dp.PropricostDel();
                                            for(DeleteModel dm:dele3){
                                            %>
                                            <option value="<%= dm.getProsi() %>"><%= dm.getPropayname() %>(<%= dm.getPropay() %>/<%= dm.getProrecv() %>)</option>
                                            <% } %>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
                                    </div>
                                </div>
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
    
    <div id="fixedinvest" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Fixed Invest</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="FinvestServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Invest Name</label>
                                        <input type="text" style=" width: 80%" class="form-control input-sm" name="invest" required="">
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Amount</label>
                                        <input type="number" id="rate3" autocomplete="off" style=" width: 80%" class="form-control input-sm" name="amount" required="">
                                        <input type="text" style=" width: 80%" id="total3" readonly="">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="OK">
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
    <div id="costinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cost Entry</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="CostServlet">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Cost Name</label>
                                        <select style=" width: 80%" name="costname" class="form-control" required="">
                                            <option value=""></option>
                                            <%
                                                List<Accountant> factryy = ap.CostNameView();
                                                for (Accountant act : factryy) {
                                            %>
                                            <option value="<%= act.getExpense()%>"><%= act.getExpense()%></option>
                                            <% }%>
                                        </select>
                                        
                                    </div>
                                        <div class="col-sm-4">
                                            <label>Cost Note</label>
                                            <input type="text" name="note" class="form-control input-sm" value="ON">
                                        </div>
                                            
                                    <div class="col-sm-4">
                                        <label>Cost Amount</label>
                                        <input type="number" id="rate4" style="width: 80%" autocomplete="off"  class="form-control input-sm" name="amount" required="">
                                        <input type="text" style=" width: 80%" id="total4" readonly="">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="OK">
                            </form><hr style="background-color: green">
                            <form method="POST" action="CostDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Cost-Delete</label>
                                        <select  name="costsi" class="form-control" required="">
                                            <option value="">Select-Item</option>
                                            <%
                                            List<DeleteModel>dele=dp.OfficecostDel();
                                            for(DeleteModel dm:dele){
                                            %>
                                            <option value="<%= dm.getOffcostsi() %>"><%= dm.getOffcostname() %>(<%= dm.getOffcostamount() %>)</option>
                                            <% } %>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
                                    </div>
                                </div>
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
    
    <div id="empinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Employee Expense</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="EmpPayServlet">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Employee Name</label>
                                        <select name="empname" class="form-control" style=" width: 90%" required="">
                                            <option value="">Select-Employee</option>
                                            <%
                                                List<AdminModel> listam1 = app.EmpShow();
                                                for (AdminModel am : listam1) {
                                            %>
                                            <option value="<%= am.getEname()%>"> <%= am.getEname()%></option>
                                            <%}%>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Expense Name</label>
                                        <select style=" width: 80%" name="costname" class="form-control" required="">
                                            <option value=""></option>
                                            <%
                                                List<Accountant> factoryy = ap.CostNameView();
                                                for (Accountant act : factoryy) {
                                            %>
                                            <option value="<%= act.getExpense()%>"><%= act.getExpense()%></option>
                                            <% }%>
                                        </select>
                                       
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Amount</label>
                                        <input type="number" id="rate6" autocomplete="off"  style=" width: 80%" class="form-control input-sm" name="amount" required="">
                                        <input type="text" style=" width: 80%" id="total6" readonly="">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="OK">
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
    <div id="pminfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Company-Payment</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="CompanypayServlet">
                                <div class="row">
                                    <div class="col-sm-8">
                                        <label>Company Select</label> 
                                        <select style=" width: 95%" name="factory" class="form-control" required="">
                                            <option value="">Select Company</option> 
                                        <%
                                            List<Accountant> litt = ap.FactoryView();
                                            for (Accountant ac : litt) {
                                        %>
                                        <option value="<%= ac.getFactory()%>"> <%= ac.getFactory()%></option>
                                        <%}%>
                                        </select>
                                    </div>
                                        <div class="col-sm-4">
                                            <label>Note</label>
                                            <input type="text" name="note" class="form-control" required="" >
                                        </div>

                                </div><br>

                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Payment Type</label><br>
                                        <input type="radio" name="paytype" value="Cash" required=""> Cash
                                        <input id="facbnk" type="radio" name="paytype" value="Bank" required=""> Bank
                                    </div>
                                    
                                    <div class="col-sm-6">
                                        <label>Amount</label>
                                        <input id="rate7" autocomplete="off" style="width: 80%" type="number" class="form-control input-sm" name="amount" required="">
                                        <input type="text" style=" width: 80%" id="total7" readonly="">
                                    </div>

                                </div><br>
                                <div id="bankitem" class="row">
                                    <div class="col-sm-3">
                                        <label>Bank Name</label>
                                        <select style=" width: 90%" class="form-control select2" name="bank">
                                            <option value="">Bank Select</option>
                                            <%
                                                List<Accountant> list3 = ap.BankShow();
                                                for (Accountant ac : list3) {
                                            %>
                                            <option value="<%= ac.getBank()%>"><%= ac.getBank()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="col-sm-3">
                                        <label>Branch Name</label>
                                        <input style=" width: 90%" type="text" class="form-control input-sm" name="branch">
                                    </div>
                                    <div class="col-sm-3">
                                        <label>Cheque Number</label>
                                        <input style=" width: 90%" type="text" class="form-control input-sm" name="cheque">
                                    </div>
                                    <div class="col-sm-3">
                                        <label>Payer Name</label>
                                        <input style=" width: 90%" type="text" class="form-control input-sm" name="payer">
                                    </div>
                                </div><br>

                                <div class="row">
                                    <div class="col-sm-12">
                                        <input type="submit" class="btn btn-success btn-sm" value="OK">  
                                    </div> 
                                </div>
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

    <div id="bnktrnsi" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Bank-Transaction</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="BankTranServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Bank Name</label> 
                                        <select class="form-control" name="bank">
                                            <option value="">Bank Select</option>
                                            <%
                                                List<Accountant> list0003 = ap.BankShow();
                                                for (Accountant ac : list0003) {
                                            %>
                                            <option value="<%= ac.getBank()%>"><%= ac.getBank()%></option>
                                            <% } %>
                                        </select>
                                    </div>   
                                    <div class="col-sm-6">
                                        <label>Transaction Type</label>
                                        <select name="type" class="form-control" required="">
                                            <option value="">Select Type</option>
                                            <option value="Deposit">Deposit</option>
                                            <option value="Withdraw">Withdraw</option>
                                        </select>
                                    </div>

                                </div><br>
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Amount</label>
                                        <input type="number" id="rate9" style="width: 90%" autocomplete="off" class="form-control input-sm" name="amount" required="">
                                        <input type="text" style=" width: 90%" id="total9" readonly="">
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Branch Name</label>
                                        <input type="text" class="form-control input-sm" name="branch" required="">
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Payer/Receiver</label>
                                        <input type="text" class="form-control input-sm" name="payer" required="">
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <input type="submit" class="btn btn-success btn-sm" value="OK">  
                                    </div> 
                                </div>
                            </form><hr style="background-color: green">
                            <form method="POST" action="BanktranDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Bank Transaction-Delete</label>
                                        <select  name="transi" class="form-control" required="">
                                            <option value="">Select-Item</option>
                                            <%
                                            List<DeleteModel>dell=dp.BanktransiDel();
                                            for(DeleteModel dm:dell){
                                            %>
                                            <option value="<%= dm.getBanksi() %>"><%= dm.getBank() %>(<%= dm.getBanktype() %>, <%= dm.getBankamount() %>)</option>
                                            <% } %>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
                                    </div>
                                </div>
                            </form>

                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Exit</button>
                </div>
            </div>  
        </div>
    </div>
    <div id="factoryinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Cost-Name</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="FactoryaddServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Cost Name</label>
                                        <input type="text" style=" width: 70%" class="form-control input-sm" name="fname" required=""><br>
                                        <input type="submit" class="btn btn-success btn-sm" value="OK">
                                    </div>
                                </div>
                            </form><hr style=" background-color: black">
                            <form method="POST" action="FactoryDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Delete Cost-Name</label>
                                        <select style=" width: 70%" name="fname" class="form-control input-sm" required="">
                                            <option value=""></option>
                                            <%
                                                List<Accountant> factory = ap.CostNameView();
                                                for (Accountant act : factory) {
                                            %>
                                            <option value="<%= act.getExpense()%>"><%= act.getExpense()%></option>
                                            <% }%>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
                                    </div>
                                </div> 
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
    <div id="bankinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Bank</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="BankaddServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Bank Name</label>
                                        <input type="text" style=" width: 70%" class="form-control input-sm" name="bankname" required=""><br>
                                        <input type="submit" class="btn btn-success btn-sm" value="OK">
                                    </div>
                                </div>
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
    <div id="targetcomision" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Company-Commission</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="Fac_commiServlet" class="form-inline">
                                    <div class="row">
                                        <div class="col-sm-8">
                                    <select style="width: 90%" class="form-control" name="retailer" required="" >
                                        <option value="">Select-Company</option>
                                        <%
                                            List<Accountant> listt = ap.FactoryView();
                                            for (Accountant ac : listt) {
                                        %>
                                        <option value="<%= ac.getFactory()%>"> <%= ac.getFactory()%></option>
                                        <%}%>
                                    </select>
                                        </div>
                                     <div class="col-sm-4">
                                         <input style="width: 80%" autocomplete="off" id="rate10" type="text" name="amount" class="form-control input-sm" value="" required="" placeholder="Amount">
                                         <input type="text" style=" width: 80%" id="total10" readonly="">
                                     </div>
                                    </div><br>
                                    <div class="row">
                                    <div class="col-sm-4">
                                    <select style="width: 90%" name="month" class="form-control" required="">
                                            <option class="active" value=""> Select Month</option>
                                            <option value="1">January</option>
                                            <option value="2">February</option>
                                            <option value="3">March</option>
                                            <option value="4">April</option>
                                            <option value="5">May</option>
                                            <option value="6">June</option>
                                            <option value="7">July</option>
                                            <option value="8">August</option>
                                            <option value="9">September</option>
                                            <option value="10">October</option>
                                            <option value="11">November</option>
                                            <option value="12">December</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <select style="width: 90%" name="year" class="form-control" required="">
                                            <option value=""> Select Year</option>
                                            <option value="2019">2019</option>
                                            <option value="2020">2020</option>
                                            <option value="2021">2021</option>
                                            <option value="2022">2022</option>
                                            <option value="2023">2023</option>
                                            <option value="2024">2024</option>
                                            <option value="2025">2025</option>
                                            <option value="2026">2026</option>
                                            <option value="2027">2027</option>
                                            <option value="2028">2028</option>
                                            <option value="2029">2029</option>
                                            <option value="2030">2030</option>
                                        </select>
                                    </div>
                                        <div class="col-sm-4">
                                            <input style="width: 90%" placeholder="Note" type="text" class="form-control" name="note" value="" required="">
                                        </div>
                                            
                                    </div><br>
                                    <div class="row">
                                        <div class="col-sm-12">
                                          <input type="submit" class="btn btn-info btn-sm" value="OK">   
                                        </div>
                                    </div>
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
    <div id="faccommission" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Commission View</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="commission_1.jsp">
                                <div class="row">
                                    <div class="col-sm-4">
                                    <select name="month" class="form-control" required="">
                                            <option class="active" value=""> Select Month</option>
                                            <option value="1">January</option>
                                            <option value="2">February</option>
                                            <option value="3">March</option>
                                            <option value="4">April</option>
                                            <option value="5">May</option>
                                            <option value="6">June</option>
                                            <option value="7">July</option>
                                            <option value="8">August</option>
                                            <option value="9">September</option>
                                            <option value="10">October</option>
                                            <option value="11">November</option>
                                            <option value="12">December</option>
                                        </select>
                                    </div>
                                     <div class="col-sm-4">
                                        <select name="year" class="form-control" required="">
                                            <option value=""> Select Year</option>
                                            <option value="2019">2019</option>
                                            <option value="2020">2020</option>
                                            <option value="2021">2021</option>
                                            <option value="2022">2022</option>
                                            <option value="2023">2023</option>
                                            <option value="2024">2024</option>
                                            <option value="2025">2025</option>
                                            <option value="2026">2026</option>
                                            <option value="2027">2027</option>
                                            <option value="2028">2028</option>
                                            <option value="2029">2029</option>
                                            <option value="2030">2030</option>
                                        </select>
                                    </div>
                                    <div class="col-sm-3">
                                       <input type="submit" class="btn btn-success btn-sm" value="OK">
                                    </div>
                                </div>
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
   
    <div id="empadd" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Employee-Info</h4>
                </div>
                <div class="modal-body">
                    <fieldset class="scheduler-border">
                        <legend class="scheduler-border">Add-Employee</legend>
                        <div class="container-fluid">
                            <form method="POST" action="EmployeeEntryServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Employee Name :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="ename" id="model" required="" >
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Father's Name :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="fname" id="model" required="" >
                                    </div>
                                </div><br>

                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Address :</label>
                                        <input  type="text" class="form-control input-sm" value="" name="address" id="model" required="" >
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Phone Number :</label>
                                        <input  type="number" class="form-control input-sm" value="" name="pnumber" id="model" required="" >
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Designation :</label>
                                        <select  class="form-control" value="" name="desiganation"  required="" >
                                            <option value="">Select Type</option>
                                            <option value="Manager">Manager</option>
                                            <option value="Accountant">Accountant</option>
                                            <option value="Officer">Officer</option>
                                            <option value="Sales Representative">Sales Representative</option>
                                            <option value="Employee">Employee</option>
                                        </select>
                                    </div>
                                </div><br>

                                <div class="row">
                                    <div class="col-sm-6">
                                        <input type="submit" id="modeladd" class="btn btn-success btn-sm" value="OK"> 
                                    </div>
                                </div>

                            </form>
                        </div><hr style=" background-color: green">
                        <div class="container-fluid">
                            <form method="POST" action="EmpDeleteServlet">
                                <label>Select Employee To Delete :</label>
                                <select  class="form-control" name="empsi" required="" >
                                    <option value="">Select-Employee</option>
                                    <%
                                        AdminPojo adp = new AdminPojo();
                                        List<AdminModel> listtt = adp.EmpShow();
                                        for (AdminModel am : listtt) {
                                    %>
                                    <option value="<%= am.getEsi()%>"> <%= am.getEname()%></option>
                                    <%}%>
                                </select><br>
                                <input  type="submit" class="btn btn-info btn-sm" value="Delete">
                            </form>
                        </div>
                    </fieldset>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Close</button>
                </div>
            </div>  
        </div>
    </div>
    <div id="demotransaction" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Demo-Transaction</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="DemoTranServlet">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <label>Transaction Type</label><br>
                                        <input type="radio" name="type" value="Receive" required=""> Receive
                                        <input type="radio" name="type" value="Payment" required=""> Payment
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Remark</label> 
                                        <input type="text" class="form-control input-sm" name="remark" required="">
                                    </div> 
                                    <div class="col-sm-4">
                                        <label>Amount</label> 
                                        <input type="number" id="rate11" style=" width: 80%" autocomplete="off" class="form-control input-sm" name="amount" required="">
                                        <input type="text" style=" width: 80%" id="total11" readonly="">
                                    </div> 
                                </div><br>
                               
                                <div class="row">
                                    <div class="col-sm-12">
                                        <input type="submit" class="btn btn-success btn-sm" value="OK">  
                                    </div> 
                                </div>
                            </form><hr style="background-color: green">
                            <form method="POST" action="DemotranDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Demo Transaction-Delete</label>
                                        <select  name="transi" class="form-control" required="">
                                            <option value="">Select-Item</option>
                                            <%
                                            List<DeleteModel>ddell=dp.demotransiDel();
                                            for(DeleteModel dm:ddell){
                                            %>
                                            <option value="<%= dm.getDemosi() %>"><%= dm.getDemotype() %>,<%= dm.getDemoremark() %>, <%= dm.getDemoamount() %></option>
                                            <% } %>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
                                    </div>
                                </div>
                            </form>

                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Exit</button>
                </div>
            </div>  
        </div>
    </div>
    <div id="cdinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cash-Debit(Amount Plus)</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="CashinServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Debit Name</label>
                                        <input type="text" style=" width: 80%" class="form-control input-sm" name="dname" required="">
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Debit Amount</label>
                                        <input type="number" id="rate2" style="width: 80%" autocomplete="off"  class="form-control input-sm" name="amount" required="">
                                        <input type="text" style=" width: 80%" id="total2" readonly="">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="OK">
                            </form><hr style="background-color: green">
                            <form method="POST" action="DebitDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Debit Item-Delete</label>
                                        <select  name="costsi" class="form-control" required="">
                                            <option value="">Select-Item</option>
                                            <%
                                            
                                                List<DeleteModel>ddel=dp.DebitDel();
                                            for(DeleteModel dm:ddel){
                                            %>
                                            <option value="<%= dm.getDebitsi() %>"><%= dm.getDebitname() %>(<%= dm.getDebitamount() %>)</option>
                                            <% } %>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
                                    </div>
                                </div>
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
    <div id="crdinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Cash-Credit(Amount Minus)</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="CashoutServlet">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Credit Name</label>
                                        <input type="text" style=" width: 80%" class="form-control input-sm" name="cname" required="">
                                    </div>
                                    <div class="col-sm-6">
                                        <label>Credit Amount</label>
                                        <input type="number" id="rate5" autocomplete="off"  style=" width: 80%" class="form-control input-sm" name="amount" required="">
                                        <input type="text" style=" width: 80%" id="total5" readonly="">
                                    </div>
                                </div><br>
                                <input type="submit" class="btn btn-success btn-sm" value="OK">
                            </form><hr style="background-color: green">
                            <form method="POST" action="CreditDelServlet">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <label>Credit Item-Delete</label>
                                        <select  name="costsi" class="form-control" required="">
                                            <option value="">Select-Item</option>
                                            <%
                                            List<DeleteModel>credel=dp.CreditDel();
                                            for(DeleteModel dm:credel){
                                            %>
                                            <option value="<%= dm.getCreditsi() %>"><%= dm.getCreditname() %>(<%= dm.getCreditamount() %>)</option>
                                            <% } %>
                                        </select><br>
                                        <input type="submit" class="btn btn-info btn-sm" value="Delete">
                                    </div>
                                </div>
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
    <div id="reportsummary" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="summary_report.jsp">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Select Date</label>
                                        <input type="date"  class="form-control input-sm" name="date" required="">
                                        <br>
                                       <input type="submit" class="btn btn-success btn-sm" value="GO">
                                    </div>
                                    <div class="col-sm-6">
                                    </div>
                                </div>
                                
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
    <div id="orderlist" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="order_list.jsp">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <label>Select Date</label>
                                        <input type="date"  class="form-control input-sm" name="date" required="">
                                        <br>
                                       <input type="submit" class="btn btn-success btn-sm" value="GO">
                                    </div>
                                    <div class="col-sm-6">
                                    </div>
                                </div>
                                
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
    <div id="vatinfo" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Add Vat</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="VatServlet">
                                <div class="row">
                                  
                                    <div class="col-sm-6">
                                        <label>VAT (%)</label>
                                       <input type="number" step="0.01" style=" width: 80%" class="form-control input-sm" name="vatrate" required=""> 
                                    </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-12">
                                        <input type="submit" class=" btn btn-success" value="OK">
                                    </div>
                                </div>
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
   <script src="js/comma.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.min.js"></script>
   <script src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
     <script>
      $(document).ready(function () { 
          var p = document.getElementById('advalue').value;
          var q = document.getElementById('prostatus').value;
          var r = document.getElementById('fistatus').value;
          var s = document.getElementById('pwstatus').value;
          var t = document.getElementById('cdstatus').value;
          var u = document.getElementById('ccstatus').value;
          var v = document.getElementById('cmcstatus').value;
          var w = document.getElementById('cmdstatus').value;
       if(p == 1){
         $("#pr").show(); 
       }else{
        $("#pr").hide();    
       };
       if(q == 1){
         $("#pl").show(); 
       }else{
        $("#pl").hide();    
       };
       if(r == 1){
         $("#fi").show(); 
       }else{
        $("#fi").hide();    
       };
       if(s == 1){
         $("#prow").show(); 
       }else{
        $("#prow").hide();    
       };
       if(t == 1){
         $("#cd").show(); 
       }else{
        $("#cd").hide();    
       };
       if(u == 1){
         $("#cc").show(); 
       }else{
        $("#cc").hide(); 
        };
        if(v == 1){
         $("#cmc").show(); 
       }else{
        $("#cmc").hide();  
       };
       if(w == 1){
         $("#cmd").show(); 
       }else{
        $("#cmd").hide(); 
        };
      });
     
   </script>
    <script>
    $('.select2').select2();
    </script>
    <script>
                var app = angular.module('myApp', []);
                app.controller('myCtrl', function ($scope, $interval) {
                    $scope.theTime = new Date().toLocaleTimeString();
                    $interval(function () {
                        $scope.theTime = new Date().toLocaleTimeString();
                    }, 1000);

                });

    </script>
   <script>
                        $(document).ready(function () {
                            $('form').submit(function () {
                                if (this.beenSubmitted)
                                    return false;
                                else
                                    this.beenSubmitted = true;
                            });
                        });
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
 
     pdf.save("CurrentInfo.pdf");
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
<% } %>
</body>
</html>
