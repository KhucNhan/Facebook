package com.example.facebook.service;

import com.example.facebook.model.User;

import java.sql.SQLException;
import java.util.List;

public interface IUserDAO {
    List<User> selectAllUsers() throws SQLException;
    boolean insertUser(User user) throws SQLException;
    User selectUserById(int userId) throws SQLException;
    boolean updateUser(User user, int userId) throws SQLException;
    boolean deleteUser(int userId) throws SQLException;
    List<User> selectUsersByEmail(String value) throws SQLException;
    List<User> selectUsersByPhone(String value) throws SQLException;
    List<User> selectUsersByName(String value) throws SQLException;
    boolean isUserExists(String email, String phone) throws SQLException;
    List<User> adminSearchUsers(String value) throws SQLException;
    List<User> userSearchUsers(String value, int userId) throws SQLException;
}