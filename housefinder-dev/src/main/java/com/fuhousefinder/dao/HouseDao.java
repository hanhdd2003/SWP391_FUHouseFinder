package com.fuhousefinder.dao;

import com.fuhousefinder.context.DBContext;
import com.fuhousefinder.entity.*;
import java.sql.*;
import java.util.*;

public class HouseDao extends DBContext implements IHousIe {


public void updateHouseStatusss
        () {
    String houseIdsSql = "SELECT house_id FROM HOUSE";
    String roomStatusSql = "SELECT status FROM ROOM WHERE house_id = ?";
    String updateHouseSql = "UPDATE HOUSE SET status = ? WHERE house_id = ?";
    
    Connection connection = null;
    PreparedStatement housePs = null;
    PreparedStatement roomPs = null;
    PreparedStatement updatePs = null;
    ResultSet houseRs = null;
    ResultSet roomRs = null;

    try {
        connection = getConnection();
        
        // Lấy danh sách các nhà
        housePs = connection.prepareStatement(houseIdsSql);
        houseRs = housePs.executeQuery();

        while (houseRs.next()) {
            int houseId = houseRs.getInt("house_id");

            // Kiểm tra trạng thái của các phòng trong nhà
            roomPs = connection.prepareStatement(roomStatusSql);
            roomPs.setInt(1, houseId);
            roomRs = roomPs.executeQuery();

            boolean allRoomsOccupied = true;
            boolean hasRoomAvailable = false;

            while (roomRs.next()) {
                boolean roomStatus = roomRs.getBoolean("status");
                if (roomStatus) {  // Còn phòng
                    hasRoomAvailable = true;
                } else {  // Hết phòng
                    allRoomsOccupied = false;
                }
            }

            // Xác định trạng thái của nhà
            String houseStatus;
            if (hasRoomAvailable) {
                houseStatus = "Còn phòng";
            } else {
                houseStatus = "Hết phòng";
            }

            // Cập nhật trạng thái của nhà
            updatePs = connection.prepareStatement(updateHouseSql);
            updatePs.setString(1, houseStatus);
            updatePs.setInt(2, houseId);
            updatePs.executeUpdate();

            // Đóng ResultSet và PreparedStatement cho mỗi lần lặp
            roomRs.close();
            roomPs.close();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Đóng tất cả các tài nguyên
        closeResultSet(houseRs);
        closeStatement(housePs);
        closeStatement(updatePs);
        closeConnection(connection);
    }
}



    @Override
    public String getUserRole(int userId) {
        String role = null;
        String sql = "SELECT u.role_id FROM USERS u WHERE u.user_id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        PreparedStatement housePs = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                int role_id = rs.getInt("role_id");
                role = role_id == 1 ? "Admin" : role_id == 2 ? "Landlord" : role_id == 3 ? "Tenant" : "";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }
        return role;
    }

    @Override
    public List<HouseModel> getFilteredHouses(String priceRange, String dateOrder, String distanceRange, String keyword, int userId) {
        List<HouseModel> houses = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT h.*,a.distance_km ,"
                + "(SELECT TOP 1 image_url FROM HOUSE_IMAGE WHERE house_id = h.house_id ORDER BY house_image_id ASC) AS avatar_image, "
                + "(SELECT MIN(price) FROM ROOM WHERE house_id = h.house_id) AS min_price, "
                + "(SELECT MAX(price) FROM ROOM WHERE house_id = h.house_id) AS max_price, "
                + "(CASE WHEN EXISTS (SELECT 1 FROM WISHLIST WHERE tenant_id = ? AND house_id = h.house_id) THEN 1 ELSE 0 END) AS is_favorite "
                + "FROM dbo.HOUSE h join [PROPERTY_LOCATION] a on a.location_id = h.location_id WHERE 1=1"
        );

        boolean isLandlord = false;
        if (userId != -1) {
            String userRole = getUserRole(userId);
            if ("Landlord".equals(userRole)) {
                isLandlord = true;
                sql.append(" AND h.landlord_id NOT IN (SELECT landlord_id FROM LANDLORD WHERE user_id = ?)");
            }
        }

