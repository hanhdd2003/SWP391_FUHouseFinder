package com.fuhousefinder.controller.adminservlet;

import com.fuhousefinder.dao.IUpgrade;
import com.fuhousefinder.dao.UpgradeDAO;
import com.fuhousefinder.entity.Upgrade;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "TransactionServlet", urlPatterns = {"/transaction"})
public class TransactionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        IUpgrade dao = new UpgradeDAO();
        int page = 1;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        List<Upgrade> list = dao.getAll();

        request.setAttribute("data", pagination(request, list, page));
        request.getRequestDispatcher("pages/admin/transaction.jsp").forward(request, response);
    }

    private List<Upgrade> pagination(HttpServletRequest request, List<Upgrade> list, int page) {
        int recordsPerPage = 9;
        int totalRecords = list.size();
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
        int startIndex = (page - 1) * recordsPerPage;
        int endIndex = Math.min(startIndex + recordsPerPage, totalRecords);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        return list.subList(startIndex, endIndex);
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
