package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.TreeMap;

public class NotificationDAO implements INotification {
    private ConnectDatabase connectDatabase = new ConnectDatabase();
    private Connection connection = connectDatabase.connection();

    private final static String update_is_read_notification_message = "UPDATE notifications\n" +
            "JOIN activities ON notifications.activityId = activities.activityId\n" +
            "JOIN messages ON activities.targetId = messages.messageId\n" +
            "SET notifications.isRead = 1\n" +
            "WHERE messages.messageId = (\n" +
            "    SELECT messageId \n" +
            "    FROM messages \n" +
            "    WHERE senderId = ? AND receiverId = ? \n" +
            "    ORDER BY createAt DESC \n" +
            "    LIMIT 1\n" +
            ");";

    private final static String get_isRead_from_messageId = "select isRead from notifications\n" +
            "join activities on  notifications.activityId = activities.activityId\n" +
            "join messages on activities.targetId = messages.messageId\n" +
            "where messageId = ?";
    private final static String conut_number_of_notification = "SELECT COUNT(*) AS count\n" +
            "FROM notifications\n" +
            "JOIN activities ON activities.activityId = notifications.activityId\n" +
            "WHERE notifications.userId = ? \n" +
            "  AND notifications.isRead = 0 \n" +
            "  AND activities.type IN ('comment', 'like_comment', 'like_post', 'friendship_request','accepted');\n";
    private final static String conut_number_of_notification_message = "SELECT COUNT(*) AS count\n" +
            "FROM notifications\n" +
            "JOIN activities ON activities.activityId = notifications.activityId\n" +
            "WHERE notifications.userId = ? \n" +
            "  AND notifications.isRead = 0 \n" +
            "  AND activities.type IN ('message');\n";

    private final static String insert_into_notification = "INSERT INTO notifications (userId, activityId) VALUES (?, ?)";

    private final static String getAllNotification = "select * from notifications where userId = ? order by notificationId desc ";

    private final static String getNotificationInformation = "select *from activities where activityId = ? order by activityId desc ";

    private final static String updateIsRead = "UPDATE notifications SET isRead = 1 WHERE (notificationId = ?)";

    private final static String get_all_postId = "SELECT posts.* \n" +
            "FROM posts\n" +
            "JOIN postemotions ON posts.postId = postemotions.postId\n" +
            "JOIN activities ON postemotions.emotionId = activities.targetId\n" +
            "JOIN notifications ON activities.activityId = notifications.activityId\n" +
            "WHERE notifications.notificationId = ?";

    private final static String get_all_comment = "SELECT postId \n" +
            "FROM comments\n" +
            "JOIN commentemotions ON comments.commentId = commentemotions.commentId\n" +
            "JOIN activities ON commentemotions.emotionId = activities.targetId\n" +
            "JOIN notifications ON activities.activityId = notifications.activityId\n" +
            "WHERE notifications.notificationId = ?";

    private final static String get_all_userid = "SELECT users.* \n" +
            "FROM users\n" +
            "JOIN activities ON users.userId = activities.userId  \n" +
            "JOIN notifications ON activities.activityId = notifications.activityId\n" +
            "WHERE notifications.notificationId = ?";

    private final static String check_notification_message = "SELECT \n" +
            "    COALESCE(\n" +
            "        (SELECT a.activityId\n" +
            "         FROM activities a\n" +
            "         JOIN notifications n ON a.activityId = n.activityId\n" +
            "         WHERE a.userId = ? AND a.type = 'message' and n.userId = ?\n" +
            "         ORDER BY a.activityId DESC LIMIT 1),\n" +
            "        -1\n" +
            "    ) AS activityId";

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
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, activityId);

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
    public boolean updateIsReadNotification(int notificationId) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(updateIsRead);
            preparedStatement.setInt(1, notificationId);

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
    public boolean updateIsReadNotificationMessage(int senderId, int receiverId) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(update_is_read_notification_message);
            preparedStatement.setInt(1, senderId);
            preparedStatement.setInt(2, receiverId);

            int row = preparedStatement.executeUpdate();
            return row > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public int checkNotificationMessage(int senderId, int receiverId) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(check_notification_message);
            preparedStatement.setInt(1, senderId);
            preparedStatement.setInt(2, receiverId);

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public Post getAllPostId(int notification) {
        Post post = new Post();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(get_all_postId);
            preparedStatement.setInt(1, notification);

            ResultSet result = preparedStatement.executeQuery();
            if (result.next()) {
                post = new Post(
                        result.getInt(1),
                        result.getInt(2),
                        result.getString(3),
                        result.getString(4),
                        result.getTimestamp(5),
                        result.getTimestamp(6)
                );
            }
            return post;


        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int getAllComment(int notification) {
        int commentId = -1;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(get_all_comment);
            preparedStatement.setInt(1, notification);

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                commentId = resultSet.getInt(1);
            }
            return commentId;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public User getAllUserId(int notification) {
        User user = new User();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(get_all_userid);
            preparedStatement.setInt(1, notification);

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                user = new User(
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
                        resultSet.getString(13),
                        resultSet.getString(14)
                );
            }
            return user;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;

    }

    @Override
    public int countNumberOfNotification(int userId) {
        int row = -1;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(conut_number_of_notification);
            preparedStatement.setInt(1, userId);

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return row = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public Boolean getIsReadMessageFromMessageId(int messageId) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(get_isRead_from_messageId);
            preparedStatement.setInt(1, messageId);

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getBoolean(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int countNumberOfNotificationMessage(int userId) {
        int row = -1;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(conut_number_of_notification_message);
            preparedStatement.setInt(1, userId);

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return row = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
}
