package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.PostEmotion;

import java.sql.*;

public class LikeDAO implements ILike {
    private ConnectDatabase connectDatabase = new ConnectDatabase();
    private Connection connection = connectDatabase.connection();

    private static final String checkLikePost = "select count(*) from postemotions where postId = ? and userId = ?";
    private static final String checkLikeComment= "select count(*) from commentemotions where commentId = ? and userId = ?";

    private static final String totalLikePost = "select count(*) from postemotions where postId =?";
    private static final String deleteLikePost = "delete from postemotions where userId = ? and postId = ?";
    private static final String deleteLikeComment = "delete from commentemotions where userId = ? and commentId = ?";

    private static final String addLikeToPost = "insert into postemotions (postId, userId) values (?,?) ";
    private static final String addLikeToComment = "insert into commentemotions (commentId, userId) values (?,?) ";

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
    public int addLikeToPost(int postId, int userId) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(addLikeToPost , Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setInt(1, postId);
            preparedStatement.setInt(2, userId);

            int row = preparedStatement.executeUpdate();
            if (row > 0) {
                ResultSet resultSet = preparedStatement.getGeneratedKeys();
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
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

    @Override
    public boolean checkLikeComment(int userId, int commentId) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(checkLikeComment);
            preparedStatement.setInt(1, commentId);
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
    public boolean deleteLikeComment(int userId, int commentId) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(deleteLikeComment);
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, commentId);

            int row = preparedStatement.executeUpdate();

            return row > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public int addLikeToComment(int commentId, int userId) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(addLikeToComment, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setInt(1, commentId);
            preparedStatement.setInt(2, userId);

            int row = preparedStatement.executeUpdate();
            if (row > 0) {
                ResultSet resultSet = preparedStatement.getGeneratedKeys();
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
}
