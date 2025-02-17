package com.example.facebook.model;

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

    public static Connection connection() throws ClassNotFoundException, SQLException {
        Connection connection = null;
        Class.forName("com.mysql.cj.jdbc.Driver");

        connection = DriverManager.getConnection(URL, dbUsername, dbPassword);
        return connection;
    }

}
