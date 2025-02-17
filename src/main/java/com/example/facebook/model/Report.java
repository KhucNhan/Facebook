package com.example.facebook.model;

import java.sql.Timestamp;

public class Report {
    private int reportId;
    private int userId;
    private int targetId;
    private String type;
    private Timestamp createAt;

    public Report() {
    }

    public Report(int reportId, int userId, int targetId, String type, Timestamp createAt) {
        this.reportId = reportId;
        this.userId = userId;
        this.targetId = targetId;
        this.type = type;
        this.createAt = createAt;
    }

    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getTargetId() {
        return targetId;
    }

    public void setTargetId(int targetId) {
        this.targetId = targetId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    @Override
    public String toString() {
        return "Reports{" +
                "reportId=" + reportId +
                ", userId=" + userId +
                ", targetId=" + targetId +
                ", type='" + type + '\'' +
                ", createAt=" + createAt +
                '}';
    }
}
