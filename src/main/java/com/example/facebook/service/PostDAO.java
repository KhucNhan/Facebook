package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.Post;
import com.example.facebook.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDAO implements IPostDAO{
    private ConnectDatabase connectDatabase = new ConnectDatabase();
    private Connection connection = connectDatabase.connection();

    private static final String select_all_post = "SELECT p.postId, p.userId, p.content, p.privacy, p.createAt, p.updateAt, \n" +
            "       COALESCE(e.total_emotions, 0) AS totalEmotions,\n" +
            "       COALESCE(c.total_comments, 0) AS totalComments\n" +
            "FROM posts p\n" +
            "LEFT JOIN friendships f ON (\n" +
            "    (p.userId = f.senderId AND f.receiverId = ?) \n" +
            "    OR (p.userId = f.receiverId AND f.senderId = ?)\n" +
            ")\n" +
            "LEFT JOIN (\n" +
            "    SELECT postId, COUNT(*) AS total_emotions\n" +
            "    FROM postemotions\n" +
            "    GROUP BY postId\n" +
            ") e ON p.postId = e.postId\n" +
            "LEFT JOIN (\n" +
            "    SELECT postId, COUNT(*) AS total_comments\n" +
            "    FROM comments\n" +
            "    GROUP BY postId\n" +
            ") c ON p.postId = c.postId\n" +
            "WHERE p.privacy != 'Private' \n" +
            "AND p.userId != ?  \n" +
            "AND (\n" +
            "    p.privacy = 'Public' \n" +
            "    OR (p.privacy = 'Friends' AND f.status = 'accepted')  \n" +
            ")\n" +
            "ORDER BY p.createAt DESC;";

    private static final String insert_post = "insert into posts (userId, content, privacy) values (?, ?, ?)";
    @Override
    public List<Post> selectAllPosts(int userId) throws SQLException {
        List<Post> posts = new ArrayList<>();
        PreparedStatement preparedStatement = connection.prepareStatement(select_all_post);
        preparedStatement.setInt(1, userId);
        preparedStatement.setInt(2, userId);
        preparedStatement.setInt(3, userId);
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            posts.add(new Post(
                    resultSet.getInt(1),
                    resultSet.getInt(2),
                    resultSet.getString(3),
                    resultSet.getString(4),
                    resultSet.getTimestamp(5),
                    resultSet.getTimestamp(6),
                    resultSet.getInt(7),
                    resultSet.getInt(8)
            ));
        }

        return posts;
    }

    @Override
    public boolean insertPost(Post post) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(insert_post);
        preparedStatement.setInt(1, post.getUserId());
        preparedStatement.setString(2, post.getContent());
        preparedStatement.setString(3, post.getPrivacy());

        int rowsAffected = preparedStatement.executeUpdate();
        return rowsAffected > 0;
    }
}
