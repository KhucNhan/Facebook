package com.example.facebook.controller;

import com.example.facebook.model.Activity;
import com.example.facebook.service.dao.ActivityDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/activities")
public class ActivityServlet extends HttpServlet {

    ActivityDAO activityDAO = new ActivityDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                default:
                    usersActivity(req, resp);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void usersActivity(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        List<Activity> activities = activityDAO.selectAllActivity();
        req.setAttribute("activities", activities);
        req.getRequestDispatcher("admin/Activity.jsp").forward(req, resp);
    }
}
