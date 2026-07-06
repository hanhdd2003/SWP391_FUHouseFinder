package com.fuhousefinder.controller.report;

import com.fuhousefinder.dao.ReportDAO;
import com.fuhousefinder.entity.Report;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.*;
/**
 *
 * @author hp
 */
@WebServlet(name = "viewreportdeatiladmin", urlPatterns = {"/view-report-deatil-admin"})
public class viewreportdeatiladmin extends HttpServlet {

   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet viewreportdeatiladmin</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet viewreportdeatiladmin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

   
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");

        ReportDAO dAO = new ReportDAO();

        List<Report> reportList = dAO.getAllByDetail(id);
        Report firstReport = null;
        if (!reportList.isEmpty()) {
            firstReport = reportList.get(0);
        }
        request.setAttribute("report", firstReport);

        request.getRequestDispatcher("/pages/report/ViewReportDeatilAdmin.jsp").forward(request, response);
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
