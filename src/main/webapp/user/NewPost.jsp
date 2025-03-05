<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="all">
    <form action="posts?action=newPost" method="post" enctype="multipart/form-data">
        <!-- Header section -->
        <div class="top_nav">
            <div style="font-size: 2em; text-align: center; border-bottom: 1px solid black">
                <b>Tạo bài viết</b>
            </div>
            <div class="post_UI">
                <div>
                    <img src="${pageContext.request.contextPath}/uploads/avatars/${user.image}" style="width: 40px; height: 40px; border-radius: 50%" alt="Avt">
                </div>
                <div>
                    <div class="fw-bold">${user.name}</div>
                    <select class="form-select form-select-sm mt-1 select" name="privacy" id="privacySelect"
                            style="padding-right: 0px">
                        <option value="Public">🌍 Công khai</option>
                        <option value="Private">🔒 Chỉ mình tôi</option>
                        <option value="Friends">👥 Bạn của bạn bè</option>
                    </select>
                </div>
            </div>
            <div class="text">
                <input type="text" id="postInput" name="content" placeholder="Bạn đang nghĩ gì thế?"
                       oninput="checkPostStatus()">
            </div>
        </div>
        <div>
            <div class="image" id="A">
                <div>
                    <label for="fileA" class="custom-file-upload">Thêm ảnh/video</label>
                    <input type="file" id="fileA"  name="fileA[]" onchange="newImage(event)" multiple>
                </div>
            </div>
            <div style="border: 0px" class="ListImage" id="listImageInput">
                <div id="B" style="display: none">
                    <label for="fileB" class="custom-file-upload">Thêm ảnh/video</label>
                    <input id="fileB" type="file" name="fileB[]" onchange="newImage(event)" multiple>
                    <button style="background: #F44336;width: 100px;color: white;margin-left: 30px" class="delete-button" onclick="clearImages(event)">Xóa ảnh</button>
                </div>
            </div>
        </div>

        <div class="done">
            <button type="submit" id="postButton">Đăng</button>
        </div>
    </form>
</div>

<%--</body>--%>
<%--</html>--%>
<script>
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
        let postButton = document.getElementById("postButton");

        if (postText || fileInput) {
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
        width: 100%;
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
        width: 350px;
        height: 150px;
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
        height: 630px;
        width: 100%;
        border: 1px solid silver;
        margin: auto;
        padding: 10px;
        border-radius: 10px;
    }
</style>
