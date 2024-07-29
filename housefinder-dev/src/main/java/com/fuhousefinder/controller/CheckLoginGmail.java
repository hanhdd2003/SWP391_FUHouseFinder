package com.fuhousefinder.controller;

import com.fuhousefinder.entity.*;
import com.fuhousefinder.configs.*;
import com.fuhousefinder.dao.*;
import com.google.gson.Gson;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.util.*;

public class CheckLoginGmail extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            IUser dao = new UserDAO();
            User userLogin;
            HttpSession session = request.getSession();
            Profile p;
            String code = request.getParameter("code");
            String accessToken = Constants.getToken(code);
            UserGoogleDto user = Constants.getUserInfo(accessToken);

            String email = user.getEmail();
            boolean isExistEmail = dao.checkExistEmail(email);

            if (isExistEmail) {
                userLogin = dao.getUserByEmail(email);
                if (userLogin != null) {
                    p = dao.getProfile(userLogin.getId(), userLogin.getRoleId());
                    session.setAttribute("user", userLogin);
                    session.setAttribute("profile", p);
                    Cookie cookie = new Cookie("email", Config.md5(email));
                    cookie.setMaxAge(60 * 60);
                    response.addCookie(cookie);
                    String alertMessage = "Đăng Nhập Thành Công";
                    String alertType = "success";
                    request.setAttribute("alertMessage", alertMessage);
                    request.setAttribute("alertType", alertType);
                    request.getRequestDispatcher("home.jsp").forward(request, response);
                } else {
                    List<AlertMessage> alertMessages = new ArrayList<>();
                    alertMessages.add(new AlertMessage("Tài khoản của bạn đã bị Vô Hiệu Hóa, hãy liên hệ với admin", "danger"));
                    String jsonAlertMessages = new Gson().toJson(alertMessages);
                    request.setAttribute("alertMessages", jsonAlertMessages);
                    request.getRequestDispatcher("/pages/system/login.jsp").forward(request, response);
                }

            } else {
                //nhập thêm dữ liệu cần thiết cho lần đầu đăng nhập
                request.setAttribute("email", email);
                request.setAttribute("ho", user.getFamily_name());
                request.setAttribute("ten", user.getGiven_name());
                request.setAttribute("avatar", user.getPicture());
                request.getRequestDispatcher("/pages/system/logingmail.jsp").forward(request, response);
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
    }
    private final Validate val = new Validate();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // lấy dữ liệu
            String ho = request.getParameter("ho").trim();
            String ten = request.getParameter("ten").trim();
            String email = request.getParameter("email").trim();
            String sdt = request.getParameter("sdt").trim();
            String diaChi = request.getParameter("diaChi").trim();
            String role = request.getParameter("loaiTaiKhoan").trim();
            String imagUrl = request.getParameter("img");
            //khai báo biến
            IUser dao = new UserDAO();
            List<AlertMessage> alertMessages = new ArrayList<>();
            boolean isValid = true;
            User user = new User();

            if (!val.checkLastName(ten)) {
                alertMessages.add(new AlertMessage("Tên không hợp lệ", "danger"));
                isValid = false;
            }
            if (!val.checkFirstName(ho)) {
                alertMessages.add(new AlertMessage("Họ và tên đệm không hợp lệ", "danger"));
                isValid = false;
            }
            if (dao.checkExistPhone(sdt)) {
                alertMessages.add(new AlertMessage("Số điện thoại đã tồn tại", "danger"));
                isValid = false;
            }
            if (!val.checkPhone(sdt)) {
                alertMessages.add(new AlertMessage("Số điện thoại không hợp lệ", "danger"));
                isValid = false;
            }
            if (isValid) {
                // them vao
                user.setEmail(email);
                user.setStatus("Đã xác minh");
                user.setAvatarUrl(imagUrl);
                user.setRoleId(Integer.parseInt(role));
                dao.addUserGmail(user, ho, ten, diaChi, sdt);

                //lấy user và profile
                User userLogin = dao.getUserByEmail(email);
                Profile p = dao.getProfile(userLogin.getId(), userLogin.getRoleId());
                HttpSession session = request.getSession();
                session.setAttribute("user", userLogin);
                session.setAttribute("profile", p);

                request.setAttribute("alertMessage", "Đăng nhập thành công");
                request.setAttribute("alertType", "success");
                request.getRequestDispatcher("home.jsp").forward(request, response);

            } else {
                String jsonAlertMessages = new Gson().toJson(alertMessages);
                // Đặt mảng JSON vào request để sử dụng trong JSP
                request.setAttribute("alertMessages", jsonAlertMessages);

                request.setAttribute("ho", ho);
                request.setAttribute("ten", ten);
                request.setAttribute("email", email);
                request.setAttribute("sdt", sdt);
                request.setAttribute("diachi", diaChi);
                request.setAttribute("role", role);
                request.setAttribute("avatar", imagUrl);
                request.getRequestDispatcher("/pages/system/logingmail.jsp").forward(request, response);

            }
        } catch (ServletException | IOException | NumberFormatException e) {
            response.sendRedirect("pages/error/error500.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
