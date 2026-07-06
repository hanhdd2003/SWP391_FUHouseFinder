package com.fuhousefinder.controller.adminservlet;

import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.ManageUser;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.*;

@WebServlet(name = "ManageUserServlet", urlPatterns = {"/manageuser"})
public class ManageUserServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            IUser dao = new UserDAO();
            String action = request.getParameter("action") == null ? "" : request.getParameter("action");
            String email = request.getParameter("email");
            String previousPage = request.getHeader("referer");

            int page = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                try {
                    page = Integer.parseInt(pageStr);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            HttpSession session = request.getSession();
            request.setAttribute("action", action);
            switch (action) {
                case "ban":
                    dao.banUser(email, 1);
                    session.setAttribute("alertMessage", "Cấm người dùng thành công");
                    session.setAttribute("alertType", "success");
                    if (previousPage != null && !previousPage.isEmpty()) {
                        response.sendRedirect(previousPage);
                        return;
                    }
                    break;
                case "unban":
                    dao.banUser(email, 0);
                    session.setAttribute("alertMessage", "Hủy cấm người dùng thành công");
                    session.setAttribute("alertType", "success");
                    if (previousPage != null && !previousPage.isEmpty()) {
                        response.sendRedirect(previousPage);
                        return;
                    }
                    break;
                case "viewdetail":
                    //System.out.println(email);
                    ManageUser u = dao.getManageUser(email);
                    //System.out.println(email +" " +u.getLastName());
                    request.setAttribute("u", u);
                    request.getRequestDispatcher("pages/admin/userdetail.jsp").forward(request, response);
                    break;
                case "landlord":
                    request.setAttribute("type", "Chủ Nhà");
                    List<ManageUser> list = new ArrayList<>();
                    list = dao.getLandlord(list);
                    request.setAttribute("data", pagination(request, list, page));
                    request.getRequestDispatcher("pages/admin/manageuser.jsp").forward(request, response);
                    break;
                case "tenant":
                    request.setAttribute("type", "Khách Thuê");
                    List<ManageUser> ls = new ArrayList<>();
                    ls = dao.getTenant(ls);
                    request.setAttribute("data", pagination(request, ls, page));
                    request.getRequestDispatcher("pages/admin/manageuser.jsp").forward(request, response);
                    break;
                case "search":
                    String key = request.getParameter("key").trim();
                    List<ManageUser> l = this.search(key);
                    request.setAttribute("data", l);
                    request.setAttribute("key", key);
                    request.getRequestDispatcher("pages/admin/manageuser.jsp").forward(request, response);
                    break;
                case "isConfirm":
                    request.setAttribute("type", "Đã Xác Minh");
                    List<ManageUser> isConfirm = this.isConfirm("Đã xác minh");
                    request.setAttribute("data", pagination(request, isConfirm, page));
                    request.getRequestDispatcher("pages/admin/manageuser.jsp").forward(request, response);
                    break;
                case "noConfirm":
                    request.setAttribute("type", "Chưa Xác Minh");
                    List<ManageUser> noConfirm = this.isConfirm("Chưa xác minh");
                    request.setAttribute("data", pagination(request, noConfirm, page));
                    request.getRequestDispatcher("pages/admin/manageuser.jsp").forward(request, response);
                    break;
                case "banned":
                    request.setAttribute("type", "Đã Bị Cấm");
                    List<ManageUser> banned = this.banned();
                    request.setAttribute("data", pagination(request, banned, page));
                    request.getRequestDispatcher("pages/admin/manageuser.jsp").forward(request, response);
                    break;
                default:
                    break;
            }
            request.setAttribute("type", "Tất cả người dùng");
            List<ManageUser> list = dao.getUserForAdmin();
            request.setAttribute("data", pagination(request, list, page));
            if (!response.isCommitted()) {
                request.getRequestDispatcher("pages/admin/manageuser.jsp").forward(request, response);
            }
        } catch (ServletException | IOException e) {
            response.sendRedirect("pages/error/error500.jsp");
        }
    }

    private List<ManageUser> pagination(HttpServletRequest request, List<ManageUser> list, int page) {
        int recordsPerPage = 9;
        int totalRecords = list.size();
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
        int startIndex = (page - 1) * recordsPerPage;
        int endIndex = Math.min(startIndex + recordsPerPage, totalRecords);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        return list.subList(startIndex, endIndex);
    }

    private List<ManageUser> search(String key) {
        IUser dao = new UserDAO();
        List<ManageUser> list = dao.getUserForAdmin();
        List<ManageUser> result = new ArrayList<>();
        for (ManageUser manageUser : list) {
            if (manageUser.getFirstName().toLowerCase().contains(key.toLowerCase())
                    || manageUser.getLastName().toLowerCase().contains(key.toLowerCase())
                    || manageUser.getAddress().toLowerCase().contains(key.toLowerCase())
                    || manageUser.getEmail().toLowerCase().contains(key.toLowerCase())
                    || manageUser.getPhoneNumber().toLowerCase().contains(key.toLowerCase())
                    || manageUser.getStatus().toLowerCase().contains(key.toLowerCase())
                    || key.isBlank()) {
                result.add(manageUser);
            }
        }
        return result;
    }

    private List<ManageUser> isConfirm(String status) {
        IUser dao = new UserDAO();
        List<ManageUser> list = dao.getUserForAdmin();
        List<ManageUser> result = new ArrayList<>();
        for (ManageUser manageUser : list) {
            if (manageUser.getStatus().equals(status)) {
                result.add(manageUser);
            }
        }
        return result;
    }

    private List<ManageUser> banned() {
        IUser dao = new UserDAO();
        List<ManageUser> list = dao.getUserForAdmin();
        List<ManageUser> result = new ArrayList<>();
        for (ManageUser manageUser : list) {
            if (manageUser.isIsBan()) {
                result.add(manageUser);
            }
        }
        return result;
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
