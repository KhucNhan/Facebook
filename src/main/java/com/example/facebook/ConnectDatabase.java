package com.example.facebook;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectDatabase {
    private static String URL = "jdbc:mysql://127.0.0.1/facebook";
    private static String dbUsername = System.getenv("dbUsername");
    private static String dbPassword = System.getenv("dbPassword");

//    private static String dbUsername = "root";
//    private static String dbPassword = "1962005";

    public ConnectDatabase() {
    }

    public static Connection connection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, dbUsername, dbPassword);
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }

        return connection;
    }

}