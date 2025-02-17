package model;

import java.sql.Timestamp;

public class PostEmotion {
    private int emotionId;
    private int userId;
    private int postId;
    private Timestamp createAt;

    public PostEmotion(){

    }
    public PostEmotion(int emotionId, int userId, int postId, Timestamp createAt){
        this.emotionId = emotionId;
        this.userId = userId;
        this.postId = postId;
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

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }
}
