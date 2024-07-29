
package com.fuhousefinder.controller.adminservlet;

import com.fuhousefinder.dao.UpgradeDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;


@WebServlet(name="DashBoard", urlPatterns={"/dashboard"})
public class DashBoard extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        UpgradeDAO dao = new UpgradeDAO();
        double transactionMonth = dao.getTransactionMonth();
        double transactionYear = dao.getTransactionYear();
        double percentSuccess = dao.getPercentRentSuccess();
        int pending = dao.getNumberPending();
        request.setAttribute("pending", pending);
        request.setAttribute("success", (int)percentSuccess);
        request.setAttribute("month", transactionMonth);
        request.setAttribute("year", transactionYear);
        request.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(request, response);
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
