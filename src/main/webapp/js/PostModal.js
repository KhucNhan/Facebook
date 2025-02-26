function showPostPopup(postId) {
    fetch("/posts?action=postModal&postId=" + postId)
        .then(response => response.text())
        .then(html => {
            let modalContainer = document.createElement("div");
            modalContainer.classList.add("modal-overlay");
            modalContainer.innerHTML = html;
            document.body.appendChild(modalContainer);
        })
        .catch(error => console.error("Lỗi khi tải bài viết:", error));
}

function closePostModal() {
    let modal = document.querySelector(".modal-overlay");
    if (modal) modal.remove();
}

function submitComment(postId) {
    let inputField = document.getElementById("comment-input-" + postId);
    let commentText = inputField.value.trim();

    if (commentText === "") {
        alert("Vui lòng nhập bình luận!");
        return;
    }

    $.ajax({
        url: "/comments?action=add",
        type: "POST",
        data: {postId: postId, content: commentText},
        success: function (response) {
            let commentsList = document.querySelector(".comments-list");
            let newComment = document.createElement("li");
            newComment.className = "comment-item";
            newComment.innerHTML = `
        <div class='comment-item' style='display: flex; align-items: flex-start; gap: 10px;margin-block:10px'>
            <div class='comment-avatar'>
                <img style='width:50px;height:50px;border-radius:50%;' src='/uploads/avatars/` + response.image + `' class='avatar'>
            </div>
            <div class='comment-body' style='background: #f0f2f5; padding: 10px; border-radius: 10px; max-width: 85%;'>
                <div class='comment-info' style='display: flex; align-items: center; gap: 8px; margin-bottom: 5px;'>
                    <strong class='comment-name' style='color: #050505;'>` + response.name + `</strong>
                    <span class='comment-time' style='color: #65676b; font-size: 12px;'>Vừa xong</span>
                </div>
                <div class='comment-content' style='color: #050505;'>` + response.content + `</div>
            </div>
        </div>
        <div class='comment-actions' style='display: flex; justify-content: start; padding-left: 70px;'>
                 <a class='like-button' style='background-color: inherit; width: fit-content; margin-right: 20px; cursor: pointer; color: grey;' onclick='likeComment(` + response.commentId + `)'>Thích</a>
                 <a class='reply-button' style='background-color: inherit; width: fit-content; cursor: pointer; color: grey;' onclick='replyToComment(` + response.commentId + `)'>Phản hồi</a>
        </div>
    `;

            commentsList.appendChild(newComment);
            inputField.value = ""; // Xóa nội dung input sau khi gửi
        },

        error: function () {
            alert("Có lỗi xảy ra, vui lòng thử lại!");
        }
    });
}



