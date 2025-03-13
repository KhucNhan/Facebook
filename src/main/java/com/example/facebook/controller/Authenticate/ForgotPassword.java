package com.example.facebook.controller.Authenticate;

import com.example.facebook.ConnectDatabase;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/forgotPassword")
public class ForgotPassword extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        switch (action) {
            case "checkPhone":
                checkPhone(req, resp);
                break;
            case "updatePass":
                updatePass(req, resp);
                break;
            case "backLogin":
                backLogin(req, resp);
                break;
        }


    }

    private void backLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatchers = req.getRequestDispatcher("authenticate/Login.jsp");
        dispatchers.forward(req, resp);
    }

    private void updatePass(HttpServletRequest req, HttpServletResponse resp) {
        String password = req.getParameter("newPassword");
        String phone = req.getParameter("phone");

        String updatePassword = "UPDATE users SET password = ? where phone = ?";

        try {
            Connection connection = ConnectDatabase.connection();
            PreparedStatement preparedStatement = connection.prepareStatement(updatePassword);

            preparedStatement.setString(1, password);
            preparedStatement.setString(2, phone);

            int row = preparedStatement.executeUpdate();

            if (row > 0) {

                RequestDispatcher dispatchers = req.getRequestDispatcher("authenticate/ForgotPassword.jsp");
                req.setAttribute("successMessage", "Mật khẩu của bạn đã được cập nhật thành công!");

                dispatchers.forward(req, resp);

            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    private void checkPhone(HttpServletRequest req, HttpServletResponse resp) {
        String phone = req.getParameter("phone");
        boolean phoneExists = false;

        try (Connection connection = ConnectDatabase.connection()) {
            String checkPhoneSQL = "SELECT COUNT(*) FROM users WHERE phone = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(checkPhoneSQL)) {
                preparedStatement.setString(1, phone);

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        phoneExists = resultSet.getInt(1) > 0;
                    }
                }
            }

            resp.setContentType("application/json");
            PrintWriter out = resp.getWriter();
            if (phoneExists) {
                out.println("{\"exists\": true}");
            } else {
                out.println("{\"exists\": false}");
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        switch (action) {
            case "backLogin":
                backLogin(req, resp);
                break;
        }

    }
}
