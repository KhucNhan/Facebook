<%@ page import="com.example.facebook.model.Post" %>
<%@ page import="com.example.facebook.model.PostMedia" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.List" %>
<%@ page import="com.example.facebook.model.User" %><%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 2/24/2025
  Time: 12:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%
    User user = (User) request.getAttribute("user");
    Post editPost = (Post) request.getAttribute("editPost");
%>

<div style="margin-top: -10px">
    <div class="menu">

        <!-- Logo Facebook -->
        <svg xmlns="http://www.w3.org/2000/svg" width="40" height="45" fill="currentColor" class="bi bi-facebook"
             viewBox="0 0 16 16nu" style="color: #0866ff; margin-right: 20px;">
            <path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951"/>
        </svg>

        <!-- Ô tìm kiếm -->
        <div class="search-container">
            <input class="search" type="text" placeholder="Tìm kiếm trên Facebook">
            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="silver"
                 class="bi bi-search iconFacebook"
                 viewBox="0 0 16 16">
                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
            </svg>
        </div>

        <div class="menuCenter">
            <div class="home">
                <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="silver"
                     class="bi bi-house-door-fill iconHome" viewBox="0 0 16 16">
                    <path d="M6.5 14.5v-3.505c0-.245.25-.495.5-.495h2c.25 0 .5.25.5.5v3.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 .5-.5"/>
                </svg>
            </div>
            <div class="people">
                <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="silver"
                     class="bi bi-people-fill iconPeople" viewBox="0 0 16 16">
                    <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6m-5.784 6A2.24 2.24 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.3 6.3 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1zM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5"/>
                </svg>
            </div>
        </div>
        <div class="menuRight">
            <div>
                <svg viewBox="0 0 12 13" width="35" height="35" fill="silver"
                     class="xfx01vb x1lliihq x1tzjh5l x1k90msu x2h7rmj x1qfuztq iconMessage">
                    <g fill-rule="evenodd" transform="translate(-450 -1073)">
                        <path d="m459.603 1077.948-1.762 2.851a.89.89 0 0 1-1.302.245l-1.402-1.072a.354.354 0 0 0-.433.001l-1.893 1.465c-.253.196-.583-.112-.414-.386l1.763-2.851a.89.89 0 0 1 1.301-.245l1.402 1.072a.354.354 0 0 0 .434-.001l1.893-1.465c.253-.196.582.112.413.386M456 1073.5c-3.38 0-6 2.476-6 5.82 0 1.75.717 3.26 1.884 4.305.099.087.158.21.162.342l.032 1.067a.48.48 0 0 0 .674.425l1.191-.526a.473.473 0 0 1 .32-.024c.548.151 1.13.231 1.737.231 3.38 0 6-2.476 6-5.82 0-3.344-2.62-5.82-6-5.82"></path>
                    </g>
                </svg>
            </div>
            <div>
                <svg viewBox="0 0 24 24" width="35" height="35" fill="silver"
                     class="xfx01vb x1lliihq x1tzjh5l x1k90msu x2h7rmj x1qfuztq iconTB">
                    <path d="M3 9.5a9 9 0 1 1 18 0v2.927c0 1.69.475 3.345 1.37 4.778a1.5 1.5 0 0 1-1.272 2.295h-4.625a4.5 4.5 0 0 1-8.946 0H2.902a1.5 1.5 0 0 1-1.272-2.295A9.01 9.01 0 0 0 3 12.43V9.5zm6.55 10a2.5 2.5 0 0 0 4.9 0h-4.9z"></path>
                </svg>
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
                                <li><a class="dropdown-item" href="/users?action=userUpdateInformation">Cập nhật thông
                                    tin
                                    cá nhân</a></li>
                                <li><a class="dropdown-item" href="/users?action=changePassword">Đổi mật khẩu</a></li>
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
</div>
<div style="margin-top: 15px">
    <div class="all">
        <form action="posts?action=updatePost" method="post" enctype="multipart/form-data">
            <!-- Header section -->
            <input type="hidden" name="postId" value="<%= editPost.getPostId() %>">

            <div class="top_nav">
                <div style="font-size: 2em; text-align: center; border-bottom: 1px solid black">
                    <b>Chỉnh sửa bài viết</b>
                </div>
                <div class="post_UI">
                    <div>
                        <img src="${pageContext.request.contextPath}/uploads/avatars/${user.image}"
                             style="width: 40px; height: 40px; border-radius: 50%" alt="Avt">
                    </div>
                    <div>
                        <div class="fw-bold">${user.name}</div>
                        <select onchange="checkPostStatus()" class="form-select form-select-sm mt-1 select" name="privacy" id="privacySelect"
                                style="padding-right: 0px">
                            <option value="Public" <%= "Public".equals(editPost.getPrivacy()) ? "selected" : "" %> >🌍
                                Công
                                khai
                            </option>
                            <option value="Private" <%= "Private".equals(editPost.getPrivacy()) ? "selected" : "" %>>🔒
                                Chỉ
                                mình tôi
                            </option>
                            <option value="Friends" <%= "Friends".equals(editPost.getPrivacy()) ? "selected" : "" %>>👥
                                Bạn
                                của bạn bè
                            </option>
                        </select>
                    </div>
                </div>
                <div class="text">
                <textarea id="postInput" name="content"
                          oninput="checkPostStatus()"><%=editPost.getContent()%></textarea>
                </div>
            </div>
            <div>
                <div class="image" id="A" >
                    <div>
                        <label style="margin-top: 35%"  for="fileA" class="custom-file-upload addImage">Thêm ảnh/video</label>
                        <input type="file" id="fileA" name="fileA[]" onchange="newImage(event)" multiple>
                    </div>

                </div>
                <div style="border: 0px" class="ListImage" id="listImageInput">
                    <div id="B">
                        <label for="fileB" class="custom-file-upload">Thêm ảnh/video</label>
                        <input id="fileB" type="file" name="fileB[]" onchange="newImage(event)" multiple>
                        <input type="hidden" id="deleteAllImagesInput" name="deleteAllImages" value="false">
                        <button style="background: #F44336;width: 100px;color: white;margin-left: 30px"
                                name="deleteAllImages" class="delete-button" onclick="clearImages(event)">Xóa ảnh
                        </button>
                    </div>
                    <c:forEach var="media" items="${imageLinks}">
                        <img src="${pageContext.request.contextPath}/uploads/postMedias/${media.url}"
                             width="100" alt="Ảnh bài viết">
                    </c:forEach>


                </div>
            </div>

            <div class="done">
                <button type="submit" id="postButton">Cập nhật</button>
            </div>
        </form>
        <button style="background: #00ff3c;color: white;width: 100px;margin-top: -74px;margin-left: 350px" type="submit" onclick="exit()" >Thoát</button>
    </div>
