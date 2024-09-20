
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DB.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    </head>
    <body>
        <%
            String coname = request.getParameter("coname");
            String address = request.getParameter("address");
            String number = request.getParameter("number");
            String mail = request.getParameter("mail");

            Connection con = null;
            PreparedStatement ps = null;

            try {
                con = Database.getConnection();
                String query = "update companyinfo set COMPANY_NAME='" + coname + "', ADDRESS='" + address + "', PHONE_NUMBER='" + number + "', EMAIL='" + mail + "', DATE=CURDATE() ";
                     
                ps = con.prepareStatement(query);
                int a = ps.executeUpdate();
              
                if (a > 0) {
                    response.sendRedirect("company_info.jsp");
                } else {
                    out.print("Sorry! Data is not Updated");
                }
            } catch (SQLException ex) {
            }finally {
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

        %>
    </body>
</html>
