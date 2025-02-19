package com.example.facebook.controller;


import com.example.facebook.service.FriendShip;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/friendShip")
public class FriendServlet extends HttpServlet {
    FriendShip friendShip = new FriendShip();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
