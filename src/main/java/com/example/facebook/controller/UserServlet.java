package com.example.facebook.controller;

import com.example.facebook.model.User;
import com.example.facebook.service.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
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
        try {
            switch (action) {
                case "add":
                    showAddUser(req, resp);
                    break;
                case "update":
                    showUpdateUser(req, resp);
                    break;
                default:
                    showUserList(req, resp);
                    break;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void showUpdateUser(HttpServletRequest req, HttpServletResponse resp) {

    }

    private void showAddUser(HttpServletRequest req, HttpServletResponse resp) {

    }

    private void showUserList(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        List<User> users = userDAO.selectAllUsers();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/admin/Users.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }
        try {
            switch (action) {
                case "add":
                    addUser(req, resp);
                    break;
                case "update":
                    updateUser(req, resp);
                    break;
                case "delete":
                    deleteUser(req, resp);
                    break;
                case "search":
                    searchUser(req, resp);
                    break;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void searchUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        String value = req.getParameter("value");
        List<User> users = userDAO.searchUsers(value);
        req.setAttribute("users", users);
        req.getRequestDispatcher("/admin/Users.jsp").forward(req, resp);
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        String userId = req.getParameter("userId");
        userDAO.deleteUser(Integer.parseInt(userId));
    }

    private void addUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        String image = req.getParameter("image");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String dateOfBirth = req.getParameter("dateOfBirth");
        boolean gender = Boolean.parseBoolean(req.getParameter("gender"));

        User user = new User(image, name, email, Integer.parseInt(phone), password, Date.valueOf(dateOfBirth), gender);
        userDAO.insertUser(user);
    }

    private void updateUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        String userId = req.getParameter("userId");
        String image = req.getParameter("image");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String dateOfBirth = req.getParameter("dateOfBirth");
        boolean gender = Boolean.parseBoolean(req.getParameter("gender"));

        User user = userDAO.selectUserById(Integer.parseInt(userId));
        user.setImage(image);
        user.setName(name);
        user.setEmail(email);
        user.setPhone(Integer.parseInt(phone));
        user.setDateOfBirth(Date.valueOf(dateOfBirth));
        user.setGender(gender);

        userDAO.updateUser(user, Integer.parseInt(userId));
    }
}