package com.example.facebook.service;

import com.example.facebook.model.User;

import java.sql.SQLException;
import java.util.List;

public interface IFriendShipDAO {
    List<User> getAllFriendsAdded(int userId) throws SQLException;
    List<User> getAllFriendsRequest(int userId) throws SQLException;

    boolean acceptFriend(int userId,int userIdFriend);
    boolean deleteFriend(int userId,int userIdFriend);
    List<User> searchUsersInRequests(String value, int userId)  throws SQLException;
    List<User> searchUsersFriends(String value, int userId) throws SQLException;
}
