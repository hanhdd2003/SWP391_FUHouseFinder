/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuhousefinder.entity;

import java.time.LocalDateTime;

/**
 *
 * @author phung
 */
public class ReplyFeedback {
      private int replyFeedbackId;
    private int feedbackId;
    private int landlordId;
    private LocalDateTime replyDate;
    private String replyContent;
private boolean  adminReply;
    public ReplyFeedback() {
    }

    public ReplyFeedback(int replyFeedbackId, int feedbackId, int landlordId, LocalDateTime replyDate, String replyContent) {
        this.replyFeedbackId = replyFeedbackId;
        this.feedbackId = feedbackId;
        this.landlordId = landlordId;
        this.replyDate = replyDate;
        this.replyContent = replyContent;
    }

    public int getReplyFeedbackId() {
        return replyFeedbackId;
    }

    public boolean isAdminReply() {
        return adminReply;
    }

    public void setAdminReply(boolean adminReply) {
        this.adminReply = adminReply;
    }

    public void setReplyFeedbackId(int replyFeedbackId) {
        this.replyFeedbackId = replyFeedbackId;
    }

    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getLandlordId() {
        return landlordId;
    }

    public void setLandlordId(int landlordId) {
        this.landlordId = landlordId;
    }

    public LocalDateTime getReplyDate() {
        return replyDate;
    }

    public void setReplyDate(LocalDateTime replyDate) {
        this.replyDate = replyDate;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    
}
