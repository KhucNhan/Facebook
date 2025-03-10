<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<script src="${pageContext.request.contextPath}/js/AcceptFriend.js"></script>
<script src="${pageContext.request.contextPath}/js/Notification.js"></script>

<div class="notificationMess-header">
    <b>Tin nhắn</b>
    <div>...</div>
</div>
<c:if test="${empty notifications}">
    <div class="notificationMess-content">
        <p>Không có tin nhắn nào</p>
    </div>
</c:if>


<c:forEach var="userNotification" items="${usersNotification}" varStatus="status">
    <c:set var="notification" value="${notifications[status.index]}"/>
    <c:set var="activity" value="${activities[status.index]}"/>


    <c:if test="${activity.type == 'message'}">
        <div class="notificationMess-content ${notification.getIsRead() ? 'read' : 'unread'}"
             onclick="updateIsReadNotificationMess(event, ${notification.getNotificationId()},${notification.getIsRead()})"
             data-id="${notification.getNotificationId()}">
            <div class="notificationMess-item">
                <img src="${pageContext.request.contextPath}/img/avatars/${userNotification.image}"
                     alt="Avatar">
                <c:if test="${!notification.getIsRead()}">
                    <div class="readAndUnRead">
                        <svg xmlns="http://www.w3.org/2000/svg" width="60" height="60" fill="#007bff"
                             style="margin-bottom: -10px; margin-left: 200px;"
                             class="bi bi-dot" viewBox="0 0 16 16">
                            <path d="M8 9.5a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3"/>
                        </svg>
                    </div>
                </c:if>
            </div>
            <c:choose>
                <c:when test="${activity.type == 'message'}">
                    <div class="notificationMess-text ${notification.getIsRead() ? 'read' : 'unread'}">
                        <b>${userNotification.name}</b></div>
                    <c:if test="${messageNotifications[status.index].getSenderId() != activity.targetId}">
                                <span class="message-text">
                                   <p>${messageNotifications[status.index].getContent()}</p>
                                </span>
                    </c:if>

                    <div class="notificationMess-time"
                         data-time="<fmt:formatDate value="${activity.createAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" />">
                    </div>
                </c:when>
            </c:choose>
        </div>
    </c:if>
</c:forEach>
