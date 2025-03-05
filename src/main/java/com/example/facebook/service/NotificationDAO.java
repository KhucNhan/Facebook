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

    private final static String insert_into_notification = "INSERT INTO notifications (userId, activityId) VALUES (?, ?)";

    private final static String getAllNotification = "select * from notifications where userId = ? order by notificationId desc ";

    private final static String getNotificationInformation = "select *from activities where activityId = ? order by activityId desc ";

    private final static String updateIsRead = "UPDATE notifications SET isRead = 1 WHERE (notificationId = ?)";

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

    @Override
    public boolean new_notification(int userId, int activityId) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(insert_into_notification);
            preparedStatement.setInt(1,userId);
            preparedStatement.setInt(2,activityId);

            int row = preparedStatement.executeUpdate();
            if (row > 0){
                return true;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateIsReadNotification(int notificationId) {
        try {
            PreparedStatement preparedStatement =connection.prepareStatement(updateIsRead);
            preparedStatement.setInt(1,notificationId);

            int row = preparedStatement.executeUpdate();
            if (row > 0){
                return true;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return false;
    }
}
