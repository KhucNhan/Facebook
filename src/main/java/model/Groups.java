package model;

import java.sql.Timestamp;
import java.util.SplittableRandom;

public class Groups {
    private int groupId;
    private String name;
    private int createBy;
    private Timestamp createAt;

    public Groups(){

    }
    public Groups(int groupId, String name, int createBy, Timestamp createAt){
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
