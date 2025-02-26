function toggleLike(commentId) {
    fetch('/posts?action=likeComment', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'commentId=' + encodeURIComponent(commentId)
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                let likeButton = document.querySelector(`a[data-comment-id='${commentId}']`);
                if (likeButton) {
                    if (data.isLiked) {
                        likeButton.textContent = "Thích";
                        likeButton.style.color = "blue";
                    } else {
                        likeButton.textContent = "Thích";
                        likeButton.style.color = "gray";
                    }
                } else {
                    console.error("Không tìm thấy nút like!");
                }
            }
        })
        .catch(error => console.error('Lỗi:', error));
}

document.addEventListener("click", function(event) {
    if (event.target.classList.contains("like-button")) {
        let commentId = event.target.getAttribute("data-comment-id");
        toggleLike(commentId);
    }
});

