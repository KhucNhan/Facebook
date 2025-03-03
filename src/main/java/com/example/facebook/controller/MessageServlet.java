package com.example.facebook.controller;

import com.example.facebook.model.Message;
import com.example.facebook.model.User;
import com.example.facebook.service.MessageDAO;
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
                    showMessage(user ,req, resp);
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
                out.println("<div class='message message-right'>");
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
}