        if (priceRange != null && !priceRange.isEmpty()) {
            String[] priceBounds = priceRange.split("-");
            double minPrice = Double.parseDouble(priceBounds[0]);
            double maxPrice = (priceBounds.length > 1) ? Double.parseDouble(priceBounds[1]) : Double.MAX_VALUE;
            sql.append(" AND EXISTS (SELECT 1 FROM ROOM r WHERE r.house_id = h.house_id AND r.price BETWEEN ? AND ?)");
        }

        if (distanceRange != null && !distanceRange.isEmpty()) {
            String[] distances = distanceRange.split("-");
            double minDistance = Double.parseDouble(distances[0]);
            double maxDistance = (distances.length > 1) ? Double.parseDouble(distances[1]) : Double.MAX_VALUE;
            sql.append(" AND a.distance_km BETWEEN ? AND ?");
        }

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (h.description_house LIKE ? OR h.house_name LIKE ?)");
        }

        if ("newest".equals(dateOrder)) {
            sql.append(" ORDER BY h.create_date DESC");
        } else if ("oldest".equals(dateOrder)) {
            sql.append(" ORDER BY h.create_date ASC");
        }

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql.toString());
            IUser userDAO = new UserDAO();
            ps.setInt(1, userDAO.getTenantIDByUserID(userId));

            int paramIndex = 2;
            if (isLandlord) {
                ps.setInt(paramIndex++, userId);
            }

            if (priceRange != null && !priceRange.isEmpty()) {
                String[] priceBounds = priceRange.split("-");
                double minPrice = Double.parseDouble(priceBounds[0]);
                double maxPrice = (priceBounds.length > 1) ? Double.parseDouble(priceBounds[1]) : Double.MAX_VALUE;
                ps.setDouble(paramIndex++, minPrice);
                ps.setDouble(paramIndex++, maxPrice);
            }

            if (distanceRange != null && !distanceRange.isEmpty()) {
                String[] distances = distanceRange.split("-");
                double minDistance = Double.parseDouble(distances[0]);
                double maxDistance = (distances.length > 1) ? Double.parseDouble(distances[1]) : Double.MAX_VALUE;
                ps.setDouble(paramIndex++, minDistance);
                ps.setDouble(paramIndex++, maxDistance);
            }

            if (keyword != null && !keyword.isEmpty()) {
                ps.setString(paramIndex++, "%" + keyword + "%");
                ps.setString(paramIndex++, "%" + keyword + "%");
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                HouseModel house = new HouseModel();
                house.setId(rs.getInt("house_id"));
                house.setHouse_name(rs.getString("house_name"));
                house.setAddress(rs.getString("address"));
                house.setDescriptionHouse(rs.getString("description_house"));
                house.setStatus(rs.getString("status"));
                house.setDistance_km(rs.getString("distance_km"));
                house.setAvatarImage(rs.getString("avatar_image"));
                house.setMinPrice(rs.getDouble("min_price"));
                house.setMaxPrice(rs.getDouble("max_price"));

                boolean isFavorite = rs.getInt("is_favorite") == 1;
                house.setFavorite(isFavorite);

                Timestamp createDateTimestamp = rs.getTimestamp("create_date");
                if (createDateTimestamp != null) {
                    house.setCreateDate(createDateTimestamp.toLocalDateTime());
                }
                Timestamp updateDateTimestamp = rs.getTimestamp("update_date");
                if (updateDateTimestamp != null) {
                    house.setUpdateDate(updateDateTimestamp.toLocalDateTime());
                }
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

    @Override
    public HouseModel getHouseById(String houseId) {
        HouseModel house = null;
        String sql = "SELECT * FROM  dbo.HOUSE h join [PROPERTY_LOCATION] a on a.location_id = h.location_id WHERE house_id = ?";
        String imageSql = "SELECT house_image_id, image_url FROM dbo.HOUSE_IMAGE WHERE house_id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        PreparedStatement imagePs = null;
        ResultSet rs = null;
        ResultSet imageRs = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, houseId);
            rs = ps.executeQuery();
            if (rs.next()) {
                house = new HouseModel();
                house.setId(rs.getInt("house_id"));
                house.setHouse_name(rs.getString("house_name"));
                house.setAddress(rs.getString("address"));
                house.setDescriptionHouse(rs.getString("description_house"));
                house.setStatus(rs.getString("status"));
                house.setDistance_km(rs.getString("distance_km"));
                house.setLocation_id(rs.getInt("location_id"));
                Timestamp createDateTimestamp = rs.getTimestamp("create_date");
                if (createDateTimestamp != null) {
                    house.setCreateDate(createDateTimestamp.toLocalDateTime());
                }
                Timestamp updateDateTimestamp = rs.getTimestamp("update_date");
                if (updateDateTimestamp != null) {
                    house.setUpdateDate(updateDateTimestamp.toLocalDateTime());
                }

                // Lấy các ảnh hiện tại
                imagePs = connection.prepareStatement(imageSql);
                imagePs.setString(1, houseId);
                imageRs = imagePs.executeQuery();
                List<HouseImages> images = new ArrayList<>();
                while (imageRs.next()) {
                    HouseImages image = new HouseImages();
                    image.setId(imageRs.getInt("house_image_id"));
                    image.setImageUrl(imageRs.getString("image_url"));
                    images.add(image);
                }
                house.setHouseImagess(images);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeResultSet(imageRs);
            closeStatement(ps);
            closeStatement(imagePs);
            closeConnection(connection);
        }
        return house;
    }

    @Override
    public List<HouseImages> getHouseImagesByHouseId(String houseId) {
        List<HouseImages> houseImages = new ArrayList<>();
        String sql = ""
                + " SELECT hi.house_image_id AS house_image_id, hi.image_url AS image_url FROM dbo.HOUSE h "
                + "JOIN [PROPERTY_LOCATION] a ON a.location_id = h.location_id "
                + "JOIN HOUSE_IMAGE hi ON hi.house_id = h.house_id "
                + "WHERE h.house_id = ?";

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, houseId);
            rs = ps.executeQuery();
            while (rs.next()) {
                HouseImages image = new HouseImages();
                image.setId(rs.getInt("house_image_id"));
                image.setImageUrl(rs.getString("image_url"));
                houseImages.add(image);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }

        return houseImages;
    }

    public static void main(String[] args) {
        HouseDao d = new HouseDao();
        List<LocationModer> ls = d.getAllLocations();
        for (LocationModer l : ls) {
            System.out.println(l.getLocation_id() + " " + l.getLocation_link());
        }
    }

    @Override
    public List<RoomModel> getRoomsByHouseId(String houseId) {
        List<RoomModel> rooms = new ArrayList<>();
        String sql = "  SELECT r.room_id, h.house_id ,r.room_number,r.status ,r.price,r.area,r.create_date,r.update_date FROM  dbo.HOUSE h join [PROPERTY_LOCATION] a on a.location_id = h.location_id \n"
                + "  join ROOM r on r.house_id = h.house_id \n"
                + "  WHERE h.house_id = ?";

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setString(1, houseId);
            rs = ps.executeQuery();
            while (rs.next()) {
                RoomModel room = new RoomModel();
                room.setRoomId(rs.getInt("room_id"));
                room.setHouseId(rs.getInt("house_id"));
                room.setRoomNumber(rs.getString("room_number"));
                room.setStatus(rs.getString("status"));
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
                // Lấy danh sách tiện ích cho phòng
                room.setUtilities(getRoomUtilities(room.getRoomId()));
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
    public boolean updateHouse(HouseModel house, String removedImages) {
        String updateHouseSql = "UPDATE [dbo].[HOUSE] SET "
                + "[address] = ?, "
                + "[description_house] = ?, "
                + "[update_date] = ?, "
                + "[house_name] = ? ,"
                +"[location_id] = ? "
                + "WHERE [house_id] = ?";
        String deleteImageSql = "DELETE FROM [dbo].[HOUSE_IMAGE] WHERE house_image_id = ?";
        String insertImageSql = "INSERT INTO [dbo].[HOUSE_IMAGE] ([house_id], [image_url]) VALUES (?, ?)";

        Connection connection = null;
        PreparedStatement updateHousePs = null;
        PreparedStatement deleteImagePs = null;
        PreparedStatement insertImagePs = null;

        try {
            connection = getConnection();
            connection.setAutoCommit(false);

            // Update house details
            updateHousePs = connection.prepareStatement(updateHouseSql);
            updateHousePs.setString(1, house.getAddress());
            updateHousePs.setString(2, house.getDescriptionHouse());

            updateHousePs.setTimestamp(3, Timestamp.valueOf(house.getUpdateDate()));

            updateHousePs.setString(4, house.getHouse_name());
            updateHousePs.setInt(5, house.getLocationModer().getLocation_id());
            updateHousePs.setInt(6, house.getId());
            int houseRowsAffected = updateHousePs.executeUpdate();

            // Remove old images
            if (removedImages != null && !removedImages.isEmpty()) {
                String[] imageIds = removedImages.split(",");
                deleteImagePs = connection.prepareStatement(deleteImageSql);
                for (String imageId : imageIds) {
                    deleteImagePs.setInt(1, Integer.parseInt(imageId));
                    deleteImagePs.executeUpdate();
                }
            }

            // Add new images
            if (house.getHouseImagess() != null && !house.getHouseImagess().isEmpty()) {
                insertImagePs = connection.prepareStatement(insertImageSql);
                for (HouseImages img : house.getHouseImagess()) {
                    insertImagePs.setInt(1, house.getId());
                    insertImagePs.setString(2, img.getImageUrl());
                    insertImagePs.addBatch();
                }
                insertImagePs.executeBatch();
            }

            connection.commit();
            return houseRowsAffected > 0;
        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            closeStatement(updateHousePs);
            closeStatement(deleteImagePs);
            closeStatement(insertImagePs);
            closeConnection(connection);
        }
    }

    @Override
    public List<HouseModel> getFilteredHousess(int userId) {
        List<HouseModel> houses = new ArrayList<>();
        String sql = "SELECT h.*,a.location_id, "
                + "(SELECT TOP 1 [image_url] FROM HOUSE_IMAGE WHERE house_id = h.house_id ORDER BY house_image_id ASC) AS avatar_image, "
                + "(SELECT MIN(price) FROM ROOM WHERE house_id = h.house_id) AS min_price, "
                + "(SELECT MAX(price) FROM ROOM WHERE house_id = h.house_id) AS max_price "
                + "FROM dbo.HOUSE h join [PROPERTY_LOCATION] a on a.location_id = h.location_id "
                + "JOIN LANDLORD l ON h.landlord_id = l.landlord_id "
                + "JOIN USERS u ON u.user_id = l.user_id "
                + "WHERE u.user_id = ?";

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);

            // Đặt giá trị userId vào PreparedStatement
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                HouseModel house = new HouseModel();
                house.setId(rs.getInt("house_id"));
                house.setAvatarImage(rs.getString("avatar_image"));
                house.setHouse_name(rs.getString("house_name"));
                house.setAddress(rs.getString("address"));
                house.setDescriptionHouse(rs.getString("description_house"));
                house.setStatus(rs.getString("status"));
                house.setDistance_km(rs.getString("location_id"));
                house.setMinPrice(rs.getDouble("min_price"));
                house.setMaxPrice(rs.getDouble("max_price"));
                Timestamp createDateTimestamp = rs.getTimestamp("create_date");
                if (createDateTimestamp != null) {
                    house.setCreateDate(createDateTimestamp.toLocalDateTime());
                }

                Timestamp updateDateTimestamp = rs.getTimestamp("update_date");
                if (updateDateTimestamp != null) {
                    house.setUpdateDate(updateDateTimestamp.toLocalDateTime());
                }

                // Assuming you have a method to get house images by house ID
                // house.setHouseImages(getHouseImagesByHouseId(house.getId()));
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

    @Override
    public List<PropertyLocationModel> getAllPropertyLocations() {
        List<PropertyLocationModel> locations = new ArrayList<>();
        String selectPropertyLocationsSql = "SELECT location_id, distance_km FROM PROPERTY_LOCATION";

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(selectPropertyLocationsSql);
            rs = ps.executeQuery();

            while (rs.next()) {
                PropertyLocationModel location = new PropertyLocationModel();
                location.setLocationId(rs.getInt("location_id"));
                location.setDistanceKm(rs.getString("distance_km"));
                locations.add(location);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }

        return locations;
    }

    @Override
    public boolean addHouse(HouseModel house) {
        String insertHouseSql = "INSERT INTO [dbo].[HOUSE] ([landlord_id], address, description_house, status, "
                + "create_date, update_date, location_id, [house_name]) VALUES (?, ?, ?, N'Hết phòng', ?, ?, ?, ?)";
        String insertHouseImageSql = "INSERT INTO [dbo].[HOUSE_IMAGE] ([house_id], [image_url]) VALUES (?, ?)";

        Connection connection = null;
        PreparedStatement housePs = null;
        PreparedStatement imagePs = null;
        ResultSet generatedKeys = null;

        try {
            connection = getConnection();
            housePs = connection.prepareStatement(insertHouseSql, Statement.RETURN_GENERATED_KEYS);

            // Thiết lập giá trị cho câu lệnh INSERT vào bảng HOUSE
            housePs.setInt(1, house.getLandlordMder().getId());
            housePs.setString(2, house.getAddress());
            housePs.setString(3, house.getDescriptionHouse());
            housePs.setTimestamp(4, Timestamp.valueOf(house.getCreateDates()));
            housePs.setTimestamp(5, Timestamp.valueOf(house.getUpdateDates()));

            housePs.setInt(6, house.getLocationModer().getLocation_id());
            housePs.setString(7, house.getHouse_name());

            // Thực hiện chèn dữ liệu vào bảng HOUSE
            int houseRowsAffected = housePs.executeUpdate();
            if (houseRowsAffected > 0) {
                // Lấy ID của bản ghi vừa chèn
                generatedKeys = housePs.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int houseId = generatedKeys.getInt(1);

                    // Chuẩn bị câu lệnh INSERT vào bảng HOUSE_IMAGE
                    imagePs = connection.prepareStatement(insertHouseImageSql);

                    for (HouseImages img : house.getHouseImagess()) {
                        imagePs.setInt(1, houseId);
                        imagePs.setString(2, img.getImageUrl());
                        imagePs.addBatch();
                    }

                    // Thực hiện chèn dữ liệu vào bảng HOUSE_IMAGE
                    int[] imageRowsAffected = imagePs.executeBatch();
                    return imageRowsAffected.length == house.getHouseImagess().size();
                }
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResultSet(generatedKeys);
            closeStatement(imagePs);
            closeStatement(housePs);
            closeConnection(connection);
        }
    }

    @Override
    public List<HouseModel> getAllHouses() {
        List<HouseModel> houses = new ArrayList<>();
        String sql = "SELECT HOUSE.*, PROPERTY_LOCATION.distance_km "
                + "FROM HOUSE  INNER JOIN "
                + "PROPERTY_LOCATION ON HOUSE.location_id = PROPERTY_LOCATION.location_id";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                HouseModel house = new HouseModel();
                int house_id = rs.getInt("house_id");
                house.setId(house_id);
                house.setHouse_name(rs.getString("house_name"));
                house.setAddress(rs.getString("address"));
                house.setDescriptionHouse(rs.getString("description_house"));
                house.setStatus(rs.getString("status"));
                house.setDistance_km(rs.getString("distance_km"));

                List<HouseImages> ls = this.getHouseImage(house_id);
                house.setAvatarImage(ls.get(0).getImageUrl());
                Timestamp createDateTimestamp = rs.getTimestamp("create_date");
                if (createDateTimestamp != null) {
                    house.setCreateDate(createDateTimestamp.toLocalDateTime());
                }
                Timestamp updateDateTimestamp = rs.getTimestamp("update_date");
                if (updateDateTimestamp != null) {
                    house.setUpdateDate(updateDateTimestamp.toLocalDateTime());
                }
                IUser userDAO = new UserDAO();
                int landlord_id = rs.getInt("landlord_id");
                String email = userDAO.getEmailByLandlordId(landlord_id);
                ManageUser landlord = userDAO.getManageUser(email);
                if (landlord != null) {
                    house.setLandlord(landlord);
                }
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

    @Override
    public boolean updateHouseStatus(int houseId, String newStatus) {
        String sql = "UPDATE [dbo].[HOUSE] SET [status] = ? WHERE [house_id] = ?";

        Connection connection = null;
        PreparedStatement ps = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);

            ps.setString(1, newStatus);
            ps.setInt(2, houseId);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
    }

    @Override
    public boolean deleteHouse(int houseId) {
        String deleteWishlistSql = "DELETE FROM WISHLIST WHERE house_id = ?";
        String deleteHouseImagesSql = "DELETE FROM HOUSE_IMAGE WHERE house_id = ?";
        String deleteRoomUtilitiesSql = "DELETE FROM room_utilities WHERE room_id IN (SELECT room_id FROM ROOM WHERE house_id = ?)";
        String deleteOrdersSql = "DELETE FROM ORDERS WHERE room_id IN (SELECT room_id FROM ROOM WHERE house_id = ?)";
        String deleteRoomsSql = "DELETE FROM ROOM WHERE house_id = ?";
        String deleteFeedbackSql = "DELETE FROM FEEDBACK WHERE house_id = ?";
        String deleteReplyFeedbackSql = "DELETE FROM REPLY_FEEDBACK WHERE feedback_id IN (SELECT feedback_id FROM FEEDBACK WHERE house_id = ?)";
        String deleteHouseSql = "DELETE FROM HOUSE WHERE house_id = ?";

        Connection connection = null;
        PreparedStatement ps = null;
        try {
            connection = getConnection();
            connection.setAutoCommit(false); // Bắt đầu transaction

            // Xóa các bản ghi trong WISHLIST liên quan đến houseId
            ps = connection.prepareStatement(deleteWishlistSql);
            ps.setInt(1, houseId);
            ps.executeUpdate();
            ps.close();

            // Xóa các hình ảnh của nhà
            ps = connection.prepareStatement(deleteHouseImagesSql);
            ps.setInt(1, houseId);
            ps.executeUpdate();
            ps.close();

            // Xóa các tiện ích của các phòng thuộc về nhà
            ps = connection.prepareStatement(deleteRoomUtilitiesSql);
            ps.setInt(1, houseId);
            ps.executeUpdate();
            ps.close();

            // Xóa các đơn hàng liên quan đến các phòng thuộc về nhà
            ps = connection.prepareStatement(deleteOrdersSql);
            ps.setInt(1, houseId);
            ps.executeUpdate();
            ps.close();

            // Xóa các đánh giá (reply feedback) liên quan đến các đánh giá của nhà
            ps = connection.prepareStatement(deleteReplyFeedbackSql);
            ps.setInt(1, houseId);
            ps.executeUpdate();
            ps.close();

            // Xóa các đánh giá (feedback) của nhà
            ps = connection.prepareStatement(deleteFeedbackSql);
            ps.setInt(1, houseId);
            ps.executeUpdate();
            ps.close();

            // Xóa các phòng thuộc về nhà
            ps = connection.prepareStatement(deleteRoomsSql);
            ps.setInt(1, houseId);
            ps.executeUpdate();
            ps.close();

            // Xóa nhà
            ps = connection.prepareStatement(deleteHouseSql);
            ps.setInt(1, houseId);
            int rowsAffected = ps.executeUpdate();
            ps.close();

            connection.commit(); // Commit transaction
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            if (connection != null) {
                try {
                    connection.rollback(); // Rollback transaction nếu có lỗi xảy ra
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
    public List<LocationModer> getAllLocations() {
        List<LocationModer> locations = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = getConnection();
            String sql = "SELECT location_id, location_name, location_link FROM PROPERTY_LOCATION";
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int locationId = resultSet.getInt("location_id");
                String locationName = resultSet.getString("location_name");
                String locationLink = resultSet.getString("location_link");
                LocationModer location = new LocationModer();
                location.setLocation_id(locationId);
                location.setLocation_name(locationName);
                location.setLocation_link(locationLink);
                locations.add(location);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(resultSet);
            closeStatement(statement);
            closeConnection(connection);
        }

        return locations;
    }

    @Override
    public boolean updateHouseStatusBasedOnRoomStatus(int landlordId) {
        String updateHouseStatusSql
                = "UPDATE HOUSE "
                + "SET status = CASE "
                + "WHEN NOT EXISTS (SELECT 1 FROM ROOM WHERE ROOM.house_id = HOUSE.house_id) THEN N'Hết phòng' "
                + "WHEN EXISTS (SELECT 1 FROM ROOM WHERE ROOM.house_id = HOUSE.house_id AND status = 0) THEN N'Hết phòng' "
                + "ELSE N'Còn phòng' "
                + "END "
                + "WHERE landlord_id = ?";

        try (Connection connection = getConnection(); PreparedStatement updateHouseStmt = connection.prepareStatement(updateHouseStatusSql)) {

            updateHouseStmt.setInt(1, landlordId);

            int updatedRows = updateHouseStmt.executeUpdate();
            return updatedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<HouseModel> getAllHouse(String id) {
        List<HouseModel> houses = new ArrayList<>();
        String sql = "SELECT h.*, PROPERTY_LOCATION.distance_km ,\n"
                + "               (CASE WHEN EXISTS (SELECT 1 FROM WISHLIST WHERE tenant_id = ? AND house_id = h.house_id) THEN 1 ELSE 0 END) AS is_favorite \n"
                + "\n"
                + "                FROM HOUSE h  INNER JOIN \n"
                + "                PROPERTY_LOCATION ON h.location_id = PROPERTY_LOCATION.location_id";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            IUser userd = new UserDAO();
            ps.setInt(1, userd.getTenantIDByUserID(Integer.parseInt(id)));

            rs = ps.executeQuery();
            while (rs.next()) {
                HouseModel house = new HouseModel();
                int house_id = rs.getInt("house_id");
                house.setId(house_id);
                house.setHouse_name(rs.getString("house_name"));
                house.setAddress(rs.getString("address"));
                house.setDescriptionHouse(rs.getString("description_house"));
                house.setStatus(rs.getString("status"));
                house.setDistance_km(rs.getString("distance_km"));
                boolean isFavorite = rs.getInt("is_favorite") == 1;
                house.setFavorite(isFavorite);

                List<HouseImages> ls = this.getHouseImage(house_id);
                house.setAvatarImage(ls.get(0).getImageUrl());
                Timestamp createDateTimestamp = rs.getTimestamp("create_date");
                if (createDateTimestamp != null) {
                    house.setCreateDate(createDateTimestamp.toLocalDateTime());
                }
                Timestamp updateDateTimestamp = rs.getTimestamp("update_date");
                if (updateDateTimestamp != null) {
                    house.setUpdateDate(updateDateTimestamp.toLocalDateTime());
                }
                IUser userDAO = new UserDAO();
                int landlord_id = rs.getInt("landlord_id");
                String email = userDAO.getEmailByLandlordId(landlord_id);
                ManageUser landlord = userDAO.getManageUser(email);
                if (landlord != null) {
                    house.setLandlord(landlord);
                }
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

    @Override
    public List<HouseImages> getHouseImage(int house_id) {
        List<HouseImages> images = new ArrayList<>();
        String sql = "select * from HOUSE_IMAGE where house_id = ?";
        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, house_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                HouseImages img = new HouseImages(rs.getInt("house_image_id"),
                        rs.getString("image_url"),
                        rs.getInt("house_id"));
                images.add(img);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }
        return images;
    }

    @Override
    public LocationModer getLocationModerById(int locationId) {
        List<LocationModer> listLocation = getAllLocations();
        for (LocationModer locationModer : listLocation) {
            if (locationModer.getLocation_id() == locationId) {
                return locationModer;
            }
        }
        return null;
    }

}
