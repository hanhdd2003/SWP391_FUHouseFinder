package com.fuhousefinder.controller.room;

import com.fuhousefinder.dao.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

/**
 *
 * @author hp
 */
@WebServlet(name = "deleteRoom", urlPatterns = {"/deleteRoom"})
public class deleteRoom extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet deleteRoom</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet deleteRoom at " + request.getContextPath() + "</h1>");
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
        int houseId = Integer.parseInt(request.getParameter("houseId"));
        IRoom dao = new RoomDao();
        boolean success = dao.deleteRooms(houseId, roomId);
        if (success) {
              HttpSession session = request.getSession();
            session.setAttribute("alertMessage", "Xóa thành công!");
            session.setAttribute("alertType", "success");
            response.sendRedirect("view_landrord_detail?id="+houseId);
        } else {

            response.sendRedirect("error_page");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
