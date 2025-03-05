package com.example.facebook.controller;

import com.example.facebook.model.Group;
import com.example.facebook.model.User;
import com.example.facebook.service.GroupDAO;
import com.example.facebook.service.GroupMemberDAO;
import com.example.facebook.service.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/groups")
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
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
