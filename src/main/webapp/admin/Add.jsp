<%--
  Created by IntelliJ IDEA.
  User: ThinkpadX1
  Date: 2/17/2025
  Time: 2:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thêm tài khoản mới</title>
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

        .gender-options input[type="radio"] {
            display: none;
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
        function previewImage(event){
            var reader = new FileReader();
            reader.onload = function (){
                var output = document.getElementById('preview');
                output.src = reader.result;
                output.style.display = 'block';

            };
            reader.readAsDataURL(event.target.files[0]);
        }

        document.addEventListener("DOMContentLoaded", function() {
            var today = new Date().toISOString().split('T')[0];
            document.getElementById('dateOfBirth').setAttribute('max', today);
        });
    </script>
</head>
<body>
<div class="signup-container">
    <h1 class="form-header">Thêm tài khoản</h1>

    <form action="/users?action=add" method="post" class="signup-form" enctype="multipart/form-data">

        <div class="form-group">
            <label for="image">Ảnh đại diện</label>
            <input type="file" id="image" name="image" accept="image/*" onchange="previewImage(event)" required>
            <img id="preview" class="circular-img" alt="">
        </div>

        <div class="form-group">
            <input type="text" name="name" placeholder="Họ và tên" required>
        </div>

        <div class="form-group">
            <input type="email" name="email" placeholder="Email" required>
        </div>

        <div class="form-group">
            <input type="number" name="phone" placeholder="Số điện thoại" required>
        </div>

        <div class="form-group">
            <input type="password" name="password" placeholder="Mật khẩu" required>
        </div>

        <div class="form-group">
            <label>Ngày sinh</label>
            <input type="date" id="dateOfBirth" name="dateOfBirth" required>
        </div>

        <div class="form-gender">
            <label>Giới tính</label>
            <div class="gender-options">
                <label>
                    <input type="radio" name="gender" value="true" required> Nam
                </label>
                <label>
                    <input type="radio" name="gender" value="false" required> Nữ
                </label>
            </div>
        </div>

        <button type="submit" class="signup-button">Thêm tài khoản</button>
        <a href="/users" style="display: block;text-align: center;margin-top: 10px">Quay lại</a>
    </form>
</div>

</body>
</html>
