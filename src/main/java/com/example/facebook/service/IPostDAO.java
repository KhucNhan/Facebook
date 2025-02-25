package com.example.facebook.service;

import com.example.facebook.model.Post;
import com.example.facebook.model.PostMedia;
import com.example.facebook.model.User;

import java.sql.SQLException;
import java.util.List;

public interface IPostDAO {
    List<Post> selectAllPosts(int userId) throws SQLException;
    List<Post> selectPostsById(int userId) throws SQLException;
    int insertPost(Post post) throws SQLException;

    int getPostId(int post);

    Post getInformationPostId(int post);

    List<PostMedia> getAllImageLinksPost(int post);

    boolean updatePost(int post,String content,String privacy);

    boolean deletePost(int postID);

}
