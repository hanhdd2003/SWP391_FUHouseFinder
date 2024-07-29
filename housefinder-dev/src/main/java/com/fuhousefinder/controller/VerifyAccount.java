package com.fuhousefinder.controller;

import com.fuhousefinder.entity.*;
import com.fuhousefinder.configs.SendMail;
import com.fuhousefinder.dao.*;
import com.google.gson.Gson;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.util.*;

public class VerifyAccount extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // verify
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            SendMail send = new SendMail();
            int randomNumber = send.generateRandomNumber();
            System.out.println(randomNumber);
            //String msg = "Ma xac minh tai khoan cua ban la: " + randomNumber;
            //send.send(user.getEmail(), "Xac minh tai khoan la cua ban", msg);
            send.sendToVerify(user.getEmail(), randomNumber);
            request.setAttribute("code", randomNumber);
            request.getRequestDispatcher("pages/profile/verifyaccount.jsp").forward(request, response);
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
        try {
            String verify = request.getParameter("verify");
            String code = request.getParameter("code");
            HttpSession session = request.getSession();
            User u = (User) session.getAttribute("user");
            //System.out.println(code);
            if (verify.equals(code)) {
                IUser dao = new UserDAO();
                String email = u.getEmail();
                dao.verifyAccount(email);
                u = dao.getUserByEmail(email);
                session.setAttribute("user", u);
                request.setAttribute("alertMessage", "Xác minh tài khoản thành công");
                request.setAttribute("alertType", "success");
                request.getRequestDispatcher("pages/profile/profile.jsp").forward(request, response);
            } else {
                request.setAttribute("verify", verify);
                List<AlertMessage> alertMessages = new ArrayList<>();
                alertMessages.add(new AlertMessage("Mã xác thực không chính xác", "danger"));
                String gson = new Gson().toJson(alertMessages);
                request.setAttribute("alertMessages", gson);
                request.getRequestDispatcher("pages/profile/verifyaccount.jsp").forward(request, response);
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
