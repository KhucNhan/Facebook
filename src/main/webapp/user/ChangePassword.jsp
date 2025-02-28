<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ThinkpadX1
  Date: 2/20/2025
  Time: 4:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đổi mật khẩu Facebook</title>
    <style>
        body{
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f2f5;
            font-family: Arial, sans-serif;
        }
        .container{
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
            width: 400px;
        }
        h2{
            text-align: center;
            margin-bottom: 20px;

        }
        .form-group{
            margin-bottom: 15px;
        }
        label{
            display: block;
            margin-bottom: 5px;
        }
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            background-color: #1877f2;
            color: white;
            border: none;
            padding: 10px;
            width: 100%;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #165dbb;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Đổi mật khẩu</h2>
    <c:if test="${message == 'success'}">
        <p style="color: green">Đổi mật khẩu thành công!</p>
    </c:if>
    <form action="/users?action=changePassword&userId=${sessionScope.userId}" method="post">
        <div class="form-group">
            <label for="oldPassword">Mật khẩu cũ:</label>
            <input type="password" id="oldPassword" name="oldPassword" required>
            <c:if test="${message == 'incorrectPassword'}">
                <small style="color: red">Sai mật khẩu</small>
            </c:if>
        </div>
        <div class="form-group">
            <label for="newPassword">Mật khẩu mới:</label>
            <input type="password" id="newPassword" name="newPassword" required>
            <c:if test="${message == 'index'}">
                <small style="color: red">Mật khẩu phải có ít nhất 6 ký tự</small>
            </c:if>
        </div>
        <div class="form-group">
            <label for="confirmPassword">Nhập lại mật khẩu mới:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            <c:if test="${message == 'incorrectConfirmPassword'}">
                <small style="color: red">Sai mật khẩu</small>
            </c:if>
        </div>
        <button type="submit" class="btn">Xác nhận</button>
        <a style="margin-top:20px;display: block;text-align: center" href="/home">Quay lại</a>
    </form>
</div>

</body>
</html>
