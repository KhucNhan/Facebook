package com.example.facebook.controller;

import com.example.facebook.model.Post;
import com.example.facebook.model.User;
import com.example.facebook.service.PostDAO;
import com.example.facebook.service.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
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
                case "delete":
                    deleteUser(req, resp);
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
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
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
        user.setStatus(!user.isStatus());
        userDAO.updateUser(user, Integer.parseInt(userIdStr));
        resp.getWriter().write(user.isStatus() ? "active" : "blocked");
    }

    private void searchUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        String value = req.getParameter("value");
        List<User> users = userDAO.searchUsers(value);
        req.setAttribute("users", users);
        req.getRequestDispatcher("/admin/Users.jsp").forward(req, resp);
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException {
        String userId = req.getParameter("userId");
        userDAO.deleteUser(Integer.parseInt(userId));
    }

    private void addUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        Part filePart = req.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        if (fileName.isEmpty()) {
            fileName = "default_avt.jpg";
        }

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String dateOfBirth = req.getParameter("dateOfBirth");
        boolean gender = Boolean.parseBoolean(req.getParameter("gender"));

        File uploadDir = new File("C:\\uploads\\avatars");
        if (!uploadDir.exists()) uploadDir.mkdirs();

        File file = new File(uploadDir, fileName);

        if (!file.exists()) {
            String filePath = "C:\\uploads\\avatars" + File.separator + fileName;
            filePart.write(filePath);
        }

        User user = new User(fileName, name, email, phone, password, Date.valueOf(dateOfBirth), gender);
        if (userDAO.insertUser(user)) {
            req.setAttribute("status", "success");
        } else {
            req.setAttribute("status", "error");
        }
        req.getRequestDispatcher("admin/Add.jsp").forward(req, resp);
    }

    private void updateUser(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        String userId = req.getParameter("userId");

        Part filePart = req.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();


        File uploadDir = new File("C:\\uploads\\avatars");
        if (!uploadDir.exists()) uploadDir.mkdirs();

        File file = new File(uploadDir, fileName);

        String filePath = "C:\\uploads\\avatars" + File.separator + fileName;


        if (!file.exists()) {
            filePart.write(filePath);
        }

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String dateOfBirth = req.getParameter("dateOfBirth");
        boolean gender = Boolean.parseBoolean(req.getParameter("gender"));

        User user = userDAO.selectUserById(Integer.parseInt(userId));
        user.setImage(fileName);
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