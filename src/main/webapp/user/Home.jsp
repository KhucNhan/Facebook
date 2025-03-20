<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 2/17/2025
  Time: 4:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="${pageContext.request.contextPath}/js/AcceptFriend.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Notification.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Nav3.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Post.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/PostModal.css">
    <script src="${pageContext.request.contextPath}/js/PostModal.js"></script>
    <script src="${pageContext.request.contextPath}/js/Nav3.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous">
    </script>
    <link href="${pageContext.request.contextPath}/css/LikePost.css">
    <script src="${pageContext.request.contextPath}/js/LikePost.js"></script>
    <!--     <link href="/css/LikePost.css"> -->
    <!--     <script src="/js/LikePost.js"></script> -->
    <script src="/js/LikeComment.js"></script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="${pageContext.request.contextPath}/js/Notification.js"></script>
    <script>
        function showError(message) {
            Swal.fire({
                icon: "error",
                title: "Lỗi!",
                text: message,
                timer: 1500,
                showConfirmButton: false
            });
        }

        function showSuccess(message) {
            Swal.fire({
                title: message,
                icon: "success",
                draggable: true,
                timer: 1500,
                showConfirmButton: false
            });
        }
    </script>

    <title>Facebook</title>
</head>
<body>
<div id="includeNewPost" style="display: none;">
    <div id="popup-content" style="width: 30%;margin-left: 1%;margin-top:1%;background: white; border-radius: 10px;">
        <jsp:include page="NewPost.jsp"/>
    </div>
