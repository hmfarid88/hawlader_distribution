
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Model.AdminModel"%>
<%@page import="java.util.List"%>
<%@page import="Pojo.AdminPojo"%>
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
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
        <div class="container-fluid">
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
                                <li><a data-toggle="modal" data-target="#fixup"href="#"> Update</span></a></li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul> 
                        </div>
                    </nav>
                </header>
            <div class="row">
                <div class="col-sm-12">
                    <div id="div_print">
                    <center>
                        <h3 style="font-family: fontawesome"><b>Fixed Invest</b></h3>
                        <h5><b>Date : <script> document.write(new Date().toLocaleDateString('en-GB'));</script> </b></h5>
                    </center>
                        <div style="background-image: url('img/levelupbg.png')!important; background-repeat: no-repeat !important; background-size: 300px 150px !important; background-position: 50% 50% !important;">
                    <table border="2" width="100%" class="table-condensed table-responsive">
                        <thead>
                            <tr style="background-color: #CCCCCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Invest Name</th>
                                <th style="text-align: center">Amount</th>
                                <th style="text-align: center">Date</th>
                            </tr>
                        </thead>
                        <tbody>
                             <%
                                    Connection con = null;
                                    PreparedStatement ps = null;
                                    ResultSet rs = null;
                                    try {
                                        con = Database.getConnection();
                                        String query="select SI_NO, FIXED_INVEST_NAME, AMOUNT, DATE from fixed_invest";
                                        ps=con.prepareStatement(query);
                                        rs=ps.executeQuery();
                                        while(rs.next()){
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs.getString("FIXED_INVEST_NAME") %></td>
                                <th style="text-align: center"><%= rs.getFloat("AMOUNT") %></th>
                                <td style="text-align: center"><%= rs.getString("DATE") %></td>
                            </tr>
                            <% }
 }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                            %>
                        </tbody>
                        <tfoot>
                            <tr style="background-color: #CCCCCC">
                                <th style="text-align: center"></th>
                                <th style="text-align: center"></th>
                                <td style="text-align: center">Amount</td>
                                <th style="text-align: center"></th>
                            </tr>
                        </tfoot>
                    </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <div id="fixup" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Update Amount</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="FixedInvestUpServlet">
                                <div class="row">
                                    <div class="col-sm-4">
                                      <label>Select Invest</label>  
                                      <select name="investno" class="form-control" required="">
                                          <option value="">Select Any</option>
                                          <%
                                           try {
                                        con = Database.getConnection();
                                        String query="select SI_NO, FIXED_INVEST_NAME, AMOUNT from fixed_invest";
                                        ps=con.prepareStatement(query);
                                        rs=ps.executeQuery();
                                        
                                              while(rs.next()){
                                          %>
                                          <option value="<%= rs.getInt("SI_NO") %>"><%= rs.getString("FIXED_INVEST_NAME") %>, <%= rs.getFloat("AMOUNT") %></option>
                                          <% }
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
                                        <label>Update Type</label><br>
                                        <input type="radio" name="type" value="Plus" required=""> Plus
                                        <input type="radio" name="type" value="Minus" required=""> Minus
                                    </div>
                                   
                                    <div class="col-sm-4">
                                        <label>Amount</label> 
                                        <input type="number" id="rate12" style=" width: 80%" autocomplete="off" class="form-control input-sm" name="amount" required="">
                                        <input type="text" style=" width: 80%" id="total12" readonly="">
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
                    <button type="button" class="btn btn-warning btn-sm" data-dismiss="modal">Exit</button>
                </div>
            </div>  
        </div>
                                      <br><br>
        <%@include file = "footerpage.jsp" %>
    </div>
        
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
      
        <script language="javascript">
                            var addSerialNumber = function () {
                                var i = 0;
                                $('table tr').each(function (index) {
                                    $(this).find('td:nth-child(1)').html(index - 1 + 1);
                                });
                            };

                            addSerialNumber();
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
