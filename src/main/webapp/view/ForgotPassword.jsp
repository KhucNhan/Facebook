<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Language" content="vi">
    <title>Bạn quên mật khẩu ?</title>
    <link rel="stylesheet" href="css/ForgotPassword.css">
    <script src="js/ForgotPassword.js"></script>
</head>
<body>
<div class="form-container">
    <h2>Quên mật khẩu</h2>
    <form action="/forgotPassword?action=updatePass" method="post" onsubmit="return checkPassword()">

    <div id="phoneForm">
        <label for="phone">Số điện thoại</label>
        <input type="text" id="phone" name="phone" placeholder="Nhập số điện thoại của bạn" required>
        <p id="phoneError" style="color: red; display: none;"></p>
        <button type="button" onclick="checkPhone()" class="btn">Tiếp tục</button>
    </div>
        <div id="newPasswordFields" hidden="hidden">
            <label for="newPassword">Mật khẩu mới</label>
            <input type="password" id="newPassword" name="newPassword" placeholder="Nhập mật khẩu mới" >
            <p id="phoneError_1" style="color: red; display: none;"></p>

            <label for="confirmPassword">Xác nhận mật khẩu</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
            <p id="passError" style="color: red; display: none;"></p>

            <button type="submit" class="btn">Cập nhật mật khẩu</button>
        </div>
    </form>
    <form action="/forgotPassword?action=backLogin" method="post">
        <button type="submit" class="btn" style="background: #1877f2">Thoát</button>
    </form>
</div>

<%
    String successMessage = (String) request.getAttribute("successMessage");
    if (successMessage != null) {
%>
<script>
    alert("<%= successMessage %>");
</script>
<%
    }
%>

</body>
</html>
