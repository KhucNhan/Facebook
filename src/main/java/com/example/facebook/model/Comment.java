package com.example.facebook.model;

import java.sql.Timestamp;

public class Comment {
    private int commentId;
    private int postId;
    private User user;
    private int parentId;
    private String content;
    private Timestamp createAt;
    private Timestamp updateAt;

    public Comment() {
    }

    public Comment(int commentId, int postId, User user, int parentId, String content, Timestamp createAt, Timestamp updateAt) {
        this.commentId = commentId;
        this.postId = postId;
        this.user = user;
        this.parentId = parentId;
        this.content = content;
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

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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
}
