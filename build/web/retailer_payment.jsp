
<%@page import="Pojo.AdminPojo"%>
<%@page import="Model.AdminModel"%>
<%@page import="Model.Accountant"%>
<%@page import="java.util.List"%>
<%@page import="Pojo.AccountPojo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
            <script src="js/comma.js"></script>
            <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
            <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
            <link rel="icon" type="image/png" href="img/favicon.ico">
         </head>
        <body id="main">
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
            <div class="container">
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
                                <li><a href="symmobilesell.jsp">Distribution</a></li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                
                            </ul> 
                        </div>
                    </nav>
                </header>
                <div class="row">
                    <div class="col-sm-12">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="RetailerpayServlet">
                                <div class="row">
                                    <div class="col-sm-5">
                                        <label>Retailer Select</label> 
                                        <select name="rtname"  class="form-control select2" required="">
                                            <option value="">Retailer Name</option> 
                                            <%
                                               AccountPojo ap = new AccountPojo();
                                               AdminPojo app = new AdminPojo();
                                               List<Accountant> list6 = ap.retailerView();
                                                for (Accountant ac : list6) {
                                            %>
                                            <option class="zoom" value="<%= ac.getRetailer()%>"><%= ac.getRetailer()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                        <div class="col-sm-2"></div>
                                        <div class="col-sm-5">
                                          <label>Collected By :</label><br>  
                                           <select  class="form-control select2" name="cby" required=""  >
                                        <option value="">Select-Employee</option>
                                        <%
                                            List<AdminModel> listamm = app.EmpShow();
                                            for (AdminModel am : listamm) {
                                        %>
                                        <option value="<%= am.getEname()%>"> <%= am.getEname()%></option>
                                        <%}%>
                                    </select>
                                      </div>
                                </div><br>
                                <div class="row">
                                    <div class="col-sm-5">
                                        <label>Payment Type</label><br>
                                        <input type="radio" name="paytype" value="Cash" required=""> Cash
                                        <input id="bnk" type="radio" name="paytype" value="Bank" required=""> Bank
                                        <input id="adjust" type="radio" name="paytype" value="Adjustment" required=""> Adjustment
                                    </div>
                                    <div class="col-sm-2"></div>
                                   <div class="col-sm-5">
                                        <label>Amount</label>
                                        <input type="number" style=" width: 80%" id="rate8" autocomplete="off" class="form-control input-sm" name="amount" required="">
                                        <input type="text" style=" width: 80%" id="total8" readonly=""> 
                                   </div>

                                </div><br>
                                <div id="bankrow" class="row">
                                    <div class="col-sm-4">
                                        <label>Bank Name</label>
                                        <select class="form-control select2" id="bank" style=" width: 80%" name="bank">
                                            <option value="">Bank Select</option>
                                            <%
                                                List<Accountant> list4 = ap.BankShow();
                                                for (Accountant ac : list4) {
                                            %>
                                            <option value="<%= ac.getBank()%>"><%= ac.getBank()%></option>
                                            <% } %>
                                        </select>
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Branch Name</label>
                                        <input type="text" style=" width: 80%" class="form-control input-sm" name="branch">
                                    </div>
                                    <div class="col-sm-4">
                                        <label>Payer Name</label>
                                        <input type="text" style=" width: 80%" class="form-control input-sm" name="payer">
                                    </div>
                                </div><br>
                                <div id="adjustrow" class="row">
                                    <div class="col-sm-5">
                                     <label>Adjustment Note</label>
                                     <input type="text" id="adjst" class="form-control input-sm" name="adjustnote">
                                    </div><div class="col-sm-2"></div>
                                    <div class="col-sm-5">
                                     <label>Company Name</label>
                                     <select style=" width: 95%" id="company" name="factory" class="form-control">
                                            <option value="">Select Company</option> 
                                        <%
                                            List<Accountant> littt = ap.FactoryView();
                                            for (Accountant ac : littt) {
                                        %>
                                        <option value="<%= ac.getFactory()%>"> <%= ac.getFactory()%></option>
                                        <%}%>
                                        </select>
                                    </div>
                                    </div><br>
                                <div class="row">
                                    <div class="col-sm-4"></div>
                                    <div class="col-sm-4">
                                        <input type="submit" class="btn btn-success btn-block" value="Submit">  
                                    </div> 
                                    <div class="col-sm-4"></div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
              </div>
                                         <div style="margin-top: 15%">                       
            <%@include file = "footerpage.jsp" %>
            </div>
            </div>
           
            <script src="js/bootstrap.min.js"></script>
            <script>
    $('.select2').select2();
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
          <% } %>
            
        </body>
    </html>
