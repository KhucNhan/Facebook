package model;

import java.sql.Timestamp;

public class MessageEmotions {
    private int emotionId;
    private int userId;
    private int messageId;
    private Timestamp createAt;

    public  MessageEmotions(){

    }
    public MessageEmotions(int emotionId, int userId, int messageId, Timestamp createAt){
        this.emotionId = emotionId;
        this.userId = userId;
        this.messageId = messageId;
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

    public int getMessageId() {
        return messageId;
    }

    public void setMessageId(int messageId) {
        this.messageId = messageId;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }
}
