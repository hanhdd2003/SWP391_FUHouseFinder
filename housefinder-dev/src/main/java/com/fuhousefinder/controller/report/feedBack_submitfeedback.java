package com.fuhousefinder.controller.report;

import com.fuhousefinder.configs.LocalDateTimeAdapter;
import com.fuhousefinder.dao.FeedbackDao;
import com.fuhousefinder.dao.ReportDAO;
import com.fuhousefinder.entity.*;
import com.google.gson.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.time.LocalDateTime;

/**
 *
 * @author phung
 */
@WebServlet(name = "feedBack_submitfeedback", urlPatterns = {"/api/submit-feedback"})
public class feedBack_submitfeedback extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet feedBack_submitfeedback</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet feedBack_submitfeedback at " + request.getContextPath() + "</h1>");
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
       protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // Đăng ký TypeAdapter tùy chỉnh cho LocalDateTime
        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();

        try {
            Feedback feedback = gson.fromJson(request.getReader(), Feedback.class);
            feedback.setFeedbackDate(LocalDateTime.now());
      
            if (feedback.getRating()< 1 || feedback.getRating() > 5) {
                throw new IllegalArgumentException("Rating star must be between 1 and 5.");
            }
            
              HttpSession session = request.getSession();
        User userLogin = (User) session.getAttribute("user");

            FeedbackDao feedbackDAO = new FeedbackDao();
            boolean isAdded = feedbackDAO.addFeedback(feedback,userLogin.getId());

            if (isAdded) {
                out.print("{\"success\": true}");
            } else {
                out.print("{\"success\": false}");
            }
        } catch (IllegalArgumentException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false}");
        }
    
    }

    
       
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
