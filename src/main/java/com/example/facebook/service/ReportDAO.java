package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.Report;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO implements IReportDAO{
    ConnectDatabase connectDatabase = new ConnectDatabase();
    Connection connection = connectDatabase.connection();
    private static final String insert_report = "insert into reports (userId, targetId, type) values (?, ?, ?);";
    private static final String select_all_post_reports = "select * from reports where type = 'Post'";
    private static final String select_all_comment_reports = "select * from reports where type = 'Comment'";
    @Override
    public int insertReport(Report report) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(insert_report, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setInt(1, report.getUserId());
        preparedStatement.setInt(2, report.getTargetId());
        preparedStatement.setString(3, report.getType());

        int row = preparedStatement.executeUpdate();
        if (row > 0) {
            ResultSet resultSet = preparedStatement.getGeneratedKeys();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        }

        return -1;
    }

    @Override
    public List<Report> selectAllPostReports() throws SQLException {
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(select_all_post_reports);

        List<Report> postReports = new ArrayList<>();

        while (resultSet.next()) {
            postReports.add(new Report(
                    resultSet.getInt(1),
                    resultSet.getInt(2),
                    resultSet.getInt(3),
                    resultSet.getString(4),
                    resultSet.getTimestamp(5)
            ));
        }

        return postReports;
    }

    @Override
    public List<Report> selectAllCommentReports() throws SQLException {
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(select_all_comment_reports);

        List<Report> commentReports = new ArrayList<>();

        while (resultSet.next()) {
            commentReports.add(new Report(
                resultSet.getInt(1),
                    resultSet.getInt(2),
                    resultSet.getInt(3),
                    resultSet.getString(4),
                    resultSet.getTimestamp(5)
            ));
        }

        return commentReports;
    }
}
