package com.example.facebook.service;

import com.example.facebook.model.Comment;

import java.sql.SQLException;
import java.util.List;

public interface ICommentDAO {
    List<Comment> selectAllComments(int postId) throws SQLException;

    int insertComment(Comment comment) throws SQLException;
    Comment selectCommentById(int commentId) throws SQLException;

    boolean deleteComment(int commentId) throws SQLException;

    boolean updateComment(Comment comment, int commentId) throws SQLException;
}
