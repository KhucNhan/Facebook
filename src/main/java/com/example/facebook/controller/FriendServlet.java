package com.example.facebook.controller;

import com.example.facebook.model.Activity;
import com.example.facebook.model.Message;
import com.example.facebook.model.Notification;
import com.example.facebook.model.User;
import com.example.facebook.service.dao.*;

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
    MessageDAO messageDAO = new MessageDAO();

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


        int count = notificationDAO.countNumberOfNotification(Integer.parseInt(userIdStr));
        int count_message = notificationDAO.countNumberOfNotificationMessage(Integer.parseInt(userIdStr));

        req.setAttribute("count",count);
        req.setAttribute("count_message",count_message);
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

        int count = notificationDAO.countNumberOfNotification(Integer.parseInt(userIdStr));
        int count_message = notificationDAO.countNumberOfNotificationMessage(Integer.parseInt(userIdStr));

        List<Message> messageNotifications = messageDAO.selectContentMessage(Integer.parseInt(userIdStr));

        List<Notification> notifications = notificationDAO.getAllNotifictionAddFriend(Integer.parseInt(userIdStr));
        List<Activity> activities = new ArrayList<>();
        List<User> users = new ArrayList<>();

        for (Notification notification : notifications) {
            Activity activity = notificationDAO.getNotificationInformation(notification.getActivityId());
            activities.add(activity);

            User user_1 = activity.getUser();
            users.add(user_1);
        }

        req.setAttribute("count",count);
        req.setAttribute("count_message",count_message);

        req.setAttribute("user", user);
        req.setAttribute("friends", friends);

        req.setAttribute("notifications", notifications);
        req.setAttribute("usersNotification", users);
        req.setAttribute("activities", activities);
        req.setAttribute("messageNotifications",messageNotifications);

        req.getRequestDispatcher("user/AllFriends.jsp").forward(req, resp);
    }

    private void showFriendRequests(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        HttpSession session = req.getSession();
        String userIdStr = session.getAttribute("userId").toString();
        User user = userDAO.selectUserById(Integer.parseInt(userIdStr));

        List<User> friends = friendShipDAO.getAllFriendsRequest(user.getUserId());
        int count = notificationDAO.countNumberOfNotification(Integer.parseInt(userIdStr));
        int count_message = notificationDAO.countNumberOfNotificationMessage(Integer.parseInt(userIdStr));
        List<Message> messageNotifications = messageDAO.selectContentMessage(Integer.parseInt(userIdStr));

        List<Notification> notifications = notificationDAO.getAllNotifictionAddFriend(Integer.parseInt(userIdStr));
        List<Activity> activities = new ArrayList<>();
        List<User> users = new ArrayList<>();

        for (Notification notification : notifications) {
            Activity activity = notificationDAO.getNotificationInformation(notification.getActivityId());
            activities.add(activity);

            User user_1 = activity.getUser();
            users.add(user_1);
        }

        req.setAttribute("notifications", notifications);
        req.setAttribute("usersNotification", users);
        req.setAttribute("activities", activities);
        req.setAttribute("messageNotifications",messageNotifications);
        req.setAttribute("count",count);
        req.setAttribute("count_message",count_message);
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
                case "acceptFriendNotification":
                    acceptFrined(req, resp);
                    break;
                case "deleteFriendNotification":
                    deleteFriendNotification(req, resp);
                case "acceptFriend":
                    acceptFrinedUser(req, resp);
                    break;
                case "deleteFriend":
                    deleteFriendUser(req, resp);
                    break;
                case "cancelFriend":
                    cancelFriend(req, resp);
                    break;
                case "searchInRequests":
                    searchInRequests(req, resp);
                    break;
                case "searchInFriends":
                    searchInFriends(req, resp);
                    break;
                case "addFriend":
                    addFriend(req, resp);
                    break;
                case "unfriend":
                    unFriend(req, resp);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void deleteFriendNotification(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int userID = (int) session.getAttribute("userId");

        int userFriendID = Integer.parseInt(req.getParameter("friendId"));

        int activityId = Integer.parseInt(req.getParameter("activityId"));


        activityDAO.deleteActivities(activityId);

        if (friendShipDAO.deleteFriend(userID, userFriendID)) {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"success\": true}");
        }
    }

    private void unFriend(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int userID = (int) session.getAttribute("userId");

        int userFriendID = Integer.parseInt(req.getParameter("friendId"));

        if (friendShipDAO.unFriend(userID, userFriendID)) {
            activityDAO.newActivities(userID, userFriendID, "un_friend");
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"success\": true}");
        }
    }

    private void cancelFriend(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int userID = (int) session.getAttribute("userId");

        int userFriendID = Integer.parseInt(req.getParameter("friendId"));

        int friendId = friendShipDAO.deleteFriendID(userFriendID, userID);

        if (friendShipDAO.deleteFriend(userFriendID, userID)) {
            activityDAO.deleteActivities(friendId);

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"success\": true}");
        }
    }

    private void addFriend(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int userID = (int) session.getAttribute("userId");

        int userFriendID = Integer.parseInt(req.getParameter("friendId"));

        int friendID = friendShipDAO.addFriend(userID, userFriendID);

        if (friendID != -1) {
            int activitiId = activityDAO.newActivities(userID, friendID,"friendship_request");

            notificationDAO.new_notification(userFriendID, activitiId);

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"success\": true}");
        }
    }

    private void deleteFriendUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int userID = (int) session.getAttribute("userId");

        int userFriendID = Integer.parseInt(req.getParameter("friendId"));

        if (friendShipDAO.deleteFriend(userID, userFriendID)) {
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"success\": true}");
        }
    }

    private void acceptFrinedUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int userID = (int) session.getAttribute("userId");

        int userFriendID = Integer.parseInt(req.getParameter("friendId"));
        int friendId = friendShipDAO.acceptFriend(userID, userFriendID);

        if (friendId > 0) {
//            activityDAO.newActivities(userID, friendId, "friendship_accept");

            int activitiId = activityDAO.newAddSuccess(userID, userFriendID);
            notificationDAO.new_notification(userFriendID, activitiId);

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"success\": true}");
        }
    }

    private void acceptFrined(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int userID = (int) session.getAttribute("userId");

        int userFriendID = Integer.parseInt(req.getParameter("friendId"));

        int activityId = Integer.parseInt(req.getParameter("activityId"));

        int friendId = friendShipDAO.acceptFriend(userID, userFriendID);


        if (friendId > 0) {

            int activitiId = activityDAO.newAddSuccess(userID, userFriendID);
            notificationDAO.new_notification(userFriendID, activitiId);

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"success\": true}");

        }
    }
}
