package com.fuhousefinder.controller;

import com.fuhousefinder.dao.IUser;
import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.User;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;

@MultipartConfig
public class UploadAvatar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UploadAvatar</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UploadAvatar at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        try {
            String uploadPath = request.getServletContext().getRealPath("/img/avatar/");
            Part filePart = request.getPart("avatar");

            // Tạo thư mục lưu trữ nếu chưa tồn tại
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Lưu file vào thư mục
            String fileName = filePart.getSubmittedFileName();
            filePart.write(uploadPath + File.separator + fileName);

            HttpSession session = request.getSession();
            IUser dao = new UserDAO();
            User u = (User) session.getAttribute("user");
            String email = u.getEmail();
            dao.editAvatar(u.getId(), fileName);
            u = dao.getUserByEmail(email);
            session.setAttribute("user", u);
            // Redirect hoặc forward tùy thuộc vào logic của ứng dụng
            response.sendRedirect("/HFManagementSystem/pages/profile/profile.jsp"); // Ví dụ: chuyển hướng đến trang profile
        } catch (ServletException | IOException e) {
            response.sendRedirect("pages/error/error500.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
