<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.DeleteModel"%>
<%@page import="java.util.List"%>
<%@page import="Pojo.DeletePojo"%>
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
            if ((session.getAttribute("admin") == null) || (session.getAttribute("admin") == "")) {
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
                                <li><a href="admin_portal.jsp"><span class="fa fa-home"> Home</span></a></li>
                                <li><a href="retailerlist_1.jsp"><span class="fa fa-user"> Retail List</span></a></li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li><a data-toggle="modal" data-target="#ainfo" href="#"><span class="glyphicon glyphicon-cog"></span> Account Setting</a></li>
                                <li><a id="lout" href="AdminLogoutServlet"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                            </ul> 
                        </div>
                    </nav>
                </header>
            <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            try {
                con = Database.getConnection();
                String query="select STATUS from hide_show where ITEM='Profit Ledger'";
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
                String query="select STATUS from hide_show where ITEM='Proprietor Ledger'";
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
                String query="select STATUS from hide_show where ITEM='Fixed Invest'";
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
                String query="select STATUS from hide_show where ITEM='Profit Withdraw Ledger'";
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
                String query="select STATUS from hide_show where ITEM='Cash Debit'";
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
                String query="select STATUS from hide_show where ITEM='Cash Credit'";
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
                String query="select STATUS from hide_show where ITEM='CMC'";
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
                String query="select STATUS from hide_show where ITEM='CMD'";
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
            <div class="row">
                <div class="col-sm-12">
                 
                      <center>  <h3 style="font-family: fontawesome"><b>Admin Portal</b></h3></center>
                      <div class="row">
                          <div class="col-sm-2"></div>
                          <div class="col-sm-8">
                              <div id="checkbox-container">
                              <table border="1" space="2" class=" table table-bordered table-responsive">
                                  <col width="30%">
                                  <col width="20%">
                                  <col width="50%">
                                  <tr style="background-color: #000; color: #fff">
                                      <th>Item</th>
                                      <th>Status</th>
                                      <th>Action</th>
                                  </tr>
                                  <tr>
                                      <td><label>Profit Ledger</label></td>
                                      <td style="color: green"><b>${plstatus}</b></td>
                                      <td>
                                          <form method="post" action="ProfitShowServlet" class="form-inline">
                                              <div class="row">
                                                  <div class="col-sm-4">
                                                    <input type="radio" value="1"  name="profit" required=""> Show
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="2"  name="profit" required=""> Hide
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="submit" class="btn btn-success btn-xs" value="OK">
                                                  </div>
                                              </div>
                                         </form>
                                      </td>
                                      
                                  </tr>
                                  <tr>
                                      <td><label>Proprietor Ledger</label></td>
                                      <td style="color: green"><b>${prostatus}</b></td>
                                      <td>
                                         <form method="post" action="ProlShowServlet" class="form-inline">
                                              <div class="row">
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="1"  name="propritor" required=""> Show
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="2"  name="propritor" required=""> Hide
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="submit" class="btn btn-success btn-xs" value="OK">
                                                  </div>
                                              </div>
                                         </form>
                                      </td>
                                      
                                  </tr>
                                <tr>
                                      <td><label>Fixed Invest</label></td>
                                      <td style="color: green"><b>${fistatus}</b></td>
                                      <td>
                                          <form method="post" action="FiShowServlet" class="form-inline">
                                              <div class="row">
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="1"  name="fixed" required=""> Show
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="2"  name="fixed" required=""> Hide
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="submit" class="btn btn-success btn-xs" value="OK">
                                                  </div>
                                              </div>
                                         </form>
                                      </td>
                                      
                                  </tr>
                                <tr>
                                      <td><label>Profit Withdraw Ledger</label></td>
                                      <td style="color: green"><b>${pwstatus}</b></td>
                                      <td>
                                          <form method="post" action="PwShowServlet" class="form-inline">
                                              <div class="row">
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="1"  name="profitwith" required=""> Show
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="2"  name="profitwith" required=""> Hide
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="submit" class="btn btn-success btn-xs" value="OK">
                                                  </div>
                                              </div>
                                         </form>
                                      </td>
                                      
                                  </tr>
                                  <tr>
                                      <td><label>Cash Debit</label></td>
                                      <td style="color: green"><b>${cdstatus}</b></td>
                                      <td>
                                         <form method="post" action="DebitShowServlet" class="form-inline">
                                              <div class="row">
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="1"  name="debit" required=""> Show
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="2"  name="debit" required=""> Hide
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="submit" class="btn btn-success btn-xs" value="OK">
                                                  </div>
                                              </div>
                                         </form>
                                      </td>
                                      
                                  </tr>
                                 <tr>
                                      <td><label>Cash Credit</label></td>
                                      <td style="color: green"><b>${ccstatus}</b></td>
                                      <td>
                                         <form method="post" action="CreditShowServlet" class="form-inline">
                                              <div class="row">
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="1"  name="credit" required=""> Show
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="2"  name="credit" required=""> Hide
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="submit" class="btn btn-success btn-xs" value="OK">
                                                  </div>
                                              </div>
                                         </form>
                                      </td>
                                      
                                  </tr>
<!--                                   <tr>
                                      <td><label>CM Ledger (C)</label></td>
                                      <td style="color: green"><b>${cmcstatus}</b></td>
                                      <td>
                                         <form method="post" action="CmcShowServlet" class="form-inline">
                                              <div class="row">
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="1"  name="cmc" required=""> Show
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="2"  name="cmc" required=""> Hide
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="submit" class="btn btn-success btn-xs" value="OK">
                                                  </div>
                                              </div>
                                         </form>
                                      </td>
                                      
                                  </tr>-->
                                   <tr>
                                      <td><label>Call Money Ledger</label></td>
                                      <td style="color: green"><b>${cmdstatus}</b></td>
                                      <td>
                                         <form method="post" action="CmdShowServlet" class="form-inline">
                                              <div class="row">
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="1"  name="cmd" required=""> Show
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="radio" value="2"  name="cmd" required=""> Hide
                                                  </div>
                                                  <div class="col-sm-4">
                                                      <input type="submit" class="btn btn-success btn-xs" value="OK">
                                                  </div>
                                              </div>
                                         </form>
                                      </td>
                                      
                                  </tr>
                                 
                              </table>
                              </div>
                          </div>
                          <div class="col-sm-2"></div>
                      </div>
                      
                </div>
            </div>
            <div style="margin-top: 20%">
              <%@include file = "footerpage.jsp" %>  
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
                        <form method="POST" action="AdminPassUpServlet">
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
                                    <label>Secret Number</label>
                                    <input type="text" class="form-control input-sm" name="secnumber" required="">
                                </div>
                            </div><br>
                            <div class="row">
                                <div class="col-sm-6">
                                    <label>New-ID</label>
                                    <input type="text" class="form-control input-sm" name="newid" required="">
                                </div> 
                                <div class="col-sm-6">
                                    <label>New-Password</label>
                                    <input type="password" maxlength="6" minlength="6" class="form-control input-sm" name="newpass" required="">
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
        
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
       
            <% } %>
    </body>
</html>
