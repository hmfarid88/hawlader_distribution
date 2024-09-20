
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
    <body id="main">
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
        <%
        int month=Integer.parseInt(request.getParameter("month"));
        int year=Integer.parseInt(request.getParameter("year"));
        request.setAttribute("month", month);
        request.setAttribute("year", year);
        Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                ResultSet rs1 = null;
               
                try {
                    con = Database.getConnection();
                    String query = "select FACTORY_NAME, MONTH, YEAR, AMOUNT, NOTE, DATE from fac_commission where YEAR=? AND MONTH=? order by FACTORY_NAME";
                    ps = con.prepareStatement(query);
                    ps.setInt(1, year);
                    ps.setInt(2, month);
                    rs=ps.executeQuery();
                    
                    String query1 = "select SI_NO, FACTORY_NAME, AMOUNT from fac_commission where YEAR=? AND MONTH=? order by FACTORY_NAME";
                    ps = con.prepareStatement(query1);
                    ps.setInt(1, year);
                    ps.setInt(2, month);
                    rs1=ps.executeQuery();
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
                            <li><a href="#" data-toggle="modal" data-target="#faccomup">Update</a></li>
                           
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                             <li style=" margin: 15px 60px "><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li>
                            <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                        </ul> 
                    </div>
                </nav>
            </header>
       <div id="faccomup" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
               
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="FacComUpServlet">
                                <select class="form-control input-sm" name="facsi" required="" style="width: 60%">
                                        <option value="">Select Company</option>
                                        <% 
                                        while(rs1.next()){
                                        %>
                                        <option value="<%= rs1.getInt(1) %>"><%= rs1.getString(2) %> (<%= rs1.getFloat(3) %>)</option>
                                        <% } %>
                                    </select> <br>
                                    <label>Select Type</label> :<br>
                                    <input type="radio" name="type" value="Plus" required=""> <label>Plus</label>
                                    <input type="radio" name="type" value="Minus" required=""> <label>Minus</label><br>
                                    <label>Amount</label><br>
                                    <input type="number" name="amount" class="form-control input-sm" required="" style="width: 60%"><br>
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
            <div id="div_print">
                <center>
                    <h3>Company Commission Report</h3>
                    <center><h4>Month ${month}, ${year}</h4></center>
                </center>
                <table border="2" width="100%" class="table-striped table-responsive">
                    <thead>
                        <tr style="background-color: #CCC">
                            <th style="text-align: center">SN</th>
                            <th style="text-align: center">Company Name</th>
                            <th style="text-align: center">Month</th>
                            <th style="text-align: center">Year</th>
                            <th style="text-align: center">Amount</th>
                            <th style="text-align: center">Note</th>
                            <th style="text-align: center">Entry Date</th>
                        </tr>
                    </thead>
                    <tbody id="myTable">
                        <%
                        while(rs.next()){
                        %>
                        <tr>
                            <td style="text-align: center"></td>
                            <td style="text-align: center"><%= rs.getString(1) %></td>
                            <td style="text-align: center"><%= rs.getInt(2) %></td>
                            <td style="text-align: center"><%= rs.getString(3) %></td>
                            <th style="text-align: center"><%= rs.getFloat(4) %></th>
                            <td style="text-align: center"><%= rs.getString(5) %></td>
                            <td style="text-align: center"><%= rs.getString(6) %></td>
                           
                        <% } 
                        }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }  
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
                        %>
                        </tr> 
                    </tbody>
                    <tfoot>
                       <tr style="background-color: #CCC">
                            <th style="text-align: center"></th>
                            <th style="text-align: center"></th>
                            <th style="text-align: center"></th>
                            <th style="text-align: center">TOTAL</th>
                            <td style="text-align: center"></td>
                            <th style="text-align: center"></th>
                            <th style="text-align: center"></th>
                        </tr> 
                    </tfoot>
                </table>
            </div>
        </div>
        <br><br>
        <%@include file = "footerpage.jsp" %>

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
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
    });
    $('table thead th').each(function(i) {
                calculateColumn(i);
            });
            function calculateColumn(index) {
            var total = 0;
            $('table tr').each(function() {
                var value = parseInt($('th:visible', this).eq(index).text());
                if (!isNaN(value)) {
                    total += value;
                }
            });
            $('table tfoot td').eq(index).text(total);
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
