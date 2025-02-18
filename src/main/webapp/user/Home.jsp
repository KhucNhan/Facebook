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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous">

    </script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">


    <title>Facebook</title>
</head>
<body>

<div class="menu">
    <!-- Logo Facebook -->
    <svg xmlns="http://www.w3.org/2000/svg" width="40" height="45" fill="currentColor" class="bi bi-facebook"
         viewBox="0 0 16 16" style="color: #0866ff; margin-right: 20px;">
        <path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951"/>
    </svg>

    <!-- Ô tìm kiếm -->
    <div class="search-container">
        <input class="search" type="text" placeholder="Tìm kiếm trên Facebook">
        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="silver" class="bi bi-search iconFacebook"
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
                            <img src="https://png.pngtree.com/png-vector/20191009/ourlarge/pngtree-user-icon-png-image_1796659.jpg"
                                 alt="User Icon" width="37" height="37"
                                 style="border-radius: 50%;margin-top: -10px;margin-right: -20px;position: relative">
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">Thông tin cá nhân</a></li>
                            <li><a class="dropdown-item" href="#">Mật khẩu</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="#">Đăng xuất</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div style="display: flex;height: 90%">
    <div class="left">
        <div class="leftIcon">
            <div>
                <img src="https://png.pngtree.com/png-vector/20191009/ourlarge/pngtree-user-icon-png-image_1796659.jpg"
                     alt="User Icon" width="50" height="50" style="border-radius: 50%;margin-left: -62px">
            </div>
            <div>
                <b>
                    Khúc Nhân
                </b>
            </div>
        </div>
        <div class="leftIcon">
            <div>
                <svg xmlns="http://www.w3.org/2000/svg" width="45" height="45" style="margin-left: -90px"
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
                <b style="margin-left: -30px">
                    Bạn bè
                </b>
            </div>
        </div>
    </div>


    <div class="center">
        <form action="">
            <input class="form-control" type="text" placeholder="Default input" aria-label="default input example">
        </form>
        <div class="post-container">
            <c:forEach items="${posts}" var="post">
                <div class="post-card">
                    <div class="introduce" style="display: flex; justify-content: space-between">
                        <div style="display: flex">
                            <img src="${post.user.image}" style="height: 50px;width: 50px; border-radius: 50%">
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
                                <a href="" style="font-size: large; font-weight: bold;text-decoration: none; color: grey">...</a>
                            </div>
                            <div>
                                <a href="" style="color: grey">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" fill="currentColor"
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

                    </div>
                    <div class="post-information" style="display: flex;">
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


    <div class="right">
        <div class="rightMenu">
            <div style="width: 170px" id="contactLabel">
                <label>Người liên hệ</label>
            </div>
            <div id="search-container" style="display: none;">
                <input type="text" id="searchInput" placeholder="Tìm kiếm"
                       style="padding: 5px; border-radius: 5px; border: 0px solid #e8e8e8;width: 180px;background: #ececec">
            </div>
            <div class="searchBB" id="search-input">
                <svg xmlns="http://www.w3.org/2000/svg" width="25" height="20" fill="currentColor" class="bi bi-search"
                     viewBox="0 0 16 16" onclick="showSearchInput()">
                    <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                </svg>
            </div>

            <div style="margin-bottom: 15px;font-size: 1em;margin-left: 10px">
                <b>...</b>
            </div>
        </div>
        <div></div>
    </div>
</div>
</body>
</html>

<script>
    function showSearchInput() {
        const contactLabel = document.getElementById('contactLabel');
        const searchContainer = document.getElementById('search-container');
        const search = document.getElementById('search-input')

        contactLabel.style.display = 'none';
        searchContainer.style.display = 'block';
        search.style.marginLeft = '-10px'

    }

    function hideSearchInput(event) {
        const searchContainer = document.getElementById('search-container');
        const contactLabel = document.getElementById('contactLabel');

        if (!searchContainer.contains(event.relatedTarget) && !contactLabel.contains(event.relatedTarget)) {
            searchContainer.style.display = 'none';
            contactLabel.style.display = 'block';
            contactLabel.style.marginLeft = '10px'
        }
    }

    document.getElementById('search-container').addEventListener('mouseout', hideSearchInput);
    document.getElementById('contactLabel').addEventListener('mouseout', hideSearchInput);


</script>
<style>
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
        padding: 60px;
    }

    .post-card {
        padding: 10px;
        border-radius: 8px;
        margin-bottom: 20px;
        box-shadow: 0 1px 4px 0;
    }
</style>