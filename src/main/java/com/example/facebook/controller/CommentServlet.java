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
import javax.servlet.http.HttpSession;
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
                case "delete":
                    deleteComment(req, resp);
                    break;
                case "edit":
                    editComment(req, resp);
                    break;
                case "reply":
                    addReplyComment(req, resp);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void addReplyComment(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        int parentId = Integer.parseInt(req.getParameter("parentCommentId"));
        Comment comment = commentDAO.selectCommentById(parentId);

        String content = req.getParameter("content");

        HttpSession session = req.getSession();
        User user = userDAO.selectUserById(Integer.parseInt(session.getAttribute("userId").toString()));

        Comment replyComment = new Comment();
        replyComment.setContent(content);
        replyComment.setPostId(comment.getPostId());
        replyComment.setUser(user);

        int replyCommentId = commentDAO.insertReplyComment(replyComment, parentId);
        boolean success = replyCommentId != -1;

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8"); // Đảm bảo mã hóa UTF-8
        resp.getWriter().write("{\"postId\":  \"" + comment.getPostId() + "\", \"success\": \"" + success + "\", \"name\": \"" + user.getName() + "\", \"content\": \"" + content + "\", \"image\": \"" + user.getImage() + "\", \"commentId\": \"" + replyCommentId + "\", \"isOwner\" : \"true\", \"parentCommentId\": \"" + comment.getCommentId() + "\"}");
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

        int commentId = commentDAO.insertComment(newComment); // Lấy ID của comment mới
        newComment.setCommentId(commentId); // Gán ID

        // Trả về JSON chứa thông tin bình luận mới
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8"); // Đảm bảo mã hóa UTF-8
        resp.getWriter().write("{\"postId\": \"" + postId + "\", \"commentId\": \"" + commentId + "\", \"image\": \"" + user.getImage() + "\", \"name\": \"" + user.getName() + "\", \"content\": \"" + content + "\", \"isOwner\": \"true\"}");
    }

    private void editComment(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        String commentIdStr = req.getParameter("commentId");
        Comment comment = commentDAO.selectCommentById(Integer.parseInt(commentIdStr));
        String newContent = req.getParameter("content");
        comment.setContent(newContent);
        boolean success = commentDAO.updateComment(comment, Integer.parseInt(commentIdStr));
        String successStr = success ? "success" : "error";
        resp.getWriter().write("{\"success\": \"" + successStr + "\", \"postId\": \"" + comment.getPostId() + "\"}");
    }

    private void deleteComment(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        String commentIdStr = req.getParameter("commentId");
        Comment comment = commentDAO.selectCommentById(Integer.parseInt(commentIdStr));
        boolean success = commentDAO.deleteComment(Integer.parseInt(commentIdStr));
        Post post = postDAO.selectPostById(comment.getPostId());
        boolean emptyComment = post.getTotalComments() == 0;
        String successStr = success ? "success" : "error";
        resp.getWriter().write("{\"success\": \"" + successStr + "\", \"isEmpty\": \"" + emptyComment + "\", \"postId\": \"" + post.getPostId() + "\"}");
    }
}
