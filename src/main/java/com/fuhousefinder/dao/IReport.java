package com.fuhousefinder.dao;

import com.fuhousefinder.entity.Report;
import java.util.List;

public interface IReport {

    List<Report> getAll(String sort);

    public Report getReportByID(int report_id);

    public void closeReport(int report_id);

    public List<Report> getAll();
}
