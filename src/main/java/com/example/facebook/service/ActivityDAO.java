package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.Activity;
import com.example.facebook.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ActivityDAO implements IActivityDAO {
    private ConnectDatabase connectDatabase = new ConnectDatabase();
    private Connection connection = connectDatabase.connection();
    UserDAO userDAO = new UserDAO();
    private final static String newActivities = "INSERT INTO activities (userId, type, targetId) VALUES (?, ?, ?)";

    private final static String deleteActiviti = " delete from activities where activityId = ?";
    private final static String deleteActivity = " DELETE FROM activities WHERE targetId = ?";

    private static final String select_all_activity = "select a.* from activities a join users u on a.userId = u.userId where u.role = 'User' and (a.type ='like_post' or a.type = 'like_comment' or a.type = 'post' or a.type = 'comment');";

    private final static String getIdActivitiId = "select activityId from activities where targetId = ?";

    @Override
    public int newActivities(int userID, int keyword, String type) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(newActivities, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setInt(1, userID);
            preparedStatement.setString(2, type);
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

    @Override
    public List<Activity> selectAllActivity() throws SQLException {
        List<Activity> activities = new ArrayList<>();
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(select_all_activity);

        while (resultSet.next()) {
            activities.add(new Activity(
                    resultSet.getInt(1),
                    userDAO.selectUserById(resultSet.getInt(2)),
                    resultSet.getString(3),
                    resultSet.getInt(4),
                    resultSet.getTimestamp(5)
            ));
        }

        return activities;
    }

}
