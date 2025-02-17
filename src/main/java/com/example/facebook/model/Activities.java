package com.example.facebook.model;

import java.sql.Timestamp;

public class Activities {
    private int activityId;
    private int userId;
    private String type;
    private int targetId;
    private Timestamp createAt;

    public Activities() {
    }

    public Activities(int activityId, int userId, String type, int targetId, Timestamp createAt) {
        this.activityId = activityId;
        this.userId = userId;
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

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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
                ", userId=" + userId +
                ", type='" + type + '\'' +
                ", targetId=" + targetId +
                ", createAt=" + createAt +
                '}';
    }
}
