package com.example.facebook;

import java.sql.Timestamp;

public class FriendShips {
    private int friendShipId;
    private int userId_1;
    private int userId_2;
    private String status;
    private Timestamp createAt;
    private Timestamp updateAt;

    public FriendShips() {
    }

    public FriendShips(int friendShipId, int userId_1, int userId_2, String status, Timestamp createAt, Timestamp updateAt) {
        this.friendShipId = friendShipId;
        this.userId_1 = userId_1;
        this.userId_2 = userId_2;
        this.status = status;
        this.createAt = createAt;
        this.updateAt = updateAt;
    }

    public int getFriendShipId() {
        return friendShipId;
    }

    public void setFriendShipId(int friendShipId) {
        this.friendShipId = friendShipId;
    }

    public int getUserId_1() {
        return userId_1;
    }

    public void setUserId_1(int userId_1) {
        this.userId_1 = userId_1;
    }

    public int getUserId_2() {
        return userId_2;
    }

    public void setUserId_2(int userId_2) {
        this.userId_2 = userId_2;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    public Timestamp getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Timestamp updateAt) {
        this.updateAt = updateAt;
    }

    @Override
    public String toString() {
        return "FriendShips{" +
                "friendShipId=" + friendShipId +
                ", userId_1=" + userId_1 +
                ", userId_2=" + userId_2 +
                ", status='" + status + '\'' +
                ", createAt=" + createAt +
                ", updateAt=" + updateAt +
                '}';
    }
}
