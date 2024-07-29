package com.fuhousefinder.dao;

import com.fuhousefinder.context.DBContext;
import com.fuhousefinder.entity.Tenant;
import java.sql.*;

/**
 *
 * @author Tuấn Anh
 */
public class TenantDAO extends DBContext {

    public Tenant getTenantInformationByTenantID(int tenantId) {
        String sql = "select * from Tenant where tenant_id = " + tenantId;
        Connection con;
        PreparedStatement ps;
        ResultSet rs;
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                int tenantID = rs.getInt(1);
                int userID = rs.getInt(2);
                String firstName = rs.getString(3);
                String lastName = rs.getString(4);
                String address = rs.getString(5);
                String phone = rs.getString(6);
                Tenant tenant = new Tenant(tenantID, userID, firstName, lastName, address, phone);
                return tenant;
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public int getTenantIDByUserID(int userID) {
        String sql = "select tenant_id from Tenant where user_id = " + userID;
        Connection connection = null;
        PreparedStatement ps;
        ResultSet rs = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;
    }
}
