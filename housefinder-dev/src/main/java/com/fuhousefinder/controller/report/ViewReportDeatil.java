package com.fuhousefinder.controller.report;

import com.fuhousefinder.dao.ReportDAO;
import com.fuhousefinder.entity.User;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

/**
 *
 * @author hp
 */
@WebServlet(name="ViewReportDeatil", urlPatterns={"/view-eeport-deatil"})
public class ViewReportDeatil extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewReportDeatil</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewReportDeatil at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        User userLogin = (User) session.getAttribute("user");
        ReportDAO dAO = new ReportDAO();
        request.setAttribute("user", dAO.getAllByIds(String.valueOf(userLogin.getId())));
        request.getRequestDispatcher("/pages/report/ViewReportDeatil.jsp").forward(request, response);
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
