package com.fuhousefinder.controller.adminservlet;

import com.fuhousefinder.dao.IUser;
import com.fuhousefinder.dao.UserDAO;
import com.fuhousefinder.entity.ManageUser;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ViewDetailProfile", urlPatterns = {"/ViewDetailProfile"})
public class ViewDetailProfile extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        IUser dao = new UserDAO();
        String email = request.getParameter("email");
        ManageUser u = dao.getManageUser(email);
        //System.out.println(email +" " +u.getLastName());
        request.setAttribute("u", u);
        request.getRequestDispatcher("pages/admin/userdetail.jsp").forward(request, response);
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
