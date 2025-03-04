<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script src="${pageContext.request.contextPath}/js/AcceptFriend.js"></script>

<div class="notification-header">
    <b>Thông báo</b>
    <div>...</div>
</div>
<c:if test="${empty notifications}">
    <div class="notification-content">
        <p>Không có thông báo nào</p>
    </div>
</c:if>
<c:forEach var="userNotification" items="${usersNotification}" varStatus="status">
    <c:set var="notification" value="${notifications[status.index]}" />
    <c:set var="activity" value="${activities[status.index]}" />

    <div class="notification-content">
        <div class="notification-item">
            <img src="${pageContext.request.contextPath}/uploads/avatars/${userNotification.image}"
                 alt="Avatar">
        </div>

        <c:choose>
            <c:when test="${activity.type == 'friendship_request'}">
                <div class="notification-text"><b>${userNotification.name}</b> đã gửi cho bạn lời mời kết bạn</div>
                <div class="notification-actions" id="actions-${userNotification.userId}">
                    <a class="btn btn-primary btn-sm accept-search" data-id="${userNotification.userId}"
                       onclick="acceptFriends(event, ${userNotification.userId}, ${activity.activityId})">Chấp nhận</a>
                    <a class="btn btn-primary btn-sm cancel-friend-search" data-id="${user.userId}"
                       onclick="cancelFriends(event,${userNotification.userId} ,${activity.targetId}, ${activity.activityId})">Xóa</a>
                </div>
            </c:when>

            <c:when test="${activity.type == 'like_post'}">
                <div class="notification-text"><b>${userNotification.name}</b> thích bài viết của bạn</div>
            </c:when>

            <c:when test="${activity.type == 'like_comment'}">
                <div class="notification-text"><b>${userNotification.name}</b> thích bình luận của bạn</div>
            </c:when>
        </c:choose>
    </div>
</c:forEach>
