<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cite" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
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
    <title></title>
    <style>
        body {
            background-color: #f0f2f5;
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

        .profile-container {
            width: 100%;
            background: white;
            padding: 20px;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
        }

        .avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
        }

        .profile-name {
            font-size: 24px;
            font-weight: bold;
        }

        .profile-actions button {
            margin: 5px;
        }

        .post-container {
            width: 60%;
            padding: 15px;
            border-radius: 10px;
            margin-top: 20px;
            margin-left: auto;
            margin-right: auto;
        }

        .col-md-8 {
            padding-inline: 80px;
            width: 100%;
        }

        .banner_container {
            width: 100%;
            max-height: 70%; /* Điều chỉnh chiều cao tối đa */
            overflow: hidden;
        }

        #editProfileModal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }

        #editProfileModal > .modal-content {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            width: 40%;
            text-align: center;
            position: relative;
        }

        #editProfileModal .close {
            position: absolute;
            top: 10px;
            right: 15px;
            font-size: 20px;
            cursor: pointer;
        }

        #editProfileForm > .form-group {
            margin-bottom: 15px;
            text-align: left;
        }

        .circular-img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            display: block;
            margin: 10px auto;
        }

        .banner-img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 5px;
            display: block;
            margin: 10px auto;
        }

        textarea {
            width: 100%;
            padding: 8px;
            resize: none;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
        }

        .btn-success {
            background-color: #28a745;
            color: white;
        }
    </style>
</head>
<body>
<jsp:include page="Nav3.jsp"></jsp:include>
<div class="container-fluid" style="overflow-y: auto; height: 91vh">
    <div class="row" style="justify-content: center;">
        <div class="col-md-8">
            <div class="banner_container">
                <img style="width: 100%; height: auto"
                     src="${pageContext.request.contextPath}/img/banners/${user.banner}">
            </div>
            <div class="profile-container">
                <div style="width: 10%;">
                    <img src="${pageContext.request.contextPath}/uploads/avatars/${user.image}" alt="Avatar"
                         class="avatar">
                </div>
                <div style="width: 70%;">
                    <h2 class="profile-name">${user.name}</h2>
                    <p class="text-muted">${user.bio}</p>
                </div>
                <c:choose>
                    <c:when test="${user.userId == sessionScope.userId}">
                        <div class="profile-actions">
                            <button onclick="openEditModal()" class="btn btn-primary">Chỉnh sửa thông tin</button>
                        </div>
                    </c:when>
                    <c:when test="${friendShip.status == 'accepted'}">
                        <div class="profile-actions">
                            <button class="btn btn-primary" onclick="loadMessages(${user.userId}, 'user', '${user.name}', '${pageContext.request.contextPath}/uploads/avatars/${user.image}')">Nhắn tin</button>

                        </div>
                    </c:when>
                    <c:when test="${friendShip.status == 'pending' && user.userId == friendShip.userId_2}">
                        <div class="profile-actions">
                            <button class="btn btn-warning" style="background: rgb(128, 128, 128) ;color: white"  onclick="cancelFriendProfile(${user.userId})">
                                Hủy lời mời kết bạn
                            </button>
                        </div>
                    </c:when>

                    <c:when test="${friendShip.status == 'pending' && user.userId == friendShip.userId_1}">
                        <div class="profile-actions" style="display: flex">
                            <button class="btn btn-success btn btn-primary btn-sm accept-search"
                                    onclick="acceptFriendProfile(${user.userId})"
                                    style="background: #0866ff;width: 170px;color: white">Chấp
                                nhận lời mời
                            </button>
                            <button class="btn btn-success btn btn-primary btn-sm cancel-friend-search"
                                    onclick="cancelFriendProfile(${user.userId})"
                                    style="background: #cbcbcb;width: 170px;color: white">Xóa
                                lời mời
                            </button>
                        </div>
                    </c:when>


                    <c:otherwise>
                        <div class="profile-actions" data-id="${user.userId}">
                            <button class="btn btn-primary"   onclick="addFriendProfile(${user.userId})">Kết bạn</button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="post-container">
            <c:if test="${posts.size() > 0}">
                <c:forEach items="${posts}" var="post">
                    <div class="post-card" data-post-id="${post.getPostId()}">
                        <div class="introduce" style="display: flex; justify-content: space-between">
                            <div style="display: flex">
                                <img src="${pageContext.request.contextPath}/uploads/avatars/${post.user.image}"
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
                                                    <li><a class="dropdown-item"
                                                           href="/posts?action=userEditPost&postId=${post.getPostId()}">Sửa
                                                        bài viết</a></li>
                                                    <li>
                                                        <a class="dropdown-item delete-link"
                                                           href="/posts?action=deletePost&&postId=${post.getPostId()}">Xóa
                                                        </a>
                                                    </li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div>
                                    <a href="" style="color: grey">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
                                             fill="currentColor"
                                             class="bi bi-x" viewBox="0 0 16 16">
                                            <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708"/>
                                        </svg>
                                    </a>
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
                        <div class="post-information"
                             style="display: flex;margin-top: 15px;border-top: 1px solid lightgray;">
                            <a style="margin-right: 15px;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="20" fill="currentColor"
                                     class="bi bi-hand-thumbs-up" viewBox="0 0 10 20">
                                    <path d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2 2 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a10 10 0 0 0-.443.05 9.4 9.4 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a9 9 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.2 2.2 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.9.9 0 0 1-.121.416c-.165.288-.503.56-1.066.56z"/>
                                </svg>
                                <span>Thích ${post.totalEmotions}</span>
                            </a>
                            <a onclick="showPostPopup('${post.getPostId()}')">
                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="20" fill="currentColor"
                                     class="bi bi-chat" viewBox="0 0 10 20">
                                    <path d="M2.678 11.894a1 1 0 0 1 .287.801 11 11 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8 8 0 0 0 8 14c3.996 0 7-2.807 7-6s-3.004-6-7-6-7 2.808-7 6c0 1.468.617 2.83 1.678 3.894m-.493 3.905a22 22 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a10 10 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9 9 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105"/>
                                </svg>
                                <span>Bình luận ${post.totalComments}</span>
                            </a>
                        </div>
                        <div class="function">

                        </div>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${posts.size() == 0}">
                <h1 style="text-align: center">Không có bài viết nào</h1>
            </c:if>
        </div>
    </div>
