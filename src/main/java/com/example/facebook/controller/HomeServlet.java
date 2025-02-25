package com.example.facebook.controller;

import com.example.facebook.model.Post;
import com.example.facebook.model.User;
import com.example.facebook.service.FriendShipDAO;

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

@WebServlet(name = "HomeServlet", value = "/home")
public class HomeServlet extends HttpServlet {
    UserDAO userDAO = new UserDAO();
    PostDAO postDAO = new PostDAO();
    FriendShipDAO friendShipDAO = new FriendShipDAO();


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

    private void showHome(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
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

            req.setAttribute("posts", posts);
            req.setAttribute("user", user);
            req.setAttribute("usersFriendShip",usersFriendShip);

            req.getRequestDispatcher("/user/Home.jsp").forward(req, resp);
        }


    }
}
