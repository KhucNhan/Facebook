<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../css/Signup.css">
</head>
<body>
<div class="signup-container">
    <div class="signup-header">
        <h1>Đăng kí</h1>
    </div>
    <form class="signup-form">
        <div>
            <input class="name" type="text" placeholder="Tài khoản " required>
        </div>
        <div class="form-group">
            <label>Ngày sinh</label>
            <div class="birthday">
                <select name="day" id="day" required>
                    <option value="">ngày</option>
                </select>
                <select name="month" id="month" required>
                    <option value="">tháng</option>
                </select>
                <select name="year" id="year" required>
                    <option value="">năm</option>
                </select>
            </div>
        </div>

        <div class="form-gender">
            <label>giới tính</label>
            <div class="gender-options">
                <label>
                    <input type="radio" name="gender" value="male" required> nam
                </label>
                <label>
                    <input type="radio" name="gender" value="female" required> nữ
                </label>
                <label>
                    <input type="radio" name="gender" value="other" required> khác
                </label>
            </div>
        </div>


        <div class="form-group">
            <input type="email" placeholder="số điện thoại hoặc email" required>
        </div>
        <div class="form-group">
            <input type="password" placeholder="mật khẩu" required>
        </div>
        <button type="submit" class="signup-button">Đăng kí</button>
    </form>
</div>
</body>
</html>
