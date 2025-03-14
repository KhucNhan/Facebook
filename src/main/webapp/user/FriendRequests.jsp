<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 2/25/2025
  Time: 10:35 AM
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

    <style>
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

        .container-fluid {
            height: 91vh;
        }

        .list-group-item a {
            text-decoration: none;
            color: black;
            font-size: larger;
        }

        .container-fluid > .row {
            height: 100%;
        }

        .container-fluid > .row > div:nth-child(1) {
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .container-fluid > .row > div {
            padding-top:20px;
        }

        .list-group > li {
            border:none;
        }

        .list-group li:nth-child(2) {
            border-top: 1px solid lightgrey;
        }

        .searchForm > div {
            width: 50%;
        }
    </style>
    <title>FaceEBook</title>
</head>
<body>
<jsp:include page="Nav3.jsp"></jsp:include>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-2">
            <ul class="list-group">
                <li class="list-group-item list-group-item-action">
                    <a href="/friends?action=friendRequests">Lời mời kết bạn</a>
                </li>
                <li class="list-group-item list-group-item-action">
                    <a href="/friends?action=allFriends">Tất cả bạn bè</a>
                </li>
            </ul>
        </div>
        <div class="col-md-10">
            <h3>Lời mời kết bạn</h3>
            <div style="padding-block: 10px;" class="row">
                <form class="searchForm" action="/friends?action=searchInRequests" method="post">
                    <div class="input-group mb-3">
                        <input style="border-color: #6c757d" type="text" name="value" class="form-control" placeholder="Tìm kiếm trong danh sách lời mời..." aria-label="Recipient's username" aria-describedby="button-addon2">
                        <button class="btn btn-outline-secondary" type="submit" id="button-addon2">Tìm</button>
                    </div>
                </form>
            </div>
            <div class="row">
                <c:if test="${friends.size() != 0}">
                    <c:forEach var="friend" items="${friends}" varStatus="status">
                        <input style="display: none" value="${friend.userId}">
                        <div class="col-md-2 mb-4">
                            <div class="card text-center">
                                <img style="cursor: pointer;height: 186.22px;"  onclick="sendProfile(event, ${friend.userId})" src="${pageContext.request.contextPath}/uploads/avatars/${friend.image}"
                                     class="card-img-top" alt="Avatar">
                                <div class="card-body">
                                    <h6 style="cursor: pointer;"  onclick="sendProfile(event, ${friend.userId})" class="card-title">${friend.name}</h6>
                                    <button  style="width: 100%; margin-bottom: 5px;" class="btn btn-primary btn-sm accept-btn"
                                             onclick="acceptFriend(${friend.userId})" data-id="${friend.userId}">Xác nhận
                                    </button>
                                    <button style="width: 100%" class="btn btn-secondary btn-sm delete-btn"
                                            onclick="deleteFriend(${friend.userId})" data-id="${friend.userId}" >Xóa
                                    </button>

                                    <button class="acceptFriend" data-id="${friend.userId}"  style="display: none; width: 100%;
                                            pointer-events: none; opacity: 0.5; background-color: #ccc; margin-top: 45px;height: 30px;border-radius: 5px;
                                            border: 1px solid #999; cursor: default;">Đã xác nhận...
                                    </button>
                                    <button class="deleteFriend" data-id="${friend.userId}"  style="display: none; width: 100%;
                                            pointer-events: none; opacity: 0.5; background-color: #ccc; margin-top: 45px;height: 30px;border-radius: 5px;
                                            border: 1px solid #999; cursor: default;">Đã xóa yêu cầu
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${friends.size() == 0 && action != 'requests'}">
                    <p>Không có lời mời kết bạn nào</p>
                </c:if>
                <c:if test="${friends.size() == 0 && action == 'requests'}">
                    <p>Không tìm thấy kết quả phù hợp</p>
                </c:if>
            </div>
        </div>
    </div>
</div>

<div id="chat-modal" style="height: 325px" class="modal">
    <div class="modal-content" style="height: 100%">
        <div id="chat-header" style="height: 15%;padding: 5px"></div>
        <div id="chat-messages"></div>
        <input type="hidden" id="receiverId">
        <div style="height: 15%;display: flex;padding: 5px 10px 5px 10px ; justify-content: space-between; position: relative;">
            <button style="width: fit-content;background: none;padding: 0; border:none" id="emoji-btn">😀</button>
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


    function closeChat() {
        document.getElementById("chat-modal").style.display = "none";
    }


    function sendProfile(event,userId){
        event.stopPropagation();
        window.location.href = "users?action=myProfile&userId=" + userId;
    }
</script>
