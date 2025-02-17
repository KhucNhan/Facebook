package com.example.facebook.model;

import java.sql.Timestamp;

public class GroupMembers {
    private int groupId;
    private int userId;
    private String role;
    private Timestamp joinAt;

    public GroupMembers(){

    }
    public GroupMembers(int groupId, int userId, String role, Timestamp joinAt){
        this.groupId = groupId;
        this.userId = userId;
        this.role = role;
        this.joinAt = joinAt;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Timestamp getJoinAt() {
        return joinAt;
    }

    public void setJoinAt(Timestamp joinAt) {
        this.joinAt = joinAt;
    }
}
