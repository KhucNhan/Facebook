<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous">

    </script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">


    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="user/ProfileUser.css">
    <link rel="stylesheet" href="/css/Home_Center.css">
    <script src="/js/Home_Center.js"></script>
</head>
<body style="margin: 0px">
<div>
    <div class="top-nav">
        <div class="TopProfile-photo">
            <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" fill="currentColor"
                 class="bi bi-person-circle" viewBox="0 0 16 16">
                <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                <path fill-rule="evenodd"
                      d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
            </svg>
        </div>
        <div class="TopProfile-name">Name</div>
        <div class="TopProfile-action-buttons">
            <button style="color: white" id="navbar-toggle-button">Thêm bạn bè</button>
        </div>
    </div>
    <div class="centerProfile">
        <div class="center_left">
        </div>
        <div class="center" style="overflow-y: auto; scrollbar-width: none">
            <form action="">
                <div class="addPost">
                    <div>
                        <img src="${pageContext.request.contextPath}/uploads/avatars/${user.image}"
                             alt="User Icon" width="60" height="60" style="border-radius: 50%">
                    </div>
                    <div class="addPostInput" style="width: 100%">
                        <input type="button" style="text-align: left;padding-left: 15px" id="postInput"
                               onclick="newPost()"
                               value="Bạn đang nghĩ gì thế?">
                    </div>
                </div>
            </form>

            <div class="post-container">
                <c:forEach items="${posts}" var="post">
                    <div class="post-card">
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
                                                    <li><a class="dropdown-item delete-link"
                                                           href="/posts?action=deletePost&&postId=${post.getPostId()}">Xóa</a>
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
                        <div class="content">
                            <p>${post.content}</p>
                        </div>
                        <div class="media-area">
                            <c:forEach items="${post.mediaUrls}" var="media">
                                <div style="height: fit-content" class="media" data-url="${media.url}"
                                     data-type="${media.type}"></div>
                            </c:forEach>
                        </div>
                        <div class="post-information"
                             style="display: flex;margin-top: 15px;border-top: 1px solid lightgray;">
                            <div style="margin-right: 15px">
                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="20" fill="currentColor"
                                     class="bi bi-hand-thumbs-up" viewBox="0 0 10 20">
                                    <path d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2 2 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a10 10 0 0 0-.443.05 9.4 9.4 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a9 9 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.2 2.2 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.9.9 0 0 1-.121.416c-.165.288-.503.56-1.066.56z"/>
                                </svg>
                                <span>${post.totalEmotions}</span>
                            </div>
                            <div>
                                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="20" fill="currentColor"
                                     class="bi bi-chat" viewBox="0 0 10 20">
                                    <path d="M2.678 11.894a1 1 0 0 1 .287.801 11 11 0 0 1-.398 2c1.395-.323 2.247-.697 2.634-.893a1 1 0 0 1 .71-.074A8 8 0 0 0 8 14c3.996 0 7-2.807 7-6s-3.004-6-7-6-7 2.808-7 6c0 1.468.617 2.83 1.678 3.894m-.493 3.905a22 22 0 0 1-.713.129c-.2.032-.352-.176-.273-.362a10 10 0 0 0 .244-.637l.003-.01c.248-.72.45-1.548.524-2.319C.743 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7-3.582 7-8 7a9 9 0 0 1-2.347-.306c-.52.263-1.639.742-3.468 1.105"/>
                                </svg>
                                <span>${post.totalComments}</span>
                            </div>
                        </div>
                        <div class="function">

                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

</body>
</html>


