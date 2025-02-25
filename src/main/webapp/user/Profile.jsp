<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="user/ProfileUser.css">
    <link rel="stylesheet" href="/css/Home_Center.css">
    <script src="/js/Home_Center.js"></script>
</head>
<body style="margin: 0px">
<div>
    <div class="top-nav">
        <div class="TopProfile-photo">
            <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" fill="currentColor"
                 class="bi bi-person-circle" viewBox="0 0 16 16">
                <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                <path fill-rule="evenodd"
                      d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
            </svg>
        </div>
        <div class="TopProfile-name">Name</div>
        <div class="TopProfile-action-buttons">
            <button style="color: white" id="navbar-toggle-button">Thêm bạn bè</button>
        </div>
    </div>
    <div class="centerProfile">
        <div class="center_left">
            <jsp:include page="Home_Center.jsp"/>
        </div>
        <div class="center_right"></div>
    </div>
</div>

</body>
</html>