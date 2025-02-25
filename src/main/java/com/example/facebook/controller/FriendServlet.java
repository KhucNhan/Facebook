package com.example.facebook.controller;
import com.example.facebook.model.User;
import com.example.facebook.service.FriendShipDAO;
import com.example.facebook.service.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/friends")
public class FriendServlet extends HttpServlet {
    FriendShipDAO friendShipDAO = new FriendShipDAO();
    UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "listfriends":
                    showListFriends(req, resp);
                    break;
                case "friendRequests":
                    showFriendRequests(req, resp);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void showFriendRequests(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        HttpSession session = req.getSession();
        String userIdStr = session.getAttribute("userId").toString();
        User user = userDAO.selectUserById(Integer.parseInt(userIdStr));

        List<User> friends = friendShipDAO.getAllFriendsRequest(user.getUserId());
        req.setAttribute("user", user);
        req.setAttribute("friends", friends);
        req.getRequestDispatcher("user/FriendRequests.jsp").forward(req, resp);
    }

    private void showListFriends(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        HttpSession session = req.getSession();
        String userIdStr = session.getAttribute("userId").toString();
        User user = userDAO.selectUserById(Integer.parseInt(userIdStr));

        List<User> friends = friendShipDAO.getAllFriendsAdded(user.getUserId());
        req.setAttribute("user", user);
        req.setAttribute("friends", friends);
        req.getRequestDispatcher("user/FriendRequests.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
