package com.example.facebook.model;

public class Emotion {
    private int emotionId;
    private String name;

    public Emotion(){

    }
    public Emotion(int emotionId, String name){
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
