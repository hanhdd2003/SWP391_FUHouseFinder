package com.fuhousefinder.dao;

import com.fuhousefinder.context.DBContext;
import com.fuhousefinder.entity.*;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;

public class RoomDao extends DBContext implements IRoom {

    @Override
    public RoomModel getRoomById(String roomId) {
        RoomModel room = null;
        String sql = "SELECT * FROM dbo.ROOM WHERE room_id = ?";

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, roomId);
            rs = ps.executeQuery();
            if (rs.next()) {
                room = new RoomModel();
                room.setRoomId(rs.getInt("room_id"));
                room.setHouseId(rs.getInt("house_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setStatus(rs.getString("status")); // Lưu trữ trạng thái dưới dạng int
                room.setPrice(rs.getDouble("price"));
                room.setArea(rs.getDouble("area"));
                Timestamp createDateTimestamp = rs.getTimestamp("create_date");
                if (createDateTimestamp != null) {
                    room.setCreateDate(createDateTimestamp.toLocalDateTime());
                }
                Timestamp updateDateTimestamp = rs.getTimestamp("update_date");
                if (updateDateTimestamp != null) {
                    room.setUpdateDate(updateDateTimestamp.toLocalDateTime());
                }
                room.setUtilities(getRoomUtilities(room.getRoomId()));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }

        return room;
    }

    private List<UtilityModel> getRoomUtilities(int roomId) {
        List<UtilityModel> utilities = new ArrayList<>();
        String sql = "SELECT u.utilities_id, u.utilities FROM utilities u "
                + "JOIN room_utilities ru ON u.utilities_id = ru.utilities_id "
                + "WHERE ru.room_id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, roomId);
            rs = ps.executeQuery();
            while (rs.next()) {
                UtilityModel utility = new UtilityModel();
                utility.setId(rs.getInt("utilities_id"));
                utility.setName(rs.getString("utilities"));
                utilities.add(utility);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }

        return utilities;
    }

    @Override
    public List<UtilityModel> getAllUtilities() {
        List<UtilityModel> utilities = new ArrayList<>();
        String sql = "SELECT * FROM utilities";

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                UtilityModel utility = new UtilityModel();
                utility.setId(rs.getInt("utilities_id"));
                utility.setName(rs.getString("utilities"));
                utilities.add(utility);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }

        return utilities;
    }

    @Override
    public int addRoom(int houseId, String roomNumber, boolean status, double price, double area) {
        String sql = "INSERT INTO ROOM (house_id, room_number, status, price, area) VALUES (?, ?, ?, ?, ?)";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int roomId = 0;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setInt(1, houseId);
            ps.setString(2, roomNumber);
            ps.setBoolean(3, status);
            ps.setDouble(4, price);
            ps.setDouble(5, area);
            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                roomId = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }

