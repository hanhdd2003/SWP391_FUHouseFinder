package com.fuhousefinder.controller.house;

import com.fuhousefinder.dao.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "UpdateStatusHouse", urlPatterns = {"/updatestatushouse"})
public class UpdateStatusHouse extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateStatusHouse</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateStatusHouse at " + request.getContextPath() + "</h1>");
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
        try {
            IHousIe houseDAO = new HouseDao();
            int houseId = Integer.parseInt(request.getParameter("house_id"));
            String status = request.getParameter("status");

            boolean success = houseDAO.updateHouseStatus(houseId, status);
            if (success) {

                HttpSession session = request.getSession();
                session.setAttribute("alertMessage", "Update thành công!!");
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
