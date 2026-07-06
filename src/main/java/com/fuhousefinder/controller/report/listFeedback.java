package com.fuhousefinder.controller.report;

import com.fuhousefinder.configs.LocalDateTimeAdapter;
import com.fuhousefinder.dao.FeedbackDao;
import com.fuhousefinder.dao.ReportDAO;
import com.fuhousefinder.entity.Feedback;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author phung
 */
@WebServlet(name = "listFeedback", urlPatterns = {"/api/comments"})
public class listFeedback extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet listFeedback</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet listFeedback at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
        HttpSession session = request.getSession();

        String houseId = (String) session.getAttribute("houseId");

        String pageParam = request.getParameter("page");
        int page = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;
        int recordsPerPage = 5;

        String ratingParam = request.getParameter("rating");
        int ratingFilter = (ratingParam != null && !ratingParam.equals("all") && !ratingParam.isEmpty()) ? Integer.parseInt(ratingParam) : 0;

        String sortParam = request.getParameter("sort");
        String sort = (sortParam != null && !sortParam.isEmpty()) ? sortParam : "newest";

        try {
            FeedbackDao feedbackDAO = new FeedbackDao();
            List<Feedback> feedbacks = feedbackDAO.getFeedbacks(page, recordsPerPage, ratingFilter, sort ,houseId);
            int totalPages = feedbackDAO.getTotalPages(recordsPerPage, ratingFilter);

            CommentsResponse commentsResponse = new CommentsResponse(feedbacks, totalPages);
            out.print(gson.toJson(commentsResponse));
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false}");
        }
    }

    private static class CommentsResponse {

        private List<Feedback> comments;
        private int totalPages;

        public CommentsResponse(List<Feedback> comments, int totalPages) {
            this.comments = comments;
            this.totalPages = totalPages;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
