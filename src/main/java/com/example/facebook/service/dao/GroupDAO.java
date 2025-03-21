package com.example.facebook.service.dao;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.Group;
import com.example.facebook.service.interfaces.IGroupDAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GroupDAO implements IGroupDAO {
    ConnectDatabase connectDatabase = new ConnectDatabase();
    Connection connection = connectDatabase.connection();
    private static final String insert_group = "INSERT INTO `groups` (name, createdBy) VALUES (?, ?)";
    private static final String select_all_group = "select g.* from `groups` g join group_members gm on g.groupId = gm.groupId where gm.userId = ?";
    private static final String update_group = "update `groups` set name = ?, image = ? where groupId = ?";
    private static final String delete_group = "delete from `groups` where groupId = ?";
    private static final String select_group_by_id = "select * from `groups` where groupId = ?";
    @Override
    public int insertNewGroup(Group group) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(insert_group, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setString(1, group.getName());
        preparedStatement.setInt(2, group.getCreateBy());

        int row = preparedStatement.executeUpdate();
        if (row > 0) {
            ResultSet resultSet = preparedStatement.getGeneratedKeys();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        }
        return -1;
    }

    @Override
    public List<Group> selectAllGroups(int userId) throws SQLException {
        List<Group> groups = new ArrayList<>();
        PreparedStatement preparedStatement = connection.prepareStatement(select_all_group);
        preparedStatement.setInt(1, userId);
        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()) {
            groups.add(new Group(
                    resultSet.getInt("groupId"),
                    resultSet.getString("name"),
                    resultSet.getString("image"),
                    resultSet.getInt("createdBy"),
                    resultSet.getTimestamp("createAt")
            ));
        }

        return groups;
    }

    @Override
    public boolean updateGroup(Group group, int groupId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(update_group);
        preparedStatement.setString(1, group.getName());
        preparedStatement.setString(2, group.getImage());
        preparedStatement.setInt(3, groupId);

        int row = preparedStatement.executeUpdate();
        return row > 0;
    }

    @Override
    public Group selectGroupById(int groupId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(select_group_by_id);
        preparedStatement.setInt(1, groupId);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            return new Group(
                    resultSet.getInt("groupId"),
                    resultSet.getString("name"),
                    resultSet.getString("image"),
                    resultSet.getInt("createdBy"),
                    resultSet.getTimestamp("createAt")
            );
        }

        return null;
    }

    @Override
    public boolean deleteGroup(int groupId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(delete_group);
        preparedStatement.setInt(1, groupId);
        int row = preparedStatement.executeUpdate();
        return row > 0;
    }
}
