package com.fuhousefinder.controller;

import com.fuhousefinder.entity.*;
import com.fuhousefinder.configs.Validate;
import com.fuhousefinder.dao.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import com.google.gson.Gson;
import java.util.*;

public class EditProfile extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditProfile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProfile at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String firstName = request.getParameter("firstName").trim();
            String lastName = request.getParameter("lastName").trim();
            String address = request.getParameter("address").trim();
            String phoneNumber = request.getParameter("phoneNumber").trim();
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            IUser userDAO = new UserDAO();
            Validate val = new Validate();
            List<AlertMessage> alertMessages = new ArrayList<>();

            Profile p = (Profile) session.getAttribute("profile");

            boolean isValid = true;
            if (!val.checkFirstName(firstName)) {
                alertMessages.add(new AlertMessage("Họ và tên đệm không hợp lệ", "danger"));
                isValid = false;
                request.setAttribute("inputtedFirstname", firstName);
            }
            request.setAttribute("inputtedFirstname", firstName);
            if (!val.checkLastName(lastName)) {
                alertMessages.add(new AlertMessage("Tên không hợp lệ", "danger"));
                isValid = false;
                request.setAttribute("inputtedLastName", lastName);
            }
            request.setAttribute("inputtedLastName", lastName);            
            if (phoneNumber != null && !phoneNumber.isEmpty()) {
                if (phoneNumber.equals(p.getPhoneNumber())) {
                } else {
                    boolean checkPhoneFormat = val.checkPhone(phoneNumber);
                    boolean checkPhoneExists = userDAO.checkExistPhone(phoneNumber);
                    if (checkPhoneExists) {
                        alertMessages.add(new AlertMessage("Số điện thoại đã tồn tại", "danger"));
                        isValid = false;
                        request.setAttribute("inputtedPhone", phoneNumber);
                    }

                    if (!checkPhoneFormat) {
                        alertMessages.add(new AlertMessage("Số điện thoại không hợp lệ", "danger"));
                        isValid = false;
                        request.setAttribute("inputtedPhone", phoneNumber);
                    }
                }
            } else {
                alertMessages.add(new AlertMessage("Số điện thoại không được để trống", "danger"));
                isValid = false;
                request.setAttribute("inputtedPhone", phoneNumber);
            }
            request.setAttribute("inputtedPhone", phoneNumber);
            if (isValid) {
                userDAO.editProfile(user.getRoleId(), firstName, lastName, address, phoneNumber, user.getId());

                p.setFirstName(firstName);
                p.setLastName(lastName);
                p.setAddress(address);
                p.setPhoneNumber(phoneNumber);
                session.setAttribute("profile", p);

                request.setAttribute("alertMessage", "Đổi thông tin thành công");
                request.setAttribute("alertType", "success");
                request.getRequestDispatcher("Profile").forward(request, response);
            } else {
                String gson = new Gson().toJson(alertMessages);
                request.setAttribute("alertMessages", gson);
                request.getRequestDispatcher("/pages/profile/editprofile.jsp").forward(request, response);
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
