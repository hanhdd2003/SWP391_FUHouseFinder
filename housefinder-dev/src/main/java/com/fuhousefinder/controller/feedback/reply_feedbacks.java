/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.fuhousefinder.controller.feedback;

import com.fuhousefinder.dao.FeedbackDao;
import com.fuhousefinder.dao.UserDAO;
import com.fuhousefinder.entity.ReplyFeedback;
import com.fuhousefinder.entity.Response;
import com.fuhousefinder.entity.User;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;

/**
 *
 * @author hp
 */
@WebServlet(name="reply_feedbacks", urlPatterns={"/reply_feedback"})
public class reply_feedbacks extends HttpServlet {
   
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        String feedbackIdStr = request.getParameter("feedbackId");
        String replyContent = request.getParameter("replyContent");
 HttpSession session = request.getSession();
            User userLogin = (User) session.getAttribute("user");
        int feedbackId = Integer.parseInt(feedbackIdStr);
        UserDAO userdao = new UserDAO();
        
        int landlordId = userdao.getLandlordByUserID(userLogin.getId()); 

        FeedbackDao replyFeedbackDAO = new FeedbackDao();
        ReplyFeedback  replyFeedback = new ReplyFeedback();
        replyFeedback.setFeedbackId(feedbackId);
        replyFeedback.setLandlordId(landlordId);
        replyFeedback.setReplyContent(replyContent);
        replyFeedback.setReplyDate(LocalDateTime.now());

        boolean isSuccess = replyFeedbackDAO.insertReplyFeedback(replyFeedback);

        try (PrintWriter out = response.getWriter()) {
            Gson gson = new Gson();
            if (isSuccess) {
                out.print(gson.toJson(new Response("success", "Reply submitted successfully.")));
            } else {
                out.print(gson.toJson(new Response("error", "Failed to submit reply.")));
            }
        }}

}
