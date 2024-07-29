package com.fuhousefinder.controller;

import com.fuhousefinder.dao.IUpgrade;
import com.fuhousefinder.dao.UpgradeDAO;
import com.fuhousefinder.entity.Upgrade;
import com.fuhousefinder.entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;


@WebServlet(name="HistoryTransaction", urlPatterns={"/historytransaction"})
public class HistoryTransaction extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        IUpgrade dao = new UpgradeDAO();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        List<Upgrade> list = dao.getUpgradeByUserID(user.getId());
        request.setAttribute("data", list);
        request.getRequestDispatcher("pages/profile/historytransaction.jsp").forward(request, response);
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
