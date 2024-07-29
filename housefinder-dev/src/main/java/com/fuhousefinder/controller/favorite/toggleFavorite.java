package com.fuhousefinder.controller.favorite;

import com.fuhousefinder.dao.IUser;
import com.fuhousefinder.dao.ReportDAO;
import com.fuhousefinder.dao.UserDAO;
import com.fuhousefinder.dao.WishListDao;
import com.fuhousefinder.entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author phung
 */
@WebServlet(name = "toggleFavorite", urlPatterns = {"/toggleFavorite"})
public class toggleFavorite extends HttpServlet {

    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet toggleFavorite</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet toggleFavorite at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int houseId = Integer.parseInt(request.getParameter("houseId"));
        boolean isFavorite = Boolean.parseBoolean(request.getParameter("isFavorite"));
        HttpSession session = request.getSession();
        User userLogin = (User) session.getAttribute("user");
        int userId = (userLogin != null) ? userLogin.getId() : -1;
        WishListDao favoriteService = new WishListDao();
        IUser userDAO = new UserDAO();
        int tenantID = userDAO.getTenantIDByUserID(userId);
        boolean result;
        if (isFavorite) {
            result = favoriteService.addFavorite(houseId,tenantID);
        } else {
            result = favoriteService.removeFavorite(houseId,tenantID);
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        if (result) {
            out.print("{\"status\":\"success\"}");
        } else {
            out.print("{\"status\":\"error\"}");
        }
        out.flush();
    }

    
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
