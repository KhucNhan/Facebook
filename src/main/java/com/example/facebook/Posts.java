package com.example.facebook;

import java.sql.Timestamp;

public class Posts {
    private int postId;
    private int userId;
    private String content;
    private String privacy;
    private Timestamp createAt;
    private Timestamp updateAt;

    public Posts() {
    }

    public Posts(int postId, int userId, String content, String privacy, Timestamp createAt, Timestamp updateAt) {
        this.postId = postId;
        this.userId = userId;
        this.content = content;
        this.privacy = privacy;
        this.createAt = createAt;
        this.updateAt = updateAt;
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
        return "Posts{" +
                "postId=" + postId +
                ", userId=" + userId +
                ", content='" + content + '\'' +
                ", privacy='" + privacy + '\'' +
                ", createAt=" + createAt +
                ", updateAt=" + updateAt +
                '}';
    }
}