</div>
<jsp:include page="Nav3.jsp"></jsp:include>
<div style="display: flex;height: 90%;">
    <div class="left">
        <div class="leftIcon" style="justify-content: left" onclick="goToMyProfile(${user.userId})">
            <div>
                <img src="${pageContext.request.contextPath}/uploads/avatars/${user.image}"
                     alt="User Icon" width="50" height="50" style="object-fit: cover;border-radius: 50%;">
            </div>
            <div>
                <b>
                    ${user.name}
                </b>
            </div>
        </div>
        <div class="leftIcon" style="justify-content: left" onclick="goToFriends()">
            <div>
                <svg xmlns="http://www.w3.org/2000/svg" width="45" height="45" style=""
                     class="bi bi-people-fill iconPeople"
                     viewBox="0 0 16 16">
                    <defs>
                        <linearGradient id="gradient1" x1="0%" y1="0%" x2="0%" y2="100%">
                            <stop offset="0%" style="stop-color:#0badf6; stop-opacity:1"/>
                            <stop offset="100%" style="stop-color:#7ec9ff; stop-opacity:1"/>
                        </linearGradient>
                    </defs>
                    <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6m-5.784 6A2.24 2.24 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.3 6.3 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1zM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5"
                          fill="url(#gradient1)"/>
                </svg>
            </div>
            <div>
                <b style="">
                    Bạn bè
                </b>
            </div>
        </div>
    </div>
    <div class="center" style="overflow-y: auto;">
        <form action="">
            <div class="addPost">
                <div>
                    <img src="${pageContext.request.contextPath}/uploads/avatars/${user.image}"
                         alt="User Icon" width="60" height="60" style="object-fit: cover;border-radius: 50%">
                </div>
                <div class="addPostInput" style="width: 100%">
                    <input type="button" style="text-align: left;padding-left: 15px" id="postInput" onclick="newPost()"
                           value="Bạn đang nghĩ gì thế?">
                </div>
            </div>
        </form>

        <div class="post-container">
            <c:forEach items="${posts}" var="post">
                <div class="post-card" style="<c:if test="${post.content == 'Bài viết này đã vi phạm tiêu chuẩn cộng đồng.' ? 'background-color: #ebebeb;' : ''}"/>" data-post-id="${post.getPostId()}">
                    <div class="introduce" style="display: flex; justify-content: space-between">
                        <div style="display: flex">
                            <img src="${pageContext.request.contextPath}/uploads/avatars/${post.user.image}"
                                 style="object-fit: cover;height: 50px;width: 50px; border-radius: 50%">
                            <div style="display: flex; flex-direction: column; margin-left: 10px">
                                <div style="height: 20px;">
                                    <a style="font-weight: bold; color: black">${post.user.name}</a>
                                </div>
                                <div>
                                    <p style="color: lightgrey">${post.createAt}</p>
                                </div>
                            </div>
                        </div>
                        <c:if test="${post.content != 'Bài viết này đã vi phạm tiêu chuẩn cộng đồng.'}">
                            <div style="display: flex;">
                                <div>
                                    <div>
                                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                            <li class="nav-item dropdown">
                                                <a style="margin-top: -10px;font-size: 20px;width: 20px;overflow: hidden;"
                                                   class="nav-link dropdown-toggle" href="#" role="button"
                                                   data-bs-toggle="dropdown"
                                                   aria-expanded="false">
                                                    ...
                                                </a>
                                                <ul class="dropdown-menu">
                                                    <h1></h1>

                                                    <c:if test="${post.user.userId == user.userId}">
                                                        <li><a class="dropdown-item"
                                                               href="/posts?action=userEditPost&postId=${post.getPostId()}">Sửa
                                                            bài viết</a></li>
                                                    </c:if>
                                                    <c:if test="${post.user.userId == user.userId}">
                                                        <li>
                                                            <a class="dropdown-item delete-link"
                                                               href="/posts?action=deletePost&postId=${post.getPostId()}">Xóa
                                                            </a>
                                                        </li>
                                                    </c:if>
                                                    <c:if test="${post.user.userId != user.userId}">
                                                        <li>
                                                            <button onclick="reportPost(${post.postId}, event)" style="border: none;height: fit-content;width: fit-content" class="dropdown-item">
                                                                Báo cáo bài viết
                                                            </button>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                    <div class="content" onclick="showPostPopup('${post.getPostId()}')">
                        <p>${post.content}</p>
                    </div>
                    <div class="media-area" onclick="showPostPopup('${post.getPostId()}')">
                        <c:forEach items="${post.mediaUrls}" var="media">
                            <div style="height: fit-content" class="media" data-url="${media.url}"
                                 data-type="${media.type}"></div>
                        </c:forEach>
                    </div>
                    <c:set var="isLiked" value="${likedPosts[post.postId]}"/>
                    <div class="post-information"
                         style="display: flex;margin-top: 15px;padding-top: 5px;border-top: 1px solid lightgray;">
                        <a style="margin-right: 15px;" href="javascript:void(0);"
                           class="like-btn ${isLiked ? 'liked' : ''}" data-post-id="${post.getPostId()}">
                            <svg style="margin-top: -5px;margin-right: -5px" xmlns="http://www.w3.org/2000/svg"
                                 width="25" height="20" fill="currentColor"
                                 class="bi bi-hand-thumbs-up-fill" viewBox="0 0 16 16">
                                <path d="M6.956 1.745C7.021.81 7.908.087 8.864.325l.261.066c.463.116.874.456 1.012.965.22.816.533 2.511.062 4.51a10 10 0 0 1 .443-.051c.713-.065 1.669-.072 2.516.21.518.173.994.681 1.2 1.273.184.532.16 1.162-.234 1.733q.086.18.138.363c.077.27.113.567.113.856s-.036.586-.113.856c-.039.135-.09.273-.16.404.169.387.107.819-.003 1.148a3.2 3.2 0 0 1-.488.901c.054.152.076.312.076.465 0 .305-.089.625-.253.912C13.1 15.522 12.437 16 11.5 16H8c-.605 0-1.07-.081-1.466-.218a4.8 4.8 0 0 1-.97-.484l-.048-.03c-.504-.307-.999-.609-2.068-.722C2.682 14.464 2 13.846 2 13V9c0-.85.685-1.432 1.357-1.615.849-.232 1.574-.787 2.132-1.41.56-.627.914-1.28 1.039-1.639.199-.575.356-1.539.428-2.59z"/>

                            </svg>
                            Thích
                            <span id="total-emotion-${post.postId}" class="like-count"> ${post.totalEmotions}</span>
                        </a>
                        <a onclick="showPostPopup('${post.getPostId()}')">

                            <svg style="margin-top: -5px;margin-right: -3px" xmlns="http://www.w3.org/2000/svg"
                                 width="25" height="20" fill="currentColor"
                                 class="bi bi-chat-fill" viewBox="0 0 16 16">
                                <path d="M8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6-.097 1.016-.417 2.13-.771 2.966-.079.186.074.394.273.362 2.256-.37 3.597-.938 4.18-1.234A9 9 0 0 0 8 15"/>
                            </svg>
                            Bình luận
                            <span id="total-comment-${post.postId}">${post.totalComments}</span>
                        </a>
                    </div>
                    <div class="function">

                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <div class="right">
        <div class="rightMenu">
            <div style="width: 170px" id="contactLabel">
                <label>Người liên hệ</label>
            </div>
            <div id="search-contact-container" style="display: none;">
                <input type="text" id="searchContactInput" placeholder="Tìm kiếm"
                       style="padding: 5px; border-radius: 5px; border: 0px solid #e8e8e8;width: 180px;background: #ececec">
            </div>
            <div class="searchBB" id="search-input-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="20" fill="currentColor" class="bi bi-search"
                     viewBox="0 0 16 16" onclick="showSearchInput()">
                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                </svg>
            </div>

            <div style="margin-bottom: 15px;font-size: 1em;margin-left: 10px">
                <span>...</span>
            </div>
        </div>
        <div>
            <c:forEach items="${usersFriendShip}" var="user">
                <a class="friends"
                   onclick="loadMessages(${user.userId}, 'user', '${user.name}', '${pageContext.request.contextPath}/uploads/avatars/${user.image}')">
                    <div class="left_bottom">
                        <div>
                            <img src="${pageContext.request.contextPath}/uploads/avatars/${user.image}"
                                 alt="User Icon" width="50" height="50" style="object-fit: cover;border-radius: 50%;">
                        </div>
                        <div style="margin-left: 20px;width: 100%">
                            <label>${user.name}</label>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
        <hr>
        <div class="rightMenu">
            <div style="width: 170px" id="groupLabel">
                <label>Nhóm</label>
            </div>
            <div id="search-container" style="display: none;">
                <input type="text" id="searchGroupInput" placeholder="Tìm kiếm"
                       style="padding: 5px; border-radius: 5px; border: 0px solid #e8e8e8;width: 180px;background: #ececec">
            </div>
            <button class="btn btn-primary" id="openCreateGroupModal">Tạo nhóm</button>

            <div style="margin-bottom: 15px;font-size: 1em;margin-left: 10px">
                <span>...</span>
            </div>
        </div>
        <div>
            <c:choose>
                <c:when test="${groups.size() > 0}">
                    <c:forEach items="${groups}" var="group">
                        <a class="groups"
                           onclick="loadMessages(${group.groupId}, 'group', '${group.name}', '${pageContext.request.contextPath}/img/group_avatars/${group.image}')">
                            <div class="left_bottom">
                                <div>
                                    <img src="${pageContext.request.contextPath}/img/group_avatars/${group.image}"
                                         alt="Group Icon" width="50" height="50" style="object-fit: cover;border-radius: 50%;">
                                </div>
                                <div style="margin-left: 20px;width: 100%">
                                    <label>${group.name}</label>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </c:when>
                <c:when test="${groups.size() == 0}">
                    <p style="text-align: center">Không tham gia nhóm nào</p>
                </c:when>
            </c:choose>
        </div>
    </div>
