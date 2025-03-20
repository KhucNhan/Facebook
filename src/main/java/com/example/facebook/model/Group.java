package com.example.facebook.model;

import java.sql.Timestamp;

public class Group {
    private int groupId;
    private String name;
    private int createBy;
    private Timestamp createAt;
    private String image;

    public Group(){

    }
    public Group(int groupId, String name, String image, int createBy, Timestamp createAt){
        this.groupId = groupId;
        this.name = name;
        this.image = image;
        this.createBy = createBy;
        this.createAt = createAt;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCreateBy() {
        return createBy;
    }

    public void setCreateBy(int createBy) {
        this.createBy = createBy;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }
}
