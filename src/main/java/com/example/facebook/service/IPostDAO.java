package com.example.facebook.service;

import com.example.facebook.model.Post;

import java.sql.SQLException;
import java.util.List;

public interface IPostDAO {
    List<Post> selectAllPosts(int userId) throws SQLException;
    boolean insertPost(Post post, int userId) throws SQLException;
}
