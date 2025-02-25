package com.example.facebook.controller;

import com.example.facebook.model.Post;
import com.example.facebook.model.PostMedia;
import com.example.facebook.model.User;
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
import java.util.stream.Collectors;

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
                case "userEditPost":
                    userEditPost(req,resp);
                    break;
                case "deletePost" :
                    deletePostById(req,resp);
                    break;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void deletePostById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        int userId = (int) session.getAttribute("userId");

        int postId = Integer.parseInt(req.getParameter("postId"));
        int userIdPost = postDAO.getPostId(postId);
        if (userId == userIdPost){
            postDAO.deletePost(postId);


            HttpSession session1 = req.getSession();
            session1.setAttribute("successMessage", "Xóa bài viết thành công!");

            resp.sendRedirect(req.getContextPath() + "/home");

        }else {
            req.setAttribute("errorMessage", "Bạn không có quyền xóa bài viết này!");
            req.getRequestDispatcher("/home").forward(req, resp);
        }

    }

    private void userEditPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        HttpSession session = req.getSession();
        int userId = (int) session.getAttribute("userId");

        int postId = Integer.parseInt(req.getParameter("postId"));

        int userIdPost = postDAO.getPostId(postId);
        if (userId == userIdPost){
            Post post = postDAO.getInformationPostId(postId);

            List<PostMedia> postMediaList = postDAO.getAllImageLinksPost(postId);

            User user = userDAO.selectUserById(userId);

            req.setAttribute("user", user);
            req.setAttribute("imageLinks",postMediaList);
            req.setAttribute("editPost", post);
            req.getRequestDispatcher("user/EditPost.jsp").forward(req,resp);
        }else {
            req.setAttribute("errorMessage", "Bạn không có quyền chỉnh sửa bài viết này!");
            req.getRequestDispatcher("/home").forward(req, resp);
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
                    newPost(req, resp);
                    break;
                case "updatePost":
                    updatePost(req,resp);
                    break;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    private void updatePost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {

        int postId = Integer.parseInt(req.getParameter("postId"));

        String deleteAllImages = req.getParameter("deleteAllImages");

        if (deleteAllImages.equals("true")){
            mediaDAO.deleteAllImagePostByID(postId);
        }

        Collection<Part> fileParts = req.getParts().stream()
                .filter(part -> (part.getName().startsWith("fileA") || part.getName().startsWith("fileB")) && part.getSize() > 0)
                .collect(Collectors.toList());


        String content = req.getParameter("content");
        String privacy = req.getParameter("privacy");

        File uploadDir = new File("C:\\uploads\\postMedias");
        if (!uploadDir.exists()) uploadDir.mkdirs();


        for (Part filePart : fileParts) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String filePartss = "C:\\uploads\\postMedias" + File.separator + fileName;
            filePart.write(filePartss);

            mediaDAO.insertPostMedia(postId, "picture", fileName);
        }

        postDAO.updatePost(postId,content,privacy);

        HttpSession session = req.getSession();
        session.setAttribute("successMessage", "Cập nhật bài viết thành công!");

        // Chuyển hướng về trang /home
        resp.sendRedirect(req.getContextPath() + "/home");

    }


    private void newPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {

        Collection<Part> fileParts = req.getParts().stream()
                .filter(part -> (part.getName().startsWith("fileA") || part.getName().startsWith("fileB")) && part.getSize() > 0)
                .collect(Collectors.toList());


        String content = req.getParameter("content");
        String privacy = req.getParameter("privacy");

        File uploadDir = new File("C:\\uploads\\postMedias");
        if (!uploadDir.exists()) uploadDir.mkdirs();

        HttpSession session = req.getSession();
        String userIdStr = session.getAttribute("userId").toString();

        int postId = postDAO.insertPost(new Post(userDAO.selectUserById(Integer.parseInt(userIdStr)), content, privacy));


        for (Part filePart : fileParts) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String filePartss = "C:\\uploads\\postMedias" + File.separator + fileName;
            filePart.write(filePartss);

            mediaDAO.insertPostMedia(postId, "picture", fileName);

        }
        resp.sendRedirect(req.getContextPath() + "/home");

    }

}
