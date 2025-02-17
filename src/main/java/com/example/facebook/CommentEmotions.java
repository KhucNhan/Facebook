package com.example.facebook;

import java.sql.Timestamp;

public class CommentEmotions {
    private int emotionId;
    private int userId;
    private int commentId;
    private Timestamp createAt;

    public CommentEmotions() {
    }

    public CommentEmotions(int emotionId, int userId, int commentId, Timestamp createAt) {
        this.emotionId = emotionId;
        this.userId = userId;
        this.commentId = commentId;
        this.createAt = createAt;
    }

    public int getEmotionId() {
        return emotionId;
    }

    public void setEmotionId(int emotionId) {
        this.emotionId = emotionId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    @Override
    public String toString() {
        return "CommentEmotions{" +
                "emotionId=" + emotionId +
                ", userId=" + userId +
                ", commentId=" + commentId +
                ", createAt=" + createAt +
                '}';
    }
}
