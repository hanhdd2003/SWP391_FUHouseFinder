package com.fuhousefinder.controller.house;

import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.List;
import java.sql.SQLException;

@WebServlet(name = "View_landrord_detail", urlPatterns = {"/view_landrord_detail"})
public class View_landrord_detail extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");
            if (service == null) {
                service = "ViewHouseDetail";
            }
            switch (service) {
                case "ViewHouseDetail": {
                    try {
                        String idParam = request.getParameter("id");
                        HttpSession session = request.getSession();
                        User userLogin = (User) session.getAttribute("user");
                        IHousIe dao = new HouseDao();
                        HouseModel hm = dao.getHouseById(idParam);

                        List<HouseImages> houseImages = dao.getHouseImagesByHouseId(idParam);

                        request.setAttribute("list", hm);
                        request.setAttribute("houseImages", houseImages);

                        IUser userDAO = new UserDAO();
                        User user = userDAO.getByAllId(String.valueOf(userLogin.getId()));

                        RoomDao dao1 = new RoomDao();
                        List<RoomModel> models = dao1.listRoomsByHouseId(userLogin.getId());

                        if (idParam != null && !idParam.isEmpty()) {
                            List<RoomModel> rooms = dao.getRoomsByHouseId(idParam);
                            request.setAttribute("rooms", rooms);
                        }
                        request.setAttribute("models", models);
                        request.setAttribute("user", user);

                        request.setAttribute("users", userDAO.getByAllIdss(String.valueOf(userLogin.getId())));

                        request.setAttribute("idParam", idParam);

                        HouseModel house = dao.getHouseById(idParam);
                        request.setAttribute("house", house);

                        List<UtilityModel> utilities = dao1.getAllUtilities();

                        request.setAttribute("utilities", utilities);

                        List<RoomModel> roomss = dao1.getRoomss(idParam);
                        request.setAttribute("roomss", roomss);

                        IHousIe houseDao = new HouseDao();
                        List<LocationModer> locations = null;
                        try {
                            locations = houseDao.getAllLocations();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }

                        request.setAttribute("locations", locations);

                        request.getRequestDispatcher("/pages/house/view_landrord_detail.jsp").forward(request, response);
                    } catch (ServletException | IOException | NullPointerException e) {
                        response.sendRedirect("pages/error/error500.jsp");
                    }
                }
                break;
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            int page = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                try {
                    page = Integer.parseInt(pageStr);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            String idParam = request.getParameter("id");
            HttpSession session = request.getSession();
            User userLogin = (User) session.getAttribute("user");
            HouseDao dao = new HouseDao();
            HouseModel hm = dao.getHouseById(idParam);
            session.setAttribute("houseId", idParam);

            List<HouseImages> houseImages = dao.getHouseImagesByHouseId(idParam);

            request.setAttribute("list", hm);
            request.setAttribute("houseImages", houseImages);

            UserDAO userDAO = new UserDAO();
            User user = userDAO.getByAllId(String.valueOf(userLogin.getId()));

            RoomDao dao1 = new RoomDao();
            List<RoomModel> models = dao1.listRoomsByHouseId(userLogin.getId());

            List<RoomModel> rooms = dao.getRoomsByHouseId(idParam);

            request.setAttribute("rooms", pagination(request, rooms, page));

            request.setAttribute("models", models);
            request.setAttribute("user", user);

            request.setAttribute("users", userDAO.getByAllIdss(String.valueOf(userLogin.getId())));

            request.setAttribute("idParam", idParam);

            HouseModel house = dao.getHouseById(idParam);
            request.setAttribute("house", house);

            List<UtilityModel> utilities = dao1.getAllUtilities();

            request.setAttribute("utilities", utilities);

            List<RoomModel> roomss = dao1.getRoomss(idParam);
            request.setAttribute("roomss", roomss);

            HouseDao houseDao = new HouseDao();
            List<LocationModer> locations = null;
            locations = houseDao.getAllLocations();

            LocationModer houseLocation = houseDao.getLocationModerById(house.getLocation_id());
            request.setAttribute("maphouse", houseLocation);
            request.setAttribute("locations", locations);

            request.getRequestDispatcher("/pages/house/view_landrord_detail.jsp").forward(request, response);
        } catch (ServletException | IOException | NullPointerException e) {
            response.sendRedirect("pages/error/error500.jsp");
        }
    }

    private List<RoomModel> pagination(HttpServletRequest request, List<RoomModel> list, int page) {
        int recordsPerPage = 3;
        int totalRecords = list.size();
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
        int startIndex = (page - 1) * recordsPerPage;
        int endIndex = Math.min(startIndex + recordsPerPage, totalRecords);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        return list.subList(startIndex, endIndex);
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
