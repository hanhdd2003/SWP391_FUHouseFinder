/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuhousefinder.dao;

import com.fuhousefinder.context.DBContext;
import com.fuhousefinder.entity.HouseModel;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hp
 */
public class WishListDao extends DBContext{
    public List<HouseModel> getWishlistHouses(int roleId) {
        List<HouseModel> houses = new ArrayList<>();
        String sql = "SELECT h.house_name, h.address, "
                + "(SELECT MIN(price) FROM ROOM WHERE house_id = h.house_id) AS min_price, "
                + "(SELECT MAX(price) FROM ROOM WHERE house_id = h.house_id) AS max_price, "
                + "(SELECT TOP 1 image_url FROM HOUSE_IMAGE WHERE house_id = h.house_id ORDER BY house_image_id ASC) AS avatar_image "
                + "FROM WISHLIST w "
                + "JOIN TENANT t ON w.tenant_id = t.tenant_id "
                + "JOIN USERS u ON t.user_id = u.user_id "
                + "JOIN HOUSE h ON w.house_id = h.house_id "
                + "WHERE u.role_id = ?";

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, roleId);

            rs = ps.executeQuery();
            while (rs.next()) {
                HouseModel house = new HouseModel();
                house.setHouse_name(rs.getString("house_name"));
                house.setAddress(rs.getString("address"));
                house.setMinPrice(rs.getDouble("min_price"));
                house.setMaxPrice(rs.getDouble("max_price"));
                house.setAvatarImage(rs.getString("avatar_image"));
                houses.add(house);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }
        return houses;
    }

    public List<HouseModel> getWishlistHouses(int roleId, int userId) {
        List<HouseModel> houses = new ArrayList<>();
        String sql = "SELECT h.status,h.house_id,h.house_name, h.address, "
                  + "(CASE WHEN EXISTS (SELECT 1 FROM WISHLIST WHERE tenant_id = ? AND house_id = h.house_id) THEN 1 ELSE 0 END) AS is_favorite ,"

                + "(SELECT MIN(price) FROM ROOM WHERE house_id = h.house_id) AS min_price, "
                + "(SELECT MAX(price) FROM ROOM WHERE house_id = h.house_id) AS max_price, "
                + "(SELECT TOP 1 image_url FROM HOUSE_IMAGE WHERE house_id = h.house_id ORDER BY house_image_id ASC) AS avatar_image "
                + "FROM WISHLIST w "
                + "JOIN TENANT t ON w.tenant_id = t.tenant_id "
                + "JOIN USERS u ON t.user_id = u.user_id "
                + "JOIN HOUSE h ON w.house_id = h.house_id "
                + "WHERE u.role_id = ?  and t.tenant_id = ?";

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, roleId);
            ps.setInt(3, userId);

            rs = ps.executeQuery();
            while (rs.next()) {
                HouseModel house = new HouseModel();
                house.setId(rs.getInt("house_id"));
                house.setHouse_name(rs.getString("house_name"));
                house.setAddress(rs.getString("address"));
                house.setMinPrice(rs.getDouble("min_price"));
                house.setMaxPrice(rs.getDouble("max_price"));
                house.setAvatarImage(rs.getString("avatar_image"));
                house.setStatus(rs.getString("status"));
                
 boolean isFavorite = rs.getInt("is_favorite") == 1;
                house.setFavorite(isFavorite);

//                house.setDistance_km(rs.getString("distance_km"));
                houses.add(house);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }
        return houses;
    }

    public boolean addFavorite(int houseId, int userid) {
        Connection connection = null;
        PreparedStatement ps = null;

        try {
            connection = getConnection();
            String sql = "INSERT INTO WISHLIST (tenant_id, house_id) VALUES (?, ?)";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, userid);
            ps.setInt(2, houseId);

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
    }

    public boolean removeFavorite(int houseId, int userid) {
        Connection connection = null;
        PreparedStatement ps = null;

        try {
            connection = getConnection();
            String sql = "DELETE FROM WISHLIST WHERE tenant_id = ? AND house_id = ?";
            ps = connection.prepareStatement(sql);
            ps.setInt(1, userid);
            ps.setInt(2, houseId);

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }

    }
}