</div>
<div id="chat-modal" style="height: 325px" class="modal">
    <div class="modal-content" style="height: 100%">
        <div id="chat-header" style="padding: 5px"></div>
        <div id="chat-messages"></div>
        <input type="hidden" id="receiverId">
        <div style="display: flex;padding: 5px 10px 5px 10px ; justify-content: space-between; position: relative;">
            <button style="width: fit-content;background: none;padding: 0" id="emoji-btn">😀</button>
            <input style="border-radius: 24px; padding-left: 10px; border: 1px solid grey; width: 65%;" type="text"
                   id="chat-input" placeholder="Nhập tin nhắn..." onfocus="updateNotificationStatus()">
            <button style="width: fit-content; padding-block: 1px" class="btn btn-primary" id="send-btn">Gửi</button>
        </div>
    </div>
    <a style="cursor: pointer;font-size: xx-large;position: absolute; bottom: 400px; left: 315px; border-radius: 50%;"
       onclick="closeChat()">x</a>
    <a id="settingGroup" onclick="groupSetting()" style="position: absolute;bottom: 408px; left: 275px; cursor: pointer">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-gear" viewBox="0 0 16 16">
            <path d="M8 4.754a3.246 3.246 0 1 0 0 6.492 3.246 3.246 0 0 0 0-6.492M5.754 8a2.246 2.246 0 1 1 4.492 0 2.246 2.246 0 0 1-4.492 0"/>
            <path d="M9.796 1.343c-.527-1.79-3.065-1.79-3.592 0l-.094.319a.873.873 0 0 1-1.255.52l-.292-.16c-1.64-.892-3.433.902-2.54 2.541l.159.292a.873.873 0 0 1-.52 1.255l-.319.094c-1.79.527-1.79 3.065 0 3.592l.319.094a.873.873 0 0 1 .52 1.255l-.16.292c-.892 1.64.901 3.434 2.541 2.54l.292-.159a.873.873 0 0 1 1.255.52l.094.319c.527 1.79 3.065 1.79 3.592 0l.094-.319a.873.873 0 0 1 1.255-.52l.292.16c1.64.893 3.434-.902 2.54-2.541l-.159-.292a.873.873 0 0 1 .52-1.255l.319-.094c1.79-.527 1.79-3.065 0-3.592l-.319-.094a.873.873 0 0 1-.52-1.255l.16-.292c.893-1.64-.902-3.433-2.541-2.54l-.292.159a.873.873 0 0 1-1.255-.52zm-2.633.283c.246-.835 1.428-.835 1.674 0l.094.319a1.873 1.873 0 0 0 2.693 1.115l.291-.16c.764-.415 1.6.42 1.184 1.185l-.159.292a1.873 1.873 0 0 0 1.116 2.692l.318.094c.835.246.835 1.428 0 1.674l-.319.094a1.873 1.873 0 0 0-1.115 2.693l.16.291c.415.764-.42 1.6-1.185 1.184l-.291-.159a1.873 1.873 0 0 0-2.693 1.116l-.094.318c-.246.835-1.428.835-1.674 0l-.094-.319a1.873 1.873 0 0 0-2.692-1.115l-.292.16c-.764.415-1.6-.42-1.184-1.185l.159-.291A1.873 1.873 0 0 0 1.945 8.93l-.319-.094c-.835-.246-.835-1.428 0-1.674l.319-.094A1.873 1.873 0 0 0 3.06 4.377l-.16-.292c-.415-.764.42-1.6 1.185-1.184l.292.159a1.873 1.873 0 0 0 2.692-1.115z"/>
        </svg>
    </a>
</div>
<div style="border-radius: 5px" id="message-menu" class="message-menu">
    <button style="width: fit-content;font-size: 12px;padding: 0;background-color: white" onclick="deleteMessage()">Gỡ
        tin nhắn
    </button>
