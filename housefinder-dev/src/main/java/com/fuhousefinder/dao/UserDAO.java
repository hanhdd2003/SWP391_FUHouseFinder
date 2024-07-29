package com.fuhousefinder.dao;

import com.fuhousefinder.configs.Config;
import com.fuhousefinder.entity.*;
import com.fuhousefinder.context.DBContext;
import java.sql.*;
import java.util.*;
import java.util.logging.*;

public class UserDAO extends DBContext implements IUser {

    @Override
    public List<User> getAll() {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<User> list = new ArrayList<>();
        try {
            connection = getConnection();
            String strSelect = "SELECT USERS.*, AVATAR.AVATAR_URL FROM AVATAR "
                    + "INNER JOIN USERS ON AVATAR.USER_ID = USERS.USER_ID "
                    + "WHERE USERS.IS_BAN = 0";
            stm = connection.prepareStatement(strSelect);
            rs = stm.executeQuery();
            while (rs.next()) {
                User user = new User(rs.getInt("user_id"),
                        rs.getString("email"),
                        rs.getString("hashed_password"),
                        rs.getString("salt"),
                        rs.getString("status"),
                        rs.getInt("role_id"),
                        rs.getString("avatar_url"));
                list.add(user);
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
//            Logger logger = Logger.getLogger(User.class.getName());
//            logger.log(Level.SEVERE,"");
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return list;
    }

    @Override
    public void changePassword(String email, String hased_password, String salt) {
        Connection connection = null;
        PreparedStatement stm = null;
        try {
            connection = getConnection();
            String sql = "update Users set hashed_password = ?, salt = ? where email = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, hased_password);
            stm.setString(2, salt);
            stm.setString(3, email);
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeStatement(stm);
            closeConnection(connection);
        }
    }

    @Override
    public void addUser(User u, String firstname, String lastName, String address, String phone) {
        PreparedStatement stm = null;
        Connection connection = null;
        try {
            connection = getConnection();
            String table = (u.getRoleId() == 2) ? "Landlord" : "Tenant";
            // Tạo câu lệnh SQL gộp
            String sql = "DECLARE @userID INT; "
                    + "INSERT INTO Users (email, hashed_password, salt, status, role_id, is_ban) VALUES (?,?,?,?,?,0); "
                    + "SET @userID = SCOPE_IDENTITY(); "
                    + "INSERT INTO " + table + " (user_id, first_name, last_name, address, phone) VALUES (@userID, ?, ?, ?, ?); "
                    + "INSERT INTO Avatar (user_id, avatar_url) VALUES (@userID, 'macdinh.jpg')"; // Thêm vào bảng Avatar
            //System.out.println(sql);
            stm = connection.prepareStatement(sql);
            stm.setString(1, u.getEmail());
            stm.setString(2, u.getHashed_password());
            stm.setString(3, u.getSalt());
            stm.setString(4, u.getStatus());
            stm.setInt(5, u.getRoleId());
            stm.setString(6, firstname);
            stm.setString(7, lastName);
            stm.setString(8, address);
            stm.setString(9, phone);

            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeStatement(stm);
            closeConnection(connection);
        }
    }

    @Override
    public void addUserGmail(User u, String firstname, String lastName, String address, String phone) {
        PreparedStatement stm = null;
        Connection connection = null;
        try {
            connection = getConnection();
            String table = (u.getRoleId() == 2) ? "Landlord" : "Tenant";
            // Tạo câu lệnh SQL gộp
            String sql = "DECLARE @userID INT; "
                    + "INSERT INTO Users (email, hashed_password, salt, status, role_id,is_ban) VALUES (?,?,?,?,?,0); "
                    + "SET @userID = SCOPE_IDENTITY(); "
                    + "INSERT INTO " + table + " (user_id, first_name, last_name, address, phone) VALUES (@userID, ?, ?, ?, ?); "
                    + "INSERT INTO Avatar (user_id, avatar_url) VALUES (@userID, ?)"; // Thêm vào bảng Avatar
            //System.out.println(sql);
            stm = connection.prepareStatement(sql);
            stm.setString(1, u.getEmail());
            stm.setString(2, u.getHashed_password());
            stm.setString(3, u.getSalt());
            stm.setString(4, u.getStatus());
            stm.setInt(5, u.getRoleId());
            stm.setString(6, firstname);
            stm.setString(7, lastName);
            stm.setString(8, address);
            stm.setString(9, phone);
            stm.setString(10, u.getAvatarUrl());
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeStatement(stm);
            closeConnection(connection);
        }
    }

    @Override
    public Profile getProfile(int user_Id, int roleId) {
        PreparedStatement stm = null;
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String table;
            String idColumn;
            switch (roleId) {
                case 1:
                    table = "admin";
                    idColumn = "admin_id";
                    break;
                case 2:
                    table = "landlord";
                    idColumn = "landlord_id";
                    break;
                default:
                    table = "tenant";
                    idColumn = "tenant_id";
                    break;
            }
            String strSelect = "SELECT O." + idColumn + ", O.user_id, O.first_name,"
                    + " O.LAST_NAME, O.ADDRESS, O.PHONE, USERS.role_id FROM " + table + " O INNER JOIN  USERS ON O.USER_ID = USERS.USER_ID where USERS.user_id = ?";
            //System.out.println(strSelect);
            stm = connection.prepareStatement(strSelect);
            stm.setInt(1, user_Id);
            rs = stm.executeQuery();
            while (rs.next()) {
                Profile p = new Profile(rs.getInt(idColumn),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getInt("role_id"),
                        rs.getInt("user_id"));
                return p;
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return null;
    }

    // - update ACCOUNT
    @Override
    public boolean editProfile(int roleId, String firstName, String lastName, String address, String phoneNumber, int id) {
        PreparedStatement stm = null;
        Connection connection = null;
        String table;
        switch (roleId) {
            case 1:
                table = "admin";
                break;
            case 2:
                table = "landlord";
                break;
            default:
                table = "tenant";
                break;
        }
        String strUpdate = "UPDATE " + table + " SET [first_name] = ?, last_name = ?, [address] =?, phone = ? WHERE user_id =?";

        try {
            connection = getConnection();
            stm = connection.prepareStatement(strUpdate);
            stm.setString(1, firstName);
            stm.setString(2, lastName);
            stm.setString(3, address);
            stm.setString(4, phoneNumber);
            stm.setInt(5, id);
            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeStatement(stm);
            closeConnection(connection);
        }
        return false;
    }

    @Override
    public void editAvatar(int userId, String avatarUrl) {
        PreparedStatement stm = null;
        Connection connection = null;
        String strUpdate;
        User u = this.getUserById(userId);
        System.out.println(u.getEmail());
        try {
            connection = getConnection();
            if (u.getHashed_password() != null) {
                strUpdate = "UPDATE Avatar SET avatar_url = ? WHERE user_id = ?";

                stm = connection.prepareStatement(strUpdate);
                stm.setString(1, avatarUrl);
                stm.setInt(2, userId);
                stm.executeUpdate();
            } else {
                strUpdate = "UPDATE Avatar SET avatar_url = ? WHERE user_id = ?;"
                        + "update USERS set hashed_password = '1' where user_id = ?";

                stm = connection.prepareStatement(strUpdate);
                stm.setString(1, avatarUrl);
                stm.setInt(2, userId);
                stm.setInt(3, u.getId());
                stm.executeUpdate();
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeStatement(stm);
            closeConnection(connection);
        }

    }

    @Override
    public String getSaltByEmail(String email) {
        PreparedStatement stm = null;
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String sql = "SELECT * FROM users where email = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getString("salt");
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return "";
    }

    @Override
    public String getHashed_Password(String email) {
        PreparedStatement stm = null;
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String sql = "SELECT * FROM users where email = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getString("hashed_password");
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return "";
    }

    @Override
    public boolean checkExistEmail(String email) {
        PreparedStatement stm = null;
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String sql = "SELECT * FROM users where email = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            rs = stm.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return false;
    }

    @Override
    public boolean checkExistPhone(String phone) {
        PreparedStatement stm = null;
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String sql = "SELECT 'admin' AS user_type, phone FROM admin WHERE phone = ? "
                    + "UNION ALL "
                    + "SELECT 'tenant' AS user_type, phone FROM tenant WHERE phone = ? "
                    + "UNION ALL "
                    + "SELECT 'landlord' AS user_type, phone FROM landlord WHERE phone = ?;";
            stm = connection.prepareStatement(sql);
            stm.setString(1, phone);
            stm.setString(2, phone);
            stm.setString(3, phone);
            rs = stm.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return false;
    }

    @Override
    public User getUserByEmail(String email) {
        List<User> ls = this.getAll();
        for (User l : ls) {
            if (l.getEmail().equals(email)) {
                return l;
            }
        }
        return null;
    }

    @Override
    public User getUserById(int user_id) {
        List<User> ls = this.getAll();
        for (User l : ls) {
            if (l.getId() == user_id) {
                return l;
            }
        }
        return null;
    }

    @Override
    public void verifyAccount(String email) {
        Connection connection = null;
        PreparedStatement stm = null;
        try {
            connection = getConnection();
            String sql = "update USERS set status = N'Đã xác minh' where email = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeStatement(stm);
            closeConnection(connection);
        }

    }

    @Override
    public boolean checkBan(String email) {
        PreparedStatement stm = null;
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String sql = "select * from users where email = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getBoolean("is_ban");
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return false;
    }

    @Override
    public List<ManageUser> getUserForAdmin() {
        List<ManageUser> list = new ArrayList<>();
        //list = this.getAdmin(list);
        list = this.getLandlord(list);
        list = this.getTenant(list);

        return list;
    }

    @Override
    public ManageUser getManageUser(String email) {
        List<ManageUser> list = this.getUserForAdmin();
        for (ManageUser manageUser : list) {
            if (manageUser.getEmail().equals(email)) {
                return manageUser;
            }
        }
        return null;
    }

    @Override
    public List<ManageUser> getLandlord(List<ManageUser> list) {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String strSelect = "SELECT USERS.user_id, LANDLORD.first_name, LANDLORD.last_name, USERS.email, LANDLORD.phone, "
                    + "LANDLORD.address, USERS.role_id, USERS.status, USERS.is_ban, AVATAR.avatar_url, USERS.hashed_password "
                    + "FROM AVATAR INNER JOIN "
                    + "USERS ON AVATAR.user_id = USERS.user_id INNER JOIN "
                    + "LANDLORD ON USERS.user_id = LANDLORD.user_id";
            stm = connection.prepareStatement(strSelect);
            rs = stm.executeQuery();
            while (rs.next()) {
                ManageUser u = new ManageUser(
                        rs.getInt("user_id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getInt("role_id"),
                        rs.getString("status"),
                        rs.getBoolean("is_ban"),
                        rs.getString("avatar_url"),
                        rs.getString("hashed_password"));
                list.add(u);
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return list;
    }

    @Override
    public List<ManageUser> getTenant(List<ManageUser> list) {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String strSelect = "SELECT USERS.user_id, TENANT.first_name, TENANT.last_name, USERS.email, TENANT.phone, TENANT.address, USERS.role_id, USERS.status, USERS.is_ban, AVATAR.avatar_url , USERS.hashed_password "
                    + "FROM AVATAR INNER JOIN "
                    + "USERS ON AVATAR.user_id = USERS.user_id INNER JOIN "
                    + "TENANT ON USERS.user_id = TENANT.user_id";
            stm = connection.prepareStatement(strSelect);
            rs = stm.executeQuery();
            while (rs.next()) {
                ManageUser u = new ManageUser(
                        rs.getInt("user_id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getInt("role_id"),
                        rs.getString("status"),
                        rs.getBoolean("is_ban"),
                        rs.getString("avatar_url"),
                        rs.getString("hashed_password"));
                list.add(u);
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return list;
    }

    @Override
    public List<ManageUser> getAdmin(List<ManageUser> list) {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String strSelect = "SELECT USERS.user_id, ADMIN.first_name, ADMIN.last_name, USERS.email, ADMIN.phone, ADMIN.address, USERS.role_id, USERS.status, USERS.is_ban, AVATAR.avatar_url , USERS.hashed_password"
                    + " FROM ADMIN INNER JOIN "
                    + "USERS ON ADMIN.user_id = USERS.user_id INNER JOIN "
                    + "AVATAR ON USERS.user_id = AVATAR.user_id";
            stm = connection.prepareStatement(strSelect);
            rs = stm.executeQuery();
            while (rs.next()) {
                ManageUser u = new ManageUser(
                        rs.getInt("user_id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getInt("urlrole_id"),
                        rs.getString("status"),
                        rs.getBoolean("is_ban"),
                        rs.getString("avatar_"),
                        rs.getString("hashed_password"));
                list.add(u);
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return list;
    }

    @Override
    public void banUser(String email, int statusBan) {
        Connection connection = null;
        PreparedStatement stm = null;
        try {
            connection = getConnection();
            String sql = "update USERS set is_ban = ? where email = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, statusBan);
            stm.setString(2, email);
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeStatement(stm);
            closeConnection(connection);
        }
    }

    @Override
    public User getByAllId(String id) {
        PreparedStatement stm = null;
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String sql = "SELECT u.user_id, u.email, u.hashed_password, u.salt, u.status, u.role_id,  "
                    + "l.first_name, l.last_name, l.address, l.phone, l.landlord_id, h.house_id "
                    + "FROM users u "
                    + "JOIN landlord l ON u.user_id = l.user_id "
                    + "LEFT JOIN house h ON l.landlord_id = h.landlord_id "
                    + "WHERE h.house_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setHashed_password(rs.getString("hashed_password"));
                user.setSalt(rs.getString("salt"));
                user.setStatus(rs.getString("status"));
                user.setRoleId(rs.getInt("role_id"));

                LandlordMder landlordMder = new LandlordMder();
                landlordMder.setId(rs.getInt("landlord_id"));
                landlordMder.setFirst_name(rs.getString("first_name"));
                landlordMder.setLast_name(rs.getString("last_name"));
                landlordMder.setAddress(rs.getString("address"));
                landlordMder.setPhone(rs.getString("phone"));

                user.setLandlordMder(landlordMder);

                if (rs.getInt("house_id") > 0) {
                    return user; // User có nhà
                } else {
                    return null; // User không có nhà
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return null;
    }

    @Override
    public User getByAllIdss(String id) {
        PreparedStatement stm = null;
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String sql = "SELECT u.user_id, u.email, u.hashed_password, u.salt, u.status, u.role_id, "
                    + "l.first_name, l.last_name, l.address, l.phone, l.landlord_id "
                    + "FROM users u "
                    + "JOIN landlord l ON u.user_id = l.user_id "
                    + "WHERE u.user_id = ?";

            stm = connection.prepareStatement(sql);
            stm.setString(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                User user = new User();

                LandlordMder landlordMder = new LandlordMder();
                landlordMder.setId(rs.getInt("landlord_id"));

                user.setLandlordMder(landlordMder);

                return user;

            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return null;
    }

    public User getByAllIdsAdmin() {
        PreparedStatement stm = null;
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String sql = " SELECT u.user_id, u.email,\n"
                    + "                    a.first_name, a.last_name, a.address, a.phone\n"
                    + "                    FROM Users u \n"
                    + "                    JOIN Admin a ON a.user_id = u.user_id \n"
                    + "				 \n"
                    + "                    WHERE role_id ='1'";

            stm = connection.prepareStatement(sql);

            rs = stm.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setFname(rs.getString("first_name"));
                user.setLname(rs.getString("last_name"));
                user.setAdd(rs.getString("address"));
                user.setPhone(rs.getString("phone"));

                return user;

            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return null;
    }

    @Override
    public ManageUser getManageUserByUserID(int userID) {
        List<ManageUser> list = this.getUserForAdmin();
        for (ManageUser manageUser : list) {
            if (manageUser.getUser_id() == userID) {
                return manageUser;
            }
        }
        return null;
    }

    @Override
    public String getEmailByLandlordId(int landLordId) {
        PreparedStatement stm = null;
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String sql = "SELECT USERS.email "
                    + "FROM  LANDLORD INNER JOIN "
                    + "USERS ON LANDLORD.user_id = USERS.user_id "
                    + "where landlord_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, landLordId);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getString("email");
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return "";
    }

    @Override
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

    @Override
    public int getLandlordByUserID(int userID) {
        String sql = "select landlord_id from LANDLORD where user_id = " + userID;
        Connection connection = null;
        PreparedStatement ps;
        ResultSet rs = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt("landlord_id");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;
    }

    @Override
    public int getLandlordIdByEmail(String email) {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String strSelect = "SELECT LANDLORD.landlord_id, USERS.email "
                    + "FROM LANDLORD INNER JOIN "
                    + "USERS ON LANDLORD.user_id = USERS.user_id "
                    + " where users.email =  ?";
            stm = connection.prepareStatement(strSelect);
            stm.setString(1, email);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt("landlord_id");
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
//            Logger logger = Logger.getLogger(User.class.getName());
//            logger.log(Level.SEVERE,"");
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return -1;
    }

    @Override
    public String getEmailByMd5(String emailMd5) {
        PreparedStatement stm = null;
        Connection connection = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String sql = "SELECT * FROM users where USERS.IS_BAN = 0";
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            String email;
            while (rs.next()) {
                email = rs.getString("email");
                if (Config.md5(email).equals(emailMd5)) {
                    return email;
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return null;
    }

    public static void main(String[] args) {
        UserDAO userDao = new UserDAO();

//        int landlord_id = userDao.getLandlordByUserID(u.getId());
//        System.out.println(landlord_id);
    }

    @Override
    public ManageUser getManageUserByLandlordID(int landlordID) {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String strSelect = "SELECT USERS.user_id, LANDLORD.first_name, LANDLORD.last_name, USERS.email, LANDLORD.phone, "
                    + "LANDLORD.address, USERS.role_id, USERS.status, USERS.is_ban, AVATAR.avatar_url, USERS.hashed_password "
                    + "FROM AVATAR INNER JOIN "
                    + "USERS ON AVATAR.user_id = USERS.user_id INNER JOIN "
                    + "LANDLORD ON USERS.user_id = LANDLORD.user_id "
                    + "WHERE LANDLORD.landlord_id = ?";
            stm = connection.prepareStatement(strSelect);
            stm.setInt(1, landlordID);
            rs = stm.executeQuery();
            while (rs.next()) {
                ManageUser u = new ManageUser(
                        rs.getInt("user_id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getInt("role_id"),
                        rs.getString("status"),
                        rs.getBoolean("is_ban"),
                        rs.getString("avatar_url"),
                        rs.getString("hashed_password"));
                return u;
                
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return null;
    }

}
