<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="DB.Database"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    </head>
    <body>
        <%
            String vendor = request.getParameter("vendor");
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            try {
                con = Database.getConnection();
                String query1 = "select count(*) from vendor where VENDOR_NAME=? ";
                ps = con.prepareStatement(query1);
                ps.setString(1, vendor);
                rs = ps.executeQuery();
                rs.next();
                int a = rs.getInt(1);
                if (a > 0) {
                    out.println("<h3>Sorry ! This Vendor is Exist, Input another Vendor</h3>");
                } else {
                    String query = "insert into vendor (VENDOR_NAME)  values (?)";
                    ps = con.prepareStatement(query);
                    ps.setString(1, vendor);
                    int b = ps.executeUpdate();
                    if (b > 0) {
                        response.sendRedirect("model_colorEntry.jsp");
                    } else {
                        out.println("Sorry! Entry is not Success");
                    }
                }
            } catch (SQLException ex) {

            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}

        %>
    </body>
</html>