</div>
<div id="emoji-picker" class="emoji-picker"></div>


<div id="createGroupModal" class="modal">
    <form class="modal-group-content" action="/groups?action=create" method="post">
        <span class="close">&times;</span>
        <h2>Tạo nhóm</h2>

        <!-- Nhập tên nhóm -->
        <label for="groupName">Tên nhóm:</label>
        <input type="text" name="groupName" id="groupName" placeholder="Nhập tên nhóm">

        <!-- Danh sách bạn bè -->
        <h3>Thêm thành viên:</h3>
        <div id="friendList">
            <c:forEach var="friend" items="${usersFriendShip}">
                <div class="friend-item">
                    <span>${friend.name} (${friend.email})</span>
                    <input type="checkbox" class="select-user" data-userid="${friend.userId}">
                </div>
            </c:forEach>
        </div>

        <!-- Nút tạo nhóm -->
        <button type="submit" id="createGroupButton">Tạo nhóm</button>
    </form>
</div>

<div id="modalOverlay"></div>

<form method="post" enctype="multipart/form-data" id="editGroupModal" style="display: none;" onsubmit="return editGroup(event)">
    <button type="button" class="close-btn" onclick="closeModal()">✖</button>
    <h3>Chỉnh sửa nhóm</h3>
    <input type="text" id="editGroupName" placeholder="Nhập tên nhóm mới">
    <input style="display:block;" name="editGroupImg" type="file" id="editGroupImg">
    <img style="display: none; width: 100px; height: 100px; border-radius: 50%; justify-self: center" id="editGroupImgPreview">
    <button type="submit">Lưu thay đổi</button>
</form>


</body>
</html>


