package com.example.facebook.controller;

import com.example.facebook.model.Comment;
import com.example.facebook.model.Post;
import com.example.facebook.service.CommentDAO;
import com.example.facebook.service.PostDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
@WebServlet("/getPostComments")
public class CommentServlet extends HttpServlet {
    CommentDAO commentDAO = new CommentDAO();
    PostDAO postDAO = new PostDAO();
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int postId = Integer.parseInt(request.getParameter("postId"));

        try {
            Post post = postDAO.selectPostById(postId);
            List<Comment> comments = commentDAO.selectAllComments(postId);
            PrintWriter out = response.getWriter();
            out.println("<p>" + post.getContent() + "</p>");
            out.println("<h3>Bình luận</h3>");
            for (Comment comment : comments) {
                out.println("<div style='border-bottom: 1px solid #ddd; padding: 5px;'>");
                out.println("<strong>" + comment.getUser().getName() + ":</strong> " + comment.getContent());
                out.println("<p style='color: gray; font-size: 12px;'>" + comment.getCreateAt() + "</p>");
                out.println("</div>");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
