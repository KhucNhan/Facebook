package com.example.facebook.service.interfaces;

import com.example.facebook.model.*;

import java.util.List;

public interface INotification {
    List<Notification> getAllNotifictionAddFriend(int userId);

    Activity getNotificationInformation(int activityID);

    boolean new_notification(int userId,int activityId);

    boolean updateIsReadNotification(int notificationId);
    boolean updateIsReadNotificationMessage(int senderId, int receiverId);



    int checkNotificationMessage(int senderId,int receiverId);

    Post getAllPostId (int notification);

    int getAllComment(int notification);

    User getAllUserId(int notification);

    int countNumberOfNotification(int userId);

    Boolean getIsReadMessageFromMessageId(int messageId);


}
