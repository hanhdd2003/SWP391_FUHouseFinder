package com.fuhousefinder.dao;

import com.fuhousefinder.entity.*;
import com.fuhousefinder.context.DBContext;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;
import java.util.logging.*;
import java.time.format.DateTimeFormatter;

public class ReportDAO extends DBContext implements IReport {
 public List<Report> getAllss(String sort, String status) {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Report> list = new ArrayList<>();
        try {
            connection = getConnection();
            String orderBy = "report_date DESC"; // mặc định sắp xếp theo mới nhất
            if ("oldest".equals(sort)) {
                orderBy = "report_date ASC";
            }

            String statusCondition = "";
            if (status.equals("processed")) {
                statusCondition = "AND r.status = 1 ";
            } else if (status.equals("unprocessed")) {
                statusCondition = "AND r.status = 0 ";
            }

            String strSelect = "SELECT * FROM REPORT r WHERE 1=1 " + statusCondition + "ORDER BY " + orderBy;
            stm = connection.prepareStatement(strSelect);
            rs = stm.executeQuery();
            while (rs.next()) {
                int userId = rs.getInt("user_id");
                IUser userdao = new UserDAO();
                ManageUser user_report = userdao.getManageUserByUserID(userId);
                Report report = new Report(rs.getInt("report_id"),
                        user_report,
                        rs.getString("report_problem"),
                        rs.getString("report_description"),
                        rs.getTimestamp("report_date").toLocalDateTime(),
                        rs.getBoolean("status"));
                list.add(report);
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

    public List<Report> getAllReportsByUserId(String userId, String sort, String status, int page, int recordsPerPage) {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Report> list = new ArrayList<>();
        try {
            connection = getConnection();
            String orderBy = "";
            if (sort.equals("newest")) {
                orderBy = "ORDER BY r.report_date DESC";
            } else if (sort.equals("oldest")) {
                orderBy = "ORDER BY r.report_date ASC";
            }

            String statusCondition = "";
            if (status.equals("processed")) {
                statusCondition = "AND r.status = 1 ";
            } else if (status.equals("unprocessed")) {
                statusCondition = "AND r.status = 0 ";
            }

            String strSelect = "SELECT r.report_id, r.user_id, r.report_date, r.report_problem, r.report_description, r.status, "
                    + "rr.replyreport_id, rr.admin_id, rr.reply_date, rr.reply_content "
                    + "FROM REPORT r "
                    + "LEFT JOIN REPLY_REPORT rr ON r.report_id = rr.report_id "
                    + "WHERE r.user_id = ? "
                    + statusCondition
                    + orderBy
                    + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

            stm = connection.prepareStatement(strSelect);
            stm.setString(1, userId);
            stm.setInt(2, (page - 1) * recordsPerPage);
            stm.setInt(3, recordsPerPage);
            rs = stm.executeQuery();
            while (rs.next()) {

                int userIds = rs.getInt("user_id");
                IUser userdao = new UserDAO();
                ManageUser user_report = userdao.getManageUserByUserID(userIds);

                Report report = new Report(rs.getInt("report_id"),
                        user_report,
                        rs.getString("report_problem"),
                        rs.getString("report_description"),
                        rs.getTimestamp("report_date").toLocalDateTime(),
                        rs.getBoolean("status"));

                if (rs.getInt("replyreport_id") != 0) {
                    ReplyReport replyReport = new ReplyReport(
                            rs.getInt("replyreport_id"),
                            rs.getInt("admin_id"),
                            rs.getInt("report_id"),
                            rs.getTimestamp("reply_date").toLocalDateTime(),
                            rs.getString("reply_content"));
                    report.setReplyReport(replyReport);
                }

                list.add(report);
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
    public Report getReportByID(int report_id) {
        return null;
    }

    @Override
    public void closeReport(int report_id) {
    }

    public boolean addReport(Report report) {
        String insertHouseSql = "INSERT INTO [dbo].[REPORT]\n"
                + "           ([user_id],[report_date]\n"
                + "           ,[report_problem]\n"
                + "           ,[report_description]\n"
                + "           ,[status])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,'0'\n"
                + "           )";

        Connection connection = null;
        PreparedStatement housePs = null;
        ResultSet generatedKeys = null;

        try {
            connection = getConnection();
            housePs = connection.prepareStatement(insertHouseSql, Statement.RETURN_GENERATED_KEYS);
            housePs.setString(1, report.getUserid());
            housePs.setTimestamp(2, Timestamp.valueOf(report.getReport_dates()));
            housePs.setString(3, report.getReport_problem());
            housePs.setString(4, report.getReport_description());

            int affectedRows = housePs.executeUpdate();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            closeResultSet(generatedKeys);
            closeStatement(housePs);
            closeConnection(connection);
        }
    }

    public List<Report> getAllById(String id) {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Report> list = new ArrayList<>();
        try {
            connection = getConnection();
            String strSelect = "SELECT r.report_id, r.user_id, r.report_date, r.report_problem, r.report_description, r.status, "
                    + "rr.replyreport_id, rr.admin_id, rr.reply_date, rr.reply_content "
                    + "FROM REPORT r "
                    + "LEFT JOIN REPLY_REPORT rr ON r.report_id = rr.report_id "
                    + "WHERE r.user_id = ?";
            stm = connection.prepareStatement(strSelect);
            stm.setString(1, id);
            rs = stm.executeQuery();

            while (rs.next()) {

                int userId = rs.getInt("user_id");
                IUser userdao = new UserDAO();
                ManageUser user_report = userdao.getManageUserByUserID(userId);

                Report report = new Report(rs.getInt("report_id"),
                        user_report,
                        rs.getString("report_problem"),
                        rs.getString("report_description"),
                        rs.getTimestamp("report_date").toLocalDateTime(),
                        rs.getBoolean("status"));

                if (rs.getInt("replyreport_id") != 0) {
                    ReplyReport replyReport = new ReplyReport(
                            rs.getInt("replyreport_id"),
                            rs.getInt("admin_id"),
                            rs.getInt("report_id"),
                            rs.getTimestamp("reply_date").toLocalDateTime(),
                            rs.getString("reply_content"));
                    report.setReplyReport(replyReport);
                }

                list.add(report);
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

    public List<Report> getAllReportsByUserId(String userId, String sort, int page, int recordsPerPage) {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Report> list = new ArrayList<>();
        try {
            connection = getConnection();
            String orderBy = "";
            if (sort.equals("newest")) {
                orderBy = "ORDER BY r.report_date DESC";
            } else if (sort.equals("oldest")) {
                orderBy = "ORDER BY r.report_date ASC";
            }

            String strSelect = "SELECT r.report_id, r.user_id, r.report_date, r.report_problem, r.report_description, r.status, "
                    + "rr.replyreport_id, rr.admin_id, rr.reply_date, rr.reply_content "
                    + "FROM REPORT r "
                    + "LEFT JOIN REPLY_REPORT rr ON r.report_id = rr.report_id "
                    + "WHERE r.user_id = ? "
                    + orderBy
                    + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

            stm = connection.prepareStatement(strSelect);
            stm.setString(1, userId);
            stm.setInt(2, (page - 1) * recordsPerPage);
            stm.setInt(3, recordsPerPage);
            rs = stm.executeQuery();
            while (rs.next()) {

                int userIds = rs.getInt("user_id");
                IUser userdao = new UserDAO();
                ManageUser user_report = userdao.getManageUserByUserID(userIds);

                Report report = new Report(rs.getInt("report_id"),
                        user_report,
                        rs.getString("report_problem"),
                        rs.getString("report_description"),
                        rs.getTimestamp("report_date").toLocalDateTime(),
                        rs.getBoolean("status"));

                if (rs.getInt("replyreport_id") != 0) {
                    ReplyReport replyReport = new ReplyReport(
                            rs.getInt("replyreport_id"),
                            rs.getInt("admin_id"),
                            rs.getInt("report_id"),
                            rs.getTimestamp("reply_date").toLocalDateTime(),
                            rs.getString("reply_content"));
                    report.setReplyReport(replyReport);
                }

                list.add(report);
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

    public int getReportCountByUserId(String userId) {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int count = 0;
        try {
            connection = getConnection();
            String strCount = "SELECT COUNT(*) AS count "
                    + "FROM REPORT "
                    + "WHERE user_id = ?";
            stm = connection.prepareStatement(strCount);
            stm.setString(1, userId);
            rs = stm.executeQuery();

            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return count;
    }

    public List<Report> getAllByIds(String id) {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Report> list = new ArrayList<>();
        try {
            connection = getConnection();
            String strSelect = "SELECT r.report_id, r.user_id, r.report_date, r.report_problem, r.report_description, r.status, "
                    + "rr.replyreport_id, rr.admin_id, rr.reply_date, rr.reply_content "
                    + "FROM REPORT r "
                    + "LEFT JOIN REPLY_REPORT rr ON r.report_id = rr.report_id "
                    + "WHERE r.user_id = ?";
            stm = connection.prepareStatement(strSelect);
            stm.setString(1, id);
            rs = stm.executeQuery();

            while (rs.next()) {

                int userId = rs.getInt("user_id");
                IUser userdao = new UserDAO();
                ManageUser user_report = userdao.getManageUserByUserID(userId);

                Report report = new Report(rs.getInt("report_id"),
                        user_report,
                        rs.getString("report_problem"),
                        rs.getString("report_description"),
                        rs.getTimestamp("report_date").toLocalDateTime(),
                        rs.getBoolean("status"));

                if (rs.getInt("replyreport_id") != 0) {
                    ReplyReport replyReport = new ReplyReport(
                            rs.getInt("replyreport_id"),
                            rs.getInt("admin_id"),
                            rs.getInt("report_id"),
                            rs.getTimestamp("reply_date").toLocalDateTime(),
                            rs.getString("reply_content"));
                    report.setReplyReport(replyReport);
                }

                list.add(report);
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

    public List<Report> getAllByDetail(String id) {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Report> list = new ArrayList<>();
        try {
            connection = getConnection();
            String strSelect = "SELECT r.report_id, r.user_id, r.report_date, r.report_problem, r.report_description, r.status, "
                    + "rr.replyreport_id, rr.admin_id, rr.reply_date, rr.reply_content "
                    + "FROM REPORT r "
                    + "LEFT JOIN REPLY_REPORT rr ON r.report_id = rr.report_id "
                    + "WHERE r.report_id = ?";
            stm = connection.prepareStatement(strSelect);
            stm.setString(1, id);
            rs = stm.executeQuery();
            while (rs.next()) {
                int userId = rs.getInt("user_id");
                IUser userdao = new UserDAO();
                ManageUser user_report = userdao.getManageUserByUserID(userId);

                Report report = new Report(rs.getInt("report_id"),
                        user_report,
                        rs.getString("report_problem"),
                        rs.getString("report_description"),
                        rs.getTimestamp("report_date").toLocalDateTime(),
                        rs.getBoolean("status"));

                if (rs.getInt("replyreport_id") != 0) {
                    ReplyReport replyReport = new ReplyReport(
                            rs.getInt("replyreport_id"),
                            rs.getInt("admin_id"),
                            rs.getInt("report_id"),
                            rs.getTimestamp("reply_date").toLocalDateTime(),
                            rs.getString("reply_content"));

                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
                    String formattedReplyDate = "";
                    if (rs.getTimestamp("reply_date") != null) {
                        Timestamp replyDateTimestamp = rs.getTimestamp("reply_date");
                        LocalDateTime replyDate = replyDateTimestamp.toLocalDateTime();
                        formattedReplyDate = replyDate.format(formatter);
                        replyReport.setReplyDate(replyDate);
                    }
                    report.setReplyReport(replyReport);
                }

                list.add(report);
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class
                    .getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return list;
    }

    public boolean insertReplyFeedback(ReplyReport report) {
        String sql = "INSERT INTO REPLY_REPORT (admin_id, report_id, reply_date, reply_content) VALUES (?, ?, ?, ?)";

        Connection connection = null;
        PreparedStatement ps = null;
        ResultSet generatedKeys = null;

        try {
            connection = getConnection();
            ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);

            ps.setInt(1, report.getAdminId());
            ps.setInt(2, report.getReportId());
            ps.setTimestamp(3, java.sql.Timestamp.valueOf(report.getReplyDate()));
            ps.setString(4, report.getReplyContent());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                // Retrieve the auto-generated key (if any)
                generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    report.setReplyReportId(generatedKeys.getInt(1));
                }

                // Update status to 1 in REPORT table
                updateReportStatus(connection, report.getReportId());

                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResultSet(generatedKeys);
            closeStatement(ps);
            closeConnection(connection);
        }
        return false;
    }

    private void updateReportStatus(Connection connection, int reportId) throws SQLException {
        String updateStatusSql = "UPDATE REPORT SET status = 1 WHERE report_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(updateStatusSql)) {
            ps.setInt(1, reportId);
            ps.executeUpdate();
        }
    }

    @Override
    public List<Report> getAll(String sort) {
        Connection connection = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Report> list = new ArrayList<>();
        try {
            connection = getConnection();
            String orderBy = "report_date DESC"; // mặc định sắp xếp theo mới nhất
            if ("oldest".equals(sort)) {
                orderBy = "report_date ASC";
            }
            String strSelect = "SELECT * FROM REPORT ORDER BY " + orderBy;
            stm = connection.prepareStatement(strSelect);
            rs = stm.executeQuery();
            while (rs.next()) {
                int userId = rs.getInt("user_id");
                IUser userdao = new UserDAO();
                ManageUser user_report = userdao.getManageUserByUserID(userId);
                Report report = new Report(rs.getInt("report_id"),
                        user_report,
                        rs.getString("report_problem"),
                        rs.getString("report_description"),
                        rs.getTimestamp("report_date").toLocalDateTime(),
                        rs.getBoolean("status"));
                list.add(report);
            }
        } catch (SQLException e) {
            Logger.getLogger(User.class
                    .getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResultSet(rs);
            closeStatement(stm);
            closeConnection(connection);
        }
        return list;
    }

    // Phương thức getAll không có tham số để duy trì tương thích với mã hiện có
    @Override
    public List<Report> getAll() {
        return getAll("newest");
    }

    
}
