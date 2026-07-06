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

public class Register extends HttpServlet {

    private final Validate val = new Validate();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // lấy dữ liệu
        try {
            String ho = request.getParameter("ho").trim();
            String ten = request.getParameter("ten").trim();
            String email = request.getParameter("email").trim();
            String sdt = request.getParameter("sdt").trim();
            String diaChi = request.getParameter("diaChi").trim();
            String matKhau = request.getParameter("matKhau").trim();
            String role = request.getParameter("loaiTaiKhoan").trim();
            //System.out.println(ho + " " + ten + " " + email);
            //khai báo biến
            IUser dao = new UserDAO();  
            EncodeData encode = new EncodeData();
            List<AlertMessage> alertMessages = new ArrayList<>();
            boolean isValid = true;
            User user = new User();
            String status = "Chưa Xác Minh";
            if (dao.checkExistEmail(email)) {
                alertMessages.add(new AlertMessage("Email đã được đăng ký", "danger"));
                isValid = false;
            }
            if (!val.checkEmail(email)) {
                alertMessages.add(new AlertMessage("Email không hợp lệ", "danger"));
                isValid = false;
            }
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
            if (!val.checkPassword(matKhau)) {
                alertMessages.add(new AlertMessage("Mật khẩu không hợp lệ", "danger"));
                isValid = false;
            }
            if (isValid) {
                // them vao
                user.setEmail(email);
                String salt = encode.generateSalt();
                String hash_password;
                try {
                    hash_password = encode.hashPassword(matKhau, salt);
                    user.setHashed_password(hash_password);
                    user.setSalt(salt);
                    user.setStatus(status);
                    user.setRoleId(Integer.parseInt(role));
                    dao.addUser(user, ho, ten, diaChi, sdt);

                } catch (NoSuchAlgorithmException ex) {
                    Logger.getLogger(Register.class.getName()).log(Level.SEVERE, null, ex);
                }
                alertMessages.add(new AlertMessage("Đăng ký thành công", "success"));
                String gson = new Gson().toJson(alertMessages);
                request.setAttribute("alertMessages", gson);
                //response.sendRedirect("pages/system/login.jsp");
                request.getRequestDispatcher("pages/system/login.jsp").forward(request, response);
            } else {
                String jsonAlertMessages = new Gson().toJson(alertMessages);
                // Đặt mảng JSON vào request để sử dụng trong JSP
                request.setAttribute("alertMessages", jsonAlertMessages);
                request.setAttribute("error", "Đăng ký thất bại, kiểm tra lại thông tin đã nhập!");
                request.setAttribute("ho", ho);
                request.setAttribute("ten", ten);
                request.setAttribute("email", email);
                request.setAttribute("sdt", sdt);
                request.setAttribute("diachi", diaChi);
                request.setAttribute("matkhau", matKhau);
                request.setAttribute("role", role);

                request.getRequestDispatcher("/pages/system/register.jsp").forward(request, response);
                //response.sendRedirect("/HFManagementSystem/pages/system/register.jsp");

            }
        } catch (ServletException | IOException | NumberFormatException e) {
            response.sendRedirect("pages/error/error500.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        //request.getRequestDispatcher("pages/system/register.jsp").forward(request, response);

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
