package com.example.facebook.controller;

import com.example.facebook.model.Group;
import com.example.facebook.model.User;
import com.example.facebook.service.dao.GroupDAO;
import com.example.facebook.service.dao.GroupMemberDAO;
import com.example.facebook.service.dao.UserDAO;

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
import java.sql.SQLException;

@WebServlet("/groups")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class GroupServlet extends HttpServlet {
    UserDAO userDAO = new UserDAO();
    GroupDAO groupDAO = new GroupDAO();
    GroupMemberDAO groupMemberDAO = new GroupMemberDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }

        try {
            HttpSession session = req.getSession();
            int userId = (Integer) session.getAttribute("userId");
            User user = userDAO.selectUserById(userId);
            switch (action) {
                default:
                    showGroups(user, req, resp);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void showGroups(User user, HttpServletRequest req, HttpServletResponse resp) {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }

        try {
            HttpSession session = req.getSession();
            int userId = (Integer) session.getAttribute("userId");
            User user = userDAO.selectUserById(userId);
            switch (action) {
                case "create":
                    createGroup(user, req, resp);
                    break;
                case "edit":
                    editGroup(req, resp);
                    break;
                case "groupMembers":
                    getGroupMembers(req, resp);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void getGroupMembers(HttpServletRequest req, HttpServletResponse resp) throws SQLException {

    }

    private void editGroup(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException, ServletException {
        resp.setContentType("text/plain");
        PrintWriter out = resp.getWriter();

        String action = req.getParameter("action");
        if (action == null || !action.equals("edit")) {
            out.print("error|Invalid action");
            return;
        }

        // Lấy dữ liệu từ request
        String groupId = req.getParameter("groupId");
        String groupName = req.getParameter("name");

        Part groupImgPart = req.getPart("editGroupImg"); // Nhận file ảnh
        System.out.println(groupImgPart);

        if (groupId == null || groupName == null) {
            out.print("error|Missing parameters");
            return;
        }

        // Đặt tên ảnh mặc định nếu không có file mới
        String groupImgName = (groupImgPart != null && groupImgPart.getSubmittedFileName() != null && !groupImgPart.getSubmittedFileName().isEmpty())
                ? Paths.get(groupImgPart.getSubmittedFileName()).getFileName().toString()
                : "default_group_avt.jpg";

        // Thư mục lưu ảnh trong webapp
        File uploadDir = new File(System.getenv("imgFolderUrl") + "group_avatars");
        if (!uploadDir.exists()) uploadDir.mkdirs();

        // Thư mục backup
        File backupDir = new File("C:\\uploads\\group_avatars");
        if (!backupDir.exists()) backupDir.mkdirs();

        // Đường dẫn lưu ảnh
        File fileImg = new File(uploadDir, groupImgName);

        // Lưu file vào webapp nếu chưa tồn tại
        if (!fileImg.exists() && groupImgPart != null) {
            groupImgPart.write(fileImg.getAbsolutePath());
        }

        File backupImgFile = new File(backupDir, groupImgName);
        try {
            if (!backupImgFile.exists() && fileImg.exists()) {
                Files.copy(fileImg.toPath(), backupImgFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
        } catch (IOException e) {
            e.printStackTrace();
            out.print("error|Failed to save image");
            return;
        }

        // Cập nhật group trong database
        Group group = groupDAO.selectGroupById(Integer.parseInt(groupId));
        group.setImage(groupImgName);
        group.setName(groupName);

        if (groupDAO.updateGroup(group, Integer.parseInt(groupId))) {
            System.out.println("Edit group success");
            out.print("success|" + groupImgName);
        } else {
            out.print("error|Update failed");
        }
        out.flush();
        out.close();
    }


    private void createGroup(User user, HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        String groupName = req.getParameter("groupName");
        String membersString = req.getParameter("members");

        if (groupName == null || membersString == null || groupName.isEmpty() || membersString.isEmpty()) {
            System.out.println("Thiếu thông tin nhóm hoặc thành viên.");
            return;
        }

        Group group = new Group();
        group.setName(groupName);
        group.setCreateBy(user.getUserId());
        int groupId = groupDAO.insertNewGroup(group);

        if (groupId != -1) {
            groupMemberDAO.insertMember(groupId, user.getUserId(), "Creator");
            String[] memberIds = membersString.split(",");
            for (String member : memberIds) {
                groupMemberDAO.insertMember(groupId, Integer.parseInt(member), "Member");
            }
        }

        HomeServlet homeServlet = new HomeServlet();
        homeServlet.showHome(req, resp);
    }
}
