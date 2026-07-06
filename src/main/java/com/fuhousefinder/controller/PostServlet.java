package com.fuhousefinder.controller;

import com.fuhousefinder.dao.IPost;
import com.fuhousefinder.entity.*;
import com.fuhousefinder.configs.Validate;
import com.fuhousefinder.dao.*;
import java.io.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.util.*;
import jakarta.servlet.annotation.MultipartConfig;
import java.time.LocalDate;
import java.util.logging.*;


@MultipartConfig
public class PostServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PostServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        IPost dao = new PostDAO();
        List<Post> post = dao.ListAllPosts();
        request.setAttribute("post", post);

        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        switch (action) {
            case "list-post":
                request.getRequestDispatcher("list-post.jsp").forward(request, response);
                break;
            case "edit-post":
                String id = request.getParameter("id");
                Post p = dao.getById(Integer.parseInt(id));
                request.setAttribute("post", p);
                request.getRequestDispatcher("edit-post.jsp").forward(request, response);
                break;
            default:
                // Mặc định chuyển hướng đến list-post.jsp
                request.getRequestDispatcher("view-post.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        String message = null;
        switch (action) {
            case "addPost":
                addPost(request, response);
                response.sendRedirect("PostServlet");
                break;
            case "editPost":
                editPost(request, response);
                response.sendRedirect("PostServlet");
                break;
            case "deletePost":
                deletePost(request, response);
                response.sendRedirect("PostServlet");
                break;
            default:
                throw new AssertionError();
        }
    }

    private void addPost(HttpServletRequest request, HttpServletResponse response) {
        try {
            IPost dao = new PostDAO();
            Validate v = new Validate();
            String title = request.getParameter("title");
            String priceStr = request.getParameter("price");
            Double price = Double.parseDouble(priceStr);
            String address = request.getParameter("address");
            String area = request.getParameter("area");
            String number_roomStr = request.getParameter("number_room");
            Integer number_room = Integer.parseInt(number_roomStr);
            String description = request.getParameter("description");
            //String status = request.getParameter("status");
            //String post_date = request.getParameter("post_date");
            //String landlord_idStr = request.getParameter("landlord_id");
            //Integer landlord_id = Integer.parseInt(landlord_idStr);
            String location_idStr = request.getParameter("location_id");
            Integer location_id = Integer.parseInt(location_idStr);
            String status = "available";
            String post_date = v.getDateNow();
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            int landlord_id = user.getId();
            Post p = new Post(title, price, address, area, number_room, description, status, post_date, landlord_id, location_id);
            dao.addPost(p);

            int id_post = dao.getIdNewPost();
            // them hinh anh o day
            // Lấy đường dẫn tuyệt đối cho thư mục lưu trữ ảnh
            String uploadPath = request.getServletContext().getRealPath("/img/fu_post");

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
                dao.addImagePost(id_post, fileName);
                part.write(filePath);
            }

            //response.sendRedirect("PostServlet");
        } catch (IOException | ServletException ex) {
            Logger.getLogger(PostServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void editPost(HttpServletRequest request, HttpServletResponse response) {
        PostDAO dao = new PostDAO();
        String idStr = request.getParameter("id");
        Integer id = Integer.parseInt(idStr);
        String title = request.getParameter("title");
        String priceStr = request.getParameter("price");
        Double price = Double.parseDouble(priceStr);
        String address = request.getParameter("address");
        String area = request.getParameter("area");
        String number_roomStr = request.getParameter("number_room");
        Integer number_room = Integer.parseInt(number_roomStr);
        String description = request.getParameter("description");
        //String status = request.getParameter("status");
        //String post_date = request.getParameter("post_date");
        //String landlord_idStr = request.getParameter("landlord_id");
        //Integer landlord_id = Integer.parseInt(landlord_idStr);
        String location_idStr = request.getParameter("location_id");
        Integer location_id = Integer.parseInt(location_idStr);
        String status = "available";
        LocalDate time = LocalDate.now();
        String post_date = time.toString();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int landlord_id = user.getId();
        Post p = new Post(id, title, price, address, area, number_room, description, status, post_date, landlord_id, location_id);
        dao.editPost(p);

    }

    private void deletePost(HttpServletRequest request, HttpServletResponse response) {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                IPost dao = new PostDAO();
                dao.deleteImagePost(id);
                dao.deletePost(id);

            } catch (NumberFormatException e) {

            }
        } else {

        }
    }

}
