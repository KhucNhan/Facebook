<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 2/25/2025
  Time: 8:39 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="menu">
    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
    %>
    <script>
        showError("<%= errorMessage.replace("\"", "\\\"").replace("\n", "\\n") %>");
    </script>

    <%
        }

        HttpSession session1 = request.getSession();
        String successMessage = (String) session1.getAttribute("successMessage");
        if (successMessage != null) {
            session1.removeAttribute("successMessage");
    %>
    <script>
        showSuccess("<%= successMessage.replace("\"", "\\\"").replace("\n", "\\n") %>");
    </script>
    <%
            session.removeAttribute("successMessage");
        }
    %>

    <!-- Logo Facebook -->
    <svg onclick="loadHome()" xmlns="http://www.w3.org/2000/svg" width="40" height="45" fill="currentColor"
         class="bi bi-facebook"
         viewBox="0 0 16 16" style="color: #0866ff; margin-right: 20px;">
        <path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951"/>
    </svg>

    <!-- Ô tìm kiếm -->
    <form style="margin: 0" class="search-container" action="/users?action=userSearchUsers" method="post">
        <input id="searchInputNav" name="value" value="${searchValue != null ? searchValue : ''}" type="text"
               placeholder="Tìm kiếm trên Facebook">
        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="silver" class="bi bi-search iconFacebook"
             viewBox="0 0 16 16">
            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
        </svg>
    </form>

    <div class="menuCenter">
        <div class="home">
            <svg onclick="loadHome()" xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="silver"
                 class="bi bi-house-door-fill iconHome" viewBox="0 0 16 16">
                <path d="M6.5 14.5v-3.505c0-.245.25-.495.5-.495h2c.25 0 .5.25.5.5v3.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 .5-.5"/>
            </svg>
        </div>
        <div class="people" onclick="goToFriends()">
            <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="silver"
                 class="bi bi-people-fill iconPeople" viewBox="0 0 16 16">
                <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6m-5.784 6A2.24 2.24 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.3 6.3 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1zM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5"/>
            </svg>
        </div>
    </div>
    <div class="menuRight">
        <div>
            <div id="notificationMessage" style="position: relative; display: inline-block;">
                <svg viewBox="0 0 12 13" width="35" height="35" fill="silver" onclick="gotoNotificationMess(event)"
                     id="iconMessage"
                     class="xfx01vb x1lliihq x1tzjh5l x1k90msu x2h7rmj x1qfuztq iconMessage">
                    <g fill-rule="evenodd" transform="translate(-450 -1073)">
                        <path d="m459.603 1077.948-1.762 2.851a.89.89 0 0 1-1.302.245l-1.402-1.072a.354.354 0 0 0-.433.001l-1.893 1.465c-.253.196-.583-.112-.414-.386l1.763-2.851a.89.89 0 0 1 1.301-.245l1.402 1.072a.354.354 0 0 0 .434-.001l1.893-1.465c.253-.196.582.112.413.386M456 1073.5c-3.38 0-6 2.476-6 5.82 0 1.75.717 3.26 1.884 4.305.099.087.158.21.162.342l.032 1.067a.48.48 0 0 0 .674.425l1.191-.526a.473.473 0 0 1 .32-.024c.548.151 1.13.231 1.737.231 3.38 0 6-2.476 6-5.82 0-3.344-2.62-5.82-6-5.82"></path>
                    </g>
                </svg>
                <div class="notificationMess-container" id="notificationMess"
                     style="display: none; position: absolute; top: 40px; right: -115px;height: 40em">
                    <jsp:include page="NotificationMess.jsp"></jsp:include>
                </div>
            </div>
        </div>
        <div>
            <div id="notificationIcon" style="position: relative; display: inline-block;">
                <svg viewBox="0 0 24 24" width="35" height="35" fill="silver" onclick="gotoNotification(event)"
                     id="iconTB"
                     class="xfx01vb x1lliihq x1tzjh5l x1k90msu x2h7rmj x1qfuztq iconTB">
                    <path d="M3 9.5a9 9 0 1 1 18 0v2.927c0 1.69.475 3.345 1.37 4.778a1.5 1.5 0 0 1-1.272 2.295h-4.625a4.5 4.5 0 0 1-8.946 0H2.902a1.5 1.5 0 0 1-1.272-2.295A9.01 9.01 0 0 0 3 12.43V9.5zm6.55 10a2.5 2.5 0 0 0 4.9 0h-4.9z"></path>
                </svg>
                <div class="notification-container" id="notification"
                     style="display: none; position: absolute; top: 40px; right: -60px;height: 40em">
                    <jsp:include page="Notification.jsp"></jsp:include>
                </div>
            </div>
        </div>
        <div style="width: 35px;height: 35px">
            <div id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                           aria-expanded="false">
                            <img src="${pageContext.request.contextPath}/uploads/avatars/${user.image}"
                                 alt="User Icon" width="37" height="37"
                                 style="border-radius: 50%;margin-top: -10px;margin-right: -20px;position: relative">
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/users?action=userUpdateInformation">Cập nhật thông tin
                                cá nhân</a></li>
                            <li><a class="dropdown-item" href="/users?action=changePassword">Đổi mật khẩu</a></li>
                            <li><a class="dropdown-item" href="/users?action=delete">Xóa tài khoản</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" onclick="confirmLogout()">Đăng xuất</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

