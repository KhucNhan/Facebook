package com.example.facebook.service;

public interface IActivityDAO {
    int newActivities(int userID,int keyword);

    boolean deleteActivities(int activityId);

    boolean deleteActivity(int target);

    int newAddSuccess(int userID,int keyword);

}
