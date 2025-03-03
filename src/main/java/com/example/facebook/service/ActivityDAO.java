package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;

import java.sql.*;

public class ActivityDAO implements IActivityDAO {
    private ConnectDatabase connectDatabase = new ConnectDatabase();
    private Connection connection = connectDatabase.connection();
    private final static String newActivities = "INSERT INTO activities (userId, type, targetId) VALUES (?, ?, ?)";

    @Override
    public int newActivities(int userID, int keyword) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(newActivities, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setInt(1, userID);
            preparedStatement.setString(2, "friendship_request");
            preparedStatement.setInt(3, keyword);

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
