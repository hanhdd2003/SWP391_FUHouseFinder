package com.fuhousefinder.controller.report;

import com.fuhousefinder.dao.FeedbackDao;
import com.fuhousefinder.dao.ReportDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author phung
 */
@WebServlet(name = "checkFeedback", urlPatterns = {"/api/check-feedback"})
public class checkFeedback extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet checkFeedback</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet checkFeedback at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    
     private FeedbackDao feedbackDao = new FeedbackDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // Lấy tenantId và houseId từ query parameters
        int tenantId = Integer.parseInt(request.getParameter("tenant_id"));
        int houseId = Integer.parseInt(request.getParameter("house_id"));
        
        
        System.out.println(feedbackDao.getTenantIdByUserId(tenantId));
        boolean hasFeedback = feedbackDao.checkUserFeedback(feedbackDao.getTenantIdByUserId(tenantId), houseId);
        
        try (PrintWriter out = response.getWriter()) {
            out.print("{\"hasFeedback\": " + hasFeedback + "}");
        }
    }

 
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    public String getServletInfo() {
        return "Check if the user has submitted feedback for a specific house.";
    }// </editor-fold>

}
