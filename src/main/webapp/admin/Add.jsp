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
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 20px;
        }
        form {
            width: 300px;
            margin: auto;
        }
        label,input,select {
            display: block;
            width: 100%;
            margin-bottom: 10px;
        }
        input[type="submit"]{
            background-color: blue;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
        }
        .circular-img{
            width: 100px;
            height: 100px;
            object-fit: cover;
            display: none;
            margin-top: 10px;

        }
        #preview{
            margin: 10px auto;
            border-radius: 50%;
            margin-left: 100px;
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

    </script>
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function() {
            var today = new Date().toISOString().split('T')[0];
            document.getElementById('dateOfBirth').setAttribute('max', today);
        });
    </script>
</head>
<body>
<h2>Thêm tài khoản mới</h2>
<form action="" method="post">
    <label for="image">Ảnh:</label>
    <input type="file" id="image" name="image" accept="image/*" onchange="previewImage(event)" required>
    <img id = "preview" class="circular-img" alt="Xem ảnh">
    <label for="name">Tên:</label>
    <input type="text" id="name" name="name" required>
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required>
    <label for="phone">Số điện thoại:</label>
    <input type="number" id="phone" name="phone" required>
    <label for="password">Mật khẩu</label>
    <input type="password" id="password" name="password" required>
    <label for="dateOfBirth">Ngày sinh:</label>
    <input type="date" id="dateOfBirth" name="dateOfBirth" required>
    <label for="gender">Giới tính:</label>
    <select id="gender" name="gender">
        <option value="true">Nam</option>
        <option value="false">Nữ</option>
    </select>

    <input type="submit" value="Thêm tài khoản">

</form>

</body>
</html>
