package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.Post;
import com.example.facebook.model.PostMedia;
import com.example.facebook.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PostDAO implements IPostDAO {

    private ConnectDatabase connectDatabase = new ConnectDatabase();
    private Connection connection = connectDatabase.connection();
    UserDAO userDAO = new UserDAO();
    private static final String get_Post_Id = "SELECT * FROM posts WHERE postId = ? ";

    private static final String get_user_by_id = "SELECT * FROM users";
    private static final String get_information_post_Id = "SELECT * FROM posts WHERE postId = ?";

    private static final String get_all_image_links_post = "SELECT * FROM postmedias WHERE postId = ?";

    private static final String select_all_post = "SELECT \n" +
            "    p.postId, p.userId, p.content, p.privacy, p.createAt, p.updateAt, \n" +
            "    COALESCE(e.total_emotions, 0) AS totalEmotions, \n" +
            "    COALESCE(c.total_comments, 0) AS totalComments,\n" +
            "    pm.type, \n" +
            "    pm.url\n" +
            "FROM posts p\n" +
            "LEFT JOIN friendships f ON (\n" +
            "    (p.userId = f.senderId AND f.receiverId = ?) \n" +
            "    OR (p.userId = f.receiverId AND f.senderId = ?)\n" +
            ")\n" +
            "LEFT JOIN (\n" +
            "    SELECT postId, COUNT(*) AS total_emotions FROM postemotions GROUP BY postId\n" +
            ") e ON p.postId = e.postId\n" +
            "LEFT JOIN (\n" +
            "    SELECT postId, COUNT(*) AS total_comments FROM comments GROUP BY postId\n" +
            ") c ON p.postId = c.postId\n" +
            "LEFT JOIN postmedias pm ON p.postId = pm.postId  \n" +
            "WHERE p.userId = ?  \n" +
            "   OR (p.privacy != 'Private'\n" +
            "       AND (\n" +
            "           p.privacy = 'Public'  \n" +
            "           OR (p.privacy = 'Friends' AND f.status = 'accepted')\n" +
            "       )\n" +
            "   )\n" +
            "ORDER BY p.createAt DESC;";


    private static final String insert_post = "insert into posts (userId, content, privacy) values (?, ?, ?)";

    @Override
    public List<Post> selectAllPosts(int userId) throws SQLException {
        List<Post> posts = new ArrayList<>();
        List<PostMedia> postMediaList = new ArrayList<>();
        Map<Integer, Post> postMap = new HashMap<>();
        PreparedStatement preparedStatement = connection.prepareStatement(select_all_post);
        preparedStatement.setInt(1, userId);
        preparedStatement.setInt(2, userId);
        preparedStatement.setInt(3, userId);
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            int postId = resultSet.getInt("postId");

            Post post = postMap.get(postId);
            if (post == null) {
                post = new Post(
                        postId,
                        userDAO.selectUserById(resultSet.getInt("userId")),
                        resultSet.getString("content"),
                        resultSet.getString("privacy"),
                        resultSet.getTimestamp("createAt"),
                        resultSet.getTimestamp("updateAt"),
                        resultSet.getInt("totalEmotions"),
                        resultSet.getInt("totalComments")
                );
                postMap.put(postId, post);
                posts.add(post);
            }

            String url = resultSet.getString("url");
            String type = resultSet.getString("type");
            if (url != null && type != null) {
                post.getMediaUrls().add(new PostMedia(resultSet.getInt(1), resultSet.getInt(2), url, type));
            }
        }

        return posts;
    }

    @Override
    public int insertPost(Post post) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(insert_post, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setInt(1, post.getUser().getUserId());
        preparedStatement.setString(2, post.getContent());
        preparedStatement.setString(3, post.getPrivacy());

        int rowsAffected = preparedStatement.executeUpdate();
        if (rowsAffected > 0) {
            ResultSet resultSet = preparedStatement.getGeneratedKeys();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        }
        return -1;
    }

    @Override
    public int getPostId(int post) {
        int userID = -1;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(get_Post_Id);
            preparedStatement.setInt(1, post);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                userID = resultSet.getInt("userId");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userID;
    }

    @Override
    public Post getInformationPostId(int post) {
        Post post1 = new Post();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(get_information_post_Id);
            preparedStatement.setInt(1, post);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                post1 = new Post(
                        resultSet.getInt("postId"),
                        resultSet.getInt("userId"),
                        resultSet.getString("content"),
                        resultSet.getString("privacy"),
                        resultSet.getTimestamp("createAt"),
                        resultSet.getTimestamp("updateAt")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return post1;
    }

    @Override
    public List<PostMedia> getAllImageLinksPost(int post) {
        List<PostMedia> postMediaList = new ArrayList<>();

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(get_all_image_links_post);
            preparedStatement.setInt(1, post);

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                postMediaList.add(new PostMedia(
                        resultSet.getInt("postMediaId"),
                        resultSet.getInt("postId"),
                        resultSet.getString("url"),
                        resultSet.getString("type")

                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return postMediaList;
    }
}
