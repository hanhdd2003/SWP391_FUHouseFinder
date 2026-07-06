package com.fuhousefinder.controller;

import com.fuhousefinder.configs.Config;
import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.ParseException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@WebServlet(name = "getresult", urlPatterns = {"/result"})
public class getresult extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            //Begin process return from VNPAY
            Map fields = new HashMap();
            for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
                String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
                String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
                if ((fieldValue != null) && (fieldValue.length() > 0)) {
                    fields.put(fieldName, fieldValue);
                }
            }

            String vnp_SecureHash = request.getParameter("vnp_SecureHash");
            if (fields.containsKey("vnp_SecureHashType")) {
                fields.remove("vnp_SecureHashType");
            }
            if (fields.containsKey("vnp_SecureHash")) {
                fields.remove("vnp_SecureHash");
            }
            String signValue = Config.hashAllFields(fields);

            //Mã giao dịch thanh toán/
            String maGiaoDich = request.getParameter("vnp_TxnRef");
            //Số tiền
            double soTien = Double.parseDouble(request.getParameter("vnp_Amount")) / 100;
            //Mô tả giao dịch
            String mota = request.getParameter("vnp_OrderInfo");
            //Mã lỗi thanh toán
            String maLoi = request.getParameter("vnp_ResponseCode");
            //Mã giao dịch tại CTT VNPAY-QR
            String CTT = request.getParameter("vnp_TransactionNo");
            //Mã ngân hàng thanh toán
            String maNganHang = request.getParameter("vnp_BankCode");
            //Thời gian thanh toán
            String time = request.getParameter("vnp_PayDate");
            //Tình trạng giao dịch:
            String success = request.getParameter("vnp_TransactionStatus");
            String status = "";
            boolean isSuccess = false;
            if (signValue.equals(vnp_SecureHash)) {
                if ("00".equals(success)) {
                    status = "Thành công";
                    isSuccess = true;
                } else {
                    status = "Không thành công";
                    isSuccess = false;
                }

                int dotIndex = mota.indexOf(".");
                String email = mota.substring(dotIndex + 1).trim();
                IUser userDAO = new UserDAO();

                int landlord_id = userDAO.getLandlordIdByEmail(email);

                //request.getRequestDispatcher("home").forward(request, response);
                String type = "Nâng cao";
                if (soTien == 499000) {
                    type = "Cơ bản";
                } else if (soTien == 899000) {
                    type = "Tiêu chuẩn";
                }

                Upgrade upgrade = new Upgrade(type, landlord_id, maGiaoDich,
                        soTien, mota, maLoi, CTT,
                        maNganHang, stringToLocalDateTime(time),
                        isSuccess);
                IUpgrade upgradeDAO = new UpgradeDAO();
                upgradeDAO.upgradeLandlord(upgrade);
                String alertMessage;
                String alertType;
                if (isSuccess) {
                    alertMessage = "Nâng cấp tài khoản thành công";
                    alertType = "success";
                } else {
                    alertMessage = "Nâng cấp tài khoản không thành công";
                    alertType = "error";
                }

                HttpSession session = request.getSession();
                User userLogin = userDAO.getUserByEmail(email);
                if (userLogin != null) {
                    Profile p = userDAO.getProfile(userLogin.getId(), userLogin.getRoleId());
                    session.setAttribute("user", userLogin);
                    session.setAttribute("profile", p);
                }
                
                request.setAttribute("alertMessage", alertMessage);
                request.setAttribute("alertType", alertType);
                request.getRequestDispatcher("home.jsp").forward(request, response);
            } else {
                out.print("invalid signature");
            }
            /*out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet getresult</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>" + maGiaoDich + "</h1>");
            out.println("<h1>" + soTien + "</h1>");
            out.println("<h1>" + mota + "</h1>");
            //out.println("<h1>" + maLoi + "</h1>");
            out.println("<h1>" + maNganHang + "</h1>");
            out.println("<h1>" + CTT + "</h1>");
            out.println("<h1>" + formatTime(time) + "</h1>");
            out.println("<h1>" + status + " </h1>");
            out.println("<h1>" + u + " </h1>");
            out.println("<h1> ---- </h1>");
            out.println("</body>");
            out.println("</html>");*/
        } catch (Exception e) {
        }
    }

    private LocalDateTime stringToLocalDateTime(String time) throws ParseException {
        DateTimeFormatter inputFormat = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        return LocalDateTime.parse(time, inputFormat);
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
