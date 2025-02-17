package com.example.facebook.model;

public class MessageMedias {
    private int messageMediaId;
    private int messageId;
    private String url;
    private  String type;

    public MessageMedias(){

    }
    public MessageMedias(int messageMediaId, int messageId, String url, String type){
        this.messageMediaId = messageMediaId;
        this.messageId = messageId;
        this.url = url;
        this.type = type;
    }

    public int getMessageMediaId() {
        return messageMediaId;
    }

    public void setMessageMediaId(int messageMediaId) {
        this.messageMediaId = messageMediaId;
    }

    public int getMessageId() {
        return messageId;
    }

    public void setMessageId(int messageId) {
        this.messageId = messageId;
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
