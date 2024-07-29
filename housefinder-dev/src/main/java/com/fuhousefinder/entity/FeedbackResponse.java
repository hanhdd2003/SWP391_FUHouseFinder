/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuhousefinder.entity;

import com.fuhousefinder.dao.FeedbackDao;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author phung
 */
public class FeedbackResponse {

     List<FeedbackWithReplies> feedbacks;
        int totalPages;
        int currentPage;

     public FeedbackResponse(List<Feedback> feedbacks, int totalPages, int currentPage) {
            this.feedbacks = new ArrayList<>();
            FeedbackDao replyFeedbackDAO = new FeedbackDao();
            for (Feedback feedback : feedbacks) {
                List<ReplyFeedback> replies = replyFeedbackDAO.getRepliesByFeedbackId(feedback.getFeedbackId());
                this.feedbacks.add(new FeedbackWithReplies(feedback, replies));
            }
            this.totalPages = totalPages;
            this.currentPage = currentPage;
        }}
