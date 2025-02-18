package com.example.facebook.controller;

import com.example.facebook.model.Post;
import com.example.facebook.service.PostDAO;
import com.example.facebook.service.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "PostServlet", value = "/posts")
public class PostServlet extends HttpServlet {
    PostDAO postDAO = new PostDAO();
    UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }
        try {
            switch (action) {
                default:
                    showNewsFeed(req, resp);
                    break;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void showNewsFeed(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        HttpSession session = req.getSession();
        String userIdStr = session.getAttribute("userId").toString();
        List<Post> posts = postDAO.selectAllPosts(Integer.parseInt(userIdStr));
        req.setAttribute("posts", posts);
        req.getRequestDispatcher("").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }
        try {
            switch (action) {
                case "add":
                    addPost(req, resp);
                    break;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void addPost(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        HttpSession session = req.getSession();
        String userIdStr = session.getAttribute("userId").toString();
        String content = req.getParameter("content");
        String privacy = req.getParameter("privacy");
        postDAO.insertPost(new Post(userDAO.selectUserById(Integer.parseInt(userIdStr)), content, privacy));
        // ajax
    }
}
