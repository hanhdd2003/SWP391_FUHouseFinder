    package com.fuhousefinder.controller;

import com.fuhousefinder.dao.IUser;
import com.fuhousefinder.configs.*;
import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.AlertMessage;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import com.fuhousefinder.entity.User;
import com.google.gson.Gson;
import java.security.NoSuchAlgorithmException;
import java.util.*;
import java.util.logging.*;

public class Change extends HttpServlet {

    private final Validate val = new Validate();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // lấy dữ liệu từ request
            String oldPassword = request.getParameter("oldpassword").trim();
            String newPassword = request.getParameter("newpassword").trim();
            String confirmPass = request.getParameter("confirmPassword").trim();

            // khai báo biến
            IUser userDao = new UserDAO();
            EncodeData encode = new EncodeData();
            List<AlertMessage> alertMessages = new ArrayList<>();
            boolean isValid = true;
            // lấy session
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            //kiểm tra lỗi 
            if (!val.checkPassword(newPassword)) {
                alertMessages.add(new AlertMessage("Mật khẩu mới không hợp lệ", "danger"));
                isValid = false;
            }
            if (!newPassword.equals(confirmPass)) {
                alertMessages.add(new AlertMessage("Mật khẩu mới và xác nhận mật khẩu không trùng nhau", "danger"));
                isValid = false;
            }
            if (!encode.checkLogin(user.getEmail(), oldPassword)) {
                alertMessages.add(new AlertMessage("Mật khẩu cũ không chính xác", "danger"));
                isValid = false;
            }
            if (isValid) {
                String hash_newPass;
                try {
                    hash_newPass = encode.hashPassword(newPassword, user.getSalt());
                    userDao.changePassword(user.getEmail(), hash_newPass, user.getSalt());
                    user.setHashed_password(hash_newPass);
                    session.setAttribute("user", user);
                } catch (NoSuchAlgorithmException ex) {
                    Logger.getLogger(Change.class.getName()).log(Level.SEVERE, null, ex);
                }
                request.setAttribute("alertMessage", "Đổi mật khẩu thành công");
                request.setAttribute("alertType", "success");
                //response.sendRedirect("home.jsp");
                request.getRequestDispatcher("home.jsp").forward(request, response);
            } else {

                String jsonAlertMessages = new Gson().toJson(alertMessages);
                // Đặt mảng JSON vào request để sử dụng trong JSP
                request.setAttribute("alertMessages", jsonAlertMessages);
                request.setAttribute("error", "Sai mật khẩu cũ hoặc mật khẩu mới không hợp lệ");
                request.setAttribute("oldpass", oldPassword);
                request.setAttribute("newpass", newPassword);
                request.setAttribute("confirmpass", confirmPass);
                request.getRequestDispatcher("pages/system/changepassword.jsp").forward(request, response);
            }
        } catch (ServletException | IOException e) {
            response.sendRedirect("pages/error/error500.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("pages/system/changepassword.jsp").forward(request, response);
        //response.sendRedirect("managepost.jsp");
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
