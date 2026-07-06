package com.fuhousefinder.controller.adminservlet;

import com.fuhousefinder.dao.*;
import com.fuhousefinder.entity.HouseModel;
import com.fuhousefinder.entity.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.List;

@WebServlet(name = "ManagePostServlet", urlPatterns = {"/managepost"})
public class ManagePostServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        IHousIe houseDAO = new HouseDao();
        int page = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                try {
                    page = Integer.parseInt(pageStr);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
        HttpSession session = request.getSession();
                        User userLogin = (User) session.getAttribute("user");
                        
        List<HouseModel> houses = houseDAO.getAllHouse(String.valueOf(userLogin.getId()));
        request.setAttribute("houses", pagination(request, houses, page));
        request.getRequestDispatcher("/pages/admin/managepost.jsp").forward(request, response);

    }

    private List<HouseModel> pagination(HttpServletRequest request, List<HouseModel> list, int page) {
        int recordsPerPage = 9;
        int totalRecords = list.size();
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
        int startIndex = (page - 1) * recordsPerPage;
        int endIndex = Math.min(startIndex + recordsPerPage, totalRecords);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        return list.subList(startIndex, endIndex);
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
