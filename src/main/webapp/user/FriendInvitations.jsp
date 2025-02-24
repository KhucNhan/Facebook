<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ThinkpadX1
  Date: 2/24/2025
  Time: 3:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lời mời kết bạn</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
            display: flex;
        }
        .sidebar {
            width: 350px;
            background: white;
            padding: 15px;
            border-right: 1px solid #ddd;
            height: 100vh;
            overflow-y: auto;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }
        .friend-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .friend-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px;
            border-bottom: 1px solid #ddd;
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
        }
        .friend-info {
            flex-grow: 1;
        }
        .friend-actions button {
            background: #1877f2;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
            margin-left: 5px;
        }
        .friend-actions button.delete {
            background: #ccc;
            color: black;
        }
        .content {
            flex-grow: 1;
            background: #f0f2f5;
            display: flex;
            align-items: center;
            justify-content: center;
            color: gray;
            font-size: 18px;
        }

    </style>
</head>
<body>
<div class="sidebar">
            <div  class="friend-item">
                <img src="" alt="image">
                <div class="friend-info">
                    <p></p>
                </div>
                <div class="friend-actions">
                    <button>Xác nhận </button>
                    <button class="delete">Xoá</button>
                </div>
            </div>
</div>

</body>
</html>
