package com.example.facebook.service;

import com.example.facebook.model.Group;

import java.sql.SQLException;
import java.util.List;

public interface IGroupDAO {
    int insertNewGroup(Group group) throws SQLException;
    List<Group> selectAllGroups(int userId) throws SQLException;
    boolean updateGroup(Group group, int groupId) throws SQLException;
    Group selectGroupById(int groupId) throws SQLException;
    boolean deleteGroup(int groupId) throws SQLException;
}
