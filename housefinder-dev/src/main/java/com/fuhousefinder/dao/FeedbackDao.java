/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuhousefinder.dao;

import com.fuhousefinder.context.DBContext;
import com.fuhousefinder.entity.Feedback;
import com.fuhousefinder.entity.ReplyFeedback;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hp
 */
public class FeedbackDao extends DBContext {

    public boolean checkUserFeedback(int userId, int houseId) {
    

    String checkSql = 
        "SELECT " +
        "  (SELECT COUNT(*) FROM ORDERS o " +
        "   JOIN ROOM r ON o.room_id = r.room_id " +
        "   JOIN HOUSE h ON r.house_id = h.house_id " +
        "   WHERE o.tenant_id = ? AND h.house_id = ? AND o.status = 'Approve') AS order_count, " +
        "  (SELECT COUNT(*) FROM FEEDBACK f WHERE f.tenant_id = ? AND f.house_id = ?) AS feedback_count";
    
    try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(checkSql)) {
        ps.setInt(1, userId);
        ps.setInt(2, houseId);
        ps.setInt(3, userId);
        ps.setInt(4, houseId);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                int orderCount = rs.getInt("order_count");
                int feedbackCount = rs.getInt("feedback_count");
                return orderCount > 0 && feedbackCount == 0; // Trả về true nếu có đơn đặt hàng được duyệt và chưa có phản hồi
            }
        }
    } catch (SQLException e) {
        Logger.getLogger(ReportDAO.class.getName()).log(Level.SEVERE, null, e);
        return false; // Trả về false nếu xảy ra lỗi
    }
    
    return false; // Trả về false nếu không có kết quả
}

    public static void main(String[] args) {
        FeedbackDao dao = new FeedbackDao();
        System.out.println(dao.checkUserFeedback(1, 4));
    }

