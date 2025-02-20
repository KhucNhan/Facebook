package com.example.facebook.service;

import com.example.facebook.model.Post;
import com.example.facebook.model.PostMedia;

import java.sql.SQLException;
import java.util.List;

public interface IPostDAO {
    List<Post> selectAllPosts(int userId) throws SQLException;
    int insertPost(Post post) throws SQLException;

}
