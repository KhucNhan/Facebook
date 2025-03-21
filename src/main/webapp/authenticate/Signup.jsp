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
        <h1>Đăng ký</h1>
    </div>
    <form action="/register" method="post" class="signup-form">
        <div class="form-group">
            <input id="name" class="name" type="text" name="name" placeholder="Họ và tên " required>
            <br>
            <sup id="nameError" style="color: red;padding-left: 5px;"></sup>
        </div>
        <div class="form-group">
            <input id="email" name="email" type="email" placeholder="Email" required>
            <br>
            <sup id="phoneAndEmailErrorr" style="color: red;padding-left: 5px;"></sup>
        </div>
        <div class="form-group">
            <input id="phone" name="phone" type="number" placeholder="Số điện thoại" required>
            <br>
            <sup id="phoneAndEmailError" style="color: red;padding-left: 5px;"></sup>
        </div>
        <div class="form-group">
            <input id="password" name="password" type="password" placeholder="Mật khẩu" required>
            <br>
            <sup id="passwordIsError" style="color: red;padding-left: 5px;"></sup>
        </div>
        <div class="form-group">
            <input id="rePassword" name="rePassword" type="password" placeholder="Nhập lại mật khẩu" required>
            <br>
            <sup id="passwordError" style="color: red;padding-left: 5px;"></sup>
        </div>
        <div class="form-group">
            <label>Ngày sinh</label>
            <input type="date" id="dateOfBirth" name="dob" required>
        </div>

        <div class="form-gender">
            <label>Giới tính</label>
            <div class="gender-options">
                <label>
                    <input style="margin-right: 10px;" type="radio" name="gender" value="male" required>    Nam
                </label>
                <label>
                    <input style="margin-right: 10px;" type="radio" name="gender" value="female" required>    Nữ
                </label>
            </div>
        </div>
        <button type="submit" class="signup-button">Đăng ký</button>
        <a href="/register" style="display: block;text-align: center;margin-top: 10px;">Bạn đã có tài khoản ?</a>
    </form>
</div>
</body>
<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function () {
        var today = new Date().toISOString().split('T')[0];
        document.getElementById('dateOfBirth').setAttribute('max', today);
    })

    document.querySelector(".signup-form").addEventListener("submit", function (event) {
        event.preventDefault();

        const form = this;
        const email = document.getElementById("email").value.trim();
        const phone = document.getElementById("phone").value.trim();
        const name = document.getElementById("name").value.trim();
        const password = document.getElementById("password").value.trim();
        const rePassword = document.getElementById("rePassword").value.trim();
        const emailError = document.getElementById("phoneAndEmailError");
        const nameError = document.getElementById("nameError");
        const passwordError = document.getElementById("passwordError");

        if (!email && !phone) {
            form.submit();
            return;
        }

        const xhr = new XMLHttpRequest();
        xhr.open("GET", "/check-register?email=" + encodeURIComponent(email) +
            "&phone=" + encodeURIComponent(phone) +
            "&name=" + encodeURIComponent(name) +
            "&password=" + encodeURIComponent(password) +
            "&rePassword=" + encodeURIComponent(rePassword), true);

        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                let responseText = xhr.responseText.trim();
                let errors = {
                    email: [],
                    name: [],
                    password: []
                };

                if (responseText.includes("exists")) {
                    errors.email.push("Email hoặc số điện thoại đã tồn tại!");
                }

                if (responseText.includes("emailRegex")) {
                    errors.email.push("Địa chỉ email không hợp lệ!");
                }

                if (responseText.includes("nameError")) {
                    errors.name.push("Tên không được chứa ký tự đặc biệt!");
                }

                if (responseText.includes("passwordLengthError")) {
                    errors.password.push("Mật khẩu phải có tối thiểu 6 ký tự!");
                }

                if (responseText.includes("passwordError")) {
                    errors.password.push("Mật khẩu không đúng!");
                }

                // Hiển thị tất cả lỗi
                emailError.innerHTML = errors.email.join("<br>");
                nameError.innerHTML = errors.name.join("<br>");
                passwordError.innerHTML = errors.password.join("<br>");

                // Nếu không có lỗi, submit form
                if (responseText === "pass") {
                    form.submit();
                }
            }
        };

        xhr.send();

    });


</script>
</html>
