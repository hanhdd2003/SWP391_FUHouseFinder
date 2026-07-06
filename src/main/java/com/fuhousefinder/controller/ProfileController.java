package com.fuhousefinder.controller;

import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.List;

@WebServlet(name = "ProfileController", urlPatterns = {"/Profile"})
public class ProfileController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        OrderDAO orderDAO = new OrderDAO();
        IUser usDAO = new UserDAO();
        String service = request.getParameter("service");
        if (service == null) {
            service = "ViewProfile";
        }
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("/pages/system/login.jsp");
            return;
        }
        switch (service) {
            case "ViewProfile": {
                com.fuhousefinder.entity.Profile p = (com.fuhousefinder.entity.Profile) session.getAttribute("profile");
                int tenantID = usDAO.getTenantIDByUserID(user.getId());
                String orderStatus = request.getParameter("status");

                if (orderStatus == null) {
                    orderStatus = "Đã hủy thuê phòng";
                }
                List<BookingOrderModel> ordersByTenant = orderDAO.getAllOrdersByTenantID(tenantID, orderStatus);
                request.setAttribute("orders", ordersByTenant);
                session.setAttribute("profile", p);
                request.getRequestDispatcher("pages/profile/profile.jsp").forward(request, response);
                break;
            }
        }
    }

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
