package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.Report;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO implements IReportDAO{
    ConnectDatabase connectDatabase = new ConnectDatabase();
    Connection connection = connectDatabase.connection();
    UserDAO userDAO = new UserDAO();
    private static final String insert_report = "insert into reports (userId, targetId, type) values (?, ?, ?);";
    private static final String select_all_post_reports = "select r.reportId, r.userId, r.targetId, r.type, p.userId, r.createAt " +
            "FROM reports r " +
            "JOIN posts p ON r.targetId = p.postId " +
            "WHERE r.type = 'Post' " +
            "ORDER BY r.createAt DESC";
    private static final String select_all_comment_reports = "select r.reportId, r.userId, r.targetId, p.postId, r.type, c.userId, r.createAt " +
            "FROM reports r " +
            "JOIN comments c ON r.targetId = c.commentId " +
            "join posts p on c.postId = p.postId " +
            "WHERE r.type = 'Comment' " +
            "ORDER BY r.createAt DESC";
    @Override
    public int insertReport(Report report) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(insert_report, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setInt(1, report.getReporter().getUserId());
        preparedStatement.setString(3, report.getType());

        if (report.getType().equalsIgnoreCase("post")) {
            preparedStatement.setInt(2, report.getPostId());
        } else {
            preparedStatement.setInt(2, report.getCommentId());
        }

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
                    userDAO.selectUserById(resultSet.getInt(2)),
                    resultSet.getInt(3),
                    0,
                    resultSet.getString(4),
                    userDAO.selectUserById(resultSet.getInt(5)),
                    resultSet.getTimestamp(6)
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
                    userDAO.selectUserById(resultSet.getInt(2)),
                    resultSet.getInt(4),
                    resultSet.getInt(3),
                    resultSet.getString(5),
                    userDAO.selectUserById(resultSet.getInt(6)),
                    resultSet.getTimestamp(7)
            ));
        }

        return commentReports;
    }
}
