package com.example.facebook.service;

import com.example.facebook.model.Activity;

import java.sql.SQLException;
import java.util.List;

public interface IActivityDAO {
    int newActivities(int userID,int keyword,String type);

    boolean deleteActivities(int activityId);

    boolean deleteActivity(int target);

    int newAddSuccess(int userID,int keyword);
    List<Activity> selectAllActivity() throws SQLException;

}
