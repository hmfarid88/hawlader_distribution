
<%@page import="java.sql.SQLException"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="Model.CashModel"%>
<%@page import="Pojo.CashBook"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Hawlader</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/jquery-ui.css">
        <link rel="icon" type="image/png" href="img/favicon.ico">
    </head>
    <body id="main" style="background-color: #030303; color: #ffffff">
        <%
            if ((session.getAttribute("name") == null) || (session.getAttribute("name") == "")) {
        %>
    <br> <center><h3> You are not logged in</h3><br/>
        <a href="index.jsp"><button class="btn btn-success">Please Login</button></a></center>
        <%} else {
        %>
        <%
            String date1 = request.getParameter("date1");
            request.getSession().setAttribute("date1", date1);
            
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            ResultSet rss1 = null;
            ResultSet rss11 = null;
            ResultSet rss111 = null;
            ResultSet rsss1 = null;
            ResultSet rs2 = null;
            ResultSet rss2 = null;
            ResultSet rsss2 = null;
            ResultSet rssss2 = null;
            ResultSet rsssss2 = null;
            ResultSet rs99 = null;
            ResultSet rs3 = null;
            ResultSet rs33 = null;
            ResultSet rs4 = null;
            ResultSet rs5 = null;
            ResultSet rs6 = null;
            ResultSet rs7 = null;
            ResultSet rs9 = null;
            ResultSet rs10 = null;
            ResultSet rs11 = null;
            ResultSet rs12 = null;
            try {
                con = Database.getConnection();
                String query = "select AMOUNT, DATE from netbalance where DATE<'" + date1 + "' order by SI_NO DESC LIMIT 1";
                ps = con.prepareStatement(query);
                rs = ps.executeQuery();
                rs.next();
                request.setAttribute("date", rs.getString("DATE"));
                request.setAttribute("amount", rs.getLong("AMOUNT"));
            String dbt = "select DEBIT_NAME, AMOUNT, DATE from cash_debit where DATE='" + date1 + "'";
            ps = con.prepareStatement(dbt);
            rs1 = ps.executeQuery();
            String dbt1="select RETAILER, AMOUNT, PAY_TYPE, DATE from customer_pay where DATE='" + date1 + "'";
            ps = con.prepareStatement(dbt1);
            rss1 = ps.executeQuery();
            String dbt111="select RETAILER, AMOUNT, DATE from customer_pay where PAY_TYPE='Bank' and DATE='" + date1 + "'";
            ps = con.prepareStatement(dbt111);
            rss111 = ps.executeQuery();
            String dbt2="select PROP_NAME, PAY_NAME, RECEIVE, DATE from proprietor_cost where DATE='" + date1 + "' and PAY_NAME='Receive'";
            ps = con.prepareStatement(dbt2);
            rsss1 = ps.executeQuery();
            String crd = "select CREDIT_NAME, AMOUNT, DATE from cash_credit where DATE='" + date1 + "'";
            ps = con.prepareStatement(crd);
            rs2 = ps.executeQuery();
            String crd1="select COMPANY_NAME, AMOUNT, PAY_TYPE, DATE from company_payment where DATE='" + date1 + "'";
            ps = con.prepareStatement(crd1);
            rss2 = ps.executeQuery();
            String crd2="select COST_NAME, NOTE, AMOUNT, DATE from cost where DATE='" + date1 + "'";
            ps = con.prepareStatement(crd2);
            rsss2 = ps.executeQuery();
            String crd3="select EMP_NAME, COST_NAME, AMOUNT, DATE from emp_cost where DATE='" + date1 + "'";
            ps = con.prepareStatement(crd3);
            rssss2 = ps.executeQuery();
            String crd4="select PROP_NAME, PAY_NAME, PAYMENT, DATE from proprietor_cost where DATE='" + date1 + "' and PAY_NAME='Payment'";
            ps = con.prepareStatement(crd4);
            rsssss2 = ps.executeQuery();
            String query99 = "select sum(AMOUNT) from customer_pay where PAY_TYPE='Bank' and DATE='" + date1 + "'";
            ps = con.prepareStatement(query99);
            rs99 = ps.executeQuery();
            rs99.next();
            request.setAttribute("retbankpay", rs99.getLong(1));
           
              
                String query3 = "select sum(AMOUNT) from customer_pay where  DATE= '" + date1 + "' ";
                ps = con.prepareStatement(query3);
                rs3 = ps.executeQuery();
                rs3.next();
                request.setAttribute("tcpay", rs3.getLong(1));
               
                String query4 = "select sum(AMOUNT) from cash_debit where DATE= '" + date1 + "' ";
                ps = con.prepareStatement(query4);
                rs4 = ps.executeQuery();
                rs4.next();
                request.setAttribute("tdebit", rs4.getLong(1));

                String query5 = "select sum(AMOUNT) from cash_credit where DATE= '" + date1 + "' ";
                ps = con.prepareStatement(query5);
                rs5 = ps.executeQuery();
                rs5.next();
                request.setAttribute("tcredit", rs5.getLong(1));

                String query6 = "select sum(AMOUNT) from company_payment where  DATE= '" + date1 + "' ";
                ps = con.prepareStatement(query6);
                rs6 = ps.executeQuery();
                rs6.next();
                request.setAttribute("tpay", rs6.getLong(1));
                
                String query7 = "select sum(AMOUNT) from cost where DATE= '" + date1 + "' ";
                ps = con.prepareStatement(query7);
                rs7 = ps.executeQuery();
                rs7.next();
                request.setAttribute("tcost", rs7.getLong(1));
                                          
                String query9 = "select sum(AMOUNT) from emp_cost where DATE= '" + date1 + "' ";
                ps = con.prepareStatement(query9);
                rs9 = ps.executeQuery();
                rs9.next();
                request.setAttribute("empcost", rs9.getLong(1));
                
                String query10 = "select sum(RECEIVE) from proprietor_cost where DATE= '" + date1 + "' ";
                    ps = con.prepareStatement(query10);
                    rs10 = ps.executeQuery();
                    rs10.next();
                    request.setAttribute("prorecv", rs10.getLong(1));
                    
            String query11 = "select sum(PAYMENT) from proprietor_cost where DATE= '" + date1 + "' ";
            ps = con.prepareStatement(query11);
            rs11 = ps.executeQuery();
            rs11.next();
            request.setAttribute("propay", rs11.getLong(1));
         String query12 = "select AMOUNT from netbalance where DATE<'" + date1 + "' order by SI_NO DESC LIMIT 1 ";
                                        ps=con.prepareStatement(query12);
                                        rs12 = ps.executeQuery();
                                        rs12.next();
         Long totalreceive=rs3.getLong(1)+rs4.getLong(1)+rs10.getLong(1)+rs12.getLong(1);
         Long totalpayment=rs5.getLong(1)+rs6.getLong(1)+rs7.getLong(1)+rs9.getLong(1)+rs11.getLong(1)+rs99.getLong(1);
         Long nbl=totalreceive-totalpayment;
         String balanceup="update netbalance set AMOUNT=? where DATE=?";
                ps=con.prepareStatement(balanceup);
                ps.setDouble(1, nbl);
                ps.setString(2, date1);
                ps.executeUpdate();
        %>
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
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#" name="b_print"  onClick="printdiv('div_print')"><span class="glyphicon glyphicon-print"></span> Print</a></li>
                    </ul> 
                </div>
            </nav>
        </header>

        <div class="row">

            <div class="col-sm-12">
                <div id="div_print" style="background-color: #030303; color: #ffffff">
                    <center>
                        <h3 style="font-family: fontawaesome" class="text-primary text-center"><b>Cash-Book</b></h3>
                        <h4><b>Date : ${date1}</b></h4>
                     
                        <table  border="2" width="90%" class="table-bordered table-responsive" >
                            <thead>
                                <tr>
                                    <th style="text-align: center">Date</th>
                                    <th style="text-align: center">Description</th>
                                    <th style="text-align: center">Debit Amount</th>
                                    <th style="text-align: center">Credit Amount</th>

                                </tr>
                            </thead>
                            <tbody>
                              
                                <tr>
                                    <th style="text-align: center">${date}</th>
                                    <th style="text-align: center">Balance B/D</th>
                                    <th style="text-align: center">${amount}</th>
                                    <td></td>
                               <%
                                   
                               while (rs1.next()) {
            
                                %>
                                <tr>   
                                    <td style="text-align: center"><%=rs1.getString("DATE") %></td> 
                                    <td style="text-align: center">(DR) <%=rs1.getString(1) %></td> 
                                    <td style="text-align: center"><%= rs1.getLong(2) %></td> 
                                    <td></td> 
                                </tr>
                                <%
                                   }
                               while (rss1.next()) {
            
                                %>
                                <tr>   
                                    <td style="text-align: center"><%=rss1.getString("DATE") %></td> 
                                    <td style="text-align: center"><%=rss1.getString(1) %> (Payment Type <%=rss1.getString(3) %>)</td> 
                                    <td style="text-align: center"><%= rss1.getLong(2) %></td> 
                                    <td></td> 
                                </tr>
                               
                                <%
                                   }
                               while (rsss1.next()) {
            
                                %>
                                <tr>   
                                    <td style="text-align: center"><%=rsss1.getString("DATE") %></td> 
                                    <td style="text-align: center"><%=rsss1.getString(2) %> from <%=rsss1.getString(1) %></td> 
                                    <td style="text-align: center"><%= rsss1.getLong(3) %></td> 
                                    <td></td> 
                                </tr>
                                <%  }
                                   while (rs2.next()) {
                                %>
                                <tr>
                                    <td style="text-align: center"><%=rs2.getString("DATE") %></td> 
                                    <td style="text-align: center">(CR) <%=rs2.getString(1) %></td> 
                                    <td></td>
                                    <td style="text-align: center"><%=rs2.getLong(2)%></td> 
                                </tr>
                                <%  }
                                   while (rss2.next()) {
                                %>
                                <tr>
                                    <td style="text-align: center"><%=rss2.getString("DATE") %></td> 
                                    <td style="text-align: center"><%=rss2.getString(1) %> (Payment Type <%= rss2.getString(3) %>)</td> 
                                    <td></td>
                                    <td style="text-align: center"><%=rss2.getLong(2)%></td> 
                                </tr>
                                 <%  }
                                   while (rss111.next()) {
                                %>
                                <tr>
                                    <td style="text-align: center"><%=rss111.getString("DATE") %></td> 
                                    <td style="text-align: center"><%=rss111.getString(1) %> by Bank</td> 
                                    <td></td>
                                    <td style="text-align: center"><%=rss111.getLong(2)%></td> 
                                </tr>
                                <%  }
                                   while (rsss2.next()) {
                                %>
                                <tr>
                                    <td style="text-align: center"><%=rsss2.getString("DATE") %></td> 
                                    <td style="text-align: center"><%=rsss2.getString(1) %> (<%=rsss2.getString(2) %>)</td> 
                                    <td></td>
                                    <td style="text-align: center"><%=rsss2.getLong(3)%></td> 
                                </tr>
                                <%  }
                                   while (rssss2.next()) {
                                %>
                                <tr>
                                    <td style="text-align: center"><%=rssss2.getString("DATE") %></td> 
                                    <td style="text-align: center"><%=rssss2.getString(1) %> For <%=rssss2.getString(2) %></td> 
                                    <td></td>
                                    <td style="text-align: center"><%=rssss2.getLong(3)%></td> 
                                </tr>
                                <%  }
                                   while (rsssss2.next()) {
                                %>
                                <tr>
                                    <td style="text-align: center"><%=rsssss2.getString("DATE") %></td> 
                                    <td style="text-align: center"><%=rsssss2.getString(2) %> to <%=rsssss2.getString(1) %></td> 
                                    <td></td>
                                    <td style="text-align: center"><%=rsssss2.getLong(3)%></td> 
                                </tr>
                                                                
                                <% }
                        } catch (Exception ex) {
            } finally {
try { if (rs12 != null) rs12.close(); rs12=null; } catch (SQLException ex2) { }
try { if (rs11 != null) rs11.close(); rs11=null; } catch (SQLException ex2) { }
try { if (rs10 != null) rs10.close(); rs10=null; } catch (SQLException ex2) { }
try { if (rs9 != null) rs9.close(); rs9=null; } catch (SQLException ex2) { }
try { if (rs7 != null) rs7.close(); rs7=null; } catch (SQLException ex2) { }
try { if (rs6 != null) rs6.close(); rs6=null; } catch (SQLException ex2) { }
try { if (rs5 != null) rs5.close(); rs5=null; } catch (SQLException ex2) { }
try { if (rs4 != null) rs4.close(); rs4=null; } catch (SQLException ex2) { }
try { if (rs33 != null) rs33.close(); rs33=null; } catch (SQLException ex2) { }
try { if (rs3 != null) rs3.close(); rs3=null; } catch (SQLException ex2) { }
try { if (rs99 != null) rs99.close(); rs99=null; } catch (SQLException ex2) { }
try { if (rsssss2 != null) rsssss2.close(); rsssss2=null; } catch (SQLException ex2) { }
try { if (rssss2 != null) rssss2.close(); rssss2=null; } catch (SQLException ex2) { }
try { if (rsss2 != null) rsss2.close(); rsss2=null; } catch (SQLException ex2) { }
try { if (rss2 != null) rss2.close(); rss2=null; } catch (SQLException ex2) { }
try { if (rs2 != null) rs2.close(); rs2=null; } catch (SQLException ex2) { }
try { if (rsss1 != null) rsss1.close(); rsss1=null; } catch (SQLException ex2) { }
try { if (rss111 != null) rss111.close(); rss111=null; } catch (SQLException ex2) { }
try { if (rss11 != null) rss11.close(); rss11=null; } catch (SQLException ex2) { }
try { if (rss1 != null) rss1.close(); rss1=null; } catch (SQLException ex2) { }
try { if (rs1 != null) rs1.close(); rs1=null; } catch (SQLException ex2) { }
try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }   
try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
%>
                                <tr style="border-bottom-color: black">
                                    <th style="text-align: center;border-left-style: hidden"></th>
                                    <th style="text-align: center;border-left-style: hidden"></th>
                                    <th style="text-align: center;border-left-style: hidden"><u>${amount+tcpay+tdebit+prorecv}</u></th>
                                    <th style="text-align: center;border-left-style: hidden;border-right-style: hidden"><u>${tcredit+tpay+tcost+empcost+propay+retbankpay}</u></th>
                                </tr>
                                <tr style="border-style: hidden">
                                    <th style="text-align: center;border-style: hidden"></th>
                                    <th style="text-align: center;border-style: hidden">Nit Balance</th>
                                    <th style="text-align: center;border-style: hidden"><u>${(amount+tcpay+tdebit+prorecv)-(tcredit+tpay+tcost+empcost+propay+retbankpay)}</u></th>
                                    <th style="text-align: center;border-style: hidden"></th>
                                </tr>
                            </tbody>
                        </table>
                     
                    </center>
                </div>
            </div>

        </div>

        <br><br>
        <%@include file = "footerpage.jsp" %>

        <script src="js/jquery-3.1.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        
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
