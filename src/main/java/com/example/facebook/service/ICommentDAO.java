package com.example.facebook.service;

import com.example.facebook.model.Comment;

import java.sql.SQLException;
import java.util.List;

public interface ICommentDAO {
    List<Comment> selectAllComments(int postId) throws SQLException;
}
