<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ThinkpadX1
  Date: 2/18/2025
  Time: 9:19 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>FaceEbook</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            justify-items: center;
            align-content: center;
        }

        .signup-container {
            width: 400px;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .form-header {
            font-size: 1.8rem;
            margin-bottom: 10px;
            color: #1877f2;
            text-align: center;
        }

        .signup-form {
            margin-top: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccd0d5;
            border-radius: 5px;
            font-size: 1rem;
        }

        .form-group input:focus {
            border-color: #1877f2;
            outline: none;
        }

        .signup-button {
            width: 100%;
            padding: 10px;
            background-color: #1877f2;
            color: white;
            font-size: 1.2rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
        }

        .signup-button:hover {
            background-color: #165dc6;
        }

        /* Ảnh xem trước */
        .circular-img {
            display: block;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            margin: 10px auto;
        }

        /* Giới tính */
        .form-gender label {
            font-size: 16px;
            margin-bottom: 10px;
            display: block;
        }

        .gender-options {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }

        .gender-options label {
            display: flex;
            align-items: center;
            font-size: 14px;
            padding: 10px;
            cursor: pointer;
            background-color: #ffffff;
            border: 1px solid #ccd0d5;
            border-radius: 5px;
            width: 48%;
            text-align: center;
        }

        .gender-options input[type="radio"]:checked + label {
            background-color: #1877f2;
            color: white;
        }

        .gender-options label:hover {
            background-color: #f0f2f5;
        }

    </style>
    <script type="text/javascript">
        function previewImage(event) {
            var reader = new FileReader();
            reader.onload = function () {
                var output = document.getElementById('previewImg');
                output.src = reader.result;
                output.style.display = 'block';
            };
            reader.readAsDataURL(event.target.files[0]);
        }

        function previewBannerImage(event) {
            var reader = new FileReader();
            reader.onload = function () {
                var output = document.getElementById('previewBanner');
                output.src = reader.result;
                output.style.display = 'block';
            };
            reader.readAsDataURL(event.target.files[0]);
        }
    </script>
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded",function (){
            var today = new Date().toISOString().split('T')[0];
            document.getElementById('dateOfBirth').setAttribute('max',today);
        })
    </script>
</head>
<body>
<div class="signup-container">
    <h1 class="form-header">Chỉnh sửa tài khoản</h1>
    <c:if test="${status == 'success'}">
        <div>
            <p style="color: green; text-align: center; font-weight: bold">Cập nhật tài khoản thành công!</p>
        </div>
    </c:if>
    <c:if test="${status != 'success'}">
        <div>
            <p style="color: orange; text-align: center">${status}</p>
        </div>
    </c:if>
    <form action="/users?action=update&userId=${user.userId}" method="post" class="signup-form" enctype="multipart/form-data">

        <div class="form-group" style="display: flex;">
            <div>
                <label for="image">Ảnh đại diện</label>
                <input type="file" id="image" name="image" accept="image/*" onchange="previewImage(event)" style="width: 90%;">
                <img id="previewImg" class="circular-img" alt="Xem ảnh" src="${pageContext.request.contextPath}/uploads/avatars/${user.image}">
            </div>
            <div>
                <label for="image">Ảnh bìa</label>
                <input type="file" id="banner" name="banner" accept="image/*" onchange="previewBannerImage(event)" style="width: 90%;">
                <img id="previewBanner" class="circular-img" alt="Xem ảnh" src="${pageContext.request.contextPath}/img/banners/${user.banner}">
            </div>
        </div>

        <div class="form-group">
            <input type="text" name="name" placeholder="Họ và tên" value="${user.name}" required>
        </div>

        <div class="form-group">
            <input type="email" name="email" placeholder="Email" value="${user.email}" required>
        </div>

        <div class="form-group">
            <input type="text" name="phone" placeholder="Số điện thoại" value="${user.phone}" required pattern="[0-9]{10}" maxlength="10"
                   title="Số điện thoại phải có đúng 10 chữ số">
        </div>

        <div class="form-group">
            <label>Ngày sinh</label>
            <input type="date" id="dateOfBirth" name="dateOfBirth" value="${user.dateOfBirth}" required>
        </div>

        <div class="form-gender">
            <label>Giới tính</label>
            <div class="gender-options">
                <label>
                    <input style="margin-right: 10px;" type="radio" name="gender" value="true" ${user.gender == true ? "checked" : ""}> Nam
                </label>
                <label>
                    <input style="margin-right: 10px;" type="radio" name="gender" value="false" ${!user.gender == true ? "checked" : ""}> Nữ
                </label>
            </div>
        </div>

        <button type="submit" class="signup-button">Cập nhật tài khoản</button>
        <a href="/users" style="display: block;text-align: center;margin-top: 10px">Quay lại</a>
    </form>
</div>

</body>
</html>
