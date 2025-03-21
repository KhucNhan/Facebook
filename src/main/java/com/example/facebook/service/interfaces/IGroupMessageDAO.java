package com.example.facebook.service.interfaces;

import com.example.facebook.model.GroupMessage;

import java.sql.SQLException;
import java.util.List;

public interface IGroupMessageDAO {
    int insertMessage(int groupId, int senderId, String content) throws SQLException;
    List<GroupMessage> selectAllMessageByGroup(int groupId) throws SQLException;
    boolean deleteMessage(int messageId) throws SQLException;
}
