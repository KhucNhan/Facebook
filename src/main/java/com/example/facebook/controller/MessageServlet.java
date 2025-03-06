package com.example.facebook.controller;

import com.example.facebook.model.Message;
import com.example.facebook.model.User;
import com.example.facebook.service.ActivityDAO;
import com.example.facebook.service.MessageDAO;
import com.example.facebook.service.NotificationDAO;
import com.example.facebook.service.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/messages")
public class MessageServlet extends HttpServlet {
    NotificationDAO notificationDAO = new NotificationDAO();
    ActivityDAO activityDAO = new ActivityDAO();

    UserDAO userDAO = new UserDAO();
    MessageDAO messageDAO = new MessageDAO();

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
                    showMessage(user, req, resp);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void showMessage(User user, HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        String contactId = req.getParameter("contactId");
        User contact = userDAO.selectUserById(Integer.parseInt(contactId));
        List<Message> messages = messageDAO.selectAllMessages(user.getUserId(), contact.getUserId());

        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        for (Message msg : messages) {
            if (msg.getSenderId() == user.getUserId()) {
                // Tin nhắn của người dùng hiện tại (bên phải)
                out.println("<div class='message message-right' oncontextmenu='showMessageMenu(event, " + msg.getMessageId() + ")'>");
                out.println("<span class='text'>" + msg.getContent() + "</span>");
                out.println("</div>");
            } else {
                // Tin nhắn của người khác (bên trái)
                out.println("<div class='message message-left'>");
                out.println("<span class='text'>" + msg.getContent() + "</span>");
                out.println("</div>");
            }
        }
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
                case "chat":
                    chat(user, req, resp);
                    break;
                case "delete":
                    deleteMessage(req, resp);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void deleteMessage(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        int messageId = Integer.parseInt(req.getParameter("messageId"));
        boolean success = messageDAO.deleteMessage(messageId);

        resp.setContentType("text/plain");
        resp.getWriter().write(success ? "success" : "fail");
    }

    private void chat(User user, HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        String content = req.getParameter("content");

        String receiverId = req.getParameter("receiverId");

        User receiver = userDAO.selectUserById(Integer.parseInt(receiverId));

        Message message = new Message();
        message.setContent(content);
        message.setSenderId(user.getUserId());
        message.setReceiverId(receiver.getUserId());

        int messageId = messageDAO.insertNewMessage(message);

        int activitiId = notificationDAO.checkNotificationMessage(user.getUserId(), Integer.parseInt(receiverId));
        if (activitiId > 0) {
            activityDAO.deleteActivities(activitiId);

            int activityId = activityDAO.newActivities(user.getUserId(), messageId, "message");
            notificationDAO.new_notification(Integer.parseInt(receiverId), activityId);
        } else {
            int activityId = activityDAO.newActivities(user.getUserId(), messageId, "message");
            notificationDAO.new_notification(Integer.parseInt(receiverId), activityId);
        }

    }
}
