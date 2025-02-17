package model;

public class Emotions {
    private int emotionId;
    private String name;

    public Emotions(){

    }
    public Emotions(int emotionId, String name){
        this.emotionId = emotionId;
        this.name = name;
    }

    public int getEmotionId() {
        return emotionId;
    }

    public void setEmotionId(int emotionId) {
        this.emotionId = emotionId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
