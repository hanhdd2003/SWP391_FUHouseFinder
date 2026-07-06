package com.fuhousefinder.entity;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Report {

    private int report_id;
    private ManageUser user_report;
    private String report_problem;
    private String report_description;
    private LocalDateTime report_date;
    private LocalDateTime report_dates;
    private boolean status;
    private ReplyReport replyReport;
    private String userid;

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }
    

    public Report() {
    }

    public ReplyReport getReplyReport() {
        return replyReport;
    }

    public void setReplyReport(ReplyReport replyReport) {
        this.replyReport = replyReport;
    }

    public Report(int report_id, ManageUser user_report, String report_problem, String report_description, LocalDateTime report_date, boolean status) {
        this.report_id = report_id;
        this.user_report = user_report;
        this.report_problem = report_problem;
        this.report_description = report_description;
        this.report_date = report_date;
        this.status = status;
    }

    public LocalDateTime getReport_dates() {
        return report_dates;
    }

    public void setReport_dates(LocalDateTime report_dates) {
        this.report_dates = report_dates;
    }

    public int getReport_id() {
        return report_id;
    }

    public void setReport_id(int report_id) {
        this.report_id = report_id;
    }

    public ManageUser getUser_report() {
        return user_report;
    }

    public void setUser_report(ManageUser user_report) {
        this.user_report = user_report;
    }

    public String getReport_problem() {
        return report_problem;
    }

    public void setReport_problem(String report_problem) {
        this.report_problem = report_problem;
    }

    public String getReport_description() {
        return report_description;
    }

    public void setReport_description(String report_description) {
        this.report_description = report_description;
    }

    public String getReport_date() {
        DateTimeFormatter format = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        return report_date.format(format);
    }

    public void setReport_date(LocalDateTime report_date) {
        this.report_date = report_date;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

}
