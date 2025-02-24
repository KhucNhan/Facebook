package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.Comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO implements ICommentDAO{
    ConnectDatabase connectDatabase = new ConnectDatabase();
    Connection connection = connectDatabase.connection();
    UserDAO userDAO = new UserDAO();

    private static final String select_all_comments = "SELECT * FROM comments WHERE postId = ? ORDER BY createAt ASC";
    @Override
    public List<Comment> selectAllComments(int postId) throws SQLException {
        List<Comment> comments = new ArrayList<>();

        PreparedStatement preparedStatement = connection.prepareStatement(select_all_comments);
        preparedStatement.setInt(1, postId);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            Comment comment = new Comment();
            comment.setCommentId(resultSet.getInt("commentId"));
            comment.setPostId(resultSet.getInt("postId"));
            comment.setUser(userDAO.selectUserById(resultSet.getInt("userId")));
            comment.setParentId(resultSet.getInt("parentId"));
            comment.setContent(resultSet.getString("content"));
            comment.setCreateAt(resultSet.getTimestamp("createAt"));
            comment.setUpdateAt(resultSet.getTimestamp("updateAt"));

            comments.add(comment);
        }

        return comments;
    }
}
