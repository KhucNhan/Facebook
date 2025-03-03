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
                                    <li><a class='dropdown-item' href='#' onclick='editComment(${response.commentId})'>Sửa</a></li>
                                    <li><a class='dropdown-item' href='#' onclick='deleteComment(${response.commentId})'>Xóa</a></li>
                                ` : `
                                    <li><a class='dropdown-item' href='#' onclick='reportComment(${response.commentId})'>Báo cáo</a></li>
                                `}
                            </ul>
                        </div>
                    </div>

                    <div class='comment-content' style='color: #050505;'>${response.content}</div>
                </div>
            </div>
            <div class='comment-actions' style='display: flex; justify-content: start; padding-left: 70px;'>
                 <a class='like-button ' data-comment-id='${response.commentId}' style='background-color: inherit; width: fit-content; margin-right: 20px; cursor: pointer; color: grey;font-weight: bold' onclick='toggleLike(${response.commentId})'>Thích</a>
                 <a class='reply-button' style='background-color: inherit; width: fit-content; cursor: pointer; color: grey;' onclick='replyToComment(${response.commentId})'>Phản hồi</a>
            </div>
        `;
            commentsList.appendChild(newComment);
            inputField.value = "";
            let commentCount = document.getElementById("total-comment-" + response.postId);

            if (commentCount) {
                let currentCount = parseInt(commentCount.innerText, 10) || 0; // Ép kiểu và xử lý trường hợp NaN
                commentCount.innerText = currentCount + 1;
            } else {
                console.log(commentCount);
            }

            let commentListIsNull = document.getElementById("commentListIsNull" + response.postId);

            if (commentListIsNull) {
                commentListIsNull.style.display = "none";
            } else {
                console.log(response.postId);
            }
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
        data: {commentId: commentId},
        success: function (response) {
            if (response.success === "success") {
                let comment = "comment-" + commentId;
                document.getElementById(comment).remove();
                let commentCount = document.getElementById("total-comment-" + response.postId);

                if (commentCount) {
                    let currentCount = parseInt(commentCount.innerText, 10) || 0; // Ép kiểu và xử lý trường hợp NaN
                    commentCount.innerText = currentCount - 1;
                } else {
                    console.log(commentCount);
                }

                // let commentListIsNull = document.getElementById("commentListIsNull" + response.postId);
                //
                // if (commentListIsNull && (response.isEmpty === "true")) {
                //     commentListIsNull.style.display = "inherit";
                // } else {
                //     console.log(commentListIsNull);
                // }
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
        data: {commentId: commentId, content: newContent},
        success: function (response) {
            if (response.success === "success") {
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


function replyToComment(commentId) {
    let commentElement = document.getElementById(`comment-${commentId}`);
    if (!commentElement) return;
    let liCommentElement = commentElement.closest("li");

    // Kiểm tra nếu form phản hồi đã tồn tại, tránh tạo nhiều lần
    if (liCommentElement.querySelector(".reply-form")) return;

    // Tạo form nhập phản hồi
    let replyForm = document.createElement("div");
    replyForm.className = "reply-form";
    replyForm.style.display = "flex";
    replyForm.style.alignItems = "baseline";
    replyForm.innerHTML = `
        <textarea id="reply-input-${commentId}" class="reply-input" placeholder="Viết phản hồi..." style=" height: 42px;flex: 1; padding: 8px; border-radius: 20px; border: 1px solid #ddd;width: 80%; margin-top: 10px;"></textarea>
        <button onclick="submitReply(${commentId})" class="btn btn-primary btn-sm" style='margin-left: 10px; background: blue; color: white; padding: 5px 15px; border: none; border-radius: 10px; cursor: pointer;width:fit-content; height: fit-content'>Gửi</button>
        <button onclick="cancelReply(${commentId})" class="btn btn-secondary btn-sm" style='margin-left: 10px; background: grey; color: white; padding: 5px 15px; border: none; border-radius: 10px; cursor: pointer;width:fit-content; height: fit-content'>Hủy</button>
    `;

    // Chèn form vào dưới bình luận
    liCommentElement.appendChild(replyForm);
}

function cancelReply(commentId) {
    let cmt = document.getElementById("comment-" + commentId);
    let li = cmt.closest("li");
    let replyForm = li.querySelector(".reply-form")
    if (replyForm) {
        replyForm.remove();
    } else {
        console.log(commentId);
        console.log(replyForm);
    }
}

function submitReply(commentId) {
    let inputField = document.getElementById(`reply-input-${commentId}`);
    let replyText = inputField.value.trim();

    if (replyText === "") {
        alert("Vui lòng nhập nội dung phản hồi!");
        return;
    }

    $.ajax({
        url: "/comments?action=reply",
        type: "POST",
        data: {parentCommentId: commentId, content: replyText},
        success: function (response) {
            console.log(response);
            if (response.success) {
                let commentElement = document.getElementById(`comment-${commentId}`);
                let liCommentElement = commentElement.closest("li");
                let repliesContainer = commentElement.querySelector(".replies-list");

                // Nếu chưa có danh sách phản hồi, tạo mới
                if (!repliesContainer) {
                    repliesContainer = document.createElement("ul");
                    repliesContainer.className = "replies-list";
                    repliesContainer.style.listStyleType = "none";
                    repliesContainer.style.paddingLeft = "60px";
                    repliesContainer.style.marginTop = "10px";
                    liCommentElement.appendChild(repliesContainer);
                }

                // Thêm phản hồi vào danh sách
                let newReply = document.createElement("li");
                newReply.className = "reply-item";
                newReply.innerHTML = `
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
                                    <li><a class='dropdown-item' href='#' onclick='editComment(${response.commentId})'>Sửa</a></li>
                                    <li><a class='dropdown-item' href='#' onclick='deleteComment(${response.commentId})'>Xóa</a></li>
                                ` : `
                                    <li><a class='dropdown-item' href='#' onclick='reportComment(${response.commentId})'>Báo cáo</a></li>
                                `}
                            </ul>
                        </div>
                    </div>

                    <div class='comment-content' style='color: #050505;'>${response.content}</div>
                </div>
            </div>
            <div class='comment-actions' style='display: flex; justify-content: start; padding-left: 70px;'>
                 <button class='like-button' data-comment-id='${response.commentId}'  style='background-color: inherit;padding:0; width: fit-content; margin-right: 20px; cursor: pointer; color: grey;font-weight: bold' onclick='toggleLike(${response.commentId})'>Thích</button>
                 <button class='reply-button' style='background-color: inherit;padding:0; width: fit-content; cursor: pointer; color: grey;' onclick='replyToComment(${response.commentId})'>Phản hồi</button>
            </div>
                `;
                repliesContainer.appendChild(newReply);
                inputField.value = ""; // Xóa nội dung sau khi gửi
                cancelReply(commentId); // Ẩn form phản hồi sau khi gửi

                // sau khi cmt sẽ tăng số lượng cmt
                let commentCount = document.getElementById("total-comment-" + response.postId);

                if (commentCount) {
                    let currentCount = parseInt(commentCount.innerText, 10) || 0; // Ép kiểu và xử lý trường hợp NaN
                    commentCount.innerText = currentCount + 1;
                } else {
                    console.log(commentCount);
                }
            } else {
                alert("Gửi phản hồi thất bại! Vui lòng thử lại.");
            }
        },
        error: function () {
            alert("Có lỗi xảy ra, vui lòng thử lại!");
        }
    });
}

document.addEventListener("click", function (event) {
    if (event.target.classList.contains("like-button")) {
        let commentId = event.target.getAttribute("data-comment-id");
        toggleLike(commentId);
    }
});
