package com.fuhousefinder.controller.house;

import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.*;
import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.time.LocalDateTime;
import java.util.*;

/**
 *
 * @author hp
 */
@MultipartConfig
public class Add_house extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String address = request.getParameter("address");
            String descriptionHouse = request.getParameter("house_description");
            int landlordId = Integer.parseInt(request.getParameter("landlord_id"));
            String name = request.getParameter("name");
            String km = request.getParameter("km");
            int locationId = Integer.parseInt(request.getParameter("location_id"));
            String jsonImages = request.getParameter("jsonImages");

            LocalDateTime createDate = LocalDateTime.now();
            LocalDateTime updateDate = LocalDateTime.now();

            HouseModel newHouse = new HouseModel();
            newHouse.setAddress(address);
            newHouse.setDescriptionHouse(descriptionHouse.replaceAll("\n", "<br>"));
            newHouse.setCreateDates(createDate);
            newHouse.setUpdateDates(updateDate);
            newHouse.setDistance_km(km);
            newHouse.setHouse_name(name);

            LandlordMder landlord = new LandlordMder();
            landlord.setId(landlordId);
            newHouse.setLandlordMder(landlord);

            LocationModer location = new LocationModer();
            location.setLocation_id(locationId);
            newHouse.setLocationModer(location);

            // Convert JSON to list of images
            Gson gson = new Gson();
            List<HouseImages> images = gson.fromJson(jsonImages, new TypeToken<List<HouseImages>>() {
            }.getType());
            newHouse.setHouseImagess(images);

            // Lấy đường dẫn tuyệt đối cho thư mục lưu trữ ảnh
            String uploadPath = request.getServletContext().getRealPath("/img/fu_house");

            // Đảm bảo thư mục lưu trữ tồn tại
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Lưu mỗi file ảnh được tải lên vào thư mục
            Collection<Part> fileParts = request.getParts();
            for (Part part : fileParts) {
                String fileName = part.getSubmittedFileName();
                String filePath = uploadPath + File.separator + fileName;
                part.write(filePath);
            }
            IHousIe houseDAO = new HouseDao();
            boolean isAdded = houseDAO.addHouse(newHouse);
            if (isAdded) {
                HttpSession session = request.getSession();
                session.setAttribute("alertMessage", "Thêm nhà thành công!");
                session.setAttribute("alertType", "success");
                response.sendRedirect("view_landrord");
            } else {
                response.sendRedirect("addHouse.jsp?error=true");
            }
        } catch (JsonSyntaxException | ServletException | IOException | NumberFormatException e) {
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String address = request.getParameter("address");
        String descriptionHouse = request.getParameter("house_description");
        int landlordId = Integer.parseInt(request.getParameter("landlord_id"));
        String name = request.getParameter("name");
        String km = request.getParameter("km");
        int locationId = Integer.parseInt(request.getParameter("location_id"));
        String jsonImages = request.getParameter("jsonImages");

        LocalDateTime createDate = LocalDateTime.now();
        LocalDateTime updateDate = LocalDateTime.now();

        descriptionHouse = descriptionHouse.replaceAll("\n", "<br>");
        HouseModel newHouse = new HouseModel();
        newHouse.setAddress(address);
        newHouse.setDescriptionHouse(descriptionHouse);
        newHouse.setCreateDates(createDate);
        newHouse.setUpdateDates(updateDate);
        newHouse.setDistance_km(km);
        newHouse.setHouse_name(name);

        LandlordMder landlord = new LandlordMder();
        landlord.setId(landlordId);
        newHouse.setLandlordMder(landlord);

        LocationModer location = new LocationModer();
        location.setLocation_id(locationId);
        newHouse.setLocationModer(location);

        // Convert JSON to list of images
        Gson gson = new Gson();
        List<HouseImages> images = gson.fromJson(jsonImages, new TypeToken<List<HouseImages>>() {
        }.getType());
        newHouse.setHouseImagess(images);

        // Lấy đường dẫn tuyệt đối cho thư mục lưu trữ ảnh
        String uploadPath = request.getServletContext().getRealPath("/img/fu_house");

        // Đảm bảo thư mục lưu trữ tồn tại
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Lưu mỗi file ảnh được tải lên vào thư mục
        Collection<Part> fileParts = request.getParts();
        for (Part part : fileParts) {
            String fileName = part.getSubmittedFileName();
            String filePath = uploadPath + File.separator + fileName;
            part.write(filePath);
        }
        IHousIe houseDAO = new HouseDao();
        boolean isAdded = houseDAO.addHouse(newHouse);

        HttpSession session = request.getSession();
        User userLogin = (User) session.getAttribute("user");
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getByAllId(String.valueOf(userLogin.getId()));

        User users = userDAO.getByAllIdss(String.valueOf(userLogin.getId()));

        if (users != null) {

            List<HouseModel> houses = houseDAO.getFilteredHousess(userLogin.getId());

            System.out.println(landlordId);
            boolean isUpdated = houseDAO.updateHouseStatusBasedOnRoomStatus(landlordId);
            if (houses != null && !houses.isEmpty()) {
                request.setAttribute("list", houses);
            } else {
                request.setAttribute("message", "User chưa có nhà.");
            }
        }
        HouseDao houseDao = new HouseDao();
        List<LocationModer> locations = null;
        locations = houseDao.getAllLocations();

        request.setAttribute("locations", locations);

        request.setAttribute("user", users);

        session.setAttribute("alertMessage", "Thêm thành công!");
        session.setAttribute("alertType", "success");

        request.getRequestDispatcher("/pages/house/view_landrord.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String address = request.getParameter("address");
        String descriptionHouse = request.getParameter("house_description");
        int landlordId = Integer.parseInt(request.getParameter("landlord_id"));
        String name = request.getParameter("name");
        String km = request.getParameter("km");
        int locationId = Integer.parseInt(request.getParameter("location_id"));
        String jsonImages = request.getParameter("jsonImages");

        LocalDateTime createDate = LocalDateTime.now();
        LocalDateTime updateDate = LocalDateTime.now();

        descriptionHouse = descriptionHouse.replaceAll("\n", "<br>");
        HouseModel newHouse = new HouseModel();
        newHouse.setAddress(address);
        newHouse.setDescriptionHouse(descriptionHouse);
        newHouse.setCreateDates(createDate);
        newHouse.setUpdateDates(updateDate);
        newHouse.setDistance_km(km);
        newHouse.setHouse_name(name);

        LandlordMder landlord = new LandlordMder();
        landlord.setId(landlordId);
        newHouse.setLandlordMder(landlord);

        LocationModer location = new LocationModer();
        location.setLocation_id(locationId);
        newHouse.setLocationModer(location);

        // Convert JSON to list of images
        Gson gson = new Gson();
        List<HouseImages> images = gson.fromJson(jsonImages, new TypeToken<List<HouseImages>>() {
        }.getType());
        newHouse.setHouseImagess(images);

        // Lấy đường dẫn tuyệt đối cho thư mục lưu trữ ảnh
        String uploadPath = request.getServletContext().getRealPath("/img/fu_house");

        // Đảm bảo thư mục lưu trữ tồn tại
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Lưu mỗi file ảnh được tải lên vào thư mục
        Collection<Part> fileParts = request.getParts();
        for (Part part : fileParts) {
            String fileName = part.getSubmittedFileName();
            if (fileName != null) {
                String filePath = uploadPath + File.separator + fileName;
                part.write(filePath);
            }
        }
        IHousIe houseDAO = new HouseDao();
        boolean isAdded = houseDAO.addHouse(newHouse);

        HttpSession session = request.getSession();
        User userLogin = (User) session.getAttribute("user");
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getByAllId(String.valueOf(userLogin.getId()));

        User users = userDAO.getByAllIdss(String.valueOf(userLogin.getId()));

        if (users != null) {

            List<HouseModel> houses = houseDAO.getFilteredHousess(userLogin.getId());

            System.out.println(landlordId);
            boolean isUpdated = houseDAO.updateHouseStatusBasedOnRoomStatus(landlordId);
            if (houses != null && !houses.isEmpty()) {
                request.setAttribute("list", houses);
            } else {
                request.setAttribute("message", "User chưa có nhà.");
            }
        }
        HouseDao houseDao = new HouseDao();
        List<LocationModer> locations = null;
        locations = houseDao.getAllLocations();

        request.setAttribute("locations", locations);

        request.setAttribute("user", users);

        session.setAttribute("alertMessage", isAdded ? "Thêm thành công!" : "Thêm thất bại!");
        session.setAttribute("alertType", isAdded ? "success" : "error");

        request.getRequestDispatcher("/pages/house/view_landrord.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
