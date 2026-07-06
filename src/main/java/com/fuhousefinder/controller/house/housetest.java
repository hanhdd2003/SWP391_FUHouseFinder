package com.fuhousefinder.controller.house;

import java.util.*;
import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.*;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.time.LocalDateTime;

/**
 *
 * @author hp
 */
@WebServlet(name = "housetest", urlPatterns = {"/housetest"})
public class housetest extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet housetest</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet housetest at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String address = request.getParameter("house_address");
        String descriptionHouse = request.getParameter("house_description");
        int landlordId = Integer.parseInt(request.getParameter("landlord_id"));
        String name = request.getParameter("name");
        String km = request.getParameter("km");
        int locationId = Integer.parseInt(request.getParameter("location_id"));
        String status = request.getParameter("status");

        String jsonImages = request.getParameter("jsonImages");
        String removedImages = request.getParameter("removedImages");

        LocalDateTime updateDate = LocalDateTime.now();
        String houseid = request.getParameter("house_id");
        HouseModel updatedHouse = new HouseModel();
        updatedHouse.setId(Integer.parseInt(request.getParameter("house_id")));
        updatedHouse.setAddress(address);
        updatedHouse.setDescriptionHouse(descriptionHouse);
        updatedHouse.setUpdateDate(updateDate);
        updatedHouse.setDistance_km(km);
        updatedHouse.setHouse_name(name);
        updatedHouse.setStatus(status);

        LandlordMder landlord = new LandlordMder();
        landlord.setId(landlordId);
        updatedHouse.setLandlordMder(landlord);

        LocationModer location = new LocationModer();
        location.setLocation_id(locationId);
        updatedHouse.setLocationModer(location);

        Gson gson = new Gson();
        List<HouseImages> newImages = gson.fromJson(jsonImages, new TypeToken<List<HouseImages>>() {
        }.getType());
        updatedHouse.setHouseImagess(newImages);

        IHousIe houseDAO = new HouseDao();
        boolean isUpdated = houseDAO.updateHouse(updatedHouse, removedImages);

        if (isUpdated) {
            HttpSession session = request.getSession();
            session.setAttribute("alertMessage", "Update thành công!");
            session.setAttribute("alertType", "success");
            response.sendRedirect("view_landrord_detail?id=" + houseid);
        } else {
            response.sendRedirect("addHouse.jsp?error=true");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String address = request.getParameter("house_address");
        String descriptionHouse = request.getParameter("house_description");
        int landlordId = Integer.parseInt(request.getParameter("landlord_id"));
        String name = request.getParameter("name");
        String km = request.getParameter("km");
        int locationId = Integer.parseInt(request.getParameter("location_id"));

        String jsonImages = request.getParameter("jsonImages");

        LocalDateTime createDate = LocalDateTime.now();
        LocalDateTime updateDate = LocalDateTime.now();

        HouseModel newHouse = new HouseModel();
        newHouse.setAddress("kim a");
        newHouse.setDescriptionHouse("daon ");
        newHouse.setCreateDate(createDate);
        newHouse.setUpdateDate(updateDate);
        newHouse.setDistance_km(km);

        newHouse.setHouse_name(name);

        LandlordMder landlord = new LandlordMder();
        landlord.setId(landlordId);
        newHouse.setLandlordMder(landlord);

        LocationModer location = new LocationModer();
        location.setLocation_id(locationId);

        newHouse.setLocationModer(location);

        // Chuyển đổi JSON thành danh sách ảnh
        List<HouseImages> images = new ArrayList<>();

        if (jsonImages != null && !jsonImages.isEmpty()) {
            Gson gson = new Gson();
            images = gson.fromJson(jsonImages, new TypeToken<List<HouseImages>>() {
            }.getType());
        }

        newHouse.setHouseImagess(images);

        IHousIe houseDAO = new HouseDao();
        boolean isAdded = houseDAO.addHouse(newHouse);

        if (isAdded) {
            HttpSession session = request.getSession();
            session.setAttribute("alertMessage", "Update thành công!");
            session.setAttribute("alertType", "success");
            response.sendRedirect("view_landrord_detail?id");

        } else {
            response.sendRedirect("addHouse.jsp?error=true");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
