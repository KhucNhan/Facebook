package com.example.facebook.controller;

import com.example.facebook.model.User;
import com.example.facebook.service.GroupDAO;
import com.example.facebook.service.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/groups")
public class GroupServlet extends HttpServlet {
    UserDAO userDAO = new UserDAO();
    GroupDAO groupDAO = new GroupDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }

        try {
            HttpSession session = req.getSession();
            int userId = (Integer) session.getAttribute("userId");
            User user = userDAO.selectUserById(userId);
            switch (action) {
                default:
                    showGroups(user, req, resp);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void showGroups(User user, HttpServletRequest req, HttpServletResponse resp) {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }

        try {
            HttpSession session = req.getSession();
            int userId = (Integer) session.getAttribute("userId");
            User user = userDAO.selectUserById(userId);
            switch (action) {

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
