package com.example.facebook.model;

public class Target {
    private int targetId;
    private String type;

    public Target() {
    }

    public Target(int targetId, String type) {
        this.targetId = targetId;
        this.type = type;
    }

    public int getTargetId() {
        return targetId;
    }

    public void setTargetId(int targetId) {
        this.targetId = targetId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "Targets{" +
                "targetId=" + targetId +
                ", type='" + type + '\'' +
                '}';
    }
}
