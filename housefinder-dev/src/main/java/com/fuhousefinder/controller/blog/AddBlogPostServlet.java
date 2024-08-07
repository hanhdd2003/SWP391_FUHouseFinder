/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.fuhousefinder.controller.blog;

import com.fuhousefinder.dao.BlogPostDao;
import com.fuhousefinder.entity.BlogPost;
import com.fuhousefinder.entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;

/**
 *
 * @author hp
 */
@WebServlet(name="AddBlogPostServlet", urlPatterns={"/AddBlogPost"})
public class AddBlogPostServlet extends HttpServlet {
   
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
            out.println("<title>Servlet AddBlogPostServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddBlogPostServlet at " + request.getContextPath () + "</h1>");
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
        
        request.getRequestDispatcher("/pages/blog/saveBlog.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 
        String title = request.getParameter("title");
        String content = request.getParameter("content");
    HttpSession session = request.getSession();
        User userLogin = (User) session.getAttribute("user");
        BlogPost blogPost = new BlogPost();
        blogPost.setUserId(userLogin.getId());
        blogPost.setTitle(title);
        blogPost.setContent(content);
        blogPost.setPublishDate(LocalDateTime.now());

        BlogPostDao blogPostDao = new BlogPostDao();
        blogPostDao.addBlogPost(blogPost);
  session.setAttribute("alertMessage", "Thêm thành công!");
        session.setAttribute("alertType", "success");
        response.sendRedirect("listBlogPosts?page=1");
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
