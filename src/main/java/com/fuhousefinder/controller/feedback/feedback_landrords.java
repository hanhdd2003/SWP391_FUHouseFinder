/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.fuhousefinder.controller.feedback;

import com.fuhousefinder.configs.LocalDateTimeAdapter;
import com.fuhousefinder.dao.FeedbackDao;
import com.fuhousefinder.entity.Feedback;
import com.fuhousefinder.entity.FeedbackResponse;
import com.fuhousefinder.entity.User;
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
 * @author hp
 */
@WebServlet(name="feedback_landrords", urlPatterns={"/feedback-landrords"})
public class feedback_landrords extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet feedback_landrords</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet feedback_landrords at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        String houseId = (String) session.getAttribute("houseId");

        // Kiểm tra nếu houseId null hoặc rỗng
        if (houseId == null || houseId.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "houseId is missing.");
            return;
        }

        String pageParam = request.getParameter("page");
        String ratingParam = request.getParameter("rating");
        String sortParam = request.getParameter("sort");

        int page = 1;
        int rating = -1; // Default value to indicate all ratings
        String sort = "newest"; // Default sort order

        // Kiểm tra và gán giá trị nếu tham số không null hoặc rỗng
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        if (ratingParam != null && !ratingParam.isEmpty() && !ratingParam.equals("all")) {
            try {
                rating = Integer.parseInt(ratingParam);
            } catch (NumberFormatException e) {
                rating = -1; 
            }
        }

        if (sortParam != null && !sortParam.isEmpty()) {
            sort = sortParam;
        }

        FeedbackDao feedbackDAO = new FeedbackDao();
        List<Feedback> feedbacks = feedbackDAO.getFeedbacksByHouseIds(houseId, page, 10, rating, sort);
        int totalFeedbacks = feedbackDAO.getFeedbackCountByHouseIds(houseId, rating);
        int totalPages = (int) Math.ceil((double) totalFeedbacks / 10);
 User userLogin = (User) session.getAttribute("user");
for (Feedback feedback : feedbacks) {
            boolean hasReplied = feedbackDAO.hasReplied(feedback.getFeedbackId(), userLogin.getId());
            feedback.setHasReplied(hasReplied); 
        }

        FeedbackResponse feedbackResponse = new FeedbackResponse(feedbacks, totalPages, page);

        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();

        try (PrintWriter out = response.getWriter()) {
            out.print(gson.toJson(feedbackResponse));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal server error.");
        }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
