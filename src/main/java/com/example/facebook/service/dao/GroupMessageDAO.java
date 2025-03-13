package com.example.facebook.service.dao;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.GroupMessage;
import com.example.facebook.service.interfaces.IGroupMessageDAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GroupMessageDAO implements IGroupMessageDAO {
    ConnectDatabase connectDatabase = new ConnectDatabase();
    Connection connection = connectDatabase.connection();

    private static final String insert_message = "INSERT INTO groupmessages (groupId, senderId, content, createAt) VALUES (?, ?, ?, NOW())";
    private static final String select_messages_by_group = "SELECT * FROM groupmessages WHERE groupId = ? ORDER BY createAt ASC";
    private static final String delete_message = "UPDATE groupmessages SET content = 'Tin nhắn đã bị gỡ' WHERE groupMessageId = ?";

    // Thêm tin nhắn vào nhóm
    @Override
    public int insertMessage(int groupId, int senderId, String content) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(insert_message, Statement.RETURN_GENERATED_KEYS);
        preparedStatement.setInt(1, groupId);
        preparedStatement.setInt(2, senderId);
        preparedStatement.setString(3, content);

        int row = preparedStatement.executeUpdate();
        if (row > 0) {
            ResultSet resultSet = preparedStatement.getGeneratedKeys();
            if (resultSet.next()) {
                return resultSet.getInt(1); // Trả về ID của tin nhắn mới
            }
        }

        return -1;
    }

    // Lấy danh sách tin nhắn của một nhóm
    @Override
    public List<GroupMessage> selectAllMessageByGroup(int groupId) throws SQLException {
        List<GroupMessage> messages = new ArrayList<>();
        PreparedStatement preparedStatement = connection.prepareStatement(select_messages_by_group);
        preparedStatement.setInt(1, groupId);
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            int messageId = resultSet.getInt("groupMessageId");
            int senderId = resultSet.getInt("senderId");
            String content = resultSet.getString("content");
            Timestamp createAt = resultSet.getTimestamp("createAt");

            messages.add(new GroupMessage(messageId, groupId, senderId, content, createAt));
        }

        return messages;
    }

    // Xóa tin nhắn theo ID
    @Override
    public boolean deleteMessage(int messageId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(delete_message);
        preparedStatement.setInt(1, messageId);
        return preparedStatement.executeUpdate() > 0;
    }
}

