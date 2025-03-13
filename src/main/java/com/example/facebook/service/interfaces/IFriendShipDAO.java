package com.example.facebook.service.interfaces;

import com.example.facebook.model.FriendShip;
import com.example.facebook.model.User;

import java.sql.SQLException;
import java.util.List;

public interface IFriendShipDAO {
    List<User> getAllFriendsAdded(int userId) throws SQLException;
    List<User> getAllFriendsRequest(int userId) throws SQLException;

    int acceptFriend(int userId,int userIdFriend);
    boolean deleteFriend(int userId,int userIdFriend);
    int deleteFriendID(int userId,int userIdFriend);
    boolean unFriend(int userId,int userIdFriend);

    List<User> searchUsersInRequests(String value, int userId)  throws SQLException;
    List<User> searchUsersFriends(String value, int userId) throws SQLException;

    int addFriend(int userId,int userIdFriend);

    FriendShip getFriendShipStatus(int user1, int user2);

}
