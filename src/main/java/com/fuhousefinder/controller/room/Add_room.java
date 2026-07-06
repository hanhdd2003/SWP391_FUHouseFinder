package com.fuhousefinder.controller.room;

import com.fuhousefinder.dao.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "Add_room", urlPatterns = {"/add_room"})
public class Add_room extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet add_room</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet add_room at " + request.getContextPath() + "</h1>");
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
            request.getRequestDispatcher("/pages/room/addRoom.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            response.sendRedirect("pages/error/error500.jsp");
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int houseId = Integer.parseInt(request.getParameter("house_id"));
            String roomNumber = request.getParameter("room_number");
            //boolean status = Boolean.parseBoolean(request.getParameter("status"));
            double price = Double.parseDouble(request.getParameter("price"));
            double area = Double.parseDouble(request.getParameter("area"));

            IRoom dao = new RoomDao();

            // Tiếp tục thêm phòng nếu room_number chưa tồn tại
            int roomId = dao.addRoom(houseId, roomNumber, true, price, area);

            // Thêm các tiện ích vào phòng
            String[] selectedUtilities = request.getParameterValues("utilities");
            if (selectedUtilities != null) {
                for (String utilityId : selectedUtilities) {
                    dao.addRoomUtility(roomId, Integer.parseInt(utilityId));
                }
            }

            // Chuyển hướng sau khi thêm thành công
              HttpSession session = request.getSession();
            session.setAttribute("alertMessage", "Thêm thành công!");
            session.setAttribute("alertType", "success");
            response.sendRedirect("/HFManagementSystem/view_landrord_detail?id=" + houseId);
        } catch (IOException | NumberFormatException e) {
            response.sendRedirect("pages/error/error500.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
