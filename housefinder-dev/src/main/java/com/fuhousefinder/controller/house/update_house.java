package com.fuhousefinder.controller.house;

import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.*;
import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.time.LocalDateTime;
import java.util.*;

/**
 *
 * @author hp
 */
@MultipartConfig
@WebServlet(name = "update_house", urlPatterns = {"/update_house"})
public class update_house extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String address = request.getParameter("address");
            String descriptionHouse = request.getParameter("description_house");
            int landlordId = Integer.parseInt(request.getParameter("landlord_id"));
            String name = request.getParameter("name");
            String km = request.getParameter("km");
            int locationId = Integer.parseInt(request.getParameter("location_id"));

            String jsonImages = request.getParameter("jsonImages");
            String removedImages = request.getParameter("removedImages");

            LocalDateTime updateDate = LocalDateTime.now();
            String houseid = request.getParameter("house_id");
            HouseModel updatedHouse = new HouseModel();
            updatedHouse.setId(Integer.parseInt(request.getParameter("house_id")));
            updatedHouse.setAddress(address);
            updatedHouse.setDescriptionHouse(descriptionHouse.replaceAll("\n", "<br>"));
            updatedHouse.setUpdateDate(updateDate);
            updatedHouse.setDistance_km(km);
            updatedHouse.setHouse_name(name);

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

            boolean hasNewImages = request.getParts().stream()
                    .anyMatch(part -> "img".equals(part.getName()) && part.getSize() > 0);
            
            if (hasNewImages) {
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
            }

            if (isUpdated) {
                HttpSession session = request.getSession();
                session.setAttribute("alertMessage", "Update thành công!");
                session.setAttribute("alertType", "success");
                response.sendRedirect("view_landrord_detail?id=" + houseid);
            } else {
                response.sendRedirect("addHouse.jsp?error=true");
            }
        } catch (JsonSyntaxException | ServletException | IOException | NumberFormatException e) {
            e.printStackTrace();
            //response.sendRedirect("pages/error/error500.jsp");
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String address = request.getParameter("address");
        String descriptionHouse = request.getParameter("description_house");
        int landlordId = Integer.parseInt(request.getParameter("landlord_id"));
        String name = request.getParameter("name");
        String km = request.getParameter("km");
        int locationId = Integer.parseInt(request.getParameter("location_id"));

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
//        HouseDao houseDAO = new HouseDao();
//        int houseId = Integer.parseInt(request.getParameter("house_id"));
//        String address = request.getParameter("address");
//        String descriptionHouse = request.getParameter("description_house");
//        String status = request.getParameter("status");
//        String name = request.getParameter("name");
//        int locationId = Integer.parseInt(request.getParameter("location_id"));
//        String km = request.getParameter("km");
//        LocalDateTime updateDate = LocalDateTime.now();
//
//        HouseModel house = new HouseModel();
//        house.setId(houseId);
//        house.setAddress(address);
//        house.setDescriptionHouse(descriptionHouse);
//        house.setStatus(status);
//        house.setDistance_km(km);
//        house.setHouse_name(name);
//        house.setUpdateDate(updateDate);
//
//        LocationModer locationModer = new LocationModer();
//        locationModer.setLocation_id(locationId);
//        house.setLocationModer(locationModer);
//
//        String removedImages = request.getParameter("removedImages");
//
//        // Xử lý ảnh mới được thêm
//        List<HouseImages> newImages = new ArrayList<>();
//        for (Part part : request.getParts()) {
//            if (part.getName().equals("newImages") && part.getSize() > 0) {
//                String fileName = part.getSubmittedFileName();
//                String imageUrl = "img/fu_house/" + fileName;
//                newImages.add(new HouseImages(imageUrl, houseId));
//                part.write(getServletContext().getRealPath("/") + imageUrl);
//            }
//        }
//        house.setHouseImagess(newImages);
//
//        boolean success = houseDAO.updateHouse(house, removedImages);
//        if (success) {
//            HttpSession session = request.getSession();
//            session.setAttribute("alertMessage", "Update thành công!");
//            session.setAttribute("alertType", "success");
//            response.sendRedirect("view_landrord_detail?id=" + houseId);
//        } else {
//            response.sendRedirect("error.jsp");
//        }
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
