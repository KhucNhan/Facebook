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
        data: { postId: postId, content: commentText },
        success: function (response) {
            let commentsList = document.querySelector(".comments-list");

            // Tạo phần tử bình luận mới
            let newComment = document.createElement("li");
            newComment.className = "comment-item";
            newComment.id = `comment-${response.commentId}`;
            newComment.innerHTML = `
            <div class='comment-item' id='comment-${response.commentId}' style='display: flex; align-items: flex-start; gap: 10px;'>
                <div class='comment-avatar'>
                    <img style='width:50px;height:50px;border-radius:50%;' src='/uploads/avatars/${response.image}' class='avatar'>
                </div>
                <div class='comment-body' style='background: #f0f2f5; padding: 10px; border-radius: 10px; max-width: 85%; position: relative;'>
                    <div class='comment-info' style='display: flex; align-items: center; gap: 8px; margin-bottom: 5px;'>
                        <strong class='comment-name' style='color: #050505;'>${response.name}</strong>
                        <span class='comment-time' style='color: #65676b; font-size: 12px;'>Vừa xong</span>

                        <div class='nav-item dropdown ms-auto'>
                            <a class='nav-link' href='#' role='button' data-bs-toggle='dropdown' data-bs-auto-close="outside" aria-expanded='false'>
                                <i class='bi bi-three-dots'></i>
                            </a>
                            <ul class='dropdown-menu'>
                                ${response.isOwner ? `
                                    <li><a class='dropdown-item text-primary' href='#' onclick='editComment(${response.commentId})'>Sửa</a></li>
                                    <li><a class='dropdown-item text-danger' href='#' onclick='deleteComment(${response.commentId})'>Xóa</a></li>
                                ` : `
                                    <li><a class='dropdown-item text-warning' href='#' onclick='reportComment(${response.commentId})'>Báo cáo</a></li>
                                `}
                            </ul>
                        </div>
                    </div>

                    <div class='comment-content' style='color: #050505;'>${response.content}</div>
                </div>
            </div>
            <div class='comment-actions' style='display: flex; justify-content: start; padding-left: 70px;'>
                 <a class='like-button' style='background-color: inherit; width: fit-content; margin-right: 20px; cursor: pointer; color: grey;' onclick='likeComment(\` + response.commentId + \`)'>Thích</a>
                 <a class='reply-button' style='background-color: inherit; width: fit-content; cursor: pointer; color: grey;' onclick='replyToComment(\` + response.commentId + \`)'>Phản hồi</a>
            </div>
        `;

            commentsList.appendChild(newComment);  // Thêm bình luận mới vào danh sách
            inputField.value = ""; // Xóa nội dung input sau khi gửi
        },

        error: function () {
            alert("Có lỗi xảy ra, vui lòng thử lại!");
        }
    });


}

function deleteComment(commentId) {
    closeDropdown(commentId);

    if (!confirm("Bạn có chắc chắn muốn xóa bình luận này?")) return;

    $.ajax({
        url: "/comments?action=delete",
        type: "POST",
        data: { commentId: commentId },
        success: function (response) {
            if (response.trim() === "success") {
                let comment = "comment-" + commentId;
                console.log(comment)
                document.getElementById(comment).remove();
            } else {
                alert("Xóa thất bại! Vui lòng thử lại.");
            }
        },
        error: function () {
            alert("Có lỗi xảy ra, vui lòng thử lại!");
        }
    });
}

function editComment(commentId) {
    closeDropdown(commentId);
    let commentContent = document.querySelector(`#comment-${commentId} .comment-content`);
    let oldContent = commentContent.innerText;

    // Hiển thị textarea thay vì nội dung bình luận
    commentContent.innerHTML = `
        <textarea id="edit-textarea-${commentId}" class="form-control">${oldContent}</textarea>
        <button class="btn btn-primary btn-sm mt-2" onclick="saveComment(${commentId})">Lưu</button>
        <button class="btn btn-secondary btn-sm mt-2" onclick="cancelEdit(${commentId}, '${oldContent}')">Hủy</button>
    `;
}

function saveComment(commentId) {
    let newContent = document.querySelector(`#edit-textarea-${commentId}`).value;

    $.ajax({
        url: "/comments?action=edit&commentId=" + commentId,
        type: "POST",
        data: { commentId: commentId, content: newContent },
        success: function (response) {
            if (response.trim() === "success") {
                document.querySelector(`#comment-${commentId} .comment-content`).innerText = newContent;
            } else {
                alert("Cập nhật thất bại! Vui lòng thử lại.");
            }
        },
        error: function () {
            alert("Có lỗi xảy ra, vui lòng thử lại!");
        }
    });
}

function cancelEdit(commentId, oldContent) {
    document.querySelector(`#comment-${commentId} .comment-content`).innerText = oldContent;
}

function closeDropdown(commentId) {
    let commentElement = document.getElementById(`comment-${commentId}`);
    if (commentElement) {
        let dropdownMenu = commentElement.querySelector(".dropdown-menu");
        if (dropdownMenu) {
            dropdownMenu.classList.remove("show");
        }
    }
}