<script>
    document.getElementById("editGroupImg").addEventListener("change", function(event) {
        let file = event.target.files[0]; // Lấy file đã chọn
        if (file) {
            let reader = new FileReader(); // Tạo FileReader để đọc file
            reader.onload = function(e) {
                document.getElementById("editGroupImgPreview").src = e.target.result; // Gán ảnh vào thẻ img
                document.getElementById("editGroupImgPreview").style.display = "block"; // Hiển thị ảnh
            };
            reader.readAsDataURL(file); // Đọc file dưới dạng URL
        }
    });


    function closeModal() {
        document.getElementById("modalOverlay").style.display = "none";
        document.getElementById("editGroupModal").style.display = "none";
    }

    function groupSetting() {
        let groupId = document.getElementById("settingGroup").getAttribute("data-group-id");

        if (!groupId) {
            alert("Không có nhóm nào để chỉnh sửa!");
            return;
        }

        // Hiển thị modal chỉnh sửa nhóm
        document.getElementById("editGroupModal").style.display = "block";
        document.getElementById("modalOverlay").style.display = "block";

        let nameInput = document.querySelector("input[name='groupNameHidden']");
        let imgInput = document.querySelector("input[name='groupImgHidden']");

        // Điền dữ liệu nhóm hiện tại vào input
        document.getElementById("editGroupName").value = nameInput.value;
        document.getElementById("editGroupImgPreview").src = '/img/group_avatars/' + imgInput.value;
    }

    function editGroup() {
        event.preventDefault(); // Ngăn form gửi request tự động

        let groupId = document.getElementById("settingGroup").getAttribute("data-group-id");
        let groupNameInput = document.getElementById("editGroupName").value;
        let groupImgInput = document.getElementById("editGroupImg").files[0]; // Lấy file ảnh

        if (!groupId || !groupNameInput) {
            alert("Vui lòng nhập đầy đủ thông tin!");
            return;
        }

        let formData = new FormData();
        formData.append("action", "edit");
        formData.append("groupId", groupId);
        formData.append("name", groupNameInput);
        if (groupImgInput) {
            formData.append("editGroupImg", groupImgInput);
        }

        fetch('/groups', {
            method: 'POST',
            body: formData
        })
            .then(response => {
                console.log("Response object:", response);
                return response.text();
            })  // Nhận phản hồi dạng text
            .then(data => {
                console.log("Server response:", data);
                let parts = data.split('|'); // Phân tách dữ liệu thành mảng

                let chatHeader = document.getElementById("chat-header");
                if (parts[0] === "success") {
                    chatHeader.innerHTML = `
                    <img src="/img/group_avatars/` + parts[1] + `" alt="Avatar" width="40" height="40" style="border-radius: 50%; margin-right: 10px;">
                    <span>` + groupNameInput + `</span>
                    `;

                    let groupElements = document.querySelectorAll(".groups");
                    groupElements.forEach(el => {
                        if (el.onclick.toString().includes(groupId)) {
                            let imgEl = el.querySelector("img");
                            let nameEl = el.querySelector("label");

                            let newImgSrc = '/img/group_avatars/' + parts[1]; // Ảnh mới
                            let newGroupName = groupNameInput; // Tên nhóm mới

                            if (imgEl) imgEl.src = newImgSrc;
                            if (nameEl) nameEl.textContent = newGroupName;

                            // Lấy nội dung hiện tại của `onclick`
                            let oldOnclick = el.getAttribute("onclick");

                            // Cập nhật lại `onclick` với ảnh và tên mới
                            let updatedOnclick = oldOnclick
                                .replace(/'([^']*\/img\/group_avatars\/[^']*)'/, `'` + newImgSrc + `'`) // Cập nhật ảnh
                                .replace(/'[^']*', 'group', '[^']*'/, `'` + groupId + `', 'group', '` + newGroupName + `'`); // Cập nhật tên

                            el.setAttribute("onclick", updatedOnclick);
                        }
                    });



                    closeModal();
                }
            })
            .catch(error => console.error("Lỗi:", error));
    }

    function reportComment(commentId, event) {
        fetch('/reports?action=report&type=Comment&commentId=' + encodeURIComponent(commentId), {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log("Báo cáo bình luận thành công!");
                    let dropdownMenu = event.target.closest('ul.dropdown-menu');
                    if (dropdownMenu) {
                        dropdownMenu.classList.remove('show');
                    }
                } else {
                    console.log("Báo cáo thất bại. Vui lòng thử lại sau.");
                }
            })
            .catch(error => console.error('Lỗi:', error));
    }


    function reportPost(postId, event) {
        fetch('/reports?action=report&type=Post&postId=' + encodeURIComponent(postId), {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log("Báo cáo bài viết thành công!");
                    let dropdownMenu = event.target.closest('.dropdown-menu');
                    if (dropdownMenu) {
                        dropdownMenu.classList.remove('show'); // Ẩn dropdown
                    }
                } else {
                    console.log("Báo cáo thất bại. Vui lòng thử lại sau.");
                }
            })
            .catch(error => console.error('Lỗi:', error));
    }


    document.addEventListener("DOMContentLoaded", function () {
        const modal = document.getElementById("createGroupModal");
        const openModalBtn = document.getElementById("openCreateGroupModal");
        const closeModalBtn = document.querySelector(".close");
        const createGroupBtn = document.getElementById("createGroupButton");

        const urlParams = new URLSearchParams(window.location.search);
        const postId = urlParams.get("postId");

        if (postId) {
            const targetPost = document.getElementById(`post-${postId}`);
            if (targetPost) {
                targetPost.scrollIntoView({ behavior: "smooth", block: "center" });
                targetPost.style.border = "2px solid blue"; // Đánh dấu bài post
            }
        }

        let selectedUsers = [];

        // Mở modal
        openModalBtn.addEventListener("click", function () {
            modal.style.display = "block";
        });

        // Đóng modal
        closeModalBtn.addEventListener("click", function () {
            modal.style.display = "none";
        });

        // Chọn thành viên
        document.querySelectorAll(".select-user").forEach(checkbox => {
            checkbox.addEventListener("change", function () {
                const userId = this.getAttribute("data-userid");
                if (this.checked) {
                    selectedUsers.push(userId);
                } else {
                    selectedUsers = selectedUsers.filter(id => id !== userId);
                }
            });
        });

        // Gửi AJAX request để tạo nhóm
        createGroupBtn.addEventListener("click", function () {
            event.preventDefault(); // Ngăn form submit mặc định

            const form = document.querySelector(".modal-group-content"); // Lấy form
            const groupName = document.getElementById("groupName").value;
            const selectedUsers = Array.from(document.querySelectorAll('.select-user:checked'))
                .map(checkbox => checkbox.getAttribute('data-userid'));

            function showWarning(message) {
                Swal.fire({
                    title: message,
                    icon: "warning",
                    draggable: true,
                    showConfirmButton: true
                });
            }

            if (!groupName) {
                showWarning("Vui lòng nhập tên nhóm.");
                return;
            }
            if (selectedUsers.length <= 1) {
                showWarning("Vui lòng chọn ít nhất 2 thành viên.");
                return;
            }


            const membersInput = document.createElement("input");
            membersInput.type = "hidden";
            membersInput.name = "members";
            membersInput.value = selectedUsers.join(","); // Gửi danh sách ID cách nhau bằng dấu phẩy

            form.appendChild(membersInput);
            form.submit(); // Gửi form theo cách thủ công
        });
    });


    // setInterval(loadMessages, 2000);

    let selectedMessageId = null;

    function showMessageMenu(event, messageId) {
        event.preventDefault();

        selectedMessageId = messageId;
        let menu = document.getElementById("message-menu");

        let messageElement = document.querySelector(`[oncontextmenu*='` + selectedMessageId + `'] .text`);
        if (messageElement.innerText === "Tin nhắn đã bị gỡ") {
            return;
        }

        // Hiển thị menu tại vị trí chuột
        menu.style.display = "block";
        menu.style.left = event.pageX + "px";
        menu.style.top = event.pageY + "px";
    }

    document.addEventListener("click", function () {
        document.getElementById("message-menu").style.display = "none";
    });

    function deleteMessage() {
        if (confirm('Gỡ tin nhắn?')) {
            let receiverId = document.getElementById("receiverId").value;
            let isGroup = document.getElementById("receiverId").getAttribute("data-type") === "group";

            let url = isGroup
                ? `groupMessages?action=delete&messageId=` + selectedMessageId
                : `messages?action=delete&messageId=` + selectedMessageId;

            fetch(url, {method: "POST"})
                .then(response => response.text())
                .then(data => {
                    if (data === "success") {
                        let messageElement = document.querySelector(`[oncontextmenu*='` + selectedMessageId + `'] .text`);
                        if (messageElement) {
                            messageElement.innerText = "Tin nhắn đã bị gỡ";
                            let messageFatherElement = document.querySelector(`[oncontextmenu*='` + selectedMessageId + `']`);
                            messageFatherElement.classList.add("removeMessage");
                        }
                    } else {
                        alert("Xóa tin nhắn thất bại!");
                    }
                })
                .catch(error => console.error("Lỗi khi xóa tin nhắn:", error));
        }
    }


    //Gửi tin nhắn
    document.getElementById("send-btn").addEventListener("click", function () {
        let message = document.getElementById("chat-input").value.trim();
        let receiverId = document.getElementById("receiverId").value;
        let isGroup = document.getElementById("receiverId").getAttribute("data-type") === "group";

        if (!message) return;

        let url = isGroup
            ? `groupMessages?action=chat&groupId=` + receiverId + `&content=` + encodeURIComponent(message)
            : `messages?action=chat&receiverId=` + receiverId + `&content=` + encodeURIComponent(message);

        fetch(url, {
            method: "POST",
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
        })
            .then(response => response.text())
            .then(data => {
                let chatBox = document.getElementById("chat-messages");
                chatBox.innerHTML += `
                <div class="message message-right">
                    <span class="text">` + message + `</span>
                </div>`;
                document.getElementById("chat-input").value = "";
                chatBox.scrollTop = chatBox.scrollHeight;
            })
            .catch(error => console.error("Lỗi khi gửi tin nhắn:", error));
    });


    let intervalId;

    function loadMessages(id, type, name, image) {
        let url = (type === 'group') ? `groupMessages?groupId=` + id : `messages?contactId=` + id;

        fetch(url)
            .then(response => response.text())
            .then(messages => {
                let chatBox = document.getElementById("chat-messages");
                let previousHeight = chatBox.scrollHeight; // Lưu vị trí cuộn trước khi cập nhật

                chatBox.innerHTML = messages;
                document.getElementById("receiverId").value = id;
                document.getElementById("receiverId").setAttribute("data-type", type);

                if(type === 'group') {
                    let ownerIdInput = document.querySelector("input[name='ownerId']");
                    let currentUserId = document.querySelector("input[name='currentUserId']");

                    if (ownerIdInput) {
                        let ownerId = ownerIdInput.value;
                        let settingGroup = document.getElementById("settingGroup");

                        if (ownerId === currentUserId.value) {
                            console.log("is owner");
                            if (settingGroup) {
                                settingGroup.style.display = "block"; // Hiển thị thẻ <a> nếu là chủ nhóm
                            }
                        } else {
                            console.log("not owner");
                            settingGroup.style.display = "none";
                        }
                    }
                }

                // Cập nhật header với tên và ảnh
                let chatHeader = document.getElementById("chat-header");
                chatHeader.innerHTML = `
                <img src="` + image + `" alt="Avatar" width="40" height="40" style="border-radius: 50%; margin-right: 10px;">
                <span>` + name + `</span>
            `;


                document.getElementById('chat-modal').style.display = 'inherit';

                if (type === 'group') {
                    document.getElementById("settingGroup").setAttribute("data-group-id", id);
                } else {
                    document.getElementById("settingGroup").removeAttribute("data-group-id");
                }

                // Nếu có tin nhắn mới, cuộn xuống dưới
                if (chatBox.scrollHeight > previousHeight) {
                    chatBox.scrollTop = chatBox.scrollHeight;
                }
            });

        // Xóa interval cũ nếu có
        if (intervalId) {
            clearInterval(intervalId);
        }

        // Tạo interval mới để cập nhật tin nhắn mỗi giây
        intervalId = setInterval(() => {
            fetch(url)
                .then(response => response.text())
                .then(messages => {
                    let chatBox = document.getElementById("chat-messages");
                    let previousHeight = chatBox.scrollHeight;

                    chatBox.innerHTML = messages;

                    // Nếu có tin nhắn mới, cuộn xuống dưới
                    if (chatBox.scrollHeight > previousHeight) {
                        chatBox.scrollTop = chatBox.scrollHeight;
                    }
                });
        }, 1000);
    }


    function closeChat() {
        document.getElementById("chat-modal").style.display = "none";
    }

    function goToMyProfile(userId) {
        window.location.href = "/users?action=myProfile&userId="+ userId;
    }

    function goToFriends() {
        window.location.href = "/friends?action=friendRequests";
    }

    document.addEventListener("DOMContentLoaded", function () {
        const includeNewPost = document.getElementById("includeNewPost");
        const popupContent = document.getElementById("popup-content");

        attachDeleteEvent();

        function attachDeleteEvent() {
            const deleteLinks = document.querySelectorAll(".delete-link");

            deleteLinks.forEach(link => {
                link.addEventListener("click", function (event) {
                    event.preventDefault();

                    let deleteUrl = this.href; // Lưu link xóa

                    Swal.fire({
                        title: "Bạn có chắc chắn muốn xóa bài viết?",
                        icon: "warning",
                        showCancelButton: true,
                        confirmButtonText: "Có, xóa ngay!",
                        cancelButtonText: "Hủy",
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = deleteUrl;
                        }
                    });
                });
            });
        }

        // Hiển thị popup
        function newPost() {
            includeNewPost.style.display = "flex";
        }

        // Ẩn popup
        function hidePopup() {
            includeNewPost.style.display = "none";
        }

        // Ẩn popup khi click bên ngoài popup-content
        includeNewPost.addEventListener("click", function (event) {
            if (!popupContent.contains(event.target)) {
                hidePopup();
            }
        });

        // Định nghĩa global
        window.newPost = newPost;
        window.hidePopup = hidePopup;
    });

    function confirmLogout() {
        window.location.href = '/login?action=logout';
    }

    function showSearchInput() {
        const contactLabel = document.getElementById('contactLabel');
        const searchContainer = document.getElementById('search-contact-container');
        const search = document.getElementById('search-input-icon')

        contactLabel.style.display = 'none';
        searchContainer.style.display = 'block';
        // search.style.marginLeft = '-10px'

    }

    function hideSearchInput(event) {
        const searchContainer = document.getElementById('search-contact-container');
        const contactLabel = document.getElementById('contactLabel');

        if (!searchContainer.contains(event.relatedTarget) && !contactLabel.contains(event.relatedTarget)) {
            searchContainer.style.display = 'none';
            contactLabel.style.display = 'block';
            // contactLabel.style.marginLeft = '10px'
        }
    }

    document.getElementById('search-contact-container').addEventListener('mouseout', hideSearchInput);
    document.getElementById('contactLabel').addEventListener('mouseout', hideSearchInput);

    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll(".post-card").forEach(postCard => {
            const mediaArea = postCard.querySelector(".media-area");
            const mediaElements = mediaArea.querySelectorAll(".media");
            let mediaList = [];

            mediaElements.forEach(media => {
                mediaList.push({
                    url: media.dataset.url,
                    type: media.dataset.type
                });
            });
            mediaList.reverse();
            mediaArea.innerHTML = generateMediaLayout(mediaList);
        });
    });

    function generateMediaLayout(mediaList) {
        if (!mediaList.length) return "";

        let layoutType = getLayoutType(mediaList.length);
        let mediaHTML = "";

        mediaList.slice(0, 4).forEach((media, index) => {
            let className = layoutType[index] || "quarter";
            mediaHTML += createMediaElement(media, className);
        });

        if (mediaList.length > 4) {
            let extraCount = mediaList.length - 4;
            mediaHTML += `<div class="media extra">` + extraCount + `</div>`;
        }

        return `<div class="media-grid">` + mediaHTML + `</div>`;
    }

    function getLayoutType(count) {
        return {
            1: ["full"],
            2: ["half", "half"],
            3: ["large-left", "small-right-top", "small-right-bottom"],
            4: ["quarter", "quarter", "quarter", "quarter"],
        }[count] || ["large-left", "small-right-top", "small-right-bottom", "extra"];
    }

    function createMediaElement(media, className) {
        if (media.type === "picture") {
            return `<img src="${pageContext.request.contextPath}/uploads/postMedias/` + media.url + `" class="media ` + className + `">`;
        } else if (media.type === "video") {
            return `<video src="` + media.url + `" class="media ` + className + `" controls></video>`;
        }
        return "";
    }

    document.getElementById("emoji-btn").addEventListener("click", function () {
        let emojiPicker = document.getElementById("emoji-picker");
        emojiPicker.style.display = emojiPicker.style.display === "block" ? "none" : "block";
    });

    // Danh sách emoji cơ bản
    let emojiList = ["😀", "😂", "😍", "😎", "😢", "😡", "👍", "👎", "🔥", "💖"];
    let emojiPicker = document.getElementById("emoji-picker");

    // Thêm emoji vào bảng chọn
    emojiList.forEach(emoji => {
        let span = document.createElement("span");
        span.innerText = emoji;
        span.classList.add("emoji");
        span.onclick = function () {
            document.getElementById("chat-input").value += emoji;
            emojiPicker.style.display = "none";
        };
        emojiPicker.appendChild(span);
    });


    function updateNotificationStatus() {
        let receiverId = document.getElementById("receiverId").value;
        fetch('/messages?action=updateNotification', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: `receiverId=` + receiverId
        })
            .then(response => response.text())
            .then(data => console.log(data))
            .catch(error => console.error('Lỗi:', error));
    }


