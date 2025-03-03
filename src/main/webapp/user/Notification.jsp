<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 3/1/2025
  Time: 3:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="notification-header">
    <b>Thông báo</b>
    <div>...</div>
</div>

<div class="notification-content">
    <div class="notification-item">
        <img src="${pageContext.request.contextPath}/uploads/avatars/${user.image}" alt="Avatar">
        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
             style="margin-left: -25px;margin-top: 15px;margin-right: 7px" fill="#0866ff"
             class="bi bi-people-fill" viewBox="0 0 16 16">
            <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6m-5.784 6A2.24 2.24 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.3 6.3 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1zM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5"/>
        </svg>
    </div>
    <div class="notification-text"><b>${user.name}</b> đã gửi cho bạn lời mời kết bạn</div>

    <div class="notification-actions">
        <a class="accept-search" data-id="${user.userId}" onclick="acceptFriendSearch(${user.userId})">Chấp nhận</a>
        <a class="cancel-friend-search" data-id="${user.userId}" onclick="cancelFriend(${user.userId})">Xóa</a>
    </div>
<%--    <div class="notification-text"><b>${user.name}</b>thích bài viết của bạn </div>--%>
<%--    <div class="notification-text"><b>${user.name}</b></div>--%>

</div>
