package com.example.facebook.service;

import com.example.facebook.model.Activity;
import com.example.facebook.model.Notification;

import java.util.List;

public interface INotification {
    List<Notification> getAllNotifictionAddFriend(int userId);

    Activity getNotificationInformation(int activityID);

    boolean new_notification(int userId,int activityId);

    boolean updateIsReadNotification(int notificationId);

}
