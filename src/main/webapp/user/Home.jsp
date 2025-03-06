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
        <div class="leftIcon" style="justify-content: left" onclick="goToMyProfile()">
            <div>
                <img src="${pageContext.request.contextPath}/uploads/avatars/${user.image}"
                     alt="User Icon" width="50" height="50" style="border-radius: 50%;">
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
    <div class="center" style="overflow-y: auto; scrollbar-width: none">
        <form action="">
            <div class="addPost">
                <div>
                    <img src="${pageContext.request.contextPath}/uploads/avatars/${user.image}"
                         alt="User Icon" width="60" height="60" style="border-radius: 50%">
                </div>
                <div class="addPostInput" style="width: 100%">
                    <input type="button" style="text-align: left;padding-left: 15px" id="postInput" onclick="newPost()"
                           value="Bạn đang nghĩ gì thế?">
                </div>
            </div>
        </form>

        <div class="post-container">
            <c:forEach items="${posts}" var="post">
                <div class="post-card" data-post-id="${post.getPostId()}">
                    <div class="introduce" style="display: flex; justify-content: space-between">
                        <div style="display: flex">
                            <img src="${pageContext.request.contextPath}/uploads/avatars/${user.image}"
                                 style="height: 50px;width: 50px; border-radius: 50%">
                            <div style="display: flex; flex-direction: column; margin-left: 10px">
                                <div style="height: 20px;">
                                    <a style="font-weight: bold; color: black">${post.user.name}</a>
                                </div>
                                <div>
                                    <p style="color: lightgrey">${post.createAt}</p>
                                </div>
                            </div>
                        </div>
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
                                                        <a class="dropdown-item"
                                                           href="/posts?action=report&postId=${post.getPostId()}">Báo
                                                            cáo bài viết
                                                        </a>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
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
                <a class="friends" onclick="loadMessages(${user.userId}, 'user', '${user.name}', '${pageContext.request.contextPath}/uploads/avatars/${user.image}')">
                    <div class="left_bottom">
                        <div>
                            <img src="${pageContext.request.contextPath}/uploads/avatars/${user.image}"
                                 alt="User Icon" width="50" height="50" style="border-radius: 50%;">
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
                        <a class="groups" onclick="loadMessages(${group.groupId}, 'group', '${group.name}', '${pageContext.request.contextPath}/img/group_avatars/default_group_avt.jpg')">
                            <div class="left_bottom">
                                <div>
                                    <img src="${pageContext.request.contextPath}/img/group_avatars/default_group_avt.jpg"
                                         alt="Group Icon" width="50" height="50" style="border-radius: 50%;">
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
        <div id="chat-header" style="height: 15%;padding: 5px"></div>
        <div id="chat-messages"></div>
        <input type="hidden" id="receiverId">
        <div style="height: 15%;display: flex;padding: 5px 10px 5px 10px ; justify-content: space-between; position: relative;">
            <button style="width: fit-content;background: none;padding: 0" id="emoji-btn">😀</button>
            <input style="border-radius: 24px; padding-left: 10px; border: 1px solid grey; width: 80%;" type="text"
                   id="chat-input" placeholder="Nhập tin nhắn...">
            <button style="width: fit-content; padding-block: 1px" class="btn btn-primary" id="send-btn">Gửi</button>
        </div>


        </div>
        <a style=" cursor: pointer;font-size: x-large;position: absolute; bottom: 295px; left: 275px; border-radius: 50%; width: 24px;height: 24px;"
           onclick="closeChat()">x</a>
    </div>
</div>
<div id="message-menu" class="message-menu">
    <button onclick="deleteMessage()">Xóa tin nhắn</button>
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

</body>
</html>


<script>
    document.addEventListener("DOMContentLoaded", function () {
        const modal = document.getElementById("createGroupModal");
        const openModalBtn = document.getElementById("openCreateGroupModal");
        const closeModalBtn = document.querySelector(".close");
        const createGroupBtn = document.getElementById("createGroupButton");

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

            if (!groupName) {
                alert("Vui lòng nhập tên nhóm.");
                return;
            }
            if (selectedUsers.length < 1) {
                alert("Vui lòng chọn ít nhất 2 thành viên.");
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

            fetch(url, { method: "POST" })
                .then(response => response.text())
                .then(data => {
                    if (data === "success") {
                        let messageElement = document.querySelector(`[oncontextmenu*='` + selectedMessageId + `'] .text`);
                        if (messageElement) {
                            messageElement.innerText = "Tin nhắn đã bị gỡ";
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
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
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


    function loadMessages(id, type, name, image) {
        let url = (type === 'group') ? `groupMessages?groupId=` + id : `messages?contactId=` + id;

        fetch(url)
            .then(response => response.text())
            .then(messages => {
                let chatBox = document.getElementById("chat-messages");
                chatBox.innerHTML = messages;
                document.getElementById("receiverId").value = id;
                document.getElementById("receiverId").setAttribute("data-type", type);

                // Cập nhật header với tên và ảnh
                let chatHeader = document.getElementById("chat-header");
                chatHeader.innerHTML = `
                <img src="` + image + `" alt="Avatar" width="40" height="40" style="border-radius: 50%; margin-right: 10px;">
                <span>` + name + `</span>
            `;

                document.getElementById('chat-modal').style.display = 'inherit';
                chatBox.scrollTop = chatBox.scrollHeight;
            });
    }



    function closeChat() {
        document.getElementById("chat-modal").style.display = "none";
    }

    function goToMyProfile() {
        window.location.href = "/users?action=myProfile";
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

</script>
<style>
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

    #chat-messages {
        height: 75%;
        overflow-y: auto;
        margin-bottom: 5px;
        scrollbar-width: none;
        padding-inline: 10px;
        border-block: 1px solid lightgray;
    }

    .message {
        display: flex;
        margin: 5px;
        padding: 10px;
        max-width: 60%;
        border-radius: 10px;
        font-size: 18px;
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