package com.example.facebook.service;

import com.example.facebook.model.User;

import java.sql.SQLException;
import java.util.List;

public interface IFriendShipDAO {
    List<User> getAllFriendsAdded(int friendShipId) throws SQLException;
}
