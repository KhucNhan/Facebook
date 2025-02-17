package com.example.facebook.model;

import java.sql.Timestamp;
import java.sql.Date;

public class User {
    private int userId;
    private String image;
    private String name;
    private String email;
    private int phone;
    private String password;
    private Date dateOfBirth;
    private boolean gender;
    private String bio;
    private String role;
    private Timestamp createAt;
    private Timestamp updateAt;
    private boolean status;

    public User() {
    }

    public User(int userId, String image, String name, String email, int phone, String password, Date dateOfBirth, boolean gender, String bio, String role, Timestamp createAt, Timestamp updateAt, boolean status) {
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

    public int getPhone() {
        return phone;
    }

    public void setPhone(int phone) {
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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
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
}
