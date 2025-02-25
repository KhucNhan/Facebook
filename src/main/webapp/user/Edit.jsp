<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ThinkpadX1
  Date: 2/20/2025
  Time: 2:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cập nhật thông tin tài khoản</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f2f2f2;
        }

        .container {
            width: 350px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .container h2 {
            color: blue;

        }

        table {
            width: 100%;
            margin-top: 10px;
        }

        td {
            padding: 8px 0;

        }

        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .gender-options {
            display: flex;
            justify-content: space-between;
        }

        .gender-options label {
            display: flex;
            align-items: center;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: blue;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }

        a {
            display: block;
            margin-top: 10px;
            color: blue;
            text-decoration: none;
        }
    </style>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var today = new Date().toISOString().split('T')[0];
            document.getElementById('dateOfBirth').setAttribute('max', today);
        });
    </script>
</head>
<body>
<div class="container">
    <h2>Cập nhật thông tin</h2>
    <c:if test="${status == 'success'}">
        <div>
            <p style="color: green; text-align: center; font-weight: bold">Cập nhật tài khoản thành công!</p>
        </div>
    </c:if>
    <c:if test="${status != 'success'}">
        <div>
            <p style="color: white">hehehe</p>
        </div>
    </c:if>
    <form action="/users?action=userUpdateInformation&userId=${user.userId}" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <td colspan="2"><input type="text" id="name" name="name" value="${user.name}" placeholder="Họ và Tên" required></td>
            </tr>
            <tr>
                <td colspan="2"><input type="email" id="email" name="email" value="${user.email}" placeholder="Email" required></td>
            </tr>
            <tr>
                <td colspan="2"><input type="tel" id="phone" name="phone" value="${user.phone}" placeholder="Số điện thoại" required></td>
            </tr>
            <tr>
                <td colspan="2">Ngày sinh</td>
            </tr>
            <tr>
                <td colspan="2"><input type="date" id="dateOfBirth" value="${user.dateOfBirth}" name="dateOfBirth"
                                       max="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"
                                       required></td>
            </tr>
            <tr>
                <td colspan="2">Giới tính</td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="gender-options">
                        <label><input type="radio" name="gender" value="Nam" ${user.gender ? 'checked' : ''} required> Nam</label>
                        <label><input type="radio" name="gender" value="Nữ" ${!user.gender ? "checked" : ""}> Nữ</label>
                    </div>
                </td>
            </tr>
        </table>
        <button type="submit">Lưu thông tin</button>
        <a style="display: block;text-align: center" href="/home">Quay lại</a>
    </form>
</div>


</body>
</html>
