package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.PostEmotion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LikeDAO implements ILike {
    private ConnectDatabase connectDatabase = new ConnectDatabase();
    private Connection connection = connectDatabase.connection();

    private static final String checkLikePost = "select count(*) from postemotions where postId = ? and userId = ?";

    private static final String totalLikePost = "select count(*) from postemotions where postId =?";
    private static final String deleteLikePost = "delete from postemotions where userId = ? and postId = ?";

    private static final String addLikeToPost = "insert into postemotions (postId, userId) values (?,?) ";

    @Override
    public boolean checkLikePost(int userId, int postId) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(checkLikePost);
            preparedStatement.setInt(1, postId);
            preparedStatement.setInt(2, userId);


            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                int row = resultSet.getInt(1);
                return row > 0;
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteLikePost(int userId, int postId) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(deleteLikePost);
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, postId);

            int row = preparedStatement.executeUpdate();

            return row > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public void addLikeToPost(int postId, int userId) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(addLikeToPost);
            preparedStatement.setInt(1, postId);
            preparedStatement.setInt(2, userId);

            int resultSet = preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public int getTotalLikePost(int postId) {
        int row = 0;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(totalLikePost);
            preparedStatement.setInt(1, postId);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                row = resultSet.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return row;
    }
}
