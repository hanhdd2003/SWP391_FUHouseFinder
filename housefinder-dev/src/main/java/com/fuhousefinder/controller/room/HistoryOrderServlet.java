package com.fuhousefinder.controller.room;

import com.fuhousefinder.dao.OrderDAO;
import com.fuhousefinder.dao.UserDAO;
import com.fuhousefinder.entity.HistoryOrder;
import com.fuhousefinder.entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;


@WebServlet(name="HistoryOrder", urlPatterns={"/historyorder"})
public class HistoryOrderServlet extends HttpServlet {
   
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        OrderDAO dao = new OrderDAO();
        UserDAO userdao = new UserDAO();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int tenantId = userdao.getTenantIDByUserID(user.getId());
        List<HistoryOrder> historyOrder = dao.getHistoryOrderByTenantId(tenantId);
        request.setAttribute("history", historyOrder);
        request.getRequestDispatcher("pages/room/historyorder.jsp").forward(request, response);       
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
