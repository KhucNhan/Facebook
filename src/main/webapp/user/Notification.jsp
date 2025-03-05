<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<script src="${pageContext.request.contextPath}/js/AcceptFriend.js"></script>
<script src="${pageContext.request.contextPath}/js/Notification.js"></script>

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
    <c:set var="notification" value="${notifications[status.index]}"/>
    <c:set var="activity" value="${activities[status.index]}"/>
    <c:if test="${activity.type ne 'message'}">
        <div class="notification-content ${notification.getIsRead() ? 'read' : 'unread'}"
             onclick="updateIsReadNotification(event, ${notification.getNotificationId()},${notification.getIsRead()})"
             data-id="${notification.getNotificationId()}">
            <div class="notification-item">
                <img src="${pageContext.request.contextPath}/img/avatars/${userNotification.image}"
                     alt="Avatar">
                <c:if test="${!notification.getIsRead()}">
                    <div class="readAndUnRead">
                        <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" fill="#007bff"
                             style="margin-bottom: -12px; margin-left: 200px;"
                             class="bi bi-dot" viewBox="0 0 16 16">
                            <path d="M8 9.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3"/>
                        </svg>
                    </div>
                </c:if>
            </div>


            <c:choose>
                <c:when test="${activity.type == 'friendship_request'}">
                    <div class="notification-text"><b>${userNotification.name}</b> đã gửi cho bạn lời mời kết bạn</div>
                    <div class="notification-time"
                         data-time="<fmt:formatDate value="${activity.createAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" />">
                    </div>
                    <div class="notification-actions" id="actions-${userNotification.userId}">
                        <a class="btn btn-primary btn-sm accept-search" data-id="${userNotification.userId}"
                           onclick="acceptFriends(event, ${userNotification.userId}, ${activity.activityId})">Chấp
                            nhận</a>
                        <a class="btn btn-primary btn-sm cancel-friend-search" data-id="${user.userId}"
                           onclick="cancelFriends(event,${userNotification.userId} ,${activity.targetId}, ${activity.activityId})">Xóa</a>
                    </div>
                </c:when>
                <c:when test="${activity.type == 'accepted'}">
                    <div class="notification-text"><b>${userNotification.name}</b> đã chấp nhận lời mời kết bạn của bạn
                    </div>
                    <div class="notification-time"
                         data-time="<fmt:formatDate value="${activity.createAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" />">
                    </div>

                </c:when>


                <c:when test="${activity.type == 'like_post'}">
                    <div class="notification-text"><b>${userNotification.name}</b> thích bài viết của bạn</div>
                    <div class="notification-time"
                         data-time="<fmt:formatDate value="${activity.createAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" />">
                    </div>
                </c:when>

                <c:when test="${activity.type == 'like_comment'}">
                    <div class="notification-text"><b>${userNotification.name}</b> thích bình luận của bạn</div>
                    <div class="notification-time"
                         data-time="<fmt:formatDate value="${activity.createAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" />">
                    </div>
                </c:when>
                <c:when test="${activity.type == 'comment'}">
                    <div class="notification-text"><b>${userNotification.name}</b> đã bình luận bài viết của bạn</div>
                    <div class="notification-time"
                         data-time="<fmt:formatDate value="${activity.createAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" />">
                    </div>
                </c:when>
            </c:choose>
        </div>
    </c:if>
</c:forEach>

