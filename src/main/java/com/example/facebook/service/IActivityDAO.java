package com.example.facebook.service;

public interface IActivityDAO {
    int newActivities(int userID,int keyword,String type);

    boolean deleteActivities(int activityId);

    boolean deleteActivity(int target);

    int newAddSuccess(int userID,int keyword);

}
