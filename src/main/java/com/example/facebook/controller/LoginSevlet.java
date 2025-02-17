package com.example.facebook.controller;

import com.example.facebook.ConnectDatabase;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginSevlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String action = req.getParameter("action");

        switch (action){
            case "forgotPass" :
                RequestDispatcher dispatcher = req.getRequestDispatcher("view/ForgotPassword.jsp");
                dispatcher.forward(req, resp);
                break;

        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");


        String emailOrSdt = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            Connection connection = ConnectDatabase.connection();
            String sql = "select * from users where (email = ? or phone = ?) and password = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, emailOrSdt);
            preparedStatement.setString(2, emailOrSdt);
            preparedStatement.setString(3, password);


            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int status = resultSet.getInt("status");
                String role = resultSet.getString("role");
                int userId = resultSet.getInt("userId");

                if (status == 0) {
                    resp.getWriter().println("{\"success\": false, \"message\": \"Tài khoản của bạn đã bị khóa!\"}");
                    return;
                }

                if (role.equalsIgnoreCase("User")){
                    resp.getWriter().println("{\"success\": true, \"message\": \"User\"}");

                    HttpSession session = req.getSession();
                    session.setAttribute("userId",userId);

                }else {
                    resp.getWriter().println("{\"success\": true, \"message\": \"Admin\"}");
                }
            } else {
                resp.getWriter().println("{\"success\": false, \"message\": \"Tài khoản hoặc mật khẩu không đúng!\"}");
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
