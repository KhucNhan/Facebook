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

    private static final String select_all_post = "SELECT p.postId, p.userId, p.content, p.privacy, p.createAt, p.updateAt" +
            "       COALESCE(e.total_emotions, 0) AS totalEmotions," +
            "       COALESCE(c.total_comments, 0) AS totalComments" +
            "FROM posts p" +
            "LEFT JOIN friendships f ON (" +
            "    (p.userId = f.senderId AND f.receiverId = ?) " +
            "    OR (p.userId = f.receiverId AND f.senderId = ?)" +
            ")" +
            "LEFT JOIN (" +
            "    SELECT postId, COUNT(*) AS total_emotions" +
            "    FROM emotions" +
            "    GROUP BY postId" +
            ") e ON p.postId = e.postId" +
            "LEFT JOIN (" +
            "    SELECT postId, COUNT(*) AS total_comments" +
            "    FROM comments" +
            "    GROUP BY postId" +
            ") c ON p.postId = c.postId" +
            "WHERE p.privacy != 'Private'  -- Loại bỏ bài viết Private" +
            "AND p.userId != ?  -- Loại bỏ bài viết của người dùng đang đăng nhập" +
            "AND (" +
            "    p.privacy = 'Public'  -- Hiển thị bài viết Public" +
            "    OR (p.privacy = 'Friends' AND f.status = 'accepted')  -- Chỉ hiển thị bài viết Friends nếu là bạn bè" +
            ")" +
            "ORDER BY p.createAt DESC;";

    private static final String insert_post = "insert into posts (userId, content, privacy) values (?, ?, ?)";
    @Override
    public List<Post> selectAllPosts(int userId) throws SQLException {
        List<Post> posts = new ArrayList<>();
        PreparedStatement preparedStatement = connection.prepareStatement(select_all_post);
        preparedStatement.setInt(1, userId);
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
    public boolean insertPost(Post post, int userId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(insert_post);
        preparedStatement.setInt(1, userId);
        preparedStatement.setString(2, post.getContent());
        preparedStatement.setString(3, post.getPrivacy());

        int rowsAffected = preparedStatement.executeUpdate();
        return rowsAffected > 0;
    }
}
