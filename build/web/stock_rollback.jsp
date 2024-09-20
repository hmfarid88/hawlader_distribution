
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
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
            String imei = request.getParameter("rollback");
            String cause = request.getParameter("cause");
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs=null;
            try {
                con = Database.getConnection();
                String query0="insert into stock_delete (MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, VENDOR, CAUSE, STDATE, DATE) select MODEL, COLOR, IMEI, PURCHASE_PRICE, SELL_PRICE, VENDOR, '"+ cause +"', DATE, CURDATE() from stock where IMEI=?";
                ps = con.prepareStatement(query0);
                ps.setString(1, imei);
                int p = ps.executeUpdate();
                if(p>0){
                String query00="select MODEL, PURCHASE_PRICE, VENDOR, DATE from stock where IMEI=?";
                ps = con.prepareStatement(query00);
                ps.setString(1, imei);
                rs=ps.executeQuery();
                rs.next();
                String model=rs.getString(1);
                Float pprice=rs.getFloat(2);
                String vendor=rs.getString(3);
                String date=rs.getString(4);
                String update="update company_statement set QTY=QTY-1 where COMPANY=? and MODEL=? and RATE=? and DATE=?";
                ps = con.prepareStatement(update);
                ps.setString(1, vendor);
                ps.setString(2, model);
                ps.setFloat(3, pprice);
                ps.setString(4, date);
                ps.executeUpdate();
                String delete="delete from company_statement where QTY='0' and PAYMENT='0'";
                ps = con.prepareStatement(delete);
                ps.executeUpdate();
                String query = "delete from stock where IMEI=?";
                ps = con.prepareStatement(query);
                ps.setString(1, imei);
                int a = ps.executeUpdate();
                if(a>0){
                String query1 = "delete  from vendor_stock where PRODUCT_ID=?";
                ps = con.prepareStatement(query1);
                ps.setString(1, imei);
                ps.executeUpdate();
                response.sendRedirect("totalStock.jsp");
                }
                }else{
                    out.println("<h3>Invalid Product ID</h3>");
                }
            } catch (Exception ex) {
            }finally {
   try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
   try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
   try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}


        %>
    </body>
</html>
