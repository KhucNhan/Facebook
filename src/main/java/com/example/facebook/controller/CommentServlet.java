package com.example.facebook.controller;

import com.example.facebook.model.Comment;
import com.example.facebook.model.Post;
import com.example.facebook.model.User;
import com.example.facebook.service.CommentDAO;
import com.example.facebook.service.PostDAO;
import com.example.facebook.service.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
@WebServlet("/comments")
public class CommentServlet extends HttpServlet {
    CommentDAO commentDAO = new CommentDAO();
    PostDAO postDAO = new PostDAO();
    UserDAO userDAO = new UserDAO();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

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
                    addComment(req, resp);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void addComment(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        int postId = Integer.parseInt(req.getParameter("postId"));
        String content = req.getParameter("content");
        String userId = req.getSession().getAttribute("userId").toString(); // Lấy user từ session
        User user = userDAO.selectUserById(Integer.parseInt(userId));

        Comment newComment = new Comment();
        newComment.setPostId(postId);
        newComment.setUser(user);
        newComment.setContent(content);
        System.out.println(commentDAO.insertComment(newComment));

        // Trả về JSON chứa thông tin bình luận mới
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8"); // Đảm bảo mã hóa UTF-8
        resp.getWriter().write("{\"image\": \"" + user.getImage() + "\", \"name\": \"" + user.getName() + "\", \"content\": \"" + content + "\"}");
    }
}
