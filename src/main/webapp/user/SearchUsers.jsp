<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 2/27/2025
  Time: 10:13 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Nav3.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous">
    </script>
    <script src="/js/AcceptFriend.js"></script>
    <script src="${pageContext.request.contextPath}/js/Nav3.js"></script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <style>
        .container-fluid {
            height: 91vh;
        }

        .container-fluid > .row {
            height: 100%;
            justify-content: center;
            margin: 0;
        }

        .container-fluid > .row > .col-md-8 {
            padding: 0;
        }

        .actions > a {
            min-width: 100px;
        }

        .user-card {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-block: 10px;
        }
    </style>

</head>
<body>
<jsp:include page="Nav3.jsp"></jsp:include>
<div class="container-fluid">
    <div class="row" style="box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);">
        <div class="col-md-8">
            <c:forEach var="user" items="${searchList}">
                <div style="box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);margin-block: 10px;"
                     class="user-card d-flex align-items-center p-3 border-bottom">
                    <!-- Avatar -->
                    <div class="avatar">
                        <img src="${pageContext.request.contextPath}/uploads/avatars/${user.image}" alt="Avatar"
                             class="rounded-circle" width="50" height="50">
                    </div>

                    <!-- Thông tin -->
                    <div class="info flex-grow-1 ms-3">
                        <strong class="d-block fs-5">${user.name}</strong>
                        <span class="status-text text-muted">
                    <c:choose>
                        <c:when test="${user.friendStatus == 1}">Bạn bè</c:when>
                        <c:otherwise>Chưa kết bạn</c:otherwise>
                    </c:choose>
                </span>
                    </div>

                    <!-- Hành động -->
                    <div class="actions " id="action-${user.userId}">
                        <c:choose>
                            <c:when test="${user.friendStatus == 1}">
                                <a class="btn btn-primary btn-sm message-search" data-id="${user.userId}">Nhắn tin</a>
                            </c:when>
                            <c:when test="${user.friendStatus == 2}">
                                <a class="btn btn-warning btn-sm accept-search" data-id="${user.userId}"
                                   onclick="acceptFriendSearch(${user.userId})">Chấp nhận</a>
                            </c:when>
                            <c:when test="${user.friendStatus == 3}">
                                <a class="btn btn-warning btn-sm cancel-friend-search" data-id="${user.userId}" onclick="cancelFriend(${user.userId})">Hủy lời mời</a>
                            </c:when>
                            <c:otherwise>
                                <a class="btn btn-success btn-sm add-search" data-id="${user.userId}"  onclick="addFriend(${user.userId})">Thêm bạn bè</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>
