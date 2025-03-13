package com.example.facebook.controller;

import com.example.facebook.model.GroupMessage;
import com.example.facebook.model.User;
import com.example.facebook.service.dao.GroupMessageDAO;
import com.example.facebook.service.dao.UserDAO;

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

@WebServlet("/groupMessages")
public class GroupMessageServlet extends HttpServlet {
    UserDAO userDAO = new UserDAO();
    GroupMessageDAO groupMessageDAO = new GroupMessageDAO();
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
            throw new RuntimeException(e);
        }
    }

    private void showMessage(User user, HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        String groupId = req.getParameter("groupId");

        List<GroupMessage> groupMessages = groupMessageDAO.selectAllMessageByGroup(Integer.parseInt(groupId));

        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        for (GroupMessage msg : groupMessages) {
            boolean isSender = msg.getSenderId() == user.getUserId();
            String senderName = userDAO.selectUserById(msg.getSenderId()).getName();

            if (isSender) {
                // Tin nhắn của chính người dùng (hiển thị bên phải)
                out.println("<div class='message message-right' oncontextmenu='showMessageMenu(event, " + msg.getGroupMessageId() + ")'>");
                out.println("<span class='text'>" + msg.getContent() + "</span>");
                out.println("</div>");
            } else {
                // Tin nhắn của người khác trong nhóm (hiển thị bên trái)
                out.println("<div class='message message-left'>");
                out.println("<strong>" + senderName + ":</strong>"); // Hiển thị tên người gửi
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

    private void chat(User user, HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        int groupId = Integer.parseInt(req.getParameter("groupId"));
        String content = req.getParameter("content");

        groupMessageDAO.insertMessage(groupId, user.getUserId(), content);
    }

    private void deleteMessage(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        int messageId = Integer.parseInt(req.getParameter("messageId"));
        boolean success = groupMessageDAO.deleteMessage(messageId);

        resp.setContentType("text/plain");
        resp.getWriter().write(success ? "success" : "fail");
    }
}
