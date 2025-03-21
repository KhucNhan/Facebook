package com.example.facebook.model;

import java.sql.Timestamp;
import java.sql.Date;
import java.util.Objects;

public class User {
    private int userId;
    private String image;
    private String banner;
    private String name;
    private String email;
    private String phone;
    private String password;
    private Date dateOfBirth;
    private boolean gender;
    private String bio;
    private String role;
    private Timestamp createAt;
    private Timestamp updateAt;
    private String status;

    private int friendStatus;
    public User() {
    }

    public User(int userId, String image, String name, String email, String phone, String password, Date dateOfBirth, boolean gender, String bio, String role, Timestamp createAt, Timestamp updateAt, String status, String banner) {
        this.userId = userId;
        this.image = image;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.bio = bio;
        this.role = role;
        this.createAt = createAt;
        this.updateAt = updateAt;
        this.status = status;
        this.banner = banner;
    }

    public User(String image, String name, String email, String phone, String password, Date dateOfBirth, boolean gender) {
        this.image = image;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
    }

    public String getBanner() {
        return banner;
    }

    public void setBanner(String banner) {
        this.banner = banner;
    }

    public int getFriendStatus() {
        return friendStatus;
    }

    public void setFriendStatus(int friendStatus) {
        this.friendStatus = friendStatus;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "com.example.facebook.model.User{" +
                "userId=" + userId +
                ", image='" + image + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", phone=" + phone +
                ", password='" + password + '\'' +
                ", dateOfBirth=" + dateOfBirth +
                ", gender=" + gender +
                ", bio='" + bio + '\'' +
                ", createAt=" + createAt +
                ", updateAt=" + updateAt +
                ", status=" + status +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof User)) return false;
        User user = (User) o;
        return getUserId() == user.getUserId();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getUserId());
    }
}
