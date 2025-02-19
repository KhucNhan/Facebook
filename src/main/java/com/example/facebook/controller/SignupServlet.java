package com.example.facebook.controller;

import com.example.facebook.ConnectDatabase;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;

@WebServlet("/register")
public class SignupServlet extends HttpServlet {
    ConnectDatabase connectDatabase = new ConnectDatabase();
    Connection connection = ConnectDatabase.connection();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("view/Login.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");


        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        String dateOfBirthStr = request.getParameter("dob");
        Date dateOfBirth = Date.valueOf(dateOfBirthStr);

        String genderStr = request.getParameter("gender");
        boolean gender = genderStr.equals("male");

        try {
            String sql = "INSERT INTO users (name, email, phone, password, dateOfBirth, gender, role, createAt, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, 'user', CURRENT_TIMESTAMP, true)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, password);
            ps.setDate(5, dateOfBirth);
            ps.setBoolean(6, gender);

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect("view/Login.jsp");
            }

            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

