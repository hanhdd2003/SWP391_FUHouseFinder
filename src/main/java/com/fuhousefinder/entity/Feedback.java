/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuhousefinder.entity;

/**
 *
 * @author phung
 */
import java.time.LocalDateTime;

public class Feedback {
    private int feedbackId;
    private int tenant_id;
    private int house_id;
    private LocalDateTime feedbackDate;
    private int rating;
    private String content;
    private String tenantName;
    private String sort;
    private String page;
     private boolean hasReply;
     private boolean hasReplied;
  private LocalDateTime replyDate;
    private String replyContent;
    public boolean isHasReplied() {
        return hasReplied;
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
    
    

    public void setHasReplied(boolean hasReplied) {
        this.hasReplied = hasReplied;
    }
     
    public int getFeedbackId() {
        return feedbackId;
    }

    public boolean isHasReply() {
        return hasReply;
    }

    public void setHasReply(boolean hasReply) {
        this.hasReply = hasReply;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getPage() {
        return page;
    }

    public void setPage(String page) {
        this.page = page;
    }
    

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getTenant_id() {
        return tenant_id;
    }

    public void setTenant_id(int tenant_id) {
        this.tenant_id = tenant_id;
    }

    public int getHouse_id() {
        return house_id;
    }

    public void setHouse_id(int house_id) {
        this.house_id = house_id;
    }

    public LocalDateTime getFeedbackDate() {
        return feedbackDate;
    }

    public void setFeedbackDate(LocalDateTime feedbackDate) {
        this.feedbackDate = feedbackDate;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTenantName() {
        return tenantName;
    }

    public void setTenantName(String tenantName) {
        this.tenantName = tenantName;
    }

    public Feedback(int feedbackId, int tenant_id, int house_id, LocalDateTime feedbackDate, int rating, String content,  String replyContent,LocalDateTime replyDate ,String tenantName) {
        this.feedbackId = feedbackId;
        this.tenant_id = tenant_id;
        this.house_id = house_id;
        this.feedbackDate = feedbackDate;
        this.rating = rating;
        this.content = content;
          this.replyDate = replyDate;
        this.replyContent = replyContent;
        this.tenantName = tenantName;
    }


    public Feedback() {
    }

}
