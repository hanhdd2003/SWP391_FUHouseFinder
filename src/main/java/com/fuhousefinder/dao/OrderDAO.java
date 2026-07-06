package com.fuhousefinder.dao;

import com.fuhousefinder.context.DBContext;
import com.fuhousefinder.entity.*;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;

public class OrderDAO extends DBContext {

    public int bookRoom(int tenantID, int landlordID, int roomID, String note) {
        String sql = "insert into Orders(tenant_id, landlord_id, status, room_id, order_date, note)"
                + "values(?, ?, ?, ?, ?, ?)";
        PreparedStatement ps;
        Connection connection;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, tenantID);
            ps.setInt(2, landlordID);
            ps.setString(3, "Pending");
            ps.setInt(4, roomID);
            ps.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
            ps.setString(6, note);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;
    }

    public int bookAgain(int orderId) {
        String sql = "update orders set status = 'Pending' where  order_id = ?";
        PreparedStatement ps;
        Connection connection;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated;
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return -1;
    }

    public List<Order> getOrdersByRoomID(int roomid) {
        List<Order> orders = new ArrayList<>();
        String sql = "select *from Orders where room_id = ? and status != 'Cancel';";
        Connection con;
        PreparedStatement ps;
        ResultSet rs;
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, roomid);
            rs = ps.executeQuery();
            while (rs.next()) {
                int orderID = rs.getInt(1);
                int tenantID = rs.getInt(2);
                int landlordID = rs.getInt(3);
                String status = rs.getString(4);
                int roomID = rs.getInt(5);
                Timestamp timestamp = rs.getTimestamp(6);
                LocalDateTime orderDate = null;
                if (timestamp != null) {
                    orderDate = timestamp.toLocalDateTime();
                }
                String note = rs.getString(7);
                Order ord = new Order(orderID, tenantID, landlordID, status, roomID, orderDate, note);
                orders.add(ord);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return orders;
    }

    public List<Order> getOrderByTenantID(int tenantID) {
        List<Order> listOrder = new ArrayList<>();
        String sql = "select * from Orders where tenant_id = ? and status != 'Cancel';";
        Connection con;
        PreparedStatement ps;
        ResultSet rs;
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, tenantID);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setStatus(rs.getString("status"));
                order.setRoomID(rs.getInt("room_id"));
                listOrder.add(order);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listOrder;
    }

    public List<Order> getOrderCancelByTenantID(int tenantID) {
        List<Order> listOrder = new ArrayList<>();
        String sql = "select * from Orders where tenant_id = ? and status = 'Cancel' or status = 'Reject' or status = 'CheckOut';";
        Connection con;
        PreparedStatement ps;
        ResultSet rs;
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, tenantID);
            rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("order_id"));
                order.setStatus(rs.getString("status"));
                order.setRoomID(rs.getInt("room_id"));
                listOrder.add(order);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listOrder;
    }

    public List<BookingOrderModel> getAllOrdersByTenantID(int _tenantID, String orderStatus) {
        List<BookingOrderModel> orderDetails = new ArrayList<>();
        String sql = "SELECT o.*, r.area, r.price,  r.room_number, h.house_name, h.address, h.house_id, l.first_name, "
                + "l.last_name, l.address AS landlord_address, l.phone AS landlord_phone, img.image_url "
                + "FROM Orders o "
                + "JOIN ROOM r ON o.room_id = r.room_id "
                + "JOIN HOUSE h ON r.house_id = h.house_id "
                + "JOIN LANDLORD l ON h.landlord_id = l.landlord_id "
                + "OUTER APPLY "
                + "(SELECT TOP 1 image_url FROM HOUSE_IMAGE WHERE house_id = h.house_id ORDER BY house_image_id ASC) AS img "
                + "WHERE o.tenant_id = ? AND o.status LIKE ?";

        Connection con;
        PreparedStatement ps;
        ResultSet rs;
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, _tenantID);
            ps.setString(2, "%" + orderStatus + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                BookingOrderModel bookingOrderModel = new BookingOrderModel();
                int orderID = rs.getInt(1);
                int tenantID = rs.getInt(2);
                int landlordID = rs.getInt(3);
                String status = rs.getString(4);
                int roomID = rs.getInt(5);
                Timestamp timestamp = rs.getTimestamp(6);
                LocalDateTime orderDate = null;
                if (timestamp != null) {
                    orderDate = timestamp.toLocalDateTime();
                }
                String note = rs.getString(7);
                String roomNumber = rs.getString("room_number");
                double roomArea = rs.getDouble("area");
                double roomPrice = rs.getDouble("price");
                String houseName = rs.getString("house_name");
                String houseAddress = rs.getString("address");
                int houseID = rs.getInt("house_id");
                String landlordFirstName = rs.getString("first_name");
                String landlordLastName = rs.getString("last_name");
                String landlordAddress = rs.getString("landlord_address");
                String landlordPhone = rs.getString("landlord_phone");
                String roomImage = rs.getString("image_url");

                // Set for order 
                Order order = new Order();
                order.setOrderID(orderID);
                order.setTenantID(tenantID);
                order.setLandlordID(landlordID);
                order.setStatus(status);
                order.setRoomID(roomID);
                order.setOrderDate(orderDate);
                order.setNote(note);
                // set for tentent
                Tenant tenant = new Tenant();
                tenant.setTenant_ID(tenantID);

                //set for house
                HouseModel house = new HouseModel();
                house.setId(houseID);
                house.setHouse_name(houseName);
                house.setAddress(houseAddress);
                house.setImg(roomImage);

                // set for landlord
                LandlordMder landlord = new LandlordMder();
                landlord.setFirst_name(landlordFirstName);
                landlord.setLast_name(landlordLastName);
                landlord.setPhone(landlordPhone);
                landlord.setAddress(landlordAddress);

                // set for room
                RoomModel roomModel = new RoomModel();
                roomModel.setRoomNumber(roomNumber);
                roomModel.setPrice(roomPrice);
                roomModel.setArea(roomArea);
                roomModel.setRoomId(roomID);

                bookingOrderModel.setHouse(house);
                bookingOrderModel.setLandlord(landlord);
                bookingOrderModel.setOrder(order);
                bookingOrderModel.setRoomModel(roomModel);

                orderDetails.add(bookingOrderModel);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return orderDetails;
    }

    public List<BookingOrderModel> getAllOrdersToLandLordIDAndStatus(int landlordId, String orderStatus) {
        List<BookingOrderModel> orderDetails = new ArrayList<>();
        String sql = "SELECT o.*, r.price, r.area, r.room_number, h.house_name, h.address, h.house_id, "
                + "t.address AS tenant_address, t.first_name, t.last_name, t.phone as tenant_phone, img.image_url "
                + "FROM Orders o "
                + "JOIN ROOM r ON o.room_id = r.room_id "
                + "JOIN HOUSE h ON r.house_id = h.house_id "
                + "JOIN LANDLORD l ON h.landlord_id = l.landlord_id "
                + "JOIN Tenant t ON o.tenant_id = t.tenant_id "
                + "OUTER APPLY "
                + "(SELECT TOP 1 image_url FROM HOUSE_IMAGE WHERE house_id = h.house_id ORDER BY house_image_id ASC) AS img "
                + "WHERE o.landlord_id = ? AND o.status LIKE ? AND o.status != 'Cancel'";
        Connection con;
        PreparedStatement ps;
        ResultSet rs;
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, landlordId);
            ps.setString(2, "%" + orderStatus + "%");
            rs = ps.executeQuery();
            while (rs.next()) {
                BookingOrderModel bookingOrderModel = new BookingOrderModel();
                int orderID = rs.getInt(1);
                int tenantID = rs.getInt(2);
                int landlordID = rs.getInt(3);
                String status = rs.getString(4);
                int roomID = rs.getInt(5);
                Timestamp timestamp = rs.getTimestamp(6);
                LocalDateTime orderDate = null;
                if (timestamp != null) {
                    orderDate = timestamp.toLocalDateTime();
                }
                String note = rs.getString(7);
                String roomNumber = rs.getString("room_number");
                double roomArea = rs.getDouble("area");
                double roomPrice = rs.getDouble("price");
                String houseName = rs.getString("house_name");
                String houseAddress = rs.getString("address");
                int houseID = rs.getInt("house_id");
                String tentantFirstName = rs.getString("first_name");
                String tentantLastName = rs.getString("last_name");
                String tenantAdress = rs.getString("tenant_address");
                String tenantPhone = rs.getString("tenant_phone");
                String roomImage = rs.getString("image_url");

                boolean isConfirm = rs.getInt("isConfirm") == 1;
                // Set for order 
                Order order = new Order();
                order.setOrderID(orderID);
                order.setTenantID(tenantID);
                order.setLandlordID(landlordID);
                order.setStatus(status);
                order.setRoomID(roomID);
                order.setOrderDate(orderDate);
                order.setNote(note);
                order.setIsConfirm(isConfirm);
                // set for tentent

                //set for house
                HouseModel house = new HouseModel();
                house.setId(houseID);
                house.setHouse_name(houseName);
                house.setAddress(houseAddress);
                house.setImg(roomImage);

                // set for landlord
                Tenant tenant = new Tenant();
                tenant.setTenant_ID(tenantID);
                tenant.setFirstName(tentantFirstName);
                tenant.setLastName(tentantLastName);
                tenant.setPhone(tenantPhone);
                tenant.setAddress(tenantAdress);

                // set for room
                RoomModel roomModel = new RoomModel();
                roomModel.setRoomNumber(roomNumber);
                roomModel.setPrice(roomPrice);
                roomModel.setArea(roomArea);
                roomModel.setRoomId(roomID);
                RoomDao roomdao = new RoomDao();
                roomModel.setStatus(roomdao.getStatusRoom(roomID) ? "1" : "0");

                bookingOrderModel.setHouse(house);
                bookingOrderModel.setTenant(tenant);
                bookingOrderModel.setOrder(order);
                bookingOrderModel.setRoomModel(roomModel);

                orderDetails.add(bookingOrderModel);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return orderDetails;
    }

    public int CancelBookRoom(int roomID, int tenantID) {
        String sql = "update Orders set status = 'Cancel' where room_id = ? and tenant_id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, roomID);
            ps.setInt(2, tenantID);
            int check = ps.executeUpdate();
            return check;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
        return -1;
    }

    public int AccecptBookRoom(String note, int orderId, int roomId) {
        String sql = "update Orders set status = 'Approve', note = ?, isConfirm = 0 where order_id = ?  and status != 'Cancel'";
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, note);
            ps.setInt(2, orderId);
            int check = ps.executeUpdate();
            if (check > 0) {
                UpdateRoomAfterAccept(roomId);
            }
            return check;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
        return -1;
    }

    public boolean UpdateRoomAfterAccept(int roomId) {
        String sql = "update ROOM set status = 0 where room_id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, roomId);
            int check = ps.executeUpdate();
            return check > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
        return false;
    }

    public void returnRoom(int roomId, int tenant_id, int orderId) {
        String sql = "update orders set status = 'CheckOut' where room_id = ? and tenant_id = ? and order_id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, roomId);
            ps.setInt(2, tenant_id);
            ps.setInt(3, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
    }

    public int RejectBookRoom(String note, int orderId) {
        String sql = "update Orders set status = 'Reject', note = ? where order_id = ? and status != 'Cancel'";
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, note);
            ps.setInt(2, orderId);
            int check = ps.executeUpdate();
            return check;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
        return -1;
    }

    // viết hàm thêm dữ liệu vào bảng history_order()
    public void addHistoryOrder(int orderId, String status) {
        String sql = "INSERT INTO HISTORY_ORDER(order_id, [status]) values (?, ?)";
        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setString(2, status);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
    }

    public int getIDOrder(int tenantId, int roomId) {
        String sql = "select * from orders where tenant_id = ? and room_id = ? ";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, tenantId);
            ps.setInt(2, roomId);
            rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt("order_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
        return 0;
    }

    public List<HistoryOrder> getHistoryOrderByTenantId(int tenantID) {
        List<HistoryOrder> listOrder = new ArrayList<>();
        String sql = "SELECT HOUSE.house_name, ROOM.room_number, HISTORY_ORDER.status, HISTORY_ORDER.history_date, ORDERS.tenant_id, "
                + "HOUSE.house_id FROM HISTORY_ORDER INNER JOIN  "
                + "ORDERS ON HISTORY_ORDER.order_id = ORDERS.order_id INNER JOIN  "
                + "ROOM ON ORDERS.room_id = ROOM.room_id INNER JOIN "
                + "HOUSE ON ROOM.house_id = HOUSE.house_id "
                + "where ORDERS.tenant_id = ?";
        Connection con;
        PreparedStatement ps;
        ResultSet rs;
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, tenantID);
            rs = ps.executeQuery();
            while (rs.next()) {
                Timestamp timeStamp = rs.getTimestamp("history_date");
                HistoryOrder history = new HistoryOrder(rs.getString("house_name"),
                        rs.getInt("room_number"),
                        rs.getInt("house_id"),
                        rs.getString("status"),
                        timeStamp.toLocalDateTime());

                listOrder.add(history);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listOrder;
    }

    public boolean checkRoomBookedByOther(int tenantId, int roomId){
        String sql = "select * from orders where room_id = ? and tenant_id != ? and status = 'approve'";
        Connection con;
        PreparedStatement ps;
        ResultSet rs;
        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, roomId);
            ps.setInt(2, tenantId);
            rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }
    
    public static void main(String[] args) {
        OrderDAO d = new OrderDAO();
            System.out.println(d.checkRoomBookedByOther(3, 2));

    }
}
