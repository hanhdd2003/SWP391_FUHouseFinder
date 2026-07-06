package com.fuhousefinder.controller.adminservlet;

import com.fuhousefinder.dao.ReportDAO;
import com.fuhousefinder.dao.IReport;
import com.fuhousefinder.entity.Report;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.List;

@WebServlet(name = "ManageReportServlet", urlPatterns = {"/managereport"})
public class ManageReportServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int recordsPerPage = 10;
        String sort = "newest"; // mặc định sắp xếp theo mới nhất
        String status = "all"; // mặc định là tất cả

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        if (request.getParameter("sort") != null) {
            sort = request.getParameter("sort");
        }
        if (request.getParameter("status") != null) {
            status = request.getParameter("status");
        }

        ReportDAO reportDAO = new ReportDAO();
        List<Report> listReport = reportDAO.getAllss(sort, status); 
        int totalRecords = listReport.size();

        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

        int startIndex = (page - 1) * recordsPerPage;
        int endIndex = Math.min(startIndex + recordsPerPage, totalRecords);

        List<Report> sublist = listReport.subList(startIndex, endIndex);

        request.setAttribute("list", sublist);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("sort", sort); // lưu giá trị sort vào request attribute
        request.setAttribute("status", status); // lưu giá trị status vào request attribute

        request.getRequestDispatcher("/pages/admin/managereport.jsp").forward(request, response);
    }


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
