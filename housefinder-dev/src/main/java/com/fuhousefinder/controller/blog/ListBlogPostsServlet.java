/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.fuhousefinder.controller.blog;

import com.fuhousefinder.dao.BlogPostDao;
import com.fuhousefinder.entity.BlogPost;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author hp
 */
@WebServlet(name="ListBlogPostsServlet", urlPatterns={"/listBlogPosts"})
public class ListBlogPostsServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListBlogPostsServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListBlogPostsServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
      protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pageParam = request.getParameter("page");
        String sortParam = request.getParameter("sort");
        String searchParam = request.getParameter("search");
        System.out.println(sortParam);
        int page = 1;
        String sort = "newest";
        String search = "";

        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        if (sortParam != null && !sortParam.isEmpty()) {
            sort = sortParam;
        }

        System.out.println(sort);
        if (searchParam != null && !searchParam.isEmpty()) {
            search = searchParam;
        }

        int pageSize = 5
                ;

        BlogPostDao blogPostDao = new BlogPostDao();
        List<BlogPost> blogPosts = blogPostDao.getBlogPosts(page, pageSize, sort, search);
        int totalBlogPosts = blogPostDao.getTotalBlogPosts(search);
        int totalPages = (int) Math.ceil((double) totalBlogPosts / pageSize);

        request.setAttribute("blogPosts", blogPosts);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sort", sort);
        request.setAttribute("search", search);

        request.getRequestDispatcher("/pages/blog/listBlog.jsp").forward(request, response);
    }
    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
