package com.example.facebook.controller;

import com.example.facebook.model.Activity;
import com.example.facebook.model.Notification;
import com.example.facebook.model.User;
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

@WebServlet("/notification")
public class NotificationServlet extends HttpServlet {
    NotificationDAO notificationDAO = new NotificationDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String action = req.getParameter("action");
        switch (action){
            case "updateIsRead":
                updateIsReadNotification(req,resp);
                break;
        }

    }

    private void updateIsReadNotification(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int notificationId = Integer.parseInt(req.getParameter("notificationID"));

        notificationDAO.updateIsReadNotification(notificationId);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write("{\"success\": true}");
    }
}
