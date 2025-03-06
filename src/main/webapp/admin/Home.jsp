<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 3/6/2025
  Time: 8:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/AdminNav.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminNav.css">
    <title>Title</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container-fluid">
    <div class="row d-flex justify-content-center">
        <div class="col-md-12">
            <jsp:include page="/AdminNav.jsp"></jsp:include>
            <div class="row" style="width: 88%;padding: 0;justify-self: center;">
                <img style="width: 100%;" src="https://file.hstatic.net/200000472237/article/cach-ban-hang-online-tren-facebook_9d8046e8e1fe4c58b65f102855925daf.png" alt="">
            </div>
            <div id="sidePanel" class="side-panel">
                <button class="close-btn" onclick="togglePanel()">X</button>
                <nav class="nav flex-column">
                    <a class="nav-link" aria-current="page" href="/home">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
                            <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293z"/>
                            <path d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293z"/>
                        </svg>
                        Trang chủ
                    </a>
                    <a class="nav-link" aria-current="page" href="/home?action=goToUsers">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-people-fill" viewBox="0 0 16 16">
                            <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6m-5.784 6A2.24 2.24 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.3 6.3 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1zM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5"/>
                        </svg>
                        Quản lý người dùng
                    </a>
                </nav>
            </div>
        </div>
    </div>
</div>
</body>
</html>
