package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO implements IUserDAO {
    private ConnectDatabase connectDatabase = new ConnectDatabase();
    private Connection connection = connectDatabase.connection();

    private static final String select_all_users = "select * from users";
    private static final String insert_user = "INSERT INTO users (name, email, phone, password, dateOfBirth, gender, bio, createAt, updateAt) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";

    private static final String update_user = "UPDATE users SET image = ?, name = ?, email = ?, phone = ?, dateOfBirth = ?, gender = ?, updateAt = NOW() WHERE userId = ?";

    private static final String select_user_by_id = "SELECT * FROM users WHERE userId = ?";

    @Override
    public List<User> selectAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(select_all_users);

        while (resultSet.next()) {
            users.add(new User(
                    resultSet.getInt(1),
                    resultSet.getString(2),
                    resultSet.getString(3),
                    resultSet.getString(4),
                    resultSet.getInt(5),
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

        return users;
    }

    @Override
    public boolean insertUser(User user) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(insert_user);
        preparedStatement.setString(1, user.getName());
        preparedStatement.setString(2, user.getEmail());
        preparedStatement.setInt(3, user.getPhone());
        preparedStatement.setString(4, user.getPassword());
        preparedStatement.setDate(5, user.getDateOfBirth());
        preparedStatement.setBoolean(6, user.isGender());
        preparedStatement.setString(7, user.getBio());
        preparedStatement.setTimestamp(8, user.getCreateAt());
        preparedStatement.setTimestamp(9, user.getUpdateAt());

        int rowsAffected = preparedStatement.executeUpdate();
        return rowsAffected > 0;
    }

    @Override
    public User selectUserById(int userId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(select_user_by_id);
        preparedStatement.setInt(1, userId);
        ResultSet resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            return new User(
                    resultSet.getInt(1),
                    resultSet.getString(2),
                    resultSet.getString(3),
                    resultSet.getString(4),
                    resultSet.getInt(5),
                    resultSet.getString(6),
                    resultSet.getDate(7),
                    resultSet.getBoolean(8),
                    resultSet.getString(9),
                    resultSet.getString(10),
                    resultSet.getTimestamp(11),
                    resultSet.getTimestamp(12),
                    resultSet.getBoolean(13)
            );
        } else {
            return null;
        }
    }

    @Override
    public boolean updateUser(User user, int userId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(update_user);
        preparedStatement.setString(1, user.getImage());
        preparedStatement.setString(2, user.getName());
        preparedStatement.setString(3, user.getEmail());
        preparedStatement.setInt(4, user.getPhone());
        preparedStatement.setDate(5, user.getDateOfBirth());
        preparedStatement.setBoolean(6, user.isGender());
        preparedStatement.setInt(7, userId);

        int rowsAffected = preparedStatement.executeUpdate();
        return rowsAffected > 0;
    }
}