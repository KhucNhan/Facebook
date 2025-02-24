package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.Post;
import com.example.facebook.model.PostMedia;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MediaDAO implements IMediaDAO {
    ConnectDatabase connectDatabase = new ConnectDatabase();
    Connection connection = ConnectDatabase.connection();

    private static final String delete_all_image_post_by_id = "DELETE FROM PostMedias WHERE postId = ?";
    private static final String select_all_postmedia = "select * from postmedias where postId = ?";
    private static final String insert_post_media = "insert into postmedias (postId, type, url) values (?, ?, ?)";


    @Override
    public List<PostMedia> selectAllPostMedia(int postId) throws SQLException {
        List<PostMedia> postMediaList = new ArrayList<>();
        PreparedStatement preparedStatement = connection.prepareStatement(select_all_postmedia);
        preparedStatement.setInt(1, postId);
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            postMediaList.add(new PostMedia(
                    resultSet.getInt(1),
                    resultSet.getInt(2),
                    resultSet.getString(3),
                    resultSet.getString(4)
            ));
        }

        return postMediaList;
    }

    @Override
    public boolean insertPostMedia(int postId, String type, String url) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(insert_post_media);
        preparedStatement.setInt(1, postId);
        preparedStatement.setString(2, "picture");
        preparedStatement.setString(3, url);

        int rowsAffected = preparedStatement.executeUpdate();
        return rowsAffected > 0;
    }

    @Override
    public boolean deleteAllImagePostByID(int postId) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(delete_all_image_post_by_id);
            preparedStatement.setInt(1,postId);

            int row = preparedStatement.executeUpdate();
            return row > 0;
        }catch (SQLException e){
            e.printStackTrace();
            return false;
        }
    }
}
