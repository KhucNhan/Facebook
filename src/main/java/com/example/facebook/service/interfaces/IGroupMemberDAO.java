package com.example.facebook.service.interfaces;

import com.example.facebook.model.GroupMember;

import java.sql.SQLException;
import java.util.List;

public interface IGroupMemberDAO {
    int insertMember(int groupId, int userId, String role) throws SQLException;
    List<GroupMember> selectMembersByGroup(int groupId) throws SQLException;
    boolean removeMember(int groupId, int memberId) throws SQLException;
}
