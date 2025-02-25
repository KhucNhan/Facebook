//package com.example.facebook.controller;
//
//
//import com.example.facebook.model.User;
//import com.example.facebook.service.FriendShip;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.IOException;
//import java.sql.SQLException;
//import java.util.List;
//
//@WebServlet("/friends")
//public class FriendServlet extends HttpServlet {
//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        FriendShip friendShip = new FriendShip();
//        HttpSession session = req.getSession();
////        String userIdStr = session.getAttribute("userId").toString();
//        try {
//            List<User> friends = friendShip.getAllFriendsAdded(Integer.parseInt("1"));
//            req.setAttribute("friends", friends);
//            req.getRequestDispatcher("user/Friend.jsp").forward(req, resp);
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//
//    }
//}