</div>
</body>
</html>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        let imageLinks = document.querySelectorAll("#listImageInput img"); // Lấy danh sách ảnh
        let divA = document.getElementById("A");
        let addImage = document.getElementById("addImage");
        let divB = document.getElementById("B");

        if (imageLinks.length > 0) {
            divA.style.display = "none";
            divB.style.display = "block";

        } else {
            divA.style.display = "block";
            divB.style.display = "none";
            addImage.style.marginTop="0%";

        }
    });

    function exit(){
        window.location.href = '/home';
    }
    function clearImages(event) {
        event.preventDefault();

        let check = document.querySelector('#A');
        let checks = document.querySelector('#B');
        let fileInputA = document.getElementById("fileA");
        let fileInputB = document.getElementById("fileB");
        let listImageInput = document.getElementById('listImageInput');

        listImageInput.querySelectorAll("img").forEach(img => img.remove());

        fileInputA.value = "";
        fileInputB.value = "";

        check.style.display = 'flex';
        checks.style.display = 'none';

        checkPostStatus();

        document.getElementById("deleteAllImagesInput").value = "true";
    }


    function newImage(event) {
        const listImageInput = document.getElementById('listImageInput');
        let check = document.querySelector('#A');
        let checks = document.querySelector('#B');

        if (event.target.files.length > 0) {

            check.style.display = 'none';
            checks.style.display = 'flex'

            Array.from(event.target.files).forEach(file => {
                var reader = new FileReader();
                reader.onload = function () {
                    var img = document.createElement("img");
                    img.src = reader.result;
                    img.classList.add("cricular-img");
                    img.style.width = "400px";
                    img.style.height = "350px";
                    img.style.objectFit = "cover";
                    img.style.borderRadius = "5px";
                    listImageInput.appendChild(img);
                };
                reader.readAsDataURL(file);
            });
        }
        checkPostStatus();

    }

    function removePreview(event) {

        event.preventDefault();
        event.stopPropagation();

        let fileInput = document.getElementById("fileInput");
        let listImageDiv = document.querySelector(".ListImage");

        fileInput.value = "";

        listImageDiv.innerHTML = "";

        document.querySelector(".newImagePost").style.display = "none";

        document.querySelector(".image_div").style.display = "flex";
    }


    function checkPostStatus() {
        let postText = document.getElementById("postInput").value.trim();
        let fileInput = document.getElementById("fileA").files.length > 0;
        let privacySelect = document.getElementById("privacySelect").value;
        let postButton = document.getElementById("postButton");

        if (postText || fileInput || privacySelect) {
            postButton.disabled = false;
            postButton.style.backgroundColor = "#007bff";
            postButton.style.color = "white";
            postButton.style.cursor = "pointer";
        } else {
            postButton.disabled = false;
            postButton.style.backgroundColor = "#ccc";
            postButton.style.color = "#666";
            postButton.style.cursor = "not-allowed";
        }
    }

