package com.example.facebook.service.interfaces;

import com.example.facebook.model.Report;

import java.sql.SQLException;
import java.util.List;

public interface IReportDAO {
    int insertReport(Report report) throws SQLException;
    List<Report> selectAllPostReports() throws SQLException;
    List<Report> selectAllCommentReports() throws SQLException;

}
