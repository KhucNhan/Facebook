package com.example.facebook.controller;

import com.example.facebook.model.Comment;
import com.example.facebook.model.Post;
import com.example.facebook.model.PostMedia;
import com.example.facebook.model.User;
import com.example.facebook.service.dao.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.Arrays;
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
    ActivityDAO activityDAO = new ActivityDAO();
    NotificationDAO notificationDAO = new NotificationDAO();
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
        String commentId = req.getParameter("commentId"); // Nhận commentId từ request

        HttpSession session = req.getSession();
        User user = userDAO.selectUserById(Integer.parseInt(session.getAttribute("userId").toString()));

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        String[] layoutType = getLayoutType(mediaList.size());

        out.println("<div class='modal-overlay' onclick='closePostModal()'>");
        out.println("<div style='padding-bottom:0;' class='post-modal' data-post-id='" + post.getPostId() + "' onclick='event.stopPropagation();'>");

        // Thông tin người dùng
        out.println("<div class='introduce' style='display: flex; justify-content: space-between'>");
        out.println("<div style='display: flex'>");
        out.println("<img src='/uploads/avatars/" + post.getUser().getImage() + "' style='object-fit: cover;height: 50px;width: 50px; border-radius: 50%'>");
        out.println("<div style='display: flex; flex-direction: column; margin-left: 10px'>");
        out.println("<div style='height: 20px;'><a style='font-weight: bold; color: black'>" + post.getUser().getName() + "</a></div>");
        out.println("<div><p style='color: lightgrey'>" + post.getCreateAt() + "</p></div>");
        out.println("</div></div></div>");

        // Nội dung bài viết
        out.println("<div class='content'><p>" + post.getContent() + "</p></div>");

        // Khu vực media
        out.println("<div class='media-grid'>");

        for (int i = 0; i < mediaList.size(); i++) {
            PostMedia media = mediaList.get(i);
            String className = layoutType[i % layoutType.length]; // Lặp lại class nếu cần

            if (media.getType().equals("picture")) {
                out.println("<img src='/uploads/postMedias/" + media.getUrl() + "' class='media " + className + "'>");
            } else if (media.getType().equals("video")) {
                out.println("<video src='/uploads/postMedias/" + media.getUrl() + "' class='media " + className + "' controls></video>");
            }
        }

        out.println("</div>"); // Đóng media-grid

        // Khu vực bình luận
        out.println("<h4 style=\"margin-block:10px;padding:5px ;color:gray; border-block:1px solid lightgrey;\">Bình luận</h4>");
        out.println("<ul class='comments-list' style=\"list-style-type:none\">");
        if (comments.isEmpty()) {
            out.println("<p id='commentListIsNull" + postId + "' style=\"text-align:center\">Không có bình luận</p>");
        } else {
            for (Comment comment : comments) {
                renderComment(comment, user, out); // Gọi hàm render bình luận (đệ quy)
            }
        }
        out.println("</ul>"); // Đóng danh sách bình luận


        // Gửi script xuống client
        if (commentId != null) {
            out.println("<script>");
            out.println("setTimeout(() => {");
            out.println("   let commentElement = document.getElementById('comment-" + commentId + "');");
            out.println("   if (commentElement) {");
            out.println("       commentElement.scrollIntoView({ behavior: 'smooth', block: 'center' });");
            out.println("   }");
            out.println("}, 500);"); // Chờ modal load xong rồi cuộn
            out.println("</script>");
        }


        if (user.getRole().equalsIgnoreCase("User")) {
            // Khu vực nhập bình luận
//        out.println("<div class='comment-input-section' style='display: flex; align-items: center; padding: 10px; border-top: 1px solid lightgray;'>");
            out.println("<div class='comment-input-section' style='position: sticky; bottom: 0; background: white; display: flex; align-items: center; padding: 10px; border-top: 1px solid lightgray;'>");

// Avatar của người dùng hiện tại
            out.println("<img src='/uploads/avatars/" + user.getImage() + "' style='object-fit: cover;width: 40px; height: 40px; border-radius: 50%; margin-right: 10px;'>");

// Ô nhập bình luận
            out.println("<input id='comment-input-" + post.getPostId() + "' type='text' placeholder='Viết bình luận...' style='flex: 1; padding: 8px; border-radius: 20px; border: 1px solid #ddd;'>");

// Nút gửi bình luận
            out.println("<button onclick='submitComment(" + post.getPostId() + ")' style='margin-left: 10px; background: blue; color: white; padding: 5px 15px; border: none; border-radius: 10px; cursor: pointer;width:fit-content;'>Gửi</button>");


            out.println("</div>");
        }


        out.println("</div>"); // Đóng khu vực bình luận
        out.println("<script src='/js/LikeComment.js'></script>");
        out.println("</div></div>"); // Đóng post-modal và modal-overlay


    }

    private void renderComment(Comment comment, User user, PrintWriter out) throws SQLException {
        boolean isReplyCommentLike = likeDAO.checkLikeComment(user.getUserId(), comment.getCommentId());
        out.println("<li class='comment-item' id='comment-" + comment.getCommentId() + "' style=\"margin-block:10px;\">");

        // Ảnh đại diện và thông tin người bình luận
        out.println("<div class='comment-item' style='display: flex; align-items: flex-start; gap: 10px;'>");

        // Avatar bên trái
        out.println("<div class='comment-avatar'>");
        out.println("<img style='object-fit: cover;width:50px;height:50px;border-radius:50%;' src='/uploads/avatars/" + comment.getUser().getImage() + "' class='avatar'>");
        out.println("</div>");

        // Nội dung bình luận bên phải
        String backgroundColor = "#f0f2f5";
        if (comment.getContent().equalsIgnoreCase("Bình luận này đã bị xóa do vi phạm tiêu chuẩn cộng đồng.")) {
            backgroundColor = "#ebebeb";
        }
        out.println("<div class='comment-body' style='background: " + backgroundColor + "; padding: 10px; border-radius: 10px; max-width: 85%; position: relative;'>");

        // Tên và thời gian + Dropdown
        out.println("<div class='comment-info' style='display: flex; align-items: center; gap: 8px; margin-bottom: 5px;'>");
        out.println("<strong class='comment-name' style='color: #050505;'>" + comment.getUser().getName() + "</strong>");
        out.println("<span class='comment-time' style='color: #65676b; font-size: 12px;'>" + comment.getCreateAt() + "</span>");

        if (user.getRole().equalsIgnoreCase("User")) {
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
                out.println("<li>" +
                        "<button style=\"border: none;height: fit-content;width: fit-content\" class='dropdown-item' onclick='reportComment(" + comment.getCommentId() + ", event)'>" +
                        "Báo cáo bình luận" +
                        "</button>" +
                        "</li>");
            }

            out.println("</ul>");
            out.println("</div>"); // Đóng dropdown menu
        }

        out.println("</div>"); // Đóng div comment-info

        // Nội dung bình luận
        out.println("<div class='comment-content' style='color: #050505;'>" + comment.getContent() + "</div>");

        // Đóng div comment-body
        out.println("</div>");

        // Đóng div comment-item
        out.println("</div>");

        if (user.getRole().equalsIgnoreCase("User")) {
            // Nút thích và phản hồi
            out.println("<div class='comment-actions' style=\"display: flex; justify-content: start; padding-left: 70px;\">");

            if (isReplyCommentLike) {
                out.println("<button class='like-button' data-comment-id='" + comment.getCommentId() + "' style=\"text-decoration: none; background-color: inherit; width: fit-content; margin-right: 20px; cursor: pointer;padding:0; color: blue; font-weight: bold;\" onclick='toggleLike(" + comment.getCommentId() + ")'>Thích</button>");
            } else {
                out.println("<button class='like-button' data-comment-id='" + comment.getCommentId() + "' style=\"text-decoration: none; background-color: inherit; width: fit-content; margin-right: 20px; cursor: pointer;padding:0; color: gray; font-weight: bold;\" onclick='toggleLike(" + comment.getCommentId() + ")'>Thích</button>");
            }

            out.println("<a class='reply-button' style=\"text-decoration: none;background-color: inherit; width: fit-content; cursor: pointer;color: gray;\" onclick='replyToComment(" + comment.getCommentId() + ")'>Phản hồi</a>");
            out.println("</div>");
        }

        List<Comment> replies = commentDAO.getReplies(comment.getCommentId());
        if (!replies.isEmpty()) {
            out.println("<ul class='replies-list' style='list-style-type:none; padding-left: 60px; margin-top: 10px;'>");
            for (Comment reply : replies) {
                renderComment(reply, user, out); // Gọi đệ quy để hiển thị phản hồi con
            }
            out.println("</ul>"); // Đóng danh sách replies
        }

        out.println("</li>"); // Đóng comment-item
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
                String[] layout = new String[count];
                Arrays.fill(layout, "dynamic"); // Áp dụng class động cho ảnh vượt quá 4
                return layout;
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
                case "adminDeletePost":
                    adminDeletePost(req, resp);
                    break;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void adminDeletePost(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        int postId = Integer.parseInt(req.getParameter("postId"));
        Post post = postDAO.selectPostById(postId);
        mediaDAO.deleteAllImagePostByID(postId);
        System.out.println(postDAO.updatePost(postId, "Bài viết này đã vi phạm tiêu chuẩn cộng đồng.", post.getPrivacy()));
    }

    private void likeComment(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException {
        HttpSession session = req.getSession();
        int userIdStr = (int) session.getAttribute("userId");

        int commentID = Integer.parseInt(req.getParameter("commentId"));

        boolean checkComment = likeDAO.checkLikeComment(userIdStr, commentID);

        boolean isLiked = false;

        if (checkComment) {
            likeDAO.deleteLikeComment(userIdStr, commentID);
            isLiked = false;
        } else {
            int commentUserID = likeDAO.addLikeToComment(commentID, userIdStr);
            int userIdNotification = commentDAO.selectUserIdToComment(commentID);

            Comment comment = commentDAO.selectCommentById(commentID);
            int commentUsetIDs = comment.getUser().getUserId();

            if (commentUsetIDs != userIdStr) {
                int activitiId = activityDAO.newActivities(userIdStr, commentID, "like_comment");

                notificationDAO.new_notification(userIdNotification, activitiId);
            }
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
            int postIds = likeDAO.addLikeToPost(postId, userIdStr);

            int userIdNotification = postDAO.selectUserIdToPost(postIds);

            if (userIdNotification == userIdStr) {

            } else {
                int activitiId = activityDAO.newActivities(userIdStr, postIds, "like_post");
                notificationDAO.new_notification(userIdNotification, activitiId);
            }
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

        File uploadDir = new File("C:\\Users\\ADMIN\\IdeaProjects\\Facebook\\src\\main\\webapp\\img\\postMedias");
        if (!uploadDir.exists()) uploadDir.mkdirs();


        for (Part filePart : fileParts) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String filePartss = "C:\\Users\\ADMIN\\IdeaProjects\\Facebook\\src\\main\\webapp\\img\\postMedias" + File.separator + fileName;
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
        Collection<Part> fileParts = req.getParts().stream()
                .filter(part -> (part.getName().startsWith("fileA") || part.getName().startsWith("fileB")) && part.getSize() > 0)
                .collect(Collectors.toList());

        String content = req.getParameter("content");
        String privacy = req.getParameter("privacy");

        // Thư mục lưu trong webapp
        File webappDir = new File(System.getenv("imgFolderUrl") + "postMedias");
        if (!webappDir.exists()) webappDir.mkdirs();

        // Thư mục sao chép
        File backupDir = new File("C:\\uploads\\postMedias");
        if (!backupDir.exists()) backupDir.mkdirs();

        HttpSession session = req.getSession();
        String userIdStr = session.getAttribute("userId").toString();

        int postId = postDAO.insertPost(new Post(userDAO.selectUserById(Integer.parseInt(userIdStr)), content, privacy));

        for (Part filePart : fileParts) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Đường dẫn file trong webapp
            File webappFile = new File(webappDir, fileName);
            filePart.write(webappFile.getAbsolutePath()); // Lưu ảnh vào webapp/img/postMedias

            // Đường dẫn file trong backup
            File backupFile = new File(backupDir, fileName);

            // Kiểm tra nếu file chưa tồn tại trong C:\\uploads\\postMedias, thì sao chép
            if (!backupFile.exists()) {
                Files.copy(webappFile.toPath(), backupFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            mediaDAO.insertPostMedia(postId, "picture", fileName);
        }

        activityDAO.newActivities(Integer.parseInt(userIdStr), postId, "post");

        session.setAttribute("successMessage", "Đăng bài thành công!");
        resp.sendRedirect(req.getContextPath() + "/home");
    }


}
