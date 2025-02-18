package com.example.facebook.model;

import java.sql.Timestamp;

public class Post {
    private int postId;
    private User user;
    private String content;
    private String privacy;
    private Timestamp createAt;
    private Timestamp updateAt;
    private int totalEmotions;
    private int totalComments;

    public Post() {
    }

    public Post(int postId, User user, String content, String privacy, Timestamp createAt, Timestamp updateAt, int totalEmotions, int totalComments) {
        this.postId = postId;
        this.user = user;
        this.content = content;
        this.privacy = privacy;
        this.createAt = createAt;
        this.updateAt = updateAt;
        this.totalEmotions = totalEmotions;
        this.totalComments = totalComments;
    }

    public Post(User user, String content, String privacy) {
        this.user = user;
        this.content = content;
        this.privacy = privacy;
    }

    public int getTotalEmotions() {
        return totalEmotions;
    }

    public void setTotalEmotions(int totalEmotions) {
        this.totalEmotions = totalEmotions;
    }

    public int getTotalComments() {
        return totalComments;
    }

    public void setTotalComments(int totalComments) {
        this.totalComments = totalComments;
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

}

