<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/Signup.css">
    <title>FaceEbook</title>
</head>
<body>
<div class="signup-container">
    <div class="signup-header">
        <h1>Đăng kí</h1>
    </div>
    <form action="/register" method="post" class="signup-form">
        <div class="form-group">
            <input class="name" type="text" name="name" placeholder="Họ và tên " required>
        </div>
        <div class="form-group">
            <input name="email" type="email" placeholder="Email" required>
        </div>
        <div class="form-group">
            <input name="phone" type="number" placeholder="Số điện thoại" required>
        </div>
        <div class="form-group">
            <input name="password" type="password" placeholder="Mật khẩu" required>
        </div>
        <div class="form-group">
            <label>Ngày sinh</label>
            <input type="date" id="dateOfBirth" name="dob">
        </div>

        <div class="form-gender">
            <label>Giới tính</label>
            <div class="gender-options">
                <label>
                    <input type="radio" name="gender" value="male" required> Nam
                </label>
                <label>
                    <input type="radio" name="gender" value="female" required> Nữ
                </label>
                <label>
                    <input type="radio" name="gender" value="other" required> Khác
                </label>
            </div>
        </div>
        <button type="submit" class="signup-button">Đăng kí</button>
        <a href="/register" style="display: block;text-align: center;margin-top: 10px;">Bạn đã có tài khoản ?</a>
    </form>
</div>
</body>
<script type="text/javascript">
    document.addEventListener("DOMContentLoaded",function (){
        var today = new Date().toISOString().split('T')[0];
        document.getElementById('dateOfBirth').setAttribute('max',today);
    })
</script>
</html>
