package com.example.facebook.controller;

import com.example.facebook.model.Post;
import com.example.facebook.model.User;
import com.example.facebook.service.dao.ActivityDAO;
import com.example.facebook.service.dao.NotificationDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/notification")
public class NotificationServlet extends HttpServlet {
    MessageServlet messageServlet = new MessageServlet();

    NotificationDAO notificationDAO = new NotificationDAO();
    ActivityDAO activityDAO = new ActivityDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String action = req.getParameter("action");
        switch (action) {
            case "updateIsRead":
                try {
                    updateIsReadNotification(req, resp);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                break;
            case "getPostId":
                getPostIdToNotification(req, resp);
                break;
            case "getCommentId":
                getCommentIdToNotification(req, resp);
                break;
            case "getAllUser":
                getAllUserToNotification(req, resp);
                break;
        }

    }

    private void getAllUserToNotification(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int notificationId = Integer.parseInt(req.getParameter("notificationID"));

        User user = notificationDAO.getAllUserId(notificationId);

        int userId = user.getUserId();
        String image = user.getImage();
        String name = user.getName();

        if (user != null) {
            String result = userId + "," + image + "," + name;

            resp.setContentType("text/plain");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(result);

        } else {
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
            resp.getWriter().write("Error: User not found");
        }
    }

    private void updateIsReadNotification(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException {
        int notificationId = Integer.parseInt(req.getParameter("notificationID"));
        notificationDAO.updateIsReadNotification(notificationId);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write("{\"success\": true" + "}");
    }

    private void getPostIdToNotification(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int notificationId = Integer.parseInt(req.getParameter("notificationID"));

        Post post = notificationDAO.getAllPostId(notificationId);

        int postId = post.getPostId();

        resp.setContentType("text/plain"); // Đảm bảo định dạng phản hồi
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(String.valueOf(postId));

    }

    private void getCommentIdToNotification(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int notificationId = Integer.parseInt(req.getParameter("notificationID"));

        int commentId = notificationDAO.getAllComment(notificationId);

        resp.setContentType("text/plain"); // Đảm bảo định dạng phản hồi
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(String.valueOf(commentId));

    }
}