public List<Feedback> getFeedbacks(int page, int recordsPerPage, int ratingFilter, String sort, String houseid) {
    List<Feedback> feedbackList = new ArrayList<>();
    StringBuilder selectFeedbacksSql = new StringBuilder("SELECT f.house_id, f.feedback_id, f.tenant_id, f.feedback_date, ")
            .append("f.rating_star, f.feedback_content, r.replyfeedback_id, r.landlord_id, r.reply_date, r.reply_content, u.first_name, u.last_name ")
            .append("FROM FEEDBACK f ")
            .append("LEFT JOIN REPLY_FEEDBACK r ON f.feedback_id = r.feedback_id ")
            .append("JOIN TENANT u ON f.tenant_id = u.tenant_id ")
            .append("WHERE f.house_id = ? ");

    // Thêm điều kiện lọc theo số sao nếu ratingFilter khác 0
    if (ratingFilter != 0) {
        selectFeedbacksSql.append("AND f.rating_star = ? ");
    }

    // Thêm điều kiện sắp xếp theo sort
    if ("oldest".equals(sort)) {
        selectFeedbacksSql.append("ORDER BY f.feedback_id ASC ");
    } else {
        selectFeedbacksSql.append("ORDER BY f.feedback_id DESC ");
    }

    selectFeedbacksSql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

    try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(selectFeedbacksSql.toString())) {

        int paramIndex = 1;
        ps.setString(paramIndex++, houseid); // Thiết lập house_id vào câu truy vấn

        if (ratingFilter != 0) {
            ps.setInt(paramIndex++, ratingFilter);
        }

        ps.setInt(paramIndex++, (page - 1) * recordsPerPage); // Tính toán offset
        ps.setInt(paramIndex++, recordsPerPage); // Số lượng bản ghi trên mỗi trang

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Feedback feedback = new Feedback(
                        rs.getInt("feedback_id"),
                        rs.getInt("tenant_id"),
                        rs.getInt("house_id"),
                        rs.getTimestamp("feedback_date").toLocalDateTime(),
                        rs.getInt("rating_star"),
                        rs.getString("feedback_content"),
                        rs.getString("reply_content"),
                        rs.getTimestamp("reply_date") != null ? rs.getTimestamp("reply_date").toLocalDateTime() : null,
                        rs.getString("first_name") + " " + rs.getString("last_name")
                );
                feedbackList.add(feedback);
            }
        }
    } catch (SQLException e) {
        Logger.getLogger(ReportDAO.class.getName()).log(Level.SEVERE, null, e);
    }

    return feedbackList;
}

    public int getTotalPages(int recordsPerPage, int ratingFilter) {
        StringBuilder countFeedbacksSql = new StringBuilder("SELECT COUNT(*) FROM FEEDBACK");

        if (ratingFilter != 0) {
            countFeedbacksSql.append(" WHERE rating_star = ?");
        }

        try (Connection connection = getConnection(); PreparedStatement ps = connection.prepareStatement(countFeedbacksSql.toString())) {

            if (ratingFilter != 0) {
                ps.setInt(1, ratingFilter);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int totalRecords = rs.getInt(1);
                    return (int) Math.ceil((double) totalRecords / recordsPerPage);
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(ReportDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return 0;
    }

    public int getTenantIdByUserId(int userId) {
        String sql = "SELECT tenant_id FROM TENANT WHERE user_id = ?";
        int tenantId = -1;

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);

            rs = ps.executeQuery();

            if (rs.next()) {
                tenantId = rs.getInt("tenant_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(rs);
            closeStatement(ps);
            closeConnection(connection);
        }

        return tenantId;
    }

    public boolean addFeedback(Feedback feedback, int userId) {

        int tenantId = getTenantIdByUserId(userId);
        if (tenantId == -1) {
            return false;
        }

        String insertFeedbackSql = "INSERT INTO [dbo].[FEEDBACK] "
                + "([tenant_id], [house_id], [feedback_date], [rating_star], [feedback_content]) "
                + "VALUES (?, ?, ?, ?, ?)";

        Connection connection = null;
        PreparedStatement ps = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(insertFeedbackSql);
            ps.setInt(1, tenantId); // Set tenant_id obtained from userId
            ps.setInt(2, feedback.getHouse_id());
            ps.setTimestamp(3, Timestamp.valueOf(feedback.getFeedbackDate()));
            ps.setInt(4, feedback.getRating());
            ps.setString(5, feedback.getContent());

            int affectedRows = ps.executeUpdate();

            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeStatement(ps);
            closeConnection(connection);
        }
    }

    public List<Feedback> getFeedbacksByHouseIds(String houseId, int page, int pageSize, int rating, String sort) {
        List<Feedback> feedbacks = new ArrayList<>();
        String query = "SELECT f.feedback_id, f.tenant_id, f.house_id, f.feedback_date, f.rating_star, f.feedback_content, "
                + "(SELECT COUNT(*) FROM REPLY_FEEDBACK rf WHERE rf.feedback_id = f.feedback_id) as has_reply, "
                + "t.first_name, t.last_name "
                + "FROM FEEDBACK f "
                + "JOIN TENANT t ON f.tenant_id = t.tenant_id "
                + "WHERE f.house_id = ? AND (? = -1 OR f.rating_star = ?) "
                + "ORDER BY f.feedback_date " + (sort.equals("newest") ? "DESC" : "ASC") + " "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        Connection connection = null;
        PreparedStatement statement = null;
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, Integer.parseInt(houseId));
            statement.setInt(2, rating);
            statement.setInt(3, rating);
            statement.setInt(4, (page - 1) * pageSize);
            statement.setInt(5, pageSize);

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(resultSet.getInt("feedback_id"));
                feedback.setTenant_id(resultSet.getInt("tenant_id"));
                feedback.setHouse_id(resultSet.getInt("house_id"));
                Date sqlDate = resultSet.getDate("feedback_date");
                Timestamp timestamp = new Timestamp(sqlDate.getTime());
                LocalDateTime feedbackDate = timestamp.toLocalDateTime();
                feedback.setFeedbackDate(feedbackDate);

                feedback.setRating(resultSet.getInt("rating_star"));
                feedback.setContent(resultSet.getString("feedback_content"));
                feedback.setHasReply(resultSet.getInt("has_reply") > 0);
                feedback.setTenantName(resultSet.getString("first_name") + " " + resultSet.getString("last_name"));

                feedbacks.add(feedback);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return feedbacks;
    }

    public int getFeedbackCountByHouseIds(String houseId, int rating) {
        String query = "SELECT COUNT(*) FROM FEEDBACK WHERE house_id = ? AND (? = -1 OR rating_star = ?)";
        Connection connection = null;
        PreparedStatement statement = null;
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);

            statement.setInt(1, Integer.parseInt(houseId));
            statement.setInt(2, rating);
            statement.setInt(3, rating);

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<ReplyFeedback> getRepliesByFeedbackId(int feedbackId) {
        List<ReplyFeedback> replies = new ArrayList<>();
        String query = "SELECT rf.replyfeedback_id, rf.feedback_id, rf.landlord_id, rf.reply_date, rf.reply_content, "
                + "CASE WHEN u.role_id = 2 THEN 1 ELSE 0 END as isAdminReply "
                + "FROM REPLY_FEEDBACK rf "
                + "JOIN USERS u ON rf.landlord_id = u.user_id "
                + "WHERE rf.feedback_id = ?";

        Connection connection = null;
        PreparedStatement statement = null;
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);

            statement.setInt(1, feedbackId);

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                ReplyFeedback reply = new ReplyFeedback();
                reply.setReplyFeedbackId(resultSet.getInt("replyfeedback_id"));
                reply.setFeedbackId(resultSet.getInt("feedback_id"));
                reply.setLandlordId(resultSet.getInt("landlord_id"));
                reply.setReplyDate(resultSet.getTimestamp("reply_date").toLocalDateTime());
                reply.setReplyContent(resultSet.getString("reply_content"));
                reply.setAdminReply(resultSet.getInt("isAdminReply") > 0);

                replies.add(reply);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return replies;
    }

    public boolean insertReplyFeedback(ReplyFeedback replyFeedback) {
        String query = "INSERT INTO REPLY_FEEDBACK (feedback_id, landlord_id, reply_date, reply_content) VALUES (?, ?, ?, ?)";

        Connection connection = null;
        PreparedStatement statement = null;
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);
            statement.setInt(1, replyFeedback.getFeedbackId());
            statement.setInt(2, replyFeedback.getLandlordId());
            statement.setDate(3, Date.valueOf(replyFeedback.getReplyDate().toLocalDate()));
            statement.setString(4, replyFeedback.getReplyContent());

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean hasReplied(int feedbackId, int landlordId) {
        String query = "SELECT COUNT(*) FROM REPLY_FEEDBACK WHERE feedback_id = ? AND landlord_id = ?";
        Connection connection = null;
        PreparedStatement statement = null;
        try {
            connection = getConnection();
            statement = connection.prepareStatement(query);

            statement.setInt(1, feedbackId);
            statement.setInt(2, landlordId);

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
