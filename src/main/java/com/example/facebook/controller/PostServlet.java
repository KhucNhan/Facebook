package com.example.facebook.controller;

import com.example.facebook.model.Post;
import com.example.facebook.service.MediaDAO;
import com.example.facebook.service.PostDAO;
import com.example.facebook.service.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
@WebServlet(name = "PostServlet", value = "/posts")
public class PostServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads";
    PostDAO postDAO = new PostDAO();
    UserDAO userDAO = new UserDAO();

    MediaDAO mediaDAO = new MediaDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
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
        req.getRequestDispatcher("user/Home.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }
        try {
            switch (action) {
                case "newPost":
                    newPost(req,resp);
                    break;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void newPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        Part filePart = req.getPart("file");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        String content = req.getParameter("content");
        String privacy = req.getParameter("privacy");

        if (!fileName.isEmpty()) {
            File uploadDir =new File("C:\\uploads\\postMedias");
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String filePath = "C:\\uploads\\postMedias" + File.separator + fileName;
            filePart.write(filePath);

            HttpSession session = req.getSession();
            String userIdStr = session.getAttribute("userId").toString();
            // tạo post
            int postId = postDAO.insertPost(new Post(userDAO.selectUserById(Integer.parseInt(userIdStr)), content, privacy));
            // tạo postmedia
            mediaDAO.insertPostMedia(postId, "picture", fileName);
        } else {
            HttpSession session = req.getSession();
            String userIdStr = session.getAttribute("userId").toString();
            // tạo post
            postDAO.insertPost(new Post(userDAO.selectUserById(Integer.parseInt(userIdStr)), content, privacy));
        }

        resp.sendRedirect(req.getContextPath() + "/home");
    }
}
