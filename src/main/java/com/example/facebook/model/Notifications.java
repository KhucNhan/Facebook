package com.example.facebook.model;

import java.sql.Timestamp;

public class Notifications {
    private int notificationId;
    private int userId;
    private int activityId;
    private boolean isRead;
    private Timestamp createAt;

    public Notifications() {
    }

    public Notifications(int notificationId, int userId, int activityId, boolean isRead, Timestamp createAt) {
        this.notificationId = notificationId;
        this.userId = userId;
        this.activityId = activityId;
        this.isRead = isRead;
        this.createAt = createAt;
    }

    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getActivityId() {
        return activityId;
    }

    public void setActivityId(int activityId) {
        this.activityId = activityId;
    }

    public boolean isRead() {
        return isRead;
    }

    public void setRead(boolean isRead) {
        this.isRead = isRead;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    @Override
    public String toString() {
        return "Notifications{" +
                "notificationId=" + notificationId +
                ", userId=" + userId +
                ", activityId=" + activityId +
                ", isRead=" + isRead +
                ", createAt=" + createAt +
                '}';
    }
}
