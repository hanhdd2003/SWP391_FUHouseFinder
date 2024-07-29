package com.fuhousefinder.controller.house;

import com.fuhousefinder.entity.User;
import com.fuhousefinder.dao.HouseDao;
import com.fuhousefinder.entity.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.util.List;

/**
 *
 * @author hp
 */
public class view_house extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet view_house</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet view_house at " + request.getContextPath() + "</h1>");
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
            String keyword = request.getParameter("keyword");
            updateSessionAttribute(session, "keyword", keyword);

            String priceRange = request.getParameter("priceRange");
            String distanceRange = request.getParameter("distanceRange");

            HouseDao dao = new HouseDao();
            dao.updateHouseStatusss();
            List<HouseModel> houses = dao.getFilteredHouses(priceRange, sort, distanceRange, keyword, userId);

            int page = 1;
            int recordsPerPage = 6;


            int totalRecords = houses.size();
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

            List<HouseModel> houseModels = houses.subList(startIndex, endIndex);


            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("list", houseModels);
//            session.setAttribute("alertMessage", "Thêm thành công!");
//            session.setAttribute("alertType", "success");

            request.getRequestDispatcher("/pages/house/view_house.jsp").forward(request, response);
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
