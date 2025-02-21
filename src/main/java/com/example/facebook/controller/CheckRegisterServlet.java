package com.example.facebook.controller;

import com.example.facebook.ConnectDatabase;
import com.example.facebook.service.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Objects;

@WebServlet("/check-register")
public class CheckRegisterServlet extends HttpServlet {
    UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/plain;charset=UTF-8");

        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String rePassword = request.getParameter("rePassword");

        if ((email == null || email.isEmpty()) && (phone == null || phone.isEmpty())) {
            response.getWriter().write("invalid");
            return;
        }

        try {
            if (name.matches(".*[^a-zA-Z0-9\\s].*")) {
                response.getWriter().write("nameError");
            } else if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.(com|vn|org|net|edu|gov|info)$")) {
                response.getWriter().write("emailRegex");
            } else if (userDAO.isUserExists(email, phone)) {
                response.getWriter().write("exists");
            } else if (password.length() < 6) {
                response.getWriter().write("passwordLengthError");
            } else if (!password.equals(rePassword)) {
                response.getWriter().write("passwordError");
            } else {
                response.getWriter().write("pass");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("error");
        }
    }
}

