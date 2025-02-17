<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 2/17/2025
  Time: 8:26 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="js/Login.js"></script>
    <title>Facebook/Đăng Nhập</title>
</head>
<body style="background: #f2f4f7">
<div style="justify-content: center;text-align: center">
    <img style="width: 240px; margin:28px 26px 1px 10px;"
         src="https://static.xx.fbcdn.net/rsrc.php/y1/r/4lCu2zih0ca.svg">
    <div style="display: block; background: #fff;margin:auto;border-radius: 8px;padding: 0 15px 40px 0; width: 396px;box-shadow: 0px 2px 4px rgba(0, 0, 0, .1), 0px 8px 16px rgba(0, 0, 0, .1);font-family: inherit ">
        <div style="font-family: inherit; font-size: 21px;line-height: 70px;margin-bottom: -10px">
            Đăng nhập Facebook
        </div>
        <div style="padding: 20px">
            <div style="margin-bottom: 40px">
                <input id="emailField"
                       style="width: 370px;border-radius: 6px;border: 1px solid gainsboro;font-size: 17px ;margin: auto; padding: 14px 10px"
                       type="text" placeholder="Email hoặc số điện thoại"/>
                <div style="margin-left: 325px;margin-top: -45px">
                    <span style="font-size: 24px; display: none" id="emailWarning">⚠️</span>
                </div>
                <br>
                <span id="emailError" style="display: none"></span>
            </div>
            <div id="pass"
                 style="width: 370px;border-radius: 6px;border: 1px solid gainsboro;margin: auto;display: flex">
                <input id="passwordField"
                       style="width: 370px;font-size: 17px ; padding: 14px 10px ; border: 0px;border-radius: 6px"
                       type="password" placeholder="Mật khẩu" oninput="togglePassword()"/> <br>
            </div>
            <button id="passwordButton" style="margin-top: -39px;margin-left:325px; border: none; background: none;"
                    onclick="togglePasswordVisibility()">
                <img id="eyeIcon" src="https://img.icons8.com/ios/50/000000/visible.png"
                     style="width: 25px; cursor: pointer;">
            </button>
            <div style="margin-top: 14px">
                <span id="passwordError" style="display: none"></span>
            </div>
        </div>

        <button type="button" onclick="validateLogin()"
                style="width: 370px;border-radius: 6px;border: 1px solid gainsboro;font-size: 20px ;margin-left: 16px ; padding: 14px 10px;background: #1877f2; color: white">
            <b>Đăng nhập</b>
        </button>

        <br><br>
        <a style="width: 300px;color: #1877f2;font-size: 17px" href="">Bạn quên tài khoản ư?</a>
        <br><br>

        <div style="border-bottom: 1px solid #96999e ;margin-top: 15px;margin-left: 15px;margin-bottom: -15px">
        </div>

        <div style=" background: white;width: 50px;margin: auto;position: relative;text-align: center;color:#96999e ;font-size: 17px">
            hoặc
        </div>
        <br>

        <button style="width: 200px;border-radius: 6px;border: 1px solid gainsboro;font-size: 20px ; padding: 14px 10px;background: #42b72a; color: white">
            Tạo tài khoản mới
        </button>
    </div>
</div>
<!-- Modal -->
<div id="successModal" style="display: none;" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>Đăng nhập thành công!</h2>
        <p>Chào mừng bạn đến với hệ thống.</p>
        <button onclick="closeModal()">Đóng</button>
    </div>
</div>

</body>
</html>
