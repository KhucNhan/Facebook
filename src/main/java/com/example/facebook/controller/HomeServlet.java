package com.example.facebook.controller;

import com.example.facebook.model.*;
import com.example.facebook.service.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "HomeServlet", value = "/home")
public class HomeServlet extends HttpServlet {
    MessageDAO messageDAO = new MessageDAO();
    UserDAO userDAO = new UserDAO();
    NotificationDAO notificationDAO = new NotificationDAO();

    LikeDAO likeDAO = new LikeDAO();

    CommentDAO commentDAO = new CommentDAO();

    PostDAO postDAO = new PostDAO();
    FriendShipDAO friendShipDAO = new FriendShipDAO();

    GroupDAO groupDAO = new GroupDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                default:
                    showHome(req, resp);
                    break;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void showHome(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        HttpSession session = req.getSession();
        String userIdStr = session.getAttribute("userId").toString();
        User user = userDAO.selectUserById(Integer.parseInt(userIdStr));

        if (user.getRole().equalsIgnoreCase("admin")) {
            List<User> users = userDAO.selectAllUsers();
            req.setAttribute("users", users);
            req.getRequestDispatcher("/admin/Users.jsp").forward(req, resp);
        } else {
            List<User> usersFriendShip = friendShipDAO.getAllFriendsAdded(Integer.parseInt(userIdStr));

            List<Post> posts = postDAO.selectAllPosts(Integer.parseInt(userIdStr));
            Map<Integer, Boolean> likedPosts = new HashMap<>();
            Map<Integer, Boolean> likedComments = new HashMap<>();


            for (Post post : posts) {
                boolean isLiked = likeDAO.checkLikePost(Integer.parseInt(userIdStr), post.getPostId());
                likedPosts.put(post.getPostId(), isLiked);


                List<Comment> comments = commentDAO.selectAllComments(post.getPostId());
                for (Comment comment : comments) {
                    boolean isCommentLiked = likeDAO.checkLikeComment(Integer.parseInt(userIdStr), comment.getCommentId());
                    likedComments.put(comment.getCommentId(), isCommentLiked);
                }
            }

            HttpSession session1 = req.getSession();
            String userIdStrs = session1.getAttribute("userId").toString();

            List<Notification> notifications = notificationDAO.getAllNotifictionAddFriend(Integer.parseInt(userIdStrs));
            List<Activity> activities = new ArrayList<>();
            List<User> users = new ArrayList<>();
            List<Message> messageNotification = new ArrayList<>();

            for (Notification notification : notifications) {
                Activity activity = notificationDAO.getNotificationInformation(notification.getActivityId());
                activities.add(activity);

                User user_1 = userDAO.selectUserById(activity.getUserId());
                users.add(user_1);
            }

            List<Message> messageNotifications = messageDAO.selectContentMessage(Integer.parseInt(userIdStrs));

            List<Group> groups = groupDAO.selectAllGroups(user.getUserId());
            req.setAttribute("messageNotifications",messageNotifications);
            req.setAttribute("groups", groups);
            req.setAttribute("likedPosts", likedPosts);
            req.setAttribute("likedComments", likedComments);
            req.setAttribute("posts", posts);
            req.setAttribute("user", user);
            req.setAttribute("usersFriendShip", usersFriendShip);

            req.setAttribute("notifications", notifications);
            req.setAttribute("usersNotification", users);
            req.setAttribute("activities", activities);

            req.getRequestDispatcher("/user/Home.jsp").forward(req, resp);
        }
    }
}
