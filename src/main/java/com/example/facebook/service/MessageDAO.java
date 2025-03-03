package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.Comment;
import com.example.facebook.model.Message;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessageDAO implements IMessageDAO{
    ConnectDatabase connectDatabase = new ConnectDatabase();
    Connection connection = connectDatabase.connection();
    private static final String select_all_message = "SELECT * FROM messages WHERE (senderId = ? AND receiverId = ?) OR (senderId = ? AND receiverId = ?) ORDER BY createAt";
    private static final String insert_new_message = "INSERT INTO messages (senderId, receiverId, content) VALUES (?, ?, ?)";
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
}
