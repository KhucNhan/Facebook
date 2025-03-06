package com.example.facebook.service;

import com.example.facebook.model.Message;

import java.sql.SQLException;
import java.util.List;

public interface IMessageDAO {
    List<Message> selectAllMessages(int currentUserId, int otherUserId) throws SQLException;
    int insertNewMessage(Message message) throws SQLException;

    boolean deleteMessage(int messageId) throws SQLException;

    List<Message> selectContentMessage(int receiverId);
}
