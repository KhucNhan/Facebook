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

public class MediaDAO implements IMediaDAO{
    ConnectDatabase connectDatabase = new ConnectDatabase();
    Connection connection = ConnectDatabase.connection();

    private static final String select_all_postmedia = "select * from postmedias where postId = ?";
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
}