</script>
<style>
    /* Overlay làm mờ nền */
    #modalOverlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5); /* Màu đen trong suốt */
        backdrop-filter: blur(5px); /* Hiệu ứng mờ */
        z-index: 999;
    }

    /* Căn giữa modal */
    #editGroupModal {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
        width: 300px;
        text-align: center;
        z-index: 1000;
    }

    #editGroupModal h3 {
        margin-top: 0;
    }

    #editGroupModal input {
        width: 100%;
        padding: 8px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    #editGroupModal button {
        padding: 8px 15px;
        margin-top: 10px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    #editGroupModal .close-btn {
        position: absolute;
        top: -10px;
        right: -130px;
        font-size: 18px;
        cursor: pointer;
        background: none;
        border: none;
        color: #333;
    }


    .removeMessage {
        font-style: italic;
        background-color: lightgrey !important;
        color: white !important;
    }

    #createGroupModal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 755px;
        top: 0;
        width: 100%;
        height: 99%;
        background-color: rgba(0, 0, 0, 0.5);
    }

    #createGroupModal .modal-group-content {
        background-color: white;
        padding: 20px;
        margin: 10% auto;
        width: 50%;
        border-radius: 10px;
    }

    #createGroupModal .close {
        float: right;
        cursor: pointer;
        font-size: 20px;
    }

    #createGroupModal .friend-item {
        display: flex;
        justify-content: space-between;
        padding: 5px;
    }


    .emoji-picker {
        display: none;
        position: absolute;
        bottom: 80px;
        right: 130px;
        background: white;
        border: 1px solid #ccc;
        padding: 10px;
        box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
        border-radius: 5px;
        width: 200px;
        z-index: 10005;
    }

    .emoji {
        font-size: 22px;
        cursor: pointer;
        margin: 5px;
    }


    .message-menu {
        position: absolute;
        display: none;
        background: white;
        border: 1px solid #ccc;
        padding: 5px;
        box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
        z-index: 10005;
    }


    .modal {
        display: none;
        position: fixed;
        top: 60%;
        height: 325px;
        left: 87%;
        transform: translate(-50%, 0);
        width: 300px;
        background: white;
        border: 1px solid #ccc;
        box-shadow: 0px 0px 5px grey;
        height: fit-content;
        border-radius: 10px;
    }

    #chat-modal {
        top: 46% !important;
        height: 450px !important;
        width: 350px !important;
    }

    #chat-messages {
        height: 79%;
        overflow-y: auto;
        margin-bottom: 5px;
        scrollbar-width: none;
        padding-inline: 10px;
        border-block: 1px solid lightgray;
    }

    .message {
        display: flex;
        margin: 5px;
        font-size: 15px;
        padding: 7px;
        max-width: 60%;
        border-radius: 10px;
    }

    .message-right, .message-left {
        max-width: 70%; /* Giới hạn độ rộng tối đa để tin nhắn không tràn màn hình */
        overflow-wrap: anywhere; /* Đảm bảo chữ dài (như URL) cũng xuống dòng */
        display: flex; /* Đảm bảo tin nhắn có độ rộng phù hợp */
    }

    .message-right {
        background-color: #0084ff;
        color: white;
        justify-self: end;
        width: fit-content;
    }

    .message-left {
        background-color: #e4e6eb;
        color: black;
        justify-self: left;
        width: fit-content;
    }


    .like-btn {
        color: grey; /* Mặc định nếu chưa like */
        cursor: pointer;
        text-decoration: none;
    }

    .like-btn.liked {
        color: blue; /* Nếu đã like, đổi sang màu xanh */
    }

    .like-btn.liked svg {
        fill: blue; /* Đổi màu icon khi đã like */
    }

    #includeNewPost {
        display: none; /* Mặc định ẩn */
        position: fixed;
        top: 50%;
        left: 50%;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5); /* Làm mờ nền */
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 1000; /* Đảm bảo nằm trên cùng */
        transform: translate(-50%, -50%); /* Căn giữa màn hình */
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
    }

    #includeNewPost .content {
        background: white;
        padding: 20px;
        border-radius: 10px;
        width: 50%;
        max-height: 80%;
        overflow: auto;
    }


    .friends:hover {
        background: #ececec;
    }

    .friends {
        color: black;
        display: block;
    }

    .groups:hover {
        background: #ececec;
    }

    .groups {
        color: black;
        display: block;
    }

    .left_bottom {
        align-items: center;
        display: flex;
        width: 100%;
        padding-left: 15px;
        height: 60px;
    }

    .addPostInput input {
        width: 100%;
        /*margin: auto;*/
        align-items: center;
        padding: 11px;
        margin-left: 20px;
        background: #ececec;
        border: 0 solid white;
        border-radius: 30px;
    }

    .addPost {
        padding: 40px;
        margin: auto;
        background: white;
        border-radius: 10px;
        display: flex;
        width: 100%;
        height: 60px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
        align-items: center;
    }

    .searchBB {
        padding-left: 30px;
    }

    .rightMenu {
        padding: 15px;
        font-size: 1.3em;
        display: flex;
        gap: 10px;
        height: 80px;
        align-items: center;
    }

    .right {
        width: 20%;
        height: 100%;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        overflow-y: auto;
        scrollbar-width: none;
    }

    .leftIcon {
        font-family: inherit;
        font-size: 1em;
        display: flex;
        gap: 10px;
        height: 70px;
        width: 100%;
        justify-content: center;
        align-items: center;
    }

    .left {
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        font-family: inherit;
        width: 20%;
        height: 100%;
        padding: 10px;
        display: block;
    }

    .center {
        width: 60%;
        padding: 20px 60px;
    }

</style>