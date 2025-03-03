package com.example.facebook.service;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class UserDAO implements IUserDAO {
    private ConnectDatabase connectDatabase = new ConnectDatabase();
    private Connection connection = connectDatabase.connection();

    private static UserDAO userDAO = new UserDAO();


    private static final String select_all_users = "select * from users order by userId desc";
    private static final String insert_user = "INSERT INTO users (name, email, phone, password, dateOfBirth, gender, bio, image, createAt, updateAt) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())";

    private static final String update_user = "UPDATE users SET image = ?, name = ?, email = ?, phone = ?, dateOfBirth = ?, gender = ?, updateAt = NOW(), status = ?, password = ?, banner = ? WHERE userId = ?";

    private static final String select_user_by_id = "SELECT * FROM users WHERE userId = ?";

    private static final String delete_user_by_id = "DELETE FROM users WHERE userId = ?";

    private static final String select_user_by_email = "SELECT * FROM users WHERE email LIKE ?";

    private static final String select_user_by_phone = "SELECT * FROM users WHERE phone LIKE ?";

    private static final String select_user_by_name = "SELECT * FROM users WHERE name LIKE ?";

    private static final String select_user_by_name_sort_by_status = "SELECT u.* ,\n" +
            "       CASE \n" +
            "           WHEN f.status = 'accepted' THEN 1  -- Đã kết bạn\n" +
            "           WHEN f.status = 'pending' AND f.receiverId = ? THEN 2  -- Lời mời kết bạn (user hiện tại là người nhận)\n" +
            "           when f.status = 'pending' and f.senderId = ? then 3\n" +
            "           ELSE 4  -- Chưa kết bạn\n" +
            "       END AS friend_status\n" +
            "FROM users u\n" +
            "LEFT JOIN friendships f \n" +
            "    ON (f.senderId = u.userId AND f.receiverId = ?) \n" +
            "    OR (f.receiverId = u.userId AND f.senderId = ?)\n" +
            "WHERE u.name LIKE ? AND u.userId != ?\n" +
            "ORDER BY friend_status, u.name;";

    @Override
    public List<User> selectAllUsers() throws SQLException {
        List<User> users = new ArrayList<>();
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(select_all_users);
        User user;
        while (resultSet.next()) {
            user = new User(
                    resultSet.getInt(1),
                    resultSet.getString(2),
                    resultSet.getString(3),
                    resultSet.getString(4),
                    resultSet.getString(5),
                    resultSet.getString(6),
                    resultSet.getDate(7),
                    resultSet.getBoolean(8),
                    resultSet.getString(9),
                    resultSet.getString(10),
                    resultSet.getTimestamp(11),
                    resultSet.getTimestamp(12),
                    resultSet.getBoolean(13)
            );
            user.setBanner(resultSet.getString(14));
            users.add(user);
        }

        return users;
    }

    @Override
    public boolean insertUser(User user) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(insert_user);
        preparedStatement.setString(1, user.getName());
        preparedStatement.setString(2, user.getEmail());
        preparedStatement.setString(3, user.getPhone());
        preparedStatement.setString(4, user.getPassword());
        preparedStatement.setDate(5, user.getDateOfBirth());
        preparedStatement.setBoolean(6, user.isGender());
        preparedStatement.setString(7, user.getBio());
        preparedStatement.setString(8, user.getImage());

        int rowsAffected = preparedStatement.executeUpdate();
        return rowsAffected > 0;
    }

    @Override
    public User selectUserById(int userId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(select_user_by_id);
        preparedStatement.setInt(1, userId);
        ResultSet resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            User user = new User(
                    resultSet.getInt(1),
                    resultSet.getString(2),
                    resultSet.getString(3),
                    resultSet.getString(4),
                    resultSet.getString(5),
                    resultSet.getString(6),
                    resultSet.getDate(7),
                    resultSet.getBoolean(8),
                    resultSet.getString(9),
                    resultSet.getString(10),
                    resultSet.getTimestamp(11),
                    resultSet.getTimestamp(12),
                    resultSet.getBoolean(13)
            );
            user.setBanner(resultSet.getString(14));
            return user;
        } else {
            return null;
        }
    }

    @Override
    public boolean updateUser(User user, int userId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(update_user);
        preparedStatement.setString(1, user.getImage());
        preparedStatement.setString(2, user.getName());
        preparedStatement.setString(3, user.getEmail());
        preparedStatement.setString(4, user.getPhone());
        preparedStatement.setDate(5, user.getDateOfBirth());
        preparedStatement.setBoolean(6, user.isGender());
        preparedStatement.setBoolean(7, user.isStatus());
        preparedStatement.setString(8, user.getPassword());
        preparedStatement.setString(9, user.getBanner());
        preparedStatement.setInt(10, userId);

        int rowsAffected = preparedStatement.executeUpdate();
        return rowsAffected > 0;
    }

    @Override
    public boolean deleteUser(int userId) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(delete_user_by_id);
        preparedStatement.setInt(1, userId);

        int rowsAffected = preparedStatement.executeUpdate();
        return rowsAffected > 0;
    }

    @Override
    public List<User> adminSearchUsers(String value) throws SQLException {
        Set<User> resultSet = new HashSet<>();

        if (value != null) {
            if (value.matches("^\\d+$")) {
                resultSet.addAll(userDAO.selectUsersByPhone(value));
            } else {
                resultSet.addAll(userDAO.selectUsersByName(value));
                resultSet.addAll(userDAO.selectUsersByEmail(value));
            }
        }

        return new ArrayList<>(resultSet);
    }

    @Override
    public List<User> userSearchUsers(String value, int userId) throws SQLException {
        List<User> searchList = new ArrayList<>();
        PreparedStatement preparedStatement = connection.prepareStatement(select_user_by_name_sort_by_status);
        preparedStatement.setInt(1, userId);
        preparedStatement.setInt(2, userId);
        preparedStatement.setInt(3, userId);
        preparedStatement.setInt(4, userId);
        preparedStatement.setString(5, "%" + value + "%");
        preparedStatement.setInt(6, userId);

        ResultSet resultSet = preparedStatement.executeQuery();
        User user;
        while (resultSet.next()) {
             user = new User(
                    resultSet.getInt(1),
                    resultSet.getString(2),
                    resultSet.getString(3),
                    resultSet.getString(4),
                    resultSet.getString(5),
                    resultSet.getString(6),
                    resultSet.getDate(7),
                    resultSet.getBoolean(8),
                    resultSet.getString(9),
                    resultSet.getString(10),
                    resultSet.getTimestamp(11),
                    resultSet.getTimestamp(12),
                    resultSet.getBoolean(13));
             user.setBanner(resultSet.getString(14));
             user.setFriendStatus(resultSet.getInt(15));
            searchList.add(user);
        }

        return searchList;
    }

    @Override
    public List<User> selectUsersByEmail(String value) throws SQLException {
        List<User> users = new ArrayList<>();
        PreparedStatement preparedStatement = connection.prepareStatement(select_user_by_email);
        preparedStatement.setString(1, "%" + value + "%");
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            users.add(new User(
                    resultSet.getInt(1),
                    resultSet.getString(2),
                    resultSet.getString(3),
                    resultSet.getString(4),
                    resultSet.getString(5),
                    resultSet.getString(6),
                    resultSet.getDate(7),
                    resultSet.getBoolean(8),
                    resultSet.getString(9),
                    resultSet.getString(10),
                    resultSet.getTimestamp(11),
                    resultSet.getTimestamp(12),
                    resultSet.getBoolean(13)
            ));
        }

        return users;
    }

    @Override
    public List<User> selectUsersByPhone(String value) throws SQLException {
        List<User> users = new ArrayList<>();
        System.out.println(value);
        PreparedStatement preparedStatement = connection.prepareStatement(select_user_by_phone);
        preparedStatement.setString(1, "%" + value + "%");
        System.out.println(preparedStatement);
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            users.add(new User(
                    resultSet.getInt(1),
                    resultSet.getString(2),
                    resultSet.getString(3),
                    resultSet.getString(4),
                    resultSet.getString(5),
                    resultSet.getString(6),
                    resultSet.getDate(7),
                    resultSet.getBoolean(8),
                    resultSet.getString(9),
                    resultSet.getString(10),
                    resultSet.getTimestamp(11),
                    resultSet.getTimestamp(12),
                    resultSet.getBoolean(13)
            ));
        }

        return users;
    }

    @Override
    public List<User> selectUsersByName(String value) throws SQLException {
        List<User> users = new ArrayList<>();
        PreparedStatement preparedStatement = connection.prepareStatement(select_user_by_name);
        preparedStatement.setString(1, "%" + value + "%");
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            users.add(new User(
                    resultSet.getInt(1),
                    resultSet.getString(2),
                    resultSet.getString(3),
                    resultSet.getString(4),
                    resultSet.getString(5),
                    resultSet.getString(6),
                    resultSet.getDate(7),
                    resultSet.getBoolean(8),
                    resultSet.getString(9),
                    resultSet.getString(10),
                    resultSet.getTimestamp(11),
                    resultSet.getTimestamp(12),
                    resultSet.getBoolean(13)
            ));
        }

        return users;
    }

    @Override
    public boolean isUserExists(String email, String phone) throws SQLException {
        String query = "SELECT 1 FROM users WHERE email = ? OR phone = ? LIMIT 1";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, email);
            stmt.setString(2, phone);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }
}