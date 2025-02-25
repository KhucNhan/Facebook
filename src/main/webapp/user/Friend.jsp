<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>--%>
<%--
  Created by IntelliJ IDEA.
  User: ThinkpadX1g
  Date: 2/24/2025
  Time: 11:20 AM
  To cha<nge this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách bạn bè</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
            display: flex;
        }
        /* Sidebar bên trái */
        .sidebar {
            width: 300px;
            background: white;
            padding: 15px;
            border-right: 1px solid #ddd;
            height: 100vh;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }
        .search-box {
            width: 100%;
            padding: 10px;
            border-radius: 20px;
            border: 1px solid #ccc;
            outline: none;
            font-size: 14px;
            margin-bottom: 15px;
        }
        .tabs {
            display: flex;
            border-bottom: 1px solid #ddd;
            margin-bottom: 10px;
        }
        .tab-btn {
            flex: 1;
            padding: 10px;
            text-align: center;
            cursor: pointer;
            font-weight: bold;
            background: #f0f0f0;
            border: none;
            outline: none;
            transition: 0.3s;
        }
        .tab-btn.active {
            background: #1877f2;
            color: white;
        }
        .friend-list {
            list-style: none;
            padding: 0;
            margin: 0;
            max-height: 80vh;
            overflow-y: auto;
        }
        .friend-item {
            display: flex;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #ddd;
            cursor: pointer;
            transition: background 0.2s;
        }

        .friend-item:hover {
            background: #f0f0f0;
        }

        .friend-item img {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            margin-right: 10px;
            background: #ccc; /* Placeholder */
        }

        .friend-item span {
            font-size: 16px;
            color: #333;
        }

        /* Ẩn danh sách bạn bè mặc định */
        .friend-container {
            display: none;
        }

        .friend-container.active {
            display: block;
        }
    </style>


</head>
<body>
<div class="sidebar">
    <div class="tabs">
        <button class="tab-btn active" onclick="showTab('friends')">Bạn bè</button>
        <button class="tab-btn" onclick="showTab('all-friends')">Tất cả bạn bè</button>
    </div>
    <input type="text" class="search-box" placeholder="Tìm kiếm bạn bè...">
    <ul class="friend-list">
        <c:forEach var="friend" items="${friends}">
            <li class="friend-item">
                <img src="${friend.image}" alt="image">
                <span>${friend.name}</span>
            </li>
        </c:forEach>

    </ul>

</div>
<%--<c:forEach var="friend" items="${friends}">--%>
<%--    <div>--%>
<%--        <img src="${friend.image}" alt="image" style="width: 70px; height: 70px; border-radius: 50%;">--%>
<%--        <p>${friend.name}</p>--%>
<%--    </div>--%>
<%--</c:forEach>--%>




</body>
</html>
