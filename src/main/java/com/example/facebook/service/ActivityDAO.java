package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;

import java.sql.*;

public class ActivityDAO implements IActivityDAO {
    private ConnectDatabase connectDatabase = new ConnectDatabase();
    private Connection connection = connectDatabase.connection();
    private final static String newActivities = "INSERT INTO activities (userId, type, targetId) VALUES (?, ?, ?)";

    private final static String deleteActiviti = " delete from activities where activityId = ?";
    private final static String deleteActivity = " DELETE FROM activities WHERE targetId = ?";



    private final static String getIdActivitiId = "select activityId from activities where targetId = ?";

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

    @Override
    public boolean deleteActivities(int activityId) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(deleteActiviti);
            preparedStatement.setInt(1, activityId);

            int row = preparedStatement.executeUpdate();

            if (row > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteActivity(int target) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(deleteActivity);
            preparedStatement.setInt(1, target);

            int row = preparedStatement.executeUpdate();

            if (row > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public int newAddSuccess(int userID, int keyword) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(newActivities, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setInt(1, userID);
            preparedStatement.setString(2, "accepted");
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