<script>
    function loadProfileUser() {
        window.location.href = '/home?action=loadProfile';
    }

    function newPost() {
        document.getElementById("iclusst").style.display = "block";
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


        const iclusst = document.getElementById("iclusst");
        const popupContent = document.getElementById("popup-content");

        // Hiển thị popup
        function newPost() {
            iclusst.style.display = "flex";
        }

        // Ẩn popup
        function hidePopup() {
            iclusst.style.display = "none";
        }

        // Ẩn popup khi click bên ngoài popup-content
        iclusst.addEventListener("click", function (event) {
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

    function loadHome() {
        window.location.href = '/home';
    }

    function showSearchInput() {
        const contactLabel = document.getElementById('contactLabel');
        const searchContainer = document.getElementById('search-container');
        const search = document.getElementById('search-input')

        contactLabel.style.display = 'none';
        searchContainer.style.display = 'block';
        // search.style.marginLeft = '-10px'

    }

    function hideSearchInput(event) {
        const searchContainer = document.getElementById('search-container');
        const contactLabel = document.getElementById('contactLabel');

        if (!searchContainer.contains(event.relatedTarget) && !contactLabel.contains(event.relatedTarget)) {
            searchContainer.style.display = 'none';
            contactLabel.style.display = 'block';
            // contactLabel.style.marginLeft = '10px'
        }
    }

    document.getElementById('search-container').addEventListener('mouseout', hideSearchInput);
    document.getElementById('contactLabel').addEventListener('mouseout', hideSearchInput);

    document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll(".post-card").forEach(postCard => {
            const mediaArea = postCard.querySelector(".media-area");
            const mediaElements = mediaArea.querySelectorAll(".media");
            let mediaList = [];

            mediaElements.forEach(media => {
                mediaList.push({
                    type: media.dataset.type,
                    url: media.dataset.url
                });
            });
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
        console.log(media.url)
        if (media.type === "picture") {
            return `<img src="${pageContext.request.contextPath}/uploads/postMedias/` + media.url + `" class="media ` + className + `">`;
        } else if (media.type === "video") {
            return `<video src="` + media.url + `" class="media ` + className + `" controls></video>`;
        }
        return "";
    }

</script>
<style>
    #iclusst {
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

    #iclusst .content {
        background: white;
        padding: 20px;
        border-radius: 10px;
        width: 50%;
        max-height: 80%;
        overflow: auto;
    }


    .frend:hover {
        background: #ececec;
    }

    .frend {
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

    .menuRight div:hover svg {
        fill: #0866ff;
    }

    .menuRight {
        display: flex;
        gap: 20px;
        padding: 30px;
        height: 100%;
        align-items: center;
        fill: silver;
    }

    .menuCenter div {
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        cursor: pointer;
        padding: 20px;
    }

    .menuCenter div:hover svg,
    .menuCenter div:hover svg {
        fill: #0866ff;
    }

    .menuCenter div:hover::after {
        content: "";
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 3px;
        background-color: #0866ff;
        transition: width 0.3s ease;
    }

    .menuCenter {
        width: 20%;
        margin: auto;
        gap: 5px;
        display: flex;
        height: 100%;
        align-items: center;
    }

    .menu {
        width: 100%;
        height: 70px;
        border: 0 solid silver;
        display: flex;
        align-items: center;
        padding: 0 20px;
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    }

    .search-container {
        position: relative;
        display: flex;
        align-items: center;
    }

    .iconFacebook {
        position: absolute;
        left: 20px;
        transition: opacity 0.3s ease-in-out;
    }

    .search {
        width: 250px;
        height: 50px;
        padding-left: 65px;
        font-family: inherit;
        border-radius: 37px;
        border: 0;
        background: #ececec;
        transition: all 0.3s ease-in-out;
    }

    .search:focus {
        width: 250px;
        padding-left: 20px;
        outline: none;
    }

    .search:focus + .iconFacebook {
        opacity: 0;
    }

    .center {
        width: 60%;
        padding: 20px 60px;
    }

    .post-card {
        padding: 10px;
        border-radius: 8px;
        margin-bottom: 20px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    }

    .media-area {
        display: grid;
        gap: 5px;
        width: 100%;
        height: fit-content;
        position: relative;
    }

    .media-grid {
        display: grid;
        gap: 5px;
        width: 100%;
        max-width: 100%;
        max-height: fit-content;
        overflow: hidden;
        grid-template-columns: repeat(2, 1fr);
        grid-auto-rows: auto;
        position: relative;
    }

    .media {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 10px;
    }

    .full {
        grid-column: span 2;
        grid-row: span 2;
    }

    .half {
        grid-column: span 1;
        grid-row: span 2;
    }

    .large-left {
        grid-column: span 1;
        grid-row: span 2;
    }

    .small-right-top {
        grid-column: span 1;
        grid-row: span 1;
    }

    .small-right-bottom {
        grid-column: span 1;
        grid-row: span 1;
    }

    .quarter {
        grid-column: span 1;
        grid-row: span 1;
    }

    /* ---- Extra Media Count ---- */
    .extra {
        display: flex;
        align-items: center;
        justify-content: center;
        background: rgba(0, 0, 0, 0.6);
        color: white;
        font-size: 20px;
        font-weight: bold;
        border-radius: 10px;
    }

</style>