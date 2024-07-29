package com.fuhousefinder.controller;

import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.List;

@WebServlet(name = "Upgrade", urlPatterns = {"/upgrade"})
public class UpgradeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            if (user.getRoleId() == 2) {
                IUser userDAO = new UserDAO();
                IUpgrade upgradeDAO = new UpgradeDAO();
                int landlord_id = userDAO.getLandlordIdByEmail(user.getEmail());
                List<Upgrade> upgraded = upgradeDAO.getUpgradeByLandlordID(landlord_id);
                request.setAttribute("list", upgraded);
                request.getRequestDispatcher("pages/profile/upgrade.jsp").forward(request, response);
            } else {
                response.sendRedirect("home.jsp");
            }
        } else {
            response.sendRedirect("pages/system/login.jsp");
        }

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
