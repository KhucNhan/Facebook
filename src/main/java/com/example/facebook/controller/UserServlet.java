package com.example.facebook.controller;

import com.example.facebook.model.Post;
import com.example.facebook.model.User;
import com.example.facebook.service.FriendShipDAO;
import com.example.facebook.service.PostDAO;
import com.example.facebook.service.UserDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UserServlet", value = "/users")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class UserServlet extends HttpServlet {
    UserDAO userDAO = new UserDAO();
    PostDAO postDAO = new PostDAO();
    FriendShipDAO friendShipDAO = new FriendShipDAO();

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
                case "add":
                    req.getRequestDispatcher("admin/Add.jsp").forward(req, resp);
                    break;
                case "update":
                    showUpdateUser(req, resp);
                    break;
                case "userUpdateInformation":
                    showUserUpdateInformation(req, resp);
                    break;
                case "changePassword":
                    req.getRequestDispatcher("user/ChangePassword.jsp").forward(req, resp);
                    break;
                case "myProfile":
                    showMyProfile(req, resp);
                    break;
                case "delete":
                    deleteUser(req, resp);
                    break;
                default:
                    showUserList(req, resp);
                    break;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void showMyProfile(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        HttpSession session = req.getSession();
        String userIdStr = session.getAttribute("userId").toString();
        User user = userDAO.selectUserById(Integer.parseInt(userIdStr));
        req.setAttribute("user", user);

        List<Post> myPosts = postDAO.selectPostsByUserId(user.getUserId());
        req.setAttribute("user", user);
        req.setAttribute("posts", myPosts);
        req.getRequestDispatcher("user/Profile.jsp").forward(req, resp);
    }

    private void showUserUpdateInformation(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        HttpSession session = req.getSession();
        String userIdStr = session.getAttribute("userId").toString();
        User user = userDAO.selectUserById(Integer.parseInt(userIdStr));
        req.setAttribute("user", user);
        req.getRequestDispatcher("user/Edit.jsp").forward(req, resp);
    }

    private void showUpdateUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        String userIdStr = req.getParameter("userId");
        User user = userDAO.selectUserById(Integer.parseInt(userIdStr));
        req.setAttribute("user", user);
        req.getRequestDispatcher("admin/Edit.jsp").forward(req, resp);
    }

    private void showUserList(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        List<User> users = userDAO.selectAllUsers();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/admin/Users.jsp").forward(req, resp);
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
                case "add":
                    addUser(req, resp);
                    break;
                case "update":
                    updateUser(req, resp);
                    break;
                case "changeStatus":
                    changeUserStatus(req, resp);
                    break;
                case "adminDeleteUser":
                    adminDeleteUser(req ,resp);
                    break;
                case "search":
                    searchUser(req, resp);
                    break;
                case "userUpdateInformation":
                    userUpdateInformation(req, resp);
                    break;
                case "changePassword":
                    changePassword(req, resp);
                    break;
                case "userSearchUsers":
                    userSearchUsers(req, resp);
                    break;
                case "editProfile":
                    editProfile(req, resp);
                    break;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private void editProfile(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException, SQLException {
        HttpSession session = req.getSession();
        int userId = (Integer) session.getAttribute("userId");
        User user = userDAO.selectUserById(userId);

        Part imageFilePart = req.getPart("image");
        Part bannerFilePart = req.getPart("banner");

        String bio = req.getParameter("bio");

        // Lấy tên file hoặc gán ảnh mặc định
        String imageFileName = (imageFilePart != null && imageFilePart.getSubmittedFileName() != null && !imageFilePart.getSubmittedFileName().isEmpty())
                ? Paths.get(imageFilePart.getSubmittedFileName()).getFileName().toString()
                : "default_avt.jpg";

        String bannerFileName = (bannerFilePart != null && bannerFilePart.getSubmittedFileName() != null && !bannerFilePart.getSubmittedFileName().isEmpty())
                ? Paths.get(bannerFilePart.getSubmittedFileName()).getFileName().toString()
                : "default_banner.jpg";

        // Thư mục lưu ảnh trong webapp
        File uploadDirImg = new File(System.getenv("imgFolderUrl") + "avatars");
        File uploadDirBanner = new File(System.getenv("imgFolderUrl") + "banners");

        if (!uploadDirImg.exists()) uploadDirImg.mkdirs();
        if (!uploadDirBanner.exists()) uploadDirBanner.mkdirs();

        // Thư mục backup
        File backupDirImg = new File("C:\\uploads\\avatars");
        File backupDirBanner = new File("C:\\uploads\\banners");

        if (!backupDirImg.exists()) backupDirImg.mkdirs();
        if (!backupDirBanner.exists()) backupDirBanner.mkdirs();

        // Đường dẫn lưu ảnh
        File fileImg = new File(uploadDirImg, imageFileName);
        File fileBanner = new File(uploadDirBanner, bannerFileName);

        // Lưu file vào webapp nếu chưa tồn tại
        if (!fileImg.exists() && imageFilePart != null) {
            imageFilePart.write(fileImg.getAbsolutePath());
        }
        if (!fileBanner.exists() && bannerFilePart != null) {
            bannerFilePart.write(fileBanner.getAbsolutePath());
        }

        // Copy sang C:\\uploads nếu chưa có
        File backupImgFile = new File(backupDirImg, imageFileName);
        File backupBannerFile = new File(backupDirBanner, bannerFileName);

        try {
            if (!backupImgFile.exists() && fileImg.exists()) {
                Files.copy(fileImg.toPath(), backupImgFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
            if (!backupBannerFile.exists() && fileBanner.exists()) {
                Files.copy(fileBanner.toPath(), backupBannerFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        user.setBanner(bannerFileName);
        user.setImage(imageFileName);
        user.setBio(bio);
        userDAO.updateUser(user, userId);
        req.setAttribute("user", user);
        req.getRequestDispatcher("user/Profile.jsp").forward(req, resp);
    }

    private void adminDeleteUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        int userId = Integer.parseInt(req.getParameter("userId"));
        User user = userDAO.selectUserById(userId);
        user.setStatus("Banned");
        userDAO.updateUser(user, userId);
    }

    private void userSearchUsers(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        HttpSession session = req.getSession();
        User user = userDAO.selectUserById(Integer.parseInt(session.getAttribute("userId").toString()));

        String value = req.getParameter("value");
        List<User> searchList = userDAO.userSearchUsers(value, user.getUserId());
        req.setAttribute("searchList", searchList);
        req.setAttribute("user", user);
        req.setAttribute("searchValue", value);
        req.getRequestDispatcher("user/SearchUsers.jsp").forward(req, resp);
    }

    private void changePassword(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        String userIdStr = req.getParameter("userId");
        String oldPassword = req.getParameter("oldPassword");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        User user = userDAO.selectUserById(Integer.parseInt(userIdStr));
        if (user.getPassword().equals(oldPassword)) {
            if (!(newPassword.length() < 6)) {
                if (newPassword.equals(confirmPassword)) {
                    user.setPassword(newPassword);
                    boolean status = userDAO.updateUser(user, Integer.parseInt(userIdStr));
                    if (status) {
                        req.setAttribute("message", "success");
                    }
                } else {
                    req.setAttribute("message", "incorrectConfirmPassword");
                }
            } else {
                req.setAttribute("message", "index");
            }
        } else {
            req.setAttribute("message", "incorrectPassword");
        }
        req.getRequestDispatcher("user/ChangePassword.jsp").forward(req, resp);
    }

    private void userUpdateInformation(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        String userIdStr = req.getParameter("userId");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter( "phone");
        String dateOfBirth = req.getParameter("dateOfBirth");
        boolean gender = Boolean.parseBoolean(req.getParameter("gender"));

        User user = userDAO.selectUserById(Integer.parseInt(userIdStr));

        if(name.equalsIgnoreCase(user.getName()) && email.equalsIgnoreCase(user.getEmail()) && phone.equals(user.getPhone()) && Date.valueOf(dateOfBirth).equals(user.getDateOfBirth()) && gender == user.isGender()) {
            req.setAttribute("status", "noChange");
            req.setAttribute("user", user);
            req.getRequestDispatcher("user/Edit.jsp").forward(req, resp);
            return;
        }

        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setDateOfBirth(Date.valueOf(dateOfBirth));
        user.setGender(gender);

        boolean status = userDAO.updateUser(user, Integer.parseInt(userIdStr));
        if (status) req.setAttribute("status", "success");
        req.setAttribute("user", user);
        req.getRequestDispatcher("user/Edit.jsp").forward(req, resp);

    }

    private void changeUserStatus(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        String userIdStr = req.getParameter("userId");
        User user = userDAO.selectUserById(Integer.parseInt(userIdStr));
        if (user.getStatus().equalsIgnoreCase("Active")) {
            user.setStatus("Blocked");
        } else {
            user.setStatus("Active");
        }
        userDAO.updateUser(user, Integer.parseInt(userIdStr));
        resp.getWriter().write(user.getStatus().equalsIgnoreCase("Active") ? "active" : "blocked");
    }

    private void searchUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        String value = req.getParameter("value");
        List<User> users = userDAO.adminSearchUsers(value);
        req.setAttribute("users", users);
        req.setAttribute("value", value);
        req.getRequestDispatcher("/admin/Users.jsp").forward(req, resp);
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        HttpSession session = req.getSession();
        int userId = (Integer) session.getAttribute("userId");
        userDAO.deleteUser(userId);

        session.removeAttribute("userId");

        RequestDispatcher dispatchers = req.getRequestDispatcher("view/Login.jsp");
        dispatchers.forward(req, resp);
    }

    private void addUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        String imageFileName = "default_avt.jpg";
        String bannerFileName = "default_banner.jpg";

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String dateOfBirth = req.getParameter("dateOfBirth");
        boolean gender = Boolean.parseBoolean(req.getParameter("gender"));

        User user = new User(imageFileName, name, email, phone, password, Date.valueOf(dateOfBirth), gender);
        user.setBanner(bannerFileName);

        if (userDAO.isUserExists(email, phone) != null) {
            req.setAttribute("status", "Email hoặc sđt đã tồn tại");
        } else {
            if (userDAO.insertUser(user)) {
                req.setAttribute("status", "success");
            } else {
                req.setAttribute("status", "error");
            }
        }
        req.getRequestDispatcher("admin/Add.jsp").forward(req, resp);
    }

    private void updateUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        String userId = req.getParameter("userId");

        Part imageFilePart = req.getPart("image");
        Part bannerFilePart = req.getPart("banner");

        // Lấy tên file hoặc gán ảnh mặc định
        String imageFileName = (imageFilePart != null && imageFilePart.getSubmittedFileName() != null && !imageFilePart.getSubmittedFileName().isEmpty())
                ? Paths.get(imageFilePart.getSubmittedFileName()).getFileName().toString()
                : "default_avt.jpg";

        String bannerFileName = (bannerFilePart != null && bannerFilePart.getSubmittedFileName() != null && !bannerFilePart.getSubmittedFileName().isEmpty())
                ? Paths.get(bannerFilePart.getSubmittedFileName()).getFileName().toString()
                : "default_banner.jpg";

        // Thư mục lưu ảnh trong webapp
        File uploadDirImg = new File(System.getenv("imgFolderUrl") + "avatars");
        File uploadDirBanner = new File(System.getenv("imgFolderUrl") + "banners");

        if (!uploadDirImg.exists()) uploadDirImg.mkdirs();
        if (!uploadDirBanner.exists()) uploadDirBanner.mkdirs();

        // Thư mục backup
        File backupDirImg = new File("C:\\uploads\\avatars");
        File backupDirBanner = new File("C:\\uploads\\banners");

        if (!backupDirImg.exists()) backupDirImg.mkdirs();
        if (!backupDirBanner.exists()) backupDirBanner.mkdirs();

        // Đường dẫn lưu ảnh
        File fileImg = new File(uploadDirImg, imageFileName);
        File fileBanner = new File(uploadDirBanner, bannerFileName);

        // Lưu file vào webapp nếu chưa tồn tại
        if (!fileImg.exists() && imageFilePart != null) {
            imageFilePart.write(fileImg.getAbsolutePath());
        }
        if (!fileBanner.exists() && bannerFilePart != null) {
            bannerFilePart.write(fileBanner.getAbsolutePath());
        }

        // Copy sang C:\\uploads nếu chưa có
        File backupImgFile = new File(backupDirImg, imageFileName);
        File backupBannerFile = new File(backupDirBanner, bannerFileName);

        try {
            if (!backupImgFile.exists() && fileImg.exists()) {
                Files.copy(fileImg.toPath(), backupImgFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
            if (!backupBannerFile.exists() && fileBanner.exists()) {
                Files.copy(fileBanner.toPath(), backupBannerFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Lấy thông tin từ request
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String dateOfBirth = req.getParameter("dateOfBirth");
        boolean gender = Boolean.parseBoolean(req.getParameter("gender"));

        User user = userDAO.selectUserById(Integer.parseInt(userId));

        // Kiểm tra nếu không có sự thay đổi
        if (name.equalsIgnoreCase(user.getName()) && email.equalsIgnoreCase(user.getEmail()) &&
                phone.equals(user.getPhone()) && Date.valueOf(dateOfBirth).equals(user.getDateOfBirth()) &&
                gender == user.isGender() && imageFileName.equalsIgnoreCase(user.getImage()) &&
                bannerFileName.equalsIgnoreCase(user.getBanner())) {

            req.setAttribute("status", "Không có sự thay đổi nào");
            req.setAttribute("user", user);
            req.getRequestDispatcher("admin/Edit.jsp").forward(req, resp);
            return;
        }

        User user1 = userDAO.isUserExists(email, phone);
        if (user1 != null && user1.getUserId() != Integer.parseInt(userId)) {
            req.setAttribute("status", "Email hoặc sđt đã tồn tại");
            req.setAttribute("user", user);
            req.getRequestDispatcher("admin/Edit.jsp").forward(req, resp);
            return;
        }

        // Cập nhật thông tin user
        user.setImage(imageFileName);
        user.setBanner(bannerFileName);
        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setDateOfBirth(Date.valueOf(dateOfBirth));
        user.setGender(gender);

        boolean status = userDAO.updateUser(user, Integer.parseInt(userId));

        if (status) req.setAttribute("status", "success");
        req.setAttribute("user", user);
        req.getRequestDispatcher("admin/Edit.jsp").forward(req, resp);
    }



}