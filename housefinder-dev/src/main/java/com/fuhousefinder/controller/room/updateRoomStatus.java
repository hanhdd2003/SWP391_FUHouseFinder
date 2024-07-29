package com.fuhousefinder.controller.room;

import com.fuhousefinder.dao.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;


@WebServlet(name = "updateRoomStatus", urlPatterns = {"/updateRoomStatus"})
public class updateRoomStatus extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet updateRoomStatus</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet updateRoomStatus at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String status = request.getParameter("status");
        int houseId = Integer.parseInt(request.getParameter("houseId"));

        IRoom roomdb = new RoomDao();

        boolean isUpdated = roomdb.updateRoomStatus(roomId, status);

        if (isUpdated) {
            HttpSession session = request.getSession();
            session.setAttribute("alertMessage", "Cập nhật trạng thái thành công!");
            session.setAttribute("alertType", "success");
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("alertMessage", "Cập nhật trạng thái thất bại!");
            session.setAttribute("alertType", "danger");
        }

        response.sendRedirect("view_landrord_detail?id=" + houseId);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
