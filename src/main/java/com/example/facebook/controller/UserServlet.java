package com.example.facebook.controller;

import com.example.facebook.model.User;
import com.example.facebook.service.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "UserServlet", value = "/users")
public class UserServlet extends HttpServlet {
    UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }

        switch (action) {
            default:
                try {
                    showUserList(req, resp);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
        }
    }

    private void showUserList(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        List<User> users = userDAO.selectAllUsers();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/admin/Users.jsp").forward(req, resp);
    }


}
