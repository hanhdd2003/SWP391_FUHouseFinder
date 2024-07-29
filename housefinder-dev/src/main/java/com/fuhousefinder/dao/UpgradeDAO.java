package com.fuhousefinder.dao;

import com.fuhousefinder.context.DBContext;
import com.fuhousefinder.entity.*;
import java.sql.*;
import java.util.*;
import java.util.logging.*;

public class UpgradeDAO extends DBContext implements IUpgrade {

    @Override
    public List<Upgrade> getAll() {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Upgrade> list = new ArrayList<>();
        try {
            connection = getConnection();
            String strSelect = "SELECT * FROM UPGRADE";
            stm = connection.prepareStatement(strSelect);
            rs = stm.executeQuery();
            while (rs.next()) {
                Upgrade upgrade = new Upgrade(
                        rs.getInt("upgrade_id"),
                        rs.getString("type"),
                        rs.getInt("landlord_id"),
                        rs.getString("transaction_id"),
                        rs.getDouble("amount"),
                        rs.getString("description"),
                        rs.getString("error_code"),
                        rs.getString("ctt"),
                        rs.getString("bank_code"),
                        rs.getTimestamp("time_transaction").toLocalDateTime(),
                        rs.getBoolean("status"));
                list.add(upgrade);
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
    public List<Upgrade> getUpgradeByLandlordID(int landlord_id) {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Upgrade> list = new ArrayList<>();
        try {
            connection = getConnection();
            String strSelect = "SELECT * FROM UPGRADE WHERE landlord_id = ? AND STATUS = 1";
            stm = connection.prepareStatement(strSelect);
            stm.setInt(1, landlord_id);
            rs = stm.executeQuery();
            while (rs.next()) {
                Upgrade upgrade = new Upgrade(
                        rs.getInt("upgrade_id"),
                        rs.getString("type"),
                        rs.getInt("landlord_id"),
                        rs.getString("transaction_id"),
                        rs.getDouble("amount"),
                        rs.getString("description"),
                        rs.getString("error_code"),
                        rs.getString("ctt"),
                        rs.getString("bank_code"),
                        rs.getTimestamp("time_transaction").toLocalDateTime(),
                        rs.getBoolean("status"));
                list.add(upgrade);
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
    public void upgradeLandlord(Upgrade upgrade) {
        PreparedStatement stm = null;
        Connection connection = null;
        try {
            connection = getConnection();

            String sql = "INSERT INTO UPGRADE (type, landlord_id,transaction_id,amount,description,error_code,ctt,bank_code,time_transaction,status) VALUES "
                    + "(?,?,?,?,?,?,?,?,?,?)";
            stm = connection.prepareStatement(sql);
            stm.setString(1, upgrade.getType());
            stm.setInt(2, upgrade.getLandlord_id());
            stm.setString(3, upgrade.getTransaction_id());
            stm.setDouble(4, upgrade.getAmount());
            stm.setString(5, upgrade.getDescription());
            stm.setString(6, upgrade.getError_code());
            stm.setString(7, upgrade.getCtt());
            stm.setString(8, upgrade.getBank_code());
            stm.setTimestamp(9, Timestamp.valueOf(upgrade.getTime_transaction()));
            stm.setBoolean(10, upgrade.isStatus());
            stm.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeStatement(stm);
            closeConnection(connection);
        }
    }

    @Override
    public int getNumberHouseCanAdd(int landlord_id) {
        int numberHouseCanAdd = 1;
        List<Upgrade> listUpgrade = this.getUpgradeByLandlordID(landlord_id);

        for (Upgrade upgrade : listUpgrade) {
            if (upgrade.getAmount() == 499000) {
                numberHouseCanAdd += 1;
            }
            if (upgrade.getAmount() == 899000) {
                numberHouseCanAdd += 2;
            }
            if (upgrade.getAmount() == 1499000) {
                numberHouseCanAdd += 4;
            }
        }
        return numberHouseCanAdd;
    }

    public static void main(String[] args) {
        UpgradeDAO d = new UpgradeDAO();
//        List<Upgrade> ls = d.getUpgradeByLandlordID(1);
//        for (Upgrade l : ls) {
//            System.out.println(l.getAmount() + " "+l.getDescription());
//        }
        System.out.println(d.getPercentRentSuccess());
    }

    public double getTransactionMonth() {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String strSelect = "SELECT YEAR(GETDATE()) AS TransactionYear, "
                    + "    MONTH(GETDATE()) AS TransactionMonth,\n"
                    + "    COUNT(*) AS TotalTransactions,\n"
                    + "    SUM(amount) AS TotalAmount\n"
                    + "FROM \n"
                    + "    upgrade\n"
                    + "WHERE\n"
                    + "    YEAR(time_transaction) = YEAR(GETDATE())\n"
                    + "    AND MONTH(time_transaction) = MONTH(GETDATE()) and status = 1;";
            stm = connection.prepareStatement(strSelect);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getDouble("TotalAmount");
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return 0;
    }

    public double getTransactionYear() {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String strSelect = "SELECT YEAR(GETDATE()) AS TransactionYear, "
                    + "    COUNT(*) AS TotalTransactions, "
                    + "    SUM(amount) AS TotalAmount "
                    + "FROM  "
                    + "    upgrade "
                    + "WHERE "
                    + "    YEAR(time_transaction) = YEAR(GETDATE()) and status = 1 "
                    + "GROUP BY  "
                    + "    YEAR(time_transaction) "
                    + "ORDER BY  "
                    + "    TransactionYear;";
            stm = connection.prepareStatement(strSelect);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getDouble("TotalAmount");
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return 0;
    }

    public int getRentSuccess() {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String strSelect = "SELECT COUNT(*) AS success "
                    + "FROM orders "
                    + "WHERE orders.status = 'approve';";
            stm = connection.prepareStatement(strSelect);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt("success");
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return 0;
    }

    public int getNumberAllOrder() {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String strSelect = "SELECT COUNT(*) as allorders FROM orders";
            stm = connection.prepareStatement(strSelect);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt("allorders");
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return 0;
    }

    public double getPercentRentSuccess(){
        double succes = (double) this.getRentSuccess();
        double allOrder = (double) this.getNumberAllOrder();
        return (succes/allOrder)*100;
    }
    
    public int getNumberPending(){
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            String strSelect = "SELECT COUNT(*) AS success "
                    + "FROM orders "
                    + "WHERE orders.status = 'pending';";
            stm = connection.prepareStatement(strSelect);
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt("success");
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return 0;
    }
    
    @Override
    public List<Upgrade> getUpgradeByUserID(int userId) {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Upgrade> list = new ArrayList<>();
        try {
            connection = getConnection();
            String strSelect = "SELECT UPGRADE.* "
                    + "FROM     LANDLORD INNER JOIN "
                    + "UPGRADE ON LANDLORD.landlord_id = UPGRADE.landlord_id INNER JOIN "
                    + "USERS ON LANDLORD.user_id = USERS.user_id "
                    + "where USERS.user_id = ?";
            stm = connection.prepareStatement(strSelect);
            stm.setInt(1, userId);
            rs = stm.executeQuery();
            while (rs.next()) {
                Upgrade upgrade = new Upgrade(
                        rs.getInt("upgrade_id"),
                        rs.getString("type"),
                        rs.getInt("landlord_id"),
                        rs.getString("transaction_id"),
                        rs.getDouble("amount"),
                        rs.getString("description"),
                        rs.getString("error_code"),
                        rs.getString("ctt"),
                        rs.getString("bank_code"),
                        rs.getTimestamp("time_transaction").toLocalDateTime(),
                        rs.getBoolean("status"));
                list.add(upgrade);
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
}
