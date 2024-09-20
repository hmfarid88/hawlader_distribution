
<%@page import="Model.DeleteModel"%>
<%@page import="java.util.List"%>
<%@page import="Pojo.DeletePojo"%>
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
                                <li><a data-toggle="collapse" data-target="#mdateview" href="#" >Date-wise-View</a></li>
                            <li>
                                <div id="mdateview" class="collapse" style="margin:10px 0px">
                                    <form  method="POST" action="datewise_emp_expense.jsp" class="form-inline">
                                        <input type="date" autocomplete="off" size="10px" class="form-control" name="date1" value="" placeholder="Start Date" required="" >
                                        <label>TO</label> <input type="date" autocomplete="off" class="form-control" size="10px" name="date2" value="" placeholder="End Date" required="" >
                                        <input type="submit" class="btn btn-primary btn-sm" value="View">
                                    </form>
                                </div>
                            </li>
                                <li><a data-toggle="modal" data-target="#exdelete" href="#">Delete Item</a></li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <li style=" margin: 15px 60px "><input class="form-control input-sm" id="myInput" type="text" placeholder="Search..."> </li>
                                <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                            </ul> 
                        </div>
                    </nav>
                </header>
            <div class="row">
                <div class="col-sm-12">
                    <div id="div_print">
                    <center>
                        <h3><b>Employee's Expense Ledger</b></h3>
                        <center><h4><div id="date"> </div> </h4></center>
                    </center>
                    <table border="2" width="100%" class="table-condensed table-responsive">
                        <thead>
                            <tr style="background-color: #CCCCCC">
                                <th style="text-align: center">SN</th>
                                <th style="text-align: center">Date</th>
                                <th style="text-align: center">Employee Name</th>
                                <th style="text-align: center">Expense Name</th>
                                <th style="text-align: center">Amount</th>
                                
                            </tr>
                        </thead>
                        <tbody id="myTable">
                            <%
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs = null;
                                try {
                                    con = Database.getConnection();
                                    String query = "select EMP_NAME, COST_NAME, AMOUNT, DATE from emp_cost where YEAR(DATE) = YEAR(CURRENT_DATE()) AND MONTH(DATE) = MONTH(CURRENT_DATE())";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    while (rs.next()) {
                            %>
                            <tr>
                                <td style="text-align: center"></td>
                                <td style="text-align: center"><%= rs.getString("DATE") %></td>
                                <td style="text-align: center"><%= rs.getString("EMP_NAME")%></td>
                                <td style="text-align: center"><%= rs.getString("COST_NAME") %></td>
                                <th style="text-align: center"><%= rs.getFloat("AMOUNT") %></th>
                                                               
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
                            <tr style=" background-color: #CCCCCC">
                               <th style="text-align: center"></th> 
                               <th style="text-align: center"></th> 
                               <th style="text-align: center"></th> 
                               <th style="text-align: center">TOTAL</th> 
                               <td style="text-align: center"></td> 
                            </tr>
                        </tfoot>
                    </table>
                    </div>
                </div>
            </div>
        </div>
       <div id="exdelete" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close btn btn-danger" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Expense Delete</h4>
                </div>
                <div class="modal-body">
                    <div class="panel panel-primary">
                        <div class="panel-body">
                            <form method="POST" action="EmpcostdelServlet" class="form-inline">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <select  style=" width: 80%" class="form-control input-sm" name="empsi" required="">
                                           <option value="">Select Expense</option>  
                                            <%
                                                DeletePojo dp = new DeletePojo();
                                                List<DeleteModel> list1 = dp.EmpcostDel();
                                                for (DeleteModel dm : list1) {
                                            %>
                                            <option value="<%= dm.getEmpsi() %>"><%= dm.getEmpname() %>, <%= dm.getEmpcost() %>, <%= dm.getEmpamount() %></option>
                            
                                            <% } %>` 
                                        </select>
                                    <input type="submit" class="btn btn-success btn-sm" value="Delete">
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
        <br><br>
        <%@include file = "footerpage.jsp" %>
        
        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        
        <script>
        window.onload = function () {
        var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
                                            ;
        var date = new Date();

        document.getElementById('date').innerHTML = months[date.getMonth()] + ' ' + date.getFullYear();
                                        };
        </script>
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
