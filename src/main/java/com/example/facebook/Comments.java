package com.example.facebook;

import java.sql.Timestamp;

public class Comments {
    private int commentId;
    private int postId;
    private int userId;
    private int parentId;
    private String content;
    private String privacy;
    private Timestamp createAt;
    private Timestamp updateAt;

    public Comments() {
    }

    public Comments(int commentId, int postId, int userId, int parentId, String content, String privacy, Timestamp createAt, Timestamp updateAt) {
        this.commentId = commentId;
        this.postId = postId;
        this.userId = userId;
        this.parentId = parentId;
        this.content = content;
        this.privacy = privacy;
        this.createAt = createAt;
        this.updateAt = updateAt;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPrivacy() {
        return privacy;
    }

    public void setPrivacy(String privacy) {
        this.privacy = privacy;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    public Timestamp getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Timestamp updateAt) {
        this.updateAt = updateAt;
    }

    @Override
    public String toString() {
        return "Comments{" +
                "commentId=" + commentId +
                ", postId=" + postId +
                ", userId=" + userId +
                ", parentId=" + parentId +
                ", content='" + content + '\'' +
                ", privacy='" + privacy + '\'' +
                ", createAt=" + createAt +
                ", updateAt=" + updateAt +
                '}';
    }
}
