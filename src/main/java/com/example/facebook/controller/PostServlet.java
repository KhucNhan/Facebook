package com.example.facebook.controller;

import com.example.facebook.service.PostDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "PostServlet", value = "/posts")
public class PostServlet extends HttpServlet {
    PostDAO postDAO = new PostDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }

        switch (action) {
            default:
                showNewsFeed(req, resp);
                break;
        }
    }

    private void showNewsFeed(HttpServletRequest req, HttpServletResponse resp) {

    }
}
