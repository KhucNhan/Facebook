package com.example.facebook.model;

import java.sql.Timestamp;

public class Group {
    private int groupId;
    private String name;
    private int createBy;
    private Timestamp createAt;

    public Group(){

    }
    public Group(int groupId, String name, int createBy, Timestamp createAt){
        this.groupId = groupId;
        this.name = name;
        this.createBy = createBy;
        this.createAt = createAt;
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