        return roomId;
    }

    @Override
    public void addRoomUtility(int roomId, int utilityId) {
        String sql = "INSERT INTO room_utilities (room_id, utilities_id) VALUES (?, ?)";
        Connection connection = null;
        PreparedStatement ps = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, roomId);
            ps.setInt(2, utilityId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
    }

    @Override
    public List<RoomModel> listRoomsByHouseId(int houseId) {
        List<RoomModel> roomList = new ArrayList<>();
        String sql = "SELECT [room_id], [room_number] FROM ROOM WHERE house_id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, houseId);
            rs = ps.executeQuery();
            while (rs.next()) {
                RoomModel roomInfo = new RoomModel();
                roomInfo.setRoomId(rs.getInt("room_id"));
                roomInfo.setRoomNumber(rs.getString("room_number"));
                roomList.add(roomInfo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }
        return roomList;
    }
//
//    private List<UtilityModel> getRoomUtilities(int roomId) {
//        List<UtilityModel> utilities = new ArrayList<>();
//        String sql = "SELECT u.utilities_id, u.utilities FROM utilities u "
//                + "JOIN room_utilities ru ON u.utilities_id = ru.utilities_id "
//                + "WHERE ru.room_id = ?";
//        Connection connection = null;
//        PreparedStatement ps = null;
//        ResultSet rs = null;
//
//        try {
//            connection = getConnection();
//            ps = connection.prepareStatement(sql);
//            ps.setInt(1, roomId);
//            rs = ps.executeQuery();
//            while (rs.next()) {
//                UtilityModel utility = new UtilityModel();
//                utility.setId(rs.getInt("utilities_id"));
//                utility.setName(rs.getString("utilities"));
//                utilities.add(utility);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            closeResultSet(rs);
//            closeStatement(ps);
//            closeConnection(connection);
//        }
//
//        return utilities;
//    }

//   
//       
//    private List<UtilityModel> getRoomUtilities(int roomId) {
//        List<UtilityModel> utilities = new ArrayList<>();
//        String sql = "SELECT u.utilities_id, u.utilities FROM utilities u "
//                   + "JOIN room_utilities ru ON u.utilities_id = ru.utilities_id "
//                   + "WHERE ru.room_id = ?";
//        Connection connection = null;
//        PreparedStatement ps = null;
//        ResultSet rs = null;
//
//        try {
//            connection = getConnection();
//            ps = connection.prepareStatement(sql);
//            ps.setInt(1, roomId);
//            rs = ps.executeQuery();
//            while (rs.next()) {
//                UtilityModel utility = new UtilityModel();
//                utility.setId(rs.getInt("utilities_id"));
//                utility.setName(rs.getString("utilities"));
//                utilities.add(utility);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            closeResultSet(rs);
//            closeStatement(ps);
//            closeConnection(connection);
//        }
//
//        return utilities;
//    }
    @Override
    public boolean updateRoom(RoomModel room) {
        String sql = "UPDATE [dbo].[ROOM] SET house_id = ?, room_number = ?,  price = ?, area = ?, update_date = ? WHERE room_id = ?";
        Connection connection = null;
        PreparedStatement ps = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);

            ps.setInt(1, room.getHouseId());
            ps.setString(2, room.getRoomNumber());

            ps.setDouble(3, room.getPrice());
            ps.setDouble(4, room.getArea());
            ps.setTimestamp(5, Timestamp.valueOf(room.getUpdateDate()));
            ps.setInt(6, room.getRoomId());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                updateRoomUtilities(room.getRoomId(), room.getUtilities());
                return true;
            } else {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
    }

    private void updateRoomUtilities(int roomId, List<UtilityModel> utilities) throws SQLException {
        String deleteSql = "DELETE FROM room_utilities WHERE room_id = ?";
        String insertSql = "INSERT INTO room_utilities (room_id, utilities_id) VALUES (?, ?)";

        Connection connection = null;
        PreparedStatement deletePs = null;
        PreparedStatement insertPs = null;

        try {
            connection = getConnection();
            connection.setAutoCommit(false);

            deletePs = connection.prepareStatement(deleteSql);
            deletePs.setInt(1, roomId);
            deletePs.executeUpdate();

            insertPs = connection.prepareStatement(insertSql);
            for (UtilityModel utility : utilities) {
                insertPs.setInt(1, roomId);
                insertPs.setInt(2, utility.getId());
                insertPs.addBatch();
            }
            insertPs.executeBatch();

            connection.commit();
        } catch (SQLException e) {
            if (connection != null) {
                connection.rollback();
            }
            throw e;
        } finally {
            closeStatement(deletePs);
            closeStatement(insertPs);
            closeConnection(connection);
        }
    }

