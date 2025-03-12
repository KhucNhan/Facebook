package com.example.facebook.model;

import java.sql.Timestamp;

public class Report {
    private int reportId;
    private User reporter;
    private int postId;
    private int commentId;
    private String type;
    private User poster;
    private Timestamp createAt;

    public Report() {
    }

    public Report(int reportId, User reporter, int postId, int commentId, String type, User poster, Timestamp createAt) {
        this.reportId = reportId;
        this.reporter = reporter;
        this.postId = postId;
        this.commentId = commentId;
        this.type = type;
        this.poster = poster;
        this.createAt = createAt;
    }

    public Report(User reporter, int postId, int commentId, String type) {
        this.reporter = reporter;
        this.postId = postId;
        this.commentId = commentId;
        this.type = type;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public User getReporter() {
        return reporter;
    }

    public void setReporter(User reporter) {
        this.reporter = reporter;
    }

    public User getPoster() {
        return poster;
    }

    public void setPoster(User poster) {
        this.poster = poster;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
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
}
