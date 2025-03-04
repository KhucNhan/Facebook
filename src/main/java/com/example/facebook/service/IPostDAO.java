package com.example.facebook.service;

import com.example.facebook.model.Post;
import com.example.facebook.model.PostMedia;
import com.example.facebook.model.User;

import java.sql.SQLException;
import java.util.List;

public interface IPostDAO {
    List<Post> selectAllPosts(int userId) throws SQLException;
    int insertPost(Post post) throws SQLException;
    Post selectPostById(int postId) throws SQLException;

    boolean updatePost(int post,String content,String privacy);

    boolean deletePost(int postID);

    List<Post> selectPostsByUserId(int userId) throws SQLException;

    int selectUserIdToPost(int postId);
}