//    @Override
//    public RoomModel getRoomById(String roomId) {
//        RoomModel room = null;
//        String sql = "SELECT * FROM dbo.ROOM WHERE room_id = ?";
//
//        Connection connection = null;
//        PreparedStatement ps = null;
//        ResultSet rs = null;
//
//        try {
//            connection = getConnection();
//            ps = connection.prepareStatement(sql);
//            ps.setString(1, roomId);
//            rs = ps.executeQuery();
//            if (rs.next()) {
//                room = new RoomModel();
//                room.setRoomId(rs.getInt("room_id"));
//                room.setHouseId(rs.getInt("house_id"));
//                room.setRoomNumber(rs.getString("room_number"));
//                room.setStatus(rs.getString("status"));
//                room.setPrice(rs.getDouble("price"));
//                room.setArea(rs.getDouble("area"));
//                Timestamp createDateTimestamp = rs.getTimestamp("create_date");
//                if (createDateTimestamp != null) {
//                    room.setCreateDate(createDateTimestamp.toLocalDateTime());
//                }
//                Timestamp updateDateTimestamp = rs.getTimestamp("update_date");
//                if (updateDateTimestamp != null) {
//                    room.setUpdateDate(updateDateTimestamp.toLocalDateTime());
//                }
//                room.setUtilities(getRoomUtilities(room.getRoomId()));
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            closeResultSet(rs);
//            closeStatement(ps);
//            closeConnection(connection);
//        }
//
//        return room;
//    }
    public static void main(String[] args) {
        RoomDao dao = new RoomDao();
        RoomModel room = dao.getRoomById("1");
        System.out.println(dao.getStatusRoom(1));
    }

    @Override
    public boolean deleteRooms(int houseId, int roomId) {
        String deleteRoomUtilitiesSql = "DELETE FROM room_utilities WHERE room_id = ?";
        String deleteOrdersSql = "DELETE FROM ORDERS WHERE room_id = ?";
        String deleteRoomSql = "DELETE FROM ROOM WHERE house_id = ? AND room_id = ?";

        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = getConnection();
            connection.setAutoCommit(false);

            // Xóa các tiện ích của phòng
            ps = connection.prepareStatement(deleteRoomUtilitiesSql);
            ps.setInt(1, roomId);
            ps.executeUpdate();
            ps.close();

            // Xóa các đơn hàng liên quan đến phòng
            ps = connection.prepareStatement(deleteOrdersSql);
            ps.setInt(1, roomId);
            ps.executeUpdate();
            ps.close();

            // Xóa phòng
            ps = connection.prepareStatement(deleteRoomSql);
            ps.setInt(1, houseId);
            ps.setInt(2, roomId);
            int rowsAffected = ps.executeUpdate();
            ps.close();

            connection.commit();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
    }

    @Override
    public List<RoomModel> getRoomss(String houseid) {
        List<RoomModel> rooms = null;
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connection = getConnection();

            String sql = "SELECT room_id, room_number FROM ROOM where house_id= ? ";
            ps = connection.prepareStatement(sql);
            ps.setString(1, houseid);
            rs = ps.executeQuery();

            rooms = new ArrayList<>();
            while (rs.next()) {
                RoomModel room = new RoomModel();
                room.setRoomId(rs.getInt("room_id"));

                room.setRoomNumber(rs.getString("room_number"));
                rooms.add(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {

            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }

        return rooms;
    }

    @Override
    public boolean checkRoomNumberExists(int houseId, String roomNumber) {
        String sql = "SELECT COUNT(*) AS count FROM ROOM WHERE house_id = ? AND room_number = ?";
        try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, houseId);
            ps.setString(2, roomNumber);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt("count");
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateRoomStatus(int roomId, String status) {
        String updateStatusSql = "UPDATE [dbo].[ROOM] SET status = ? WHERE [room_id] = ?";

        try (Connection connection = getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(updateStatusSql)) {

            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, roomId);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void landlordConfirm(int roomId, int tenantId, int confirm) {
        String sql = "update orders set isConfirm = ? where room_id = ? and tenant_id = ? ";
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, confirm);
            ps.setInt(2, roomId);
            ps.setInt(3, tenantId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
    }
    
    @Override
    public RoomModel getRoomDetailOrderByTenant(int roomID) {
        String sql = "SELECT * FROM ROOM WHERE room_id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, roomID);
            rs = ps.executeQuery();
            while (rs.next()) {
                int roomid = rs.getInt(1);
                int houseID = rs.getInt(2);
                String roomNumber = rs.getString(3);
                String status = rs.getString(4);
                double price = rs.getDouble(5);
                double area = rs.getDouble(6);
                Timestamp createDate = rs.getTimestamp(7);
                LocalDateTime creaDate = null;
                if (createDate != null) {
                    creaDate = createDate.toLocalDateTime();
                }
                Timestamp updateDate = rs.getTimestamp(8);
                LocalDateTime updatedate = null;
                if (updateDate != null) {
                    updatedate = updateDate.toLocalDateTime();
                }
                RoomModel room = new RoomModel();
                room.setRoomId(roomid);
                room.setHouseId(houseID);
                room.setRoomNumber(roomNumber);
                room.setStatus(status);
                room.setPrice(price);
                room.setArea(area);
                room.setCreateDate(creaDate);
                room.setUpdateDate(updatedate);
                return room;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }
        return null;
    }

    @Override
    public String getHouseNameByRoomID(int roomID) {
        String sql = "select house_name from House where house_id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, roomID);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }
        return null;
    }

    @Override
    public String getRoomNameByRoomID(int roomID) {
        String sql = "select room_number from Room where room_id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, roomID);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }
        return null;
    }

    @Override
    public String getLandlordNameByLandlordID(int landlordID) {
        String sql = "select first_name + ' ' + last_name from LANDLORD where landlord_id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, landlordID);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }
        return null;
    }

    @Override
    public void updateRoomStatus(int roomID) {
        String sql = "update Room set status = 0 where room_id = " + roomID;
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    public boolean getStatusRoom(int roomId){
        String sql = "SELECT * FROM ROOM WHERE room_id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, roomId);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt("status") == 1;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }
        return false;
    }
}
