package com.fuhousefinder.controller.house;

import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "View_landrord", urlPatterns = {"/view_landrord"})
public class View_landrord extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet view_landrord</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet view_landrord at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User userLogin = (User) session.getAttribute("user");
        IUser userDAO = new UserDAO();
        User user = userDAO.getByAllId(String.valueOf(userLogin.getId()));
        HouseDao dao = new HouseDao();
        dao.updateHouseStatusss();
        User users = userDAO.getByAllIdss(String.valueOf(userLogin.getId()));

        if (users != null) {
            IHousIe houseDAO = new HouseDao();
            List<HouseModel> houses = houseDAO.getFilteredHousess(userLogin.getId());
            int landlordId = users.getLandlordMder().getId();

            IUpgrade upgradeDAO = new UpgradeDAO();
            int numberHouseCanAdd = upgradeDAO.getNumberHouseCanAdd(landlordId);

            request.setAttribute("numberhousecanadd", numberHouseCanAdd - houses.size());
            boolean isUpdated = houseDAO.updateHouseStatusBasedOnRoomStatus(landlordId);
            if (houses != null && !houses.isEmpty()) {

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

            } else {
                request.setAttribute("message", "User chưa có nhà.");
            }
        }
        IHousIe houseDao = new HouseDao();
        List<LocationModer> locations = null;
        try {
            locations = houseDao.getAllLocations();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        List<PropertyLocationModel> locationss = houseDao.getAllPropertyLocations();

        request.setAttribute("locationss", locationss);

        request.setAttribute("locations", locations);

        request.setAttribute("user", users);
        request.getRequestDispatcher("/pages/house/view_landrord.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
