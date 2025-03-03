package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.Activity;
import com.example.facebook.model.Notification;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificationDAO implements INotification {
    private ConnectDatabase connectDatabase = new ConnectDatabase();
    private Connection connection = connectDatabase.connection();

    private final static String getAllNotification = "select * from notifications where userId =?";

    private final static String getNotificationInformation = "select *from activities where activityId = ?";


    @Override
    public List<Notification> getAllNotifictionAddFriend(int userId) {
        List<Notification> allNotification = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(getAllNotification);
            preparedStatement.setInt(1, userId);

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Notification notification = new Notification();
                notification.setNotificationId(resultSet.getInt("notificationId"));
                notification.setUserId(resultSet.getInt("userId"));
                notification.setActivityId(resultSet.getInt("activityId"));
                notification.setRead(resultSet.getBoolean("isRead"));
                notification.setCreateAt(resultSet.getTimestamp("createAt"));

                allNotification.add(notification);
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
        return allNotification;
    }

    @Override
    public Activity getNotificationInformation(int activityID) {
        Activity activity = new Activity();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(getNotificationInformation);
            preparedStatement.setInt(1, activityID);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                activity = new Activity();
                activity.setActivityId(resultSet.getInt("activityId"));
                activity.setUserId(resultSet.getInt("userId"));
                activity.setType(resultSet.getString("type"));
                activity.setTargetId(resultSet.getInt("targetId"));
                activity.setCreateAt(resultSet.getTimestamp("createAt"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return activity;
    }


}
