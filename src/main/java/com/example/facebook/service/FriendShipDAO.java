package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FriendShipDAO implements IFriendShipDAO {
    private ConnectDatabase connectDatabase = new ConnectDatabase();
    private Connection connection = connectDatabase.connection();

    private final static String select_all_friends_of_user_by_userId = "SELECT * FROM users " +
            "JOIN friendships  ON (users.userId = friendships.senderId OR users.userId = friendships.receiverId)" +
            "WHERE (friendships.senderId = ? OR friendships.receiverId = ?)" +
            "AND friendships.status = 'accepted'" +
            "AND users.userId != ?";

    private final static String select_all_friends_request_of_user_by_userId = "SELECT u.*\n" +
            "FROM friendships f\n" +
            "JOIN users u ON f.senderId = u.userId\n" +
            "WHERE f.receiverId = ? AND f.status = 'pending';";

    @Override

    public List<User> getAllFriendsAdded(int userId) throws SQLException {
        List<User> usersFriendShip = new ArrayList<>();

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(select_all_friends_of_user_by_userId);

            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, userId);
            preparedStatement.setInt(3, userId);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                usersFriendShip.add(new User(
                        resultSet.getInt(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getString(6),
                        resultSet.getDate(7),
                        resultSet.getBoolean(8),
                        resultSet.getString(9),
                        resultSet.getString(10),
                        resultSet.getTimestamp(11),
                        resultSet.getTimestamp(12),
                        resultSet.getBoolean(13)
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usersFriendShip;
    }

    @Override
    public List<User> getAllFriendsRequest(int userId) throws SQLException {
        List<User> usersFriendshipRequest = new ArrayList<>();

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(select_all_friends_request_of_user_by_userId);

            preparedStatement.setInt(1, userId);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                usersFriendshipRequest.add(new User(
                        resultSet.getInt(1),
                        resultSet.getString(2),
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getString(5),
                        resultSet.getString(6),
                        resultSet.getDate(7),
                        resultSet.getBoolean(8),
                        resultSet.getString(9),
                        resultSet.getString(10),
                        resultSet.getTimestamp(11),
                        resultSet.getTimestamp(12),
                        resultSet.getBoolean(13)
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usersFriendshipRequest;
    }
}
