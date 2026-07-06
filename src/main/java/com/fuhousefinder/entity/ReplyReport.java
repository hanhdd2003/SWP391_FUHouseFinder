/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fuhousefinder.entity;

/**
 *
 * @author hp
 */
import java.time.LocalDateTime;

public class ReplyReport {
    private int replyReportId;
    private int adminId;
    private int reportId;
    private LocalDateTime replyDate;
    private String replyContent;

    public ReplyReport(int replyReportId, int adminId, int reportId, LocalDateTime replyDate, String replyContent) {
        this.replyReportId = replyReportId;
        this.adminId = adminId;
        this.reportId = reportId;
        this.replyDate = replyDate;
        this.replyContent = replyContent;
    }

    public ReplyReport() {
    }

   

    public int getReplyReportId() {
        return replyReportId;
    }

    public void setReplyReportId(int replyReportId) {
        this.replyReportId = replyReportId;
    }

    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
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
