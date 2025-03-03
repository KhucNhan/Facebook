package com.example.facebook.controller;
import com.example.facebook.model.User;
import com.example.facebook.service.ActivityDAO;
import com.example.facebook.service.FriendShipDAO;
import com.example.facebook.service.NotificationDAO;
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
    ActivityDAO activityDAO = new ActivityDAO();
    NotificationDAO notificationDAO = new NotificationDAO();
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
                case "friendRequests":
                    showFriendRequests(req, resp);
                    break;
                case "allFriends":
                    showAllFriends(req, resp);
                    break;
                case "searchInRequests":
                    searchInRequests(req, resp);
                    break;
                case "searchInFriends":
                    searchInFriends(req, resp);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void searchInFriends(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        HttpSession session = req.getSession();
        String userIdStr = session.getAttribute("userId").toString();
        User user = userDAO.selectUserById(Integer.parseInt(userIdStr));

        String value = req.getParameter("value");
        List<User> searchInFriends = friendShipDAO.searchUsersFriends(value, user.getUserId());
        req.setAttribute("user", user);
        req.setAttribute("friends", searchInFriends);
        req.setAttribute("action", "allFriends");
        req.getRequestDispatcher("user/AllFriends.jsp").forward(req, resp);
    }

    private void searchInRequests(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        HttpSession session = req.getSession();
        String userIdStr = session.getAttribute("userId").toString();
        User user = userDAO.selectUserById(Integer.parseInt(userIdStr));

        String value = req.getParameter("value");
        List<User> searchInRequests = friendShipDAO.searchUsersInRequests(value, user.getUserId());
        req.setAttribute("user", user);
        req.setAttribute("friends", searchInRequests);
        req.setAttribute("action", "requests");
        req.getRequestDispatcher("user/FriendRequests.jsp").forward(req, resp);
    }

    private void showAllFriends(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        HttpSession session = req.getSession();
        String userIdStr = session.getAttribute("userId").toString();
        User user = userDAO.selectUserById(Integer.parseInt(userIdStr));

        List<User> friends = friendShipDAO.getAllFriendsAdded(user.getUserId());
        req.setAttribute("user", user);
        req.setAttribute("friends", friends);
        req.getRequestDispatcher("user/AllFriends.jsp").forward(req, resp);
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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "acceptFriend":
                    acceptFrinedUser(req, resp);
                    break;
                case "deleteFriend":
                    deleteFriendUser(req, resp);
                    break;
                case "cancelFriend":
                    cancelFriend(req,resp);
                    break;
                case "searchInRequests":
                    searchInRequests(req, resp);
                    break;
                case "searchInFriends":
                    searchInFriends(req, resp);
                    break;
                case "addFriend":
                    addFriend(req,resp);
                    break;
                case "unfriend":
                    unFriend(req,resp);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void unFriend(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int userID = (int) session.getAttribute("userId");

        int userFriendID = Integer.parseInt(req.getParameter("friendId"));

        if (friendShipDAO.unFriend(userID,userFriendID)){
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"success\": true}");
        }
    }

    private void cancelFriend(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int userID = (int) session.getAttribute("userId");

        int userFriendID = Integer.parseInt(req.getParameter("friendId"));

        if (friendShipDAO.deleteFriend(userFriendID,userID)){
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"success\": true}");
        }
    }

    private void addFriend(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int userID = (int) session.getAttribute("userId");

        int userFriendID = Integer.parseInt(req.getParameter("friendId"));

        int friendID = friendShipDAO.addFriend(userID,userFriendID);

        if (friendID != -1){
            activityDAO.newActivities(userFriendID,friendID);



            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"success\": true}");
        }
    }

    private void deleteFriendUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int userID = (int) session.getAttribute("userId");

        int userFriendID = Integer.parseInt(req.getParameter("friendId"));

        if (friendShipDAO.deleteFriend(userID,userFriendID)){
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"success\": true}");
        }
    }

    private void acceptFrinedUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int userID = (int) session.getAttribute("userId");

        int userFriendID = Integer.parseInt(req.getParameter("friendId"));

        if (friendShipDAO.acceptFriend(userID,userFriendID)){
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"success\": true}");

        }
    }
}
