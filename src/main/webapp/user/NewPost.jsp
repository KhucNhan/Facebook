<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 2/18/2025
  Time: 8:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tạo bài viết</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
</head>
<body style="margin-top: 30px">
<div class="all">
    <div class="top_nav">
        <div style="font-size: 2em;text-align: center;border-bottom: 1px solid black">
            <b>
                Tạo bài viết
            </b>
        </div>
        <div class="center">
            <div>
                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor"
                     class="bi bi-person-circle" viewBox="0 0 16 16">
                    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
                    <path fill-rule="evenodd"
                          d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
                </svg>
            </div>
            <div>
                <div class="fw-bold">Khúc Nhân</div>
                <select class="form-select form-select-sm mt-1 select" id="privacySelect" style="padding-right: 0px">
                    <option value="private">🔒 Chỉ mình tôi</option>
                    <option value="friends-of-friends">👥 Bạn của bạn bè</option>
                    <option value="public">🌍 Công khai</option>
                </select>
            </div>
        </div>
        <div class="text">
            <input type="text" placeholder="Bạn đang nghĩ gì thế?">
        </div>
    </div>
    <a href="">
        <div class="image">
            <div class="image_div">
                <div>
                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor"
                         class="bi bi-images"
                         viewBox="0 0 16 16">
                        <path d="M4.502 9a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3"/>
                        <path d="M14.002 13a2 2 0 0 1-2 2h-10a2 2 0 0 1-2-2V5A2 2 0 0 1 2 3a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v8a2 2 0 0 1-1.998 2M14 2H4a1 1 0 0 0-1 1h9.002a2 2 0 0 1 2 2v7A1 1 0 0 0 15 11V3a1 1 0 0 0-1-1M2.002 4a1 1 0 0 0-1 1v8l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71a.5.5 0 0 1 .577-.094l1.777 1.947V5a1 1 0 0 0-1-1z"/>
                    </svg>
                </div>
                <div class="">
                    <div>Thêm ảnh/video</div>
                    <div>hoặc kéo và thả</div>
                </div>
            </div>
        </div>
    </a>
    <div class="done">
        <button>
            Đăng
        </button>
    </div>
</div>
</body>
</html>
<style>
    .done{
        width: 98%;
        height: 50px;
        margin:auto ;
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

    .image_div {
        width: 99%;
        height: 99%;
        background: #ececec;
        border-radius: 5px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding: 10px;
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
        height: 300px;
        border: 1px solid silver;
        margin: auto;
        align-items: center;
        border-radius: 5px;

    }

    .text input {
        padding: 10px;
        width: 100%;
        height: 70px;
        border: 0;
    }

    .center {
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
        padding: 20px 10px;
    }

    .all {
        height: 630px;
        width: 40%;
        border: 1px solid silver;
        margin: auto;
        padding: 10px;
        border-radius: 5px;
    }
</style>
<script></script>
