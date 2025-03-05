package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FriendShipDAO implements IFriendShipDAO {
    private ConnectDatabase connectDatabase = new ConnectDatabase();
    private Connection connection = connectDatabase.connection();

    private final static String addFriend = "INSERT INTO friendships (senderId, receiverId, status) VALUES (?, ?, 'pending')";
    private final static String acceptFriend = "UPDATE friendships SET status = 'accepted' WHERE (receiverId = ? and senderId = ?);";
    private final static String deleteFriend = "DELETE FROM friendships WHERE receiverId = ? and senderId = ?";
    private final static String deleteFriendID = "select friendshipId from friendships WHERE receiverId = ? and senderId = ?";
    private final static String unFriend = "DELETE FROM friendships WHERE ((receiverId = ? and senderId = ?) or (receiverId = ? and senderId = ?)) and status = 'accepted'";

    private final static String select_all_friends_of_user_by_userId = "SELECT * FROM users " +
            "JOIN friendships  ON (users.userId = friendships.senderId OR users.userId = friendships.receiverId)" +
            "WHERE (friendships.senderId = ? OR friendships.receiverId = ?)" +
            "AND friendships.status = 'accepted'" +
            "AND users.userId != ?";

    private final static String select_all_friends_request_of_user_by_userId = "SELECT u.*\n" +
            "FROM friendships f\n" +
            "JOIN users u ON f.senderId = u.userId\n" +
            "WHERE f.receiverId = ? AND f.status = 'pending';";

    private final static String select_all_friends_of_user_by_name = "SELECT u.* \n" +
            "FROM friendships f\n" +
            "JOIN users u ON \n" +
            "    (f.senderId = u.userId AND f.receiverId = ?) \n" +
            "    OR (f.receiverId = u.userId AND f.senderId = ?)\n" +
            "WHERE f.status = 'accepted' \n" +
            "AND u.name LIKE ?;\n";
    private final static String select_all_friend_requests_of_user_by_name = "SELECT u.* \n" +
            "FROM friendships f\n" +
            "JOIN users u ON f.senderId = u.userId\n" +
            "WHERE f.receiverId = ? \n" +
            "AND f.status = 'pending' \n" +
            "AND u.name LIKE ?;\n";


    @Override
    public List<User> searchUsersInRequests(String value, int userId) throws SQLException {
        List<User> requests = new ArrayList<>();
        PreparedStatement preparedStatement = connection.prepareStatement(select_all_friend_requests_of_user_by_name);
        preparedStatement.setInt(1, userId);
        preparedStatement.setString(2, "%" + value + "%");

        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            requests.add(new User(
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
                    resultSet.getString(13)
            ));
        }

        return requests;
    }

    @Override
    public List<User> searchUsersFriends(String value, int userId) throws SQLException {
        List<User> requests = new ArrayList<>();
        PreparedStatement preparedStatement = connection.prepareStatement(select_all_friends_of_user_by_name);
        preparedStatement.setInt(1, userId);
        preparedStatement.setInt(2, userId);
        preparedStatement.setString(3, "%" + value + "%");

        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            requests.add(new User(
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
                    resultSet.getString(13)
            ));
        }

        return requests;
    }

    @Override
    public int addFriend(int userId, int userIdFriend) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(addFriend, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, userIdFriend);

            int row = preparedStatement.executeUpdate();
            if (row > 0) {
                ResultSet resultSet = preparedStatement.getGeneratedKeys();
                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }

            return -1;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

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
                        resultSet.getString(13)
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
                        resultSet.getString(13)
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usersFriendshipRequest;
    }

    @Override
    public int acceptFriend(int userId, int userIdFriend) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(acceptFriend);
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, userIdFriend);

            int resultSet = preparedStatement.executeUpdate();
            if (resultSet > 0) {
                String selectQuery = "SELECT friendshipId FROM friendships WHERE receiverId = ? and senderId = ?";
                PreparedStatement selectStmt = connection.prepareStatement(selectQuery);
                selectStmt.setInt(1, userId);
                selectStmt.setInt(2, userIdFriend);

                ResultSet resultSets = selectStmt.executeQuery();
                if (resultSets.next()) {
                    return resultSets.getInt("friendshipId");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public boolean deleteFriend(int userId, int userIdFriend) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(deleteFriend);
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, userIdFriend);

            int resultSet = preparedStatement.executeUpdate();

            return resultSet > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        }
    }

    @Override
    public int deleteFriendID(int userId, int userIdFriend) {
        int friendId = 0;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(deleteFriendID);
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, userIdFriend);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                friendId = resultSet.getInt("friendshipId");
            }
            return friendId;

        } catch (SQLException e) {
            e.printStackTrace();
            return -1;

        }
    }

    @Override
    public boolean unFriend(int userId, int userIdFriend) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(unFriend);
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, userIdFriend);
            preparedStatement.setInt(3, userIdFriend);
            preparedStatement.setInt(4, userId);

            int resultSet = preparedStatement.executeUpdate();

            return resultSet > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        }
    }

}