</script>

<style>
    input[type="file"] {
        display: none;
    }

    .custom-file-upload {
        display: inline-block;
        padding: 10px 15px;
        background-color: #b4b4b8;
        color: white;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
    }

    .custom-file-upload:hover {
        background-color: #4CAF50;
    }


    .done button {
        width: 70%;
        gap: 20px;
        padding: 10px;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        transition: 0.3s;
    }

    .done button:disabled {
        background-color: #ccc;
        color: #666;
    }

    .ListImage {
        display: flex;
        flex-direction: column;
        gap: 10px;
        max-height: 370px;
        overflow-y: auto;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    .ListImage img {
        width: 410px;
        height: 300px;
        object-fit: cover;
        border-radius: 5px;
    }


    .image-container {
        position: relative;
        display: inline-block;
    }

    .delete-btn {
        position: absolute;
        top: 5px;
        right: 5px;
        background: red;
        color: white;
        border: none;
        cursor: pointer;
        border-radius: 50%;
        padding: 2px 6px;
    }


    .newImagePost {
        display: none;
    }

    .image_div {
        display: flex;
        align-items: center;
        flex-direction: column;
        justify-content: center;
        width: 100%;
        height: 100%;
        border: 2px dashed grey;
        border-radius: 8px;
        cursor: pointer;
        text-align: center;
        transition: all 0.3s ease;
    }

    .image_div:hover {
        background-color: rgba(0, 0, 0, 0.1);
        border-color: black;
    }

    .new_image_div:hover {
        background-color: rgba(0, 0, 0, 0.1);
        border-color: black;
    }


    .done {
        width: 98%;
        height: 50px;
        margin: auto;
        padding: 10px;
        border-radius: 5px;
        border: 0;
    }

    button {
        width: 100%;
        align-items: center;
        justify-content: center;
        padding: 10px;
        border-radius: 5px;
        border: none;
    }

    a {
        text-decoration: none;
        color: black;
    }

    .image {
        width: 95%;
        padding: 5px;
        height: 300px;
        border: 1px solid silver;
        margin: auto;
        border-radius: 5px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
    }


    .image_div svg {
        margin-bottom: 10px;
    }

    .image_div div {
        font-size: 14px;
        font-weight: bold;
    }


    .image {
        width: 95%;
        padding: 5px;
        height: 350px;
        border: 1px solid silver;
        margin: auto;
        align-items: center;
        border-radius: 5px;

    }

    .text input {
        padding: 10px;
        width: 100%;
        height: 30px;
        border: 0;
    }

    .post_UI {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 10px;
    }

    .select {
        align-items: center;
        font-size: 10px;
        width: 110px;
        height: 25px;
        border: 0;
        background: #ececec;
        border-radius: 5px;
    }

    .top_nav {
        width: 100%;
        margin: auto;
        padding: 10px 10px;
    }

    .all {
        height: 600px;
        width: 30%;
        border: 1px solid silver;
        margin: auto;
        padding: 10px;
        border-radius: 10px;
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
</style>

