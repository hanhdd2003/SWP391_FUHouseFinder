package com.fuhousefinder.controller.report;

import com.fuhousefinder.dao.ReportDAO;
import com.fuhousefinder.entity.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.time.LocalDateTime;

/**
 *
 * @author hp
 */
@WebServlet(name = "Sendreport", urlPatterns = {"/Send-report"})
public class Sendreport extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Sendreport</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Sendreport at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String report_problem = request.getParameter("report_problem").trim();
        String report_description = request.getParameter("report_description").trim();
        if (report_problem.isEmpty() || report_description.isEmpty() || report_problem.equals("") || report_description.equals("")) {
            sendErrorResponse(response, "không được để trống");
            request.getRequestDispatcher("view-report").forward(request, response);

            return;
        }

//        if (report_problem.contains("  ") || report_description.contains("  ")) {
//            sendErrorResponse(response, "Vấn đề và mô tả không được chứa khoảng trắng liên tiếp");
//            request.getRequestDispatcher("view-report").forward(request, response);
//
//            return;
//        }
        if (report_problem.length() > 50) {
            sendErrorResponse(response, "Vấn đề không thể vượt quá 255 ký tự");
            request.getRequestDispatcher("view-report").forward(request, response);

            return;
        }

        if (report_description.length() > 255) {
            sendErrorResponse(response, "Vấn đề không thể vượt quá 255 ký tự");
            request.getRequestDispatcher("view-report").forward(request, response);

            return;
        }

        LocalDateTime createDate = LocalDateTime.now();
        HttpSession session = request.getSession();
        User userLogin = (User) session.getAttribute("user");
        ReportDAO dao = new ReportDAO();
        Report report = new Report();

        report.setUserid(String.valueOf(userLogin.getId()));
        report.setReport_dates(createDate);
        report.setReport_description(report_description);
        report.setReport_problem(report_problem);
        dao.addReport(report);

        request.setAttribute("err", "sent");
        request.getRequestDispatcher("view-report").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String report_problem = request.getParameter("report_problem").trim();
        String report_description = request.getParameter("report_description").trim();

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (report_problem.isEmpty() || report_description.isEmpty()) {
            sendErrorResponse(response, "Không được để trống");
            return;
        }

        if (report_problem.contains("  ") || report_description.contains("  ")) {
            sendErrorResponse(response, "Vấn đề và mô tả không được chứa khoảng trắng liên tiếp");
            return;
        }

        if (report_problem.length() > 50) {
            sendErrorResponse(response, "Vấn đề không thể vượt quá 50 ký tự");
            return;
        }

        if (report_description.length() > 255) {
            sendErrorResponse(response, "Mô tả không thể vượt quá 255 ký tự");
            return;
        }

        try {
            LocalDateTime createDate = LocalDateTime.now();
            HttpSession session = request.getSession();
            User userLogin = (User) session.getAttribute("user");
            ReportDAO dao = new ReportDAO();
            Report report = new Report();

            if (userLogin != null) {
                report.setUserid(String.valueOf(userLogin.getId()));
                report.setReport_dates(createDate);
                report.setReport_description(report_description);
                report.setReport_problem(report_problem);
                dao.addReport(report);

                // Send success response
                PrintWriter out = response.getWriter();
                out.print("{\"success\": \"sent\"}");
                out.flush();
            }else{
                sendErrorResponse(response, "Bạn chưa đăng nhập, vui lòng đăng nhập");
            }
            

        } catch (Exception e) {
            sendErrorResponse(response, "Đã xảy ra lỗi trong quá trình xử lý báo cáo.");
        }
    }

    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        PrintWriter out = response.getWriter();
        out.print("{\"error\": \"" + message + "\"}");
        out.flush();
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
