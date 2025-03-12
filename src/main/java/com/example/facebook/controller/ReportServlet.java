package com.example.facebook.controller;

import com.example.facebook.model.Report;
import com.example.facebook.service.ReportDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {
    ReportDAO reportDAO = new ReportDAO();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "postReports":
                    postReports(req, resp);
                    break;
                case "commentReports":
                    commentReports(req, resp);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void report(HttpServletRequest req, HttpServletResponse resp) throws SQLException, IOException {
        int userId = Integer.parseInt(req.getSession().getAttribute("userId").toString());
        String type = req.getParameter("type");
        Report report = new Report();

        if (type.equalsIgnoreCase("comment")) {
            String commentIdStr = req.getParameter("commentId");
            int commentId = Integer.parseInt(commentIdStr);
            report = new Report(userId, commentId, "Comment");
        } else {
            String postIdStr = req.getParameter("postId");
            int postId = Integer.parseInt(postIdStr);
            report = new Report(userId, postId, "Post");
        }

        boolean success = reportDAO.insertReport(report) != -1;
        resp.getWriter().write("{\"success\": " + success + "}");
    }

    private void commentReports(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        List<Report> postReports = reportDAO.selectAllPostReports();
        req.setAttribute("reports", postReports);
        req.getRequestDispatcher("admin/CommentReport.jsp").forward(req, resp);
    }

    private void postReports(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        List<Report> postReports = reportDAO.selectAllPostReports();
        req.setAttribute("reports", postReports);
        req.getRequestDispatcher("admin/PostReport.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "";
        }

        try {
            switch (action) {
                case "report":
                    report(req, resp);
                    break;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
