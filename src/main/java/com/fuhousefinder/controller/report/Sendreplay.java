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
@WebServlet(name = "Sendreplay", urlPatterns = {"/Sendreplay"})
public class Sendreplay extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Sendreplay</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Sendreplay at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String report_description = request.getParameter("report_description").trim();
        String report_id = request.getParameter("report_id").trim();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (report_description.isEmpty()) {
            sendErrorResponse(response, "Không được để trống");
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
            ReplyReport r = new ReplyReport();
            r.setAdminId(userLogin.getId());
            r.setReportId(Integer.parseInt(report_id));
            r.setReplyDate(createDate);
            r.setReplyContent(report_description);

            boolean success = dao.insertReplyFeedback(r);

            PrintWriter out = response.getWriter();
            if (success) {
                out.print("{\"success\": \"sent\"}");
            } else {
                sendErrorResponse(response, "Đã xảy ra lỗi trong quá trình xử lý báo cáo.");
            }
            out.flush();
        } catch (Exception e) {
            // Ghi log chi tiết lỗi
            e.printStackTrace();
            sendErrorResponse(response, "Đã xảy ra lỗi trong quá trình xử lý báo cáo.");
        }
    }

    private void sendErrorResponse(HttpServletResponse response, String errorMessage) throws IOException {
        PrintWriter out = response.getWriter();
        out.print("{\"error\": \"" + errorMessage + "\"}");
        out.flush();
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
