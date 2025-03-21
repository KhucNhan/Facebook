package com.example.facebook.service.dao;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.GroupMember;
import com.example.facebook.service.interfaces.IGroupMemberDAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GroupMemberDAO implements IGroupMemberDAO {
    ConnectDatabase connectDatabase = new ConnectDatabase();
    Connection connection = connectDatabase.connection();
    private static final String insert_member = "INSERT INTO group_members (groupId, userId, role) VALUES (?, ?, ?)";
    private static final String select_all_member = "select * from group_members where groupId = ?";
    private static final String delete_member = "delete from group_members where groupId = ? and userId = ?";
    @Override
    public int insertMember(int groupId, int userId, String role) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(insert_member, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setInt(1, groupId);
        preparedStatement.setInt(2, userId);
        preparedStatement.setString(3, role);

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
    public List<GroupMember> selectMembersByGroup(int groupId) throws SQLException {
        List<GroupMember> members = new ArrayList<>();
        PreparedStatement preparedStatement = connection.prepareStatement(select_all_member);
        preparedStatement.setInt(1, groupId);
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            members.add(new GroupMember(
                    resultSet.getInt("groupId"),
                    resultSet.getInt("userId"),
                    resultSet.getString("role"),
                    resultSet.getTimestamp("joinAt")
            ));
        }

        return members;
    }

    @Override
    public boolean removeMember(int groupId, int memberId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(delete_member);
        preparedStatement.setInt(1, groupId);
        preparedStatement.setInt(2, memberId);
        int row = preparedStatement.executeUpdate();
        return row > 0;
    }
}
