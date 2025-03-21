package com.example.facebook.model;

import java.sql.Timestamp;

public class Activity {
    private int activityId;
    private User user;
    private String type;
    private int targetId;
    private Timestamp createAt;

    public Activity() {
    }

    public Activity(int activityId, User user, String type, int targetId, Timestamp createAt) {
        this.activityId = activityId;
        this.user = user;
        this.type = type;
        this.targetId = targetId;
        this.createAt = createAt;
    }

    public int getActivityId() {
        return activityId;
    }

    public void setActivityId(int activityId) {
        this.activityId = activityId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getTargetId() {
        return targetId;
    }

    public void setTargetId(int targetId) {
        this.targetId = targetId;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    @Override
    public String toString() {
        return "Activities{" +
                "activityId=" + activityId +
                ", user=" + user +
                ", type='" + type + '\'' +
                ", targetId=" + targetId +
                ", createAt=" + createAt +
                '}';
    }
}
