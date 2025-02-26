package com.example.facebook.controller;

import com.example.facebook.model.Comment;
import com.example.facebook.model.Post;
import com.example.facebook.model.PostMedia;
import com.example.facebook.model.User;
import com.example.facebook.service.*;

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

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
@WebServlet(name = "PostServlet", value = "/posts")
public class PostServlet extends HttpServlet {
    private static final String UPLOAD_DIR = "uploads";
    PostDAO postDAO = new PostDAO();
    UserDAO userDAO = new UserDAO();
    LikeDAO likeDAO = new LikeDAO();
    CommentDAO commentDAO = new CommentDAO();
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
                case "postModal":
                    showPostModal(req, resp);
                    break;
                default:
                    showNewsFeed(req, resp);
                    break;
                case "userEditPost":
                    userEditPost(req, resp);
                    break;
                case "deletePost":
                    deletePostById(req, resp);
                    break;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void showPostModal(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException, ServletException {
        String postId = req.getParameter("postId");
        Post post = postDAO.selectPostById(Integer.parseInt(postId));
        List<PostMedia> mediaList = mediaDAO.selectAllPostMedia(Integer.parseInt(postId));
        List<Comment> comments = commentDAO.selectAllComments(post.getPostId());

        HttpSession session = req.getSession();
        User user = userDAO.selectUserById(Integer.parseInt(session.getAttribute("userId").toString()));

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        String[] layoutType = getLayoutType(mediaList.size());

        out.println("<div class='modal-overlay' onclick='closePostModal()'>");
        out.println("<div class='post-modal' data-post-id='" + post.getPostId() + "' onclick='event.stopPropagation();'>");

        // Thông tin người dùng
        out.println("<div class='introduce' style='display: flex; justify-content: space-between'>");
        out.println("<div style='display: flex'>");
        out.println("<img src='/uploads/avatars/" + post.getUser().getImage() + "' style='height: 50px;width: 50px; border-radius: 50%'>");
        out.println("<div style='display: flex; flex-direction: column; margin-left: 10px'>");
        out.println("<div style='height: 20px;'><a style='font-weight: bold; color: black'>" + post.getUser().getName() + "</a></div>");
        out.println("<div><p style='color: lightgrey'>" + post.getCreateAt() + "</p></div>");
        out.println("</div></div></div>");

        // Nội dung bài viết
        out.println("<div class='content'><p>" + post.getContent() + "</p></div>");

        // Khu vực media
        out.println("<div class='media-grid'>");

        // Render tối đa 4 media
        for (int i = 0; i < Math.min(4, mediaList.size()); i++) {
            PostMedia media = mediaList.get(i);
            String className = layoutType[i];

            if (media.getType().equals("picture")) {
                out.println("<img src='/uploads/postMedias/" + media.getUrl() + "' class='media " + className + "'>");
            } else if (media.getType().equals("video")) {
                out.println("<video src='/uploads/postMedias/" + media.getUrl() + "' class='media " + className + "' controls></video>");
            }
        }

        // Nếu có nhiều hơn 4 media, hiển thị số lượng còn lại
        if (mediaList.size() > 4) {
            int extraCount = mediaList.size() - 4;
            out.println("<div class='media extra'>" + extraCount + "</div>");
        }

        out.println("</div>"); // Đóng media-grid

        // Khu vực bình luận
        out.println("<div class='comments-section'>");
        out.println("<h4 style=\"margin-block:10px;padding:5px ;color:gray; border-block:1px solid lightgrey;\">Bình luận</h4>");
        if (comments.isEmpty()) {
            out.println("<p style=\"text-align:center\">Không có bình luận</p>");
        } else {

            // Hiển thị danh sách bình luận
            out.println("<ul class='comments-list' style=\"list-style-type:none\">");

            for (Comment comment : comments) {
                out.println("<li class='comment-item' id='comment-" + comment.getCommentId() + "' style=\"margin-block:10px;\">");


                // Ảnh đại diện và thông tin người bình luận
                out.println("<div class='comment-item' style='display: flex; align-items: flex-start; gap: 10px;'>");

                // Avatar bên trái
                out.println("<div class='comment-avatar'>");
                out.println("<img style='width:50px;height:50px;border-radius:50%;' src='/uploads/avatars/" + comment.getUser().getImage() + "' class='avatar'>");
                out.println("</div>");

                // Nội dung bình luận bên phải
                out.println("<div class='comment-body' style='background: #f0f2f5; padding: 10px; border-radius: 10px; max-width: 85%; position: relative;'>");

                // Tên và thời gian + Dropdown
                out.println("<div class='comment-info' style='display: flex; align-items: center; gap: 8px; margin-bottom: 5px;'>");
                out.println("<strong class='comment-name' style='color: #050505;'>" + comment.getUser().getName() + "</strong>");
                out.println("<span class='comment-time' style='color: #65676b; font-size: 12px;'>" + comment.getCreateAt() + "</span>");

                // Dropdown menu
                out.println("<div class='nav-item dropdown ms-auto'>");
                out.println("<a class='nav-link' href='#' role='button' data-bs-toggle='dropdown' data-bs-auto-close='outside' aria-expanded='false'>");
                out.println("<i class='bi bi-three-dots'></i>"); // Icon 3 dấu chấm của Bootstrap
                out.println("</a>");
                out.println("<ul class='dropdown-menu'>");

                if (comment.getUser().getUserId() == user.getUserId()) {
                    out.println("<li><a class='dropdown-item' onclick='editComment(" + comment.getCommentId() + ")'>Sửa</a></li>");
                    out.println("<li><a class='dropdown-item' onclick='deleteComment(" + comment.getCommentId() + ")'>Xóa</a></li>");
                } else {
                    // Nếu không phải chủ sở hữu, chỉ hiển thị "Báo cáo"
                    out.println("<li><a class='dropdown-item' href='#' onclick='reportComment(" + comment.getCommentId() + ")'>Báo cáo</a></li>");
                }

                out.println("</ul>");
                out.println("</div>"); // Đóng dropdown menu

                out.println("</div>"); // Đóng div comment-info

                // Nội dung bình luận
                out.println("<div class='comment-content' style='color: #050505;'>" + comment.getContent() + "</div>");

                // Đóng div comment-body
                out.println("</div>");

                // Đóng div comment-item
                out.println("</div>");

                // Nút thích và phản hồi
                out.println("<div class='comment-actions' style=\"display: flex; justify-content: start; padding-left: 70px;\">");

                if (isCommmentLike) {
                    out.println("<a class='like-button' data-comment-id='" + comment.getCommentId() + "' style=\"text-decoration: none; background-color: inherit; width: fit-content; margin-right: 20px; cursor: pointer; color: blue; font-weight: bold;\" onclick='toggleLike(" + comment.getCommentId() + ")'>Thích</a>");
                } else {
                    out.println("<a class='like-button' data-comment-id='" + comment.getCommentId() + "' style=\"text-decoration: none; background-color: inherit; width: fit-content; margin-right: 20px; cursor: pointer; color: gray; font-weight: bold;\" onclick='toggleLike(" + comment.getCommentId() + ")'>Thích</a>");
                }


                out.println("<a class='reply-button' style=\"text-decoration: none;background-color: inherit; width: fit-content; cursor: pointer;color: gray;\" onclick='replyToComment(" + comment.getCommentId() + ")'>Phản hồi</a>");
                out.println("</div>");

                out.println("</li>");
            }


            out.println("</ul>"); // Đóng danh sách bình luận
        }

        // Khu vực nhập bình luận
        out.println("<div class='comment-input-section' style='display: flex; align-items: center; padding: 10px; border-top: 1px solid lightgray;'>");

// Avatar của người dùng hiện tại
        out.println("<img src='/uploads/avatars/" + user.getImage() + "' style='width: 40px; height: 40px; border-radius: 50%; margin-right: 10px;'>");

// Ô nhập bình luận
        out.println("<input id='comment-input-" + post.getPostId() + "' type='text' placeholder='Viết bình luận...' style='flex: 1; padding: 8px; border-radius: 20px; border: 1px solid #ddd;'>");

// Nút gửi bình luận
        out.println("<button onclick='submitComment(" + post.getPostId() + ")' style='margin-left: 10px; background: blue; color: white; padding: 5px 15px; border: none; border-radius: 10px; cursor: pointer;width:fit-content;'>Gửi</button>");


        out.println("</div>");


        out.println("</div>"); // Đóng khu vực bình luận
        out.println("</div></div>"); // Đóng post-modal và modal-overlay

        out.println("<script src='/js/LikeComment.js'></script>");

    }

    // Hàm xác định layout dựa vào số lượng media
    private String[] getLayoutType(int count) {
        switch (count) {
            case 1:
                return new String[]{"full"};
            case 2:
                return new String[]{"half", "half"};
            case 3:
                return new String[]{"large-left", "small-right-top", "small-right-bottom"};
            case 4:
                return new String[]{"quarter", "quarter", "quarter", "quarter"};
            default:
                return new String[]{"large-left", "small-right-top", "small-right-bottom", "extra"};
        }
    }

    private void deletePostById(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        HttpSession session = req.getSession();
        int userId = (int) session.getAttribute("userId");

        int postId = Integer.parseInt(req.getParameter("postId"));
        int userIdPost = postDAO.selectPostById(postId).getUser().getUserId();
        if (userId == userIdPost) {
            postDAO.deletePost(postId);


            HttpSession session1 = req.getSession();
            session1.setAttribute("successMessage", "Xóa bài viết thành công!");

            resp.sendRedirect(req.getContextPath() + "/home");

        } else {
            req.setAttribute("errorMessage", "Bạn không có quyền xóa bài viết này!");
            req.getRequestDispatcher("/home").forward(req, resp);
        }

    }

    private void userEditPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {
        HttpSession session = req.getSession();
        int userId = (int) session.getAttribute("userId");
        int postId = Integer.parseInt(req.getParameter("postId"));
        int userIdPost = postDAO.selectPostById(postId).getUser().getUserId();


        if (userId == userIdPost) {
            Post post = postDAO.selectPostById(postId);

            User user = userDAO.selectUserById(userId);

            req.setAttribute("user", user);
            req.setAttribute("editPost", post);
            req.getRequestDispatcher("user/EditPost.jsp").forward(req, resp);
        } else {
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
                    updatePost(req, resp);
                    break;
                case "likePost":
                    likePost(req, resp);
                    break;
                case "likeComment":
                    likeComment(req, resp);
                    break;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void likeComment(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int userIdStr = (int) session.getAttribute("userId");

        int commentID = Integer.parseInt(req.getParameter("commentId"));

        boolean checkComment = likeDAO.checkLikeComment(userIdStr, commentID);
        boolean isLiked;

        if (checkComment) {
            likeDAO.deleteLikeComment(userIdStr, commentID);
            isLiked = false;
        } else {
            likeDAO.addLikeToComment(commentID, userIdStr);
            isLiked = true;
        }

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write("{\"success\": true, \"isLiked\": " + isLiked + "}");
    }

    private void likePost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        int userIdStr = (int) session.getAttribute("userId");

        int postId = Integer.parseInt(req.getParameter("postId"));


        boolean checkLike = likeDAO.checkLikePost(userIdStr, postId);

        if (checkLike) {
            likeDAO.deleteLikePost(userIdStr, postId);
        } else {
            likeDAO.addLikeToPost(postId, userIdStr);
        }

        int totalLikes = likeDAO.getTotalLikePost(postId);

        resp.setContentType("application/json");
        resp.getWriter().write("{\"success\": true, \"totalLikes\": " + totalLikes + "}");
    }


    private void updatePost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {

        int postId = Integer.parseInt(req.getParameter("postId"));

        String deleteAllImages = req.getParameter("deleteAllImages");

        if (deleteAllImages.equals("true")) {
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

        postDAO.updatePost(postId, content, privacy);

        HttpSession session = req.getSession();
        session.setAttribute("successMessage", "Cập nhật bài viết thành công!");

        // Chuyển hướng về trang /home
        resp.sendRedirect(req.getContextPath() + "/home");

    }


    private void newPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, SQLException {

        Collection<Part> fileParts = req.getParts().stream().filter(part -> (part.getName().startsWith("fileA") || part.getName().startsWith("fileB")) && part.getSize() > 0).collect(Collectors.toList());


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
