<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 2/25/2025
  Time: 10:35 AM
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
    <script src="${pageContext.request.contextPath}/js/Nav3.js"></script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <style>
        .container-fluid {
            height: 91vh;
        }

        .list-group-item a {
            text-decoration: none;
            color: black;
            font-size: larger;
        }

        .container-fluid > .row {
            height: 100%;
        }

        .container-fluid > .row > div:nth-child(1) {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .container-fluid > .row > div {
            padding-top:20px;
        }

        .list-group > li {
            border:none;
        }

        .list-group li:nth-child(2) {
            border-top: 1px solid lightgrey;
        }

        .searchForm > div {
            width: 50%;
        }
    </style>
</head>
<body>
<jsp:include page="Nav3.jsp"></jsp:include>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2">
            <ul class="list-group">
                <li class="list-group-item list-group-item-action">
                    <a href="/friends?action=friendRequests">Lời mời kết bạn</a>
                </li>
                <li class="list-group-item list-group-item-action">
                    <a href="/friends?action=allFriends">Tất cả bạn bè</a>
                </li>
            </ul>
        </div>
        <div class="col-md-10">
            <h3>Lời mời kết bạn</h3>
            <div style="padding-block: 10px;" class="row">
                <form class="searchForm" action="/friends?action=searchInRequests" method="post">
                    <div class="input-group mb-3">
                        <input type="text" name="value" class="form-control" placeholder="Tìm kiếm trong danh sách lời mời..." aria-label="Recipient's username" aria-describedby="button-addon2">
                        <button class="btn btn-outline-secondary" type="submit" id="button-addon2">Tìm</button>
                    </div>
                </form>
            </div>
            <div class="row">
                <c:if test="${friends.size() != 0}">
                    <c:forEach var="friend" items="${friends}" varStatus="status">
                        <div class="col-md-2 mb-4">
                            <div class="card text-center">
                                <img src="${pageContext.request.contextPath}/uploads/avatars/${friend.image}"
                                     class="card-img-top" alt="Avatar">
                                <div class="card-body">
                                    <h6 class="card-title">${friend.name}</h6>
                                    <button style="width: 100%; margin-bottom: 5px;" class="btn btn-primary btn-sm">Xác
                                        nhận
                                    </button>
                                    <button style="width: 100%" class="btn btn-secondary btn-sm">Xóa</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${friends.size() == 0 && action != 'requests'}">
                    <p>Không có lời mời kết bạn nào</p>
                </c:if>
                <c:if test="${friends.size() == 0 && action == 'requests'}">
                    <p>Không tìm thấy kết quả phù hợp</p>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
</html>
