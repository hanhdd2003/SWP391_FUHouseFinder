package com.fuhousefinder.controller;

import com.fuhousefinder.entity.*;
import com.fuhousefinder.configs.*;
import com.fuhousefinder.dao.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.util.*;
import com.google.gson.Gson;
import java.security.NoSuchAlgorithmException;
import java.util.logging.*;

public class ResetPassword extends HttpServlet {

    private final Validate val = new Validate();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String emailTo = request.getParameter("email");
            String subject = "Mã Đặt Lại Mật Khẩu";

            IUser dao = new UserDAO();
            SendMail sendMail = new SendMail();
            HttpSession session = request.getSession();
            List<User> ls = dao.getAll();
            boolean isExist = false;
            for (User l : ls) {
                if (l.getEmail().equals(emailTo)) {
                    isExist = true;
                    break;
                }
            }
            if (isExist) {
                int randomNumber = sendMail.generateRandomNumber();
                System.out.println(randomNumber);
                String msg = "Mã đặt lại mật khẩu của bạn là: " + randomNumber + ". Không chia sẻ mã này cho bất kỳ người nào";
                sendMail.send(emailTo, subject, msg);

                session.setAttribute("code", randomNumber + "");
                session.setAttribute("email", emailTo);
                session.removeAttribute("error");
                request.getRequestDispatcher("pages/system/changepasswordafterreset.jsp").forward(request, response);
            } else {
                request.setAttribute("alertMessage", "Email không tồn tại trên hệ thống");
                request.setAttribute("alertType", "danger");
                request.setAttribute("email", emailTo);
                request.getRequestDispatcher("/pages/system/resetpassword.jsp").forward(request, response);
            }
        } catch (ServletException | IOException e) {
            response.sendRedirect("pages/error/error500.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        //request.getRequestDispatcher("resetpassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        try {
            // lấy dữ liệu từ request
            String code = request.getParameter("codeverify").trim();
            String newPassword = request.getParameter("newpassword").trim();
            String confirm = request.getParameter("confirmPassword").trim();

            //Lấy session
            HttpSession session = request.getSession();
            String codeVerify = (String) session.getAttribute("code");

            System.out.println(code + " " + newPassword + " " + confirm + " " + codeVerify);
            //khai báo biến
            List<AlertMessage> list = new ArrayList<>();
            IUser dao = new UserDAO();
            EncodeData encode = new EncodeData();
            boolean isValid = true;
            String jsonAlertMessages;

            if (!code.equals(codeVerify)) {
                list.add(new AlertMessage("Code không chính xác", "danger"));
                isValid = false;
            }
            if (!val.checkPassword(newPassword)) {
                list.add(new AlertMessage("Mật khẩu mới không hợp lệ", "danger"));
                isValid = false;
            }
            if (!newPassword.equals(confirm)) {
                list.add(new AlertMessage("Mật khẩu mới và xác nhận không trùng nhau", "danger"));
                isValid = false;
            }
            if (isValid) {
                String email = (String) session.getAttribute("email");
                session.removeAttribute("email");
                String salt = encode.generateSalt();
                String hashed_password;
                try {
                    hashed_password = encode.hashPassword(newPassword, salt);
                    dao.changePassword(email, hashed_password, salt);
                } catch (NoSuchAlgorithmException ex) {
                    Logger.getLogger(ResetPassword.class.getName()).log(Level.SEVERE, null, ex);
                }
                list.add(new AlertMessage("Đặt lại mật khẩu thành công", "success"));
                jsonAlertMessages = new Gson().toJson(list);
                request.setAttribute("alertMessages", jsonAlertMessages);
                //System.out.println(code + " " + newPassword + " " + confirm);
                //response.sendRedirect("pages/system/login.jsp");
                request.getRequestDispatcher("pages/system/login.jsp").forward(request, response);
            } else {
                jsonAlertMessages = new Gson().toJson(list);
                // Đặt mảng JSON vào request để sử dụng trong JSP
                request.setAttribute("alertMessages", jsonAlertMessages);
                request.setAttribute("error", "Code không đúng hoặc mật khẩu không hợp lệ !");
                request.setAttribute("code", code);
                request.setAttribute("newpassword", newPassword);
                request.setAttribute("confirmpassword", confirm);

                request.getRequestDispatcher("pages/system/changepasswordafterreset.jsp").forward(request, response);
            }
        } catch (ServletException | IOException e) {
            response.sendRedirect("pages/error/error500.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
