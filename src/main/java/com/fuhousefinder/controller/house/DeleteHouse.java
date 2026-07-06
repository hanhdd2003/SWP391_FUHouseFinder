package com.fuhousefinder.controller.house;

import com.fuhousefinder.dao.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

/**
 *
 * @author hp
 */
@WebServlet(name = "DeleteHouse", urlPatterns = {"/deleteHouse"})
public class DeleteHouse extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final IHousIe houseService = new HouseDao();

    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int houseId = Integer.parseInt(request.getParameter("houseId"));
        boolean success = houseService.deleteHouse(houseId);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"success\":" + success + "}");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DeleteHouse</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteHouse at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

 
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            int houseId = Integer.parseInt(request.getParameter("houseId"));
        boolean success = houseService.deleteHouse(houseId);

        if (success) {
            HttpSession session = request.getSession();
            session.setAttribute("alertMessage", "Đã xóa nhà thành công");
            session.setAttribute("alertType", "success");
            response.sendRedirect("view_landrord");
        } else {
          
            response.sendRedirect("error_page");
        }
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
