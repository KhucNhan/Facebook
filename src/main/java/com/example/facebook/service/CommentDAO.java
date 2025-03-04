package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.Comment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO implements ICommentDAO {
    ConnectDatabase connectDatabase = new ConnectDatabase();
    Connection connection = connectDatabase.connection();
    UserDAO userDAO = new UserDAO();

    private static final String select_userId_to_comment = "SELECT comments.userId FROM comments where commentId =?";

    private static final String select_all_comments = "SELECT * FROM comments WHERE postId = ? and parentId is null ORDER BY createAt ASC";
    private static final String insert_comment = "insert into comments (postId, userId, content) values (?, ?, ?)";
    private static final String select_comment_by_id = "select * from comments where commentId = ?";
    private static final String delete_comment = "delete from comments where commentId = ?";
    private static final String update_comment = "update comments set content = ? where commentId = ?";
    private static final String insert_reply_comment = "INSERT INTO comments (parentId, userId, content, postId) VALUES (?, ?, ?, ?)";

    private static final String select_all_replies = "select * from comments where parentId = ?";

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

    @Override
    public int insertComment(Comment comment) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(insert_comment, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setInt(1, comment.getPostId());
        preparedStatement.setInt(2, comment.getUser().getUserId());
        preparedStatement.setString(3, comment.getContent());

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
    public Comment selectCommentById(int commentId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(select_comment_by_id);
        preparedStatement.setInt(1, commentId);
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
            return comment;
        }

        return null;
    }

    @Override
    public boolean deleteComment(int commentId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(delete_comment);
        preparedStatement.setInt(1, commentId);
        int row = preparedStatement.executeUpdate();

        return row > 0;
    }

    @Override
    public boolean updateComment(Comment comment, int commentId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(update_comment);
        preparedStatement.setString(1, comment.getContent());
        preparedStatement.setInt(2, commentId);

        int row = preparedStatement.executeUpdate();
        return row > 0;
    }

    @Override
    public int insertReplyComment(Comment comment, int parentId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(insert_reply_comment, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setInt(1, parentId);
        preparedStatement.setInt(2, comment.getUser().getUserId());
        preparedStatement.setString(3, comment.getContent());
        preparedStatement.setInt(4, comment.getPostId());

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
    public List<Comment> getReplies(int parentId) throws SQLException {
        List<Comment> comments = new ArrayList<>();

        PreparedStatement preparedStatement = connection.prepareStatement(select_all_replies);
        preparedStatement.setInt(1, parentId);
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

    @Override
    public int selectUserIdToComment(int commentId) {
        try {
            PreparedStatement preparedStatement =connection.prepareStatement(select_userId_to_comment);
            preparedStatement.setInt(1,commentId);

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()){
                return resultSet.getInt("userId");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
}
