package com.example.facebook.controller;

import com.example.facebook.model.Comment;
import com.example.facebook.model.Post;
import com.example.facebook.model.PostMedia;
import com.example.facebook.service.CommentDAO;
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
            out.println("<ul class='comments-list'>");

            for (Comment comment : comments) {
                out.println("<li class='comment-item'>");

                // Ảnh đại diện và thông tin người bình luận
                out.println("<div class='comment-header'>");
                out.println("<img src='/uploads/avatars/" + comment.getUser().getImage() + "' class='avatar'>");
                out.println("<div class='comment-info'>");
                out.println("<strong class='comment-name'>" + comment.getUser().getName() + "</strong>");
                out.println("<span class='comment-time'>" + comment.getCreateAt() + "</span>");
                out.println("</div>");
                out.println("</div>");

                // Nội dung bình luận
                out.println("<div class='comment-content'>" + comment.getContent() + "</div>");

                // Nếu bình luận có media (ảnh/video)
//            if (comment.getMediaUrl() != null && !comment.getMediaUrl().isEmpty()) {
//                if (comment.getMediaType().equals("picture")) {
//                    out.println("<img src='/uploads/commentMedias/" + comment.getMediaUrl() + "' class='comment-media'>");
//                } else if (comment.getMediaType().equals("video")) {
//                    out.println("<video src='/uploads/commentMedias/" + comment.getMediaUrl() + "' class='comment-media' controls></video>");
//                }
//            }

                // Nút thích và phản hồi
                out.println("<div class='comment-actions'>");
                out.println("<button class='like-button' onclick='likeComment(" + comment.getCommentId() + ")'>Thích</button>");
                out.println("<button class='reply-button' onclick='replyToComment(" + comment.getCommentId() + ")'>Phản hồi</button>");
                out.println("</div>");

                out.println("</li>");
            }

            out.println("</ul>"); // Đóng danh sách bình luận
        }

        out.println("</div>"); // Đóng khu vực bình luận
        out.println("</div></div>"); // Đóng post-modal và modal-overlay
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
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
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
