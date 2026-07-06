package com.fuhousefinder.controller.room;

import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.time.LocalDateTime;
import java.util.*;

@WebServlet(name = "Update_room", urlPatterns = {"/update_room"})
public class Update_room extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet update_room</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet update_room at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String house_id = request.getParameter("house_id");
            String id = request.getParameter("id");
            request.setAttribute("roomid", id);
            request.setAttribute("house_id", house_id);
            IRoom dao = new RoomDao();
            RoomModel room = dao.getRoomById(id);
            request.setAttribute("room", room);
            List<UtilityModel> allUtilities = dao.getAllUtilities();
            request.setAttribute("allUtilities", allUtilities);
            request.getRequestDispatcher("/pages/room/updateRoom.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            response.sendRedirect("pages/error/error500.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int roomId = Integer.parseInt(request.getParameter("room_id"));
            int houseId = Integer.parseInt(request.getParameter("house_id"));
            String roomNumber = request.getParameter("room_number");

            double price = Double.parseDouble(request.getParameter("price"));
            double area = Double.parseDouble(request.getParameter("area"));
            LocalDateTime updateDate = LocalDateTime.now();

            String[] selectedUtilities = request.getParameterValues("utilities");
            List<UtilityModel> utilities = new ArrayList<>();
            if (selectedUtilities != null) {
                for (String utilityId : selectedUtilities) {
                    UtilityModel utility = new UtilityModel();
                    utility.setId(Integer.parseInt(utilityId));
                    utilities.add(utility);
                }
            }
            IRoom roomDAO = new RoomDao();
            RoomModel room = new RoomModel();
            room.setRoomId(roomId);
            room.setHouseId(houseId);
            room.setRoomNumber(roomNumber);

            room.setPrice(price);
            room.setArea(area);
            room.setUpdateDate(updateDate);
            room.setUtilities(utilities);
            boolean success = roomDAO.updateRoom(room);
            if (success) {
                HttpSession session = request.getSession();
                session.setAttribute("alertMessage", "Update thành công!");
                session.setAttribute("alertType", "success");
                // Redirect đến view_house
                response.sendRedirect("view_landrord_detail?id=" + houseId);
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (IOException | NumberFormatException e) {
            response.sendRedirect("pages/error/error500.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
