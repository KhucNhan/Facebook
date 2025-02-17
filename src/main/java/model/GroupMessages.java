package model;

import java.sql.Timestamp;

public class GroupMessages {
    private int groupMessageId;
    private int groupId;
    private int senderId;
    private String content;
    private Timestamp createAt;

    public GroupMessages(){

    }
    public GroupMessages(int groupMessageId, int groupId, int senderId, String content, Timestamp createAt){
        this.groupMessageId = groupMessageId;
        this.groupId = groupId;
        this.senderId = senderId;
        this.content = content;
        this.createAt = createAt;
    }

    public int getGroupMessageId() {
        return groupMessageId;
    }

    public void setGroupMessageId(int groupMessageId) {
        this.groupMessageId = groupMessageId;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public int getSenderId() {
        return senderId;
    }

    public void setSenderId(int senderId) {
        this.senderId = senderId;
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
}
