package com.example.facebook.service.dao;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.Message;
import com.example.facebook.service.interfaces.IMessageDAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessageDAO implements IMessageDAO {
    ConnectDatabase connectDatabase = new ConnectDatabase();
    Connection connection = connectDatabase.connection();
    private static final String select_all_message = "SELECT * FROM messages WHERE (senderId = ? AND receiverId = ?) OR (senderId = ? AND receiverId = ?) ORDER BY createAt";
    private static final String insert_new_message = "INSERT INTO messages (senderId, receiverId, content) VALUES (?, ?, ?)";
    private static final String delete_message = "UPDATE messages SET content = 'Tin nhắn đã bị gỡ' WHERE messageId = ?";

    private static final String select_content_message = "SELECT *\n" +
            "FROM messages\n" +
            "WHERE senderId = ? or receiverId = ?\n" +
            "ORDER BY createAt DESC\n" +
            "LIMIT 1;";
    @Override
    public List<Message> selectAllMessages(int currentUserId, int otherUserId) throws SQLException {
        List<Message> messages = new ArrayList<>();
        PreparedStatement preparedStatement = connection.prepareStatement(select_all_message);
        preparedStatement.setInt(1, currentUserId);
        preparedStatement.setInt(2, otherUserId);
        preparedStatement.setInt(3, otherUserId);
        preparedStatement.setInt(4, currentUserId);

        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            messages.add(new Message(
               resultSet.getInt(1),
               resultSet.getInt(2),
               resultSet.getInt(3),
               resultSet.getString(4),
               resultSet.getTimestamp(5)
            ));
        }

        return messages;
    }

    @Override
    public int insertNewMessage(Message message) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(insert_new_message, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setInt(1, message.getSenderId());
        preparedStatement.setInt(2, message.getReceiverId());
        preparedStatement.setString(3, message.getContent());

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
    public boolean deleteMessage(int messageId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(delete_message);
        preparedStatement.setInt(1, messageId);
        int row = preparedStatement.executeUpdate();
        return row > 0;
    }

    @Override
    public List<Message> selectContentMessage(int receiverId) {
        List<Message> messagesNotification = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(select_content_message);
            preparedStatement.setInt(1,receiverId);
            preparedStatement.setInt(2,receiverId);

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) { // Duyệt từng dòng kết quả
                int messageId = resultSet.getInt("messageId");
                int senderId = resultSet.getInt("senderId");
                String content = resultSet.getString("content");
                Timestamp createAt = resultSet.getTimestamp("createAt");

                Message message = new Message(messageId, senderId, receiverId, content, createAt);
                messagesNotification.add(message);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return messagesNotification;
    }
}
