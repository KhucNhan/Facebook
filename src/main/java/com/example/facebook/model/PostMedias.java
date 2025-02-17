package com.example.facebook.model;

public class PostMedias {
    private int postMediaId;
    private int postId;
    private String url;
    private String type;

    public PostMedias(){

    }
    public PostMedias(int postMediaId, int postId, String url, String type){
        this.postMediaId = postMediaId;
        this.postId = postId;
        this.url = url;
        this.type = type;
    }

    public int getPostMediaId() {
        return postMediaId;
    }

    public void setPostMediaId(int postMediaId) {
        this.postMediaId = postMediaId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
