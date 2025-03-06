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
    <c:if test="${activity.type != 'message'}">

        <div class="notification-content ${notification.getIsRead() ? 'read' : 'unread'}" style="height: 90px"
             onclick="updateIsReadNotification(event, ${notification.getNotificationId()},${notification.getIsRead()})"
             data-id="${notification.getNotificationId()}">
            <div class="notification-item">
                <img src="${pageContext.request.contextPath}/uploads/avatars/${userNotification.image}"
                     alt="Avatar">

                <c:choose>
                    <c:when test="${activity.type == 'like_post'}">
                        <img style="border: 0px;width: 30px;height: 30px;margin-left: -30px;margin-bottom: -30px"
                             src="data:image/svg+xml,%3Csvg fill='none' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3E%3Cpath d='M16.0001 7.9996c0 4.418-3.5815 7.9996-7.9995 7.9996S.001 12.4176.001 7.9996 3.5825 0 8.0006 0C12.4186 0 16 3.5815 16 7.9996Z' fill='url(%23paint0_linear_15251_63610)'/%3E%3Cpath d='M16.0001 7.9996c0 4.418-3.5815 7.9996-7.9995 7.9996S.001 12.4176.001 7.9996 3.5825 0 8.0006 0C12.4186 0 16 3.5815 16 7.9996Z' fill='url(%23paint1_radial_15251_63610)'/%3E%3Cpath d='M16.0001 7.9996c0 4.418-3.5815 7.9996-7.9995 7.9996S.001 12.4176.001 7.9996 3.5825 0 8.0006 0C12.4186 0 16 3.5815 16 7.9996Z' fill='url(%23paint2_radial_15251_63610)' fill-opacity='.5'/%3E%3Cpath d='M7.3014 3.8662a.6974.6974 0 0 1 .6974-.6977c.6742 0 1.2207.5465 1.2207 1.2206v1.7464a.101.101 0 0 0 .101.101h1.7953c.992 0 1.7232.9273 1.4917 1.892l-.4572 1.9047a2.301 2.301 0 0 1-2.2374 1.764H6.9185a.5752.5752 0 0 1-.5752-.5752V7.7384c0-.4168.097-.8278.2834-1.2005l.2856-.5712a3.6878 3.6878 0 0 0 .3893-1.6509l-.0002-.4496ZM4.367 7a.767.767 0 0 0-.7669.767v3.2598a.767.767 0 0 0 .767.767h.767a.3835.3835 0 0 0 .3835-.3835V7.3835A.3835.3835 0 0 0 5.134 7h-.767Z' fill='%23fff'/%3E%3Cdefs%3E%3CradialGradient id='paint1_radial_15251_63610' cx='0' cy='0' r='1' gradientUnits='userSpaceOnUse' gradientTransform='rotate(90 .0005 8) scale(7.99958)'%3E%3Cstop offset='.5618' stop-color='%230866FF' stop-opacity='0'/%3E%3Cstop offset='1' stop-color='%230866FF' stop-opacity='.1'/%3E%3C/radialGradient%3E%3CradialGradient id='paint2_radial_15251_63610' cx='0' cy='0' r='1' gradientUnits='userSpaceOnUse' gradientTransform='rotate(45 -4.5257 10.9237) scale(10.1818)'%3E%3Cstop offset='.3143' stop-color='%2302ADFC'/%3E%3Cstop offset='1' stop-color='%2302ADFC' stop-opacity='0'/%3E%3C/radialGradient%3E%3ClinearGradient id='paint0_linear_15251_63610' x1='2.3989' y1='2.3999' x2='13.5983' y2='13.5993' gradientUnits='userSpaceOnUse'%3E%3Cstop stop-color='%2302ADFC'/%3E%3Cstop offset='.5' stop-color='%230866FF'/%3E%3Cstop offset='1' stop-color='%232B7EFF'/%3E%3C/linearGradient%3E%3C/defs%3E%3C/svg%3E">
                    </c:when>
                    <c:when test="${activity.type == 'like_comment'}">
                        <img style="border: 0px;width: 30px;height: 30px;margin-left: -30px;margin-bottom: -30px"
                             src="data:image/svg+xml,%3Csvg fill='none' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3E%3Cpath d='M16.0001 7.9996c0 4.418-3.5815 7.9996-7.9995 7.9996S.001 12.4176.001 7.9996 3.5825 0 8.0006 0C12.4186 0 16 3.5815 16 7.9996Z' fill='url(%23paint0_linear_15251_63610)'/%3E%3Cpath d='M16.0001 7.9996c0 4.418-3.5815 7.9996-7.9995 7.9996S.001 12.4176.001 7.9996 3.5825 0 8.0006 0C12.4186 0 16 3.5815 16 7.9996Z' fill='url(%23paint1_radial_15251_63610)'/%3E%3Cpath d='M16.0001 7.9996c0 4.418-3.5815 7.9996-7.9995 7.9996S.001 12.4176.001 7.9996 3.5825 0 8.0006 0C12.4186 0 16 3.5815 16 7.9996Z' fill='url(%23paint2_radial_15251_63610)' fill-opacity='.5'/%3E%3Cpath d='M7.3014 3.8662a.6974.6974 0 0 1 .6974-.6977c.6742 0 1.2207.5465 1.2207 1.2206v1.7464a.101.101 0 0 0 .101.101h1.7953c.992 0 1.7232.9273 1.4917 1.892l-.4572 1.9047a2.301 2.301 0 0 1-2.2374 1.764H6.9185a.5752.5752 0 0 1-.5752-.5752V7.7384c0-.4168.097-.8278.2834-1.2005l.2856-.5712a3.6878 3.6878 0 0 0 .3893-1.6509l-.0002-.4496ZM4.367 7a.767.767 0 0 0-.7669.767v3.2598a.767.767 0 0 0 .767.767h.767a.3835.3835 0 0 0 .3835-.3835V7.3835A.3835.3835 0 0 0 5.134 7h-.767Z' fill='%23fff'/%3E%3Cdefs%3E%3CradialGradient id='paint1_radial_15251_63610' cx='0' cy='0' r='1' gradientUnits='userSpaceOnUse' gradientTransform='rotate(90 .0005 8) scale(7.99958)'%3E%3Cstop offset='.5618' stop-color='%230866FF' stop-opacity='0'/%3E%3Cstop offset='1' stop-color='%230866FF' stop-opacity='.1'/%3E%3C/radialGradient%3E%3CradialGradient id='paint2_radial_15251_63610' cx='0' cy='0' r='1' gradientUnits='userSpaceOnUse' gradientTransform='rotate(45 -4.5257 10.9237) scale(10.1818)'%3E%3Cstop offset='.3143' stop-color='%2302ADFC'/%3E%3Cstop offset='1' stop-color='%2302ADFC' stop-opacity='0'/%3E%3C/radialGradient%3E%3ClinearGradient id='paint0_linear_15251_63610' x1='2.3989' y1='2.3999' x2='13.5983' y2='13.5993' gradientUnits='userSpaceOnUse'%3E%3Cstop stop-color='%2302ADFC'/%3E%3Cstop offset='.5' stop-color='%230866FF'/%3E%3Cstop offset='1' stop-color='%232B7EFF'/%3E%3C/linearGradient%3E%3C/defs%3E%3C/svg%3E">
                    </c:when>
                    <c:when test="${activity.type == 'friendship_request'}">

                    </c:when>
                    <c:when test="${activity.type == 'comment'}">
                        <img style="border: 0px;width: 30px;height: 30px;margin-left: -30px;margin-bottom: -30px"
                             src="data:image/svg+xml;base64,PHN2ZyBzdHlsZT0iYm9yZGVyOiAwcHg7IHdpZHRoOiA2MHB4OyBoZWlnaHQ6IDYwcHg7IiBmaWxsPSJub25lIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxMSAxMSI+PHBhdGggZD0iTTAgMGgxMXYxMUgweiIgZmlsbD0ibm9uZSIvPjxjaXJjbGUgY3g9IjUuNSIgY3k9IjUuNSIgcj0iNS41IiBmaWxsPSIjNTFjZTcwIi8+PHBhdGggZD0iTTMgM2g1Yy41IDAgLjUuNSAuNS41djNjMCAuNS0uNS41LS41LjVINC41bC0yIDJWNGMwLS41IC41LS41IC41LS41eiIgZmlsbD0id2hpdGUiLz48L3N2Zz4=" />
                    </c:when>
                </c:choose>

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
