package com.fuhousefinder.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

public class Logout extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            session.removeAttribute("user");
            session.removeAttribute("profile");
            session.invalidate();
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("email")) {
                        cookie.setValue("");
                        cookie.setMaxAge(0); // Đặt thời gian sống của cookie về 0 để xóa nó
                        cookie.setPath(request.getContextPath()); // Đặt lại Path của cookie
                        response.addCookie(cookie); // Thêm lại cookie vào phản hồi để gửi đi và xóa khỏi trình duyệt
                    }
                }
            }
            request.setAttribute("alertMessage", "Đã Đăng Xuất");
            request.setAttribute("alertType", "info");
            request.getRequestDispatcher("home").forward(request, response);
            //response.sendRedirect("home.jsp");
        } catch (ServletException | IOException e) {
            response.sendRedirect("pages/error/error500.jsp");
        }
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