</div>

<!-- Modal chỉnh sửa thông tin -->
<div id="editProfileModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeEditModal()">&times;</span>
        <h2>Chỉnh sửa trang cá nhân</h2>

        <form id="editProfileForm" action="/users?action=editProfile" method="post" enctype="multipart/form-data">
            <!-- Ảnh đại diện -->
            <div class="form-group">
                <label for="image">Ảnh đại diện</label>
                <input type="file" id="image" name="image" accept="image/*" onchange="previewImage(event)">
                <img id="previewImg" class="circular-img" alt="Xem ảnh"
                     src="${pageContext.request.contextPath}/uploads/avatars/${user.image}">
            </div>

            <!-- Ảnh bìa -->
            <div class="form-group">
                <label for="banner">Ảnh bìa</label>
                <input type="file" id="banner" name="banner" accept="image/*" onchange="previewBannerImage(event)">
                <img id="previewBanner" class="banner-img" alt="Xem ảnh"
                     src="${pageContext.request.contextPath}/img/banners/${user.banner}">
            </div>

            <!-- Tiểu sử (bio) -->
            <div class="form-group">
                <label for="bio">Tiểu sử</label>
                <textarea id="bio" name="bio" rows="4" placeholder="Nhập tiểu sử của bạn...">${user.bio}</textarea>
            </div>

            <!-- Nút lưu -->
            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
        </form>
    </div>
</div>

<div id="chat-modal" style="height: 325px" class="modal">
    <div class="modal-content" style="height: 100%">
        <div id="chat-header" style="height: 15%;padding: 5px"></div>
        <div id="chat-messages"></div>
        <input type="hidden" id="receiverId">
        <div style="height: 15%;display: flex;padding: 5px 10px 5px 10px ; justify-content: space-between; position: relative;">
            <button style="border: none;width: fit-content;background: none;padding: 0" id="emoji-btn">😀</button>
            <input style="border-radius: 24px; padding-left: 10px; border: 1px solid grey; width: 65%;" type="text"
                   id="chat-input" placeholder="Nhập tin nhắn..." onfocus="updateNotificationStatus()">
            <button style="width: fit-content; padding-block: 1px" class="btn btn-primary" id="send-btn">Gửi</button>
        </div>
    </div>
    <a style=" cursor: pointer;font-size: x-large;position: absolute; bottom: 295px; left: 275px; border-radius: 50%; width: 24px;height: 24px;"
       onclick="closeChat()">x</a>
</div>

<div style="border-radius: 5px" id="message-menu" class="message-menu">
    <button style="width: fit-content;font-size: 12px;padding: 0;background-color: white" onclick="deleteMessage()">Gỡ
        tin nhắn
    </button>
</div>
<div id="emoji-picker" class="emoji-picker"></div>


</body>
</html>

<script>
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

                // Cập nhật header với tên và ảnh
                let chatHeader = document.getElementById("chat-header");
                chatHeader.innerHTML = `
                <img src="` + image + `" alt="Avatar" width="40" height="40" style="border-radius: 50%; margin-right: 10px;">
                <span>` + name + `</span>
            `;

                document.getElementById('chat-modal').style.display = 'inherit';

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

    function acceptFriendProfile(userID){
        fetch(`/friends?action=acceptFriend&friendId=`+userID, {
            method: "POST"
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload();
                } else {
                    alert("Có lỗi xảy ra!")
                }
            })
    }
    function addFriendProfile(userID){
        fetch(`/friends?action=addFriend&friendId=`+ userID, {
            method: "POST"
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload();
                } else {
                    alert("Có lỗi xảy ra!")
                }
            })
    }
    function cancelFriendProfile(userId){
        fetch(`/friends?action=cancelFriend&friendId=`+userId, {
            method: "POST"
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    location.reload();
                } else {
                    alert("Có lỗi xảy ra!")
                }
            })
    }
    // Mở modal
    function openEditModal() {
        document.getElementById("editProfileModal").style.display = "flex";
    }

    // Đóng modal
    function closeEditModal() {
        document.getElementById("editProfileModal").style.display = "none";
    }

    // Xem trước ảnh đại diện
    function previewImage(event) {
        const preview = document.getElementById("previewImg");
        const file = event.target.files[0];

        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    }

    // Xem trước ảnh bìa
    function previewBannerImage(event) {
        const preview = document.getElementById("previewBanner");
        const file = event.target.files[0];

        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    }


    document.addEventListener("DOMContentLoaded", function () {

        document.querySelector(".delete-link").addEventListener("click", function (event) {
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
</script>