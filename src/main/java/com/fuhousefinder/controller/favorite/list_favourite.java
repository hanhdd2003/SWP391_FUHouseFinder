package com.fuhousefinder.controller.favorite;

import com.fuhousefinder.dao.IUser;
import com.fuhousefinder.dao.ReportDAO;
import com.fuhousefinder.dao.UserDAO;
import com.fuhousefinder.dao.WishListDao;
import com.fuhousefinder.entity.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.List;

@WebServlet(name = "list_favourite", urlPatterns = {"/favorite"})
public class list_favourite extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet list_favourite</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet list_favourite at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

   
    @Override   
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int roleId = 3;
        HttpSession session = request.getSession();
        User userLogin = (User) session.getAttribute("user");
        int userId = (userLogin != null) ? userLogin.getId() : -1;
        WishListDao dao = new WishListDao();
        IUser userDAO = new UserDAO();
        int tenantId = userDAO.getTenantIDByUserID(userId);
        List<HouseModel> wishlistHouses = dao.getWishlistHouses(roleId, tenantId);

        int page = 1;
        int recordsPerPage = 10;

        int totalRecords = wishlistHouses.size();
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int startIndex = (page - 1) * recordsPerPage;
        int endIndex = Math.min(startIndex + recordsPerPage, totalRecords);

        List<HouseModel> wishlistHousess = wishlistHouses.subList(startIndex, endIndex);

        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
   
        request.setAttribute("list", wishlistHousess);
        request.getRequestDispatcher("/pages/report/favourite.jsp").forward(request, response);
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
