package com.fuhousefinder.controller.house;

import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.util.List;

/**
 *
 * @author hp
 */
public class search_houses extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet search_house</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet search_house at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User userLogin = (User) session.getAttribute("user");
            int userId = (userLogin != null) ? userLogin.getId() : -1;

            String sort = getOrStoreSessionAttribute(session, request, "sort");
            String keyword = getOrStoreSessionAttribute(session, request, "keyword");

            String priceRange = request.getParameter("priceRange");
            if (priceRange == null) {
                priceRange = (String) session.getAttribute("priceRange");
            } else {
                session.setAttribute("priceRange", priceRange);
            }

            String distanceRange = request.getParameter("distanceRange");
            if (distanceRange == null) {
                distanceRange = (String) session.getAttribute("distanceRange");
            } else {
                session.setAttribute("distanceRange", distanceRange);
            }

            IHousIe dao = new HouseDao();
            List<HouseModel> houses = dao.getFilteredHouses(priceRange, sort, distanceRange, keyword, userId);

            request.setAttribute("list", houses);
            request.getRequestDispatcher("/pages/house/search_house.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            response.sendRedirect("pages/error/error500.jsp");
        }
    }

    private String getOrStoreSessionAttribute(HttpSession session, HttpServletRequest request, String attributeName) {
        String parameter = request.getParameter(attributeName);
        if (parameter != null && !parameter.isEmpty()) {
            session.setAttribute(attributeName, parameter);
        } else {
            parameter = (String) session.getAttribute(attributeName);
        }
        return parameter;
    }

    private void updateSessionAttribute(HttpSession session, String attributeName, String value) {
        if (value != null && !value.isEmpty()) {
            session.setAttribute(attributeName, value);
        } else {
            session.removeAttribute(attributeName);
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
