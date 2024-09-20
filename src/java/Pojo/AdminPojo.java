/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Pojo;

import DB.Database;
import Model.AdminModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Acer
 */
public class AdminPojo {
    
   public List<AdminModel> EmpShow() {
        List<AdminModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, E_NAME, F_NAME, ADDRESS, P_NUMBER, DESIGANATION from employee_info ";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             AdminModel am=new AdminModel();
             am.setEsi(rs.getInt(1));
             am.setEname(rs.getString(2));
             am.setFname(rs.getString(3));
             am.setEmpaddress(rs.getString(4));
             am.setEmpphone(rs.getString(5));
             am.setEmpdesi(rs.getString(6));
                         
             list.add(am);
            }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    }
   
    public List<AdminModel> RetailerShow() {
        List<AdminModel> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = Database.getConnection();
            String query = "select SI_NO, R_NAME, ADDRESS, M_NUMBER, LIMIT_AMOUNT from retailer_info order by R_NAME";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
             AdminModel am=new AdminModel();
             am.setRsi(rs.getInt(1));
             am.setRname(rs.getString(2));
             am.setArea(rs.getString(3));
             am.setMnumber(rs.getString(4));
             am.setDuelimit(rs.getFloat(5));
             list.add(am);
            }
            }catch (SQLException ex) {
            ex.printStackTrace();
        }finally {
  try { if (rs != null) rs.close(); rs=null; } catch (SQLException ex2) { }
  try { if (ps != null) ps.close(); ps=null; } catch (SQLException ex2) { }
  try { if (con != null) con.close(); con=null; } catch (SQLException ex2) { }
}
        return list;
    }   
    
}
