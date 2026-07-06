package com.fuhousefinder.controller;

import com.fuhousefinder.configs.Config;
import com.fuhousefinder.entity.*;
import com.fuhousefinder.configs.EncodeData;
import com.fuhousefinder.dao.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.util.*;
import com.google.gson.Gson;

public class HomeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // lay du lieu tu request
            String email = request.getParameter("email").trim();
            String password = request.getParameter("password").trim();

            // khai bao bien
            IUser userDao = new UserDAO();
            List<User> list = userDao.getAll();
            List<AlertMessage> alertMessages = new ArrayList<>();
            EncodeData encode = new EncodeData();
            User userLogin = null;
            Profile p;
            // lay session
            HttpSession session = request.getSession();

            // kiem tra Đăng nhập thành công hay không
            for (User user : list) {
                if (user.getEmail().equals(email) && encode.checkLogin(email, password)) {
                    userLogin = user;
                    break;
                }
            }
            if (userLogin != null) {

                p = userDao.getProfile(userLogin.getId(), userLogin.getRoleId());
                //System.out.println(userLogin.getId() +" "+userLogin.getRoleId());
                session.setAttribute("user", userLogin);
                session.setAttribute("profile", p);
                Cookie cookie = new Cookie("email", Config.md5(email));
                cookie.setMaxAge(60 * 60);
                response.addCookie(cookie);
                String alertMessage = "Đăng Nhập Thành Công";
                String alertType = "success";
// Các loại thông báo khác nhau: primary, secondary, success, danger, warning, info, light, dark
                request.setAttribute("alertMessage", alertMessage);
                request.setAttribute("alertType", alertType);
                //request.getRequestDispatcher("home.jsp").forward(request, response);
                doGet(request, response);
            } else {
                // check lỗi và gửi thông báo về cho người dùng
                if (!userDao.checkExistEmail(email)) {
                    alertMessages.add(new AlertMessage("Email không tồn tại trong hệ thống", "danger"));
                } else {
                    if (!encode.checkLogin(email, password)) {
                        alertMessages.add(new AlertMessage("Mật khẩu không chính xác", "danger"));
                    }
                }
                if (userDao.checkBan(email)) {
                    alertMessages.add(new AlertMessage("Tài khoản của bạn đã bị Vô Hiệu Hóa, hãy liên hệ với admin", "danger"));
                }
                String jsonAlertMessages = new Gson().toJson(alertMessages);
                request.setAttribute("alertMessages", jsonAlertMessages);
                request.setAttribute("error", "Lỗi");
                request.setAttribute("email", email);
                request.setAttribute("password", password);
                request.getRequestDispatcher("/pages/system/login.jsp").forward(request, response);
                //response.sendRedirect("pages/system/login.jsp");
            }

        } catch (ServletException | IOException e) {
            response.sendRedirect("pages/error/error500.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        IHousIe dao = new HouseDao();
        HttpSession session = request.getSession();
        User userLogin = (User) session.getAttribute("user");
        if (userLogin != null) {
            List<HouseModel> houses = dao.getAllHouse(String.valueOf(userLogin.getId()));
            request.setAttribute("data", houses.subList(0, 8));
            request.getRequestDispatcher("home.jsp").forward(request, response);
        } else {
            List<HouseModel> houses = dao.getAllHouses();

            request.setAttribute("data", houses.subList(0, 8));
            request.getRequestDispatcher("home.jsp").forward(request, response);
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
