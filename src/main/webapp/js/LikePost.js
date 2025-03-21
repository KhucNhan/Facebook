document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".like-btn").forEach(function (button) {
        button.addEventListener("click", function () {
            let postId = this.getAttribute("data-post-id");
            let likeCountSpan = this.querySelector(".like-count");

            fetch(`/posts?action=likePost&postId=${postId}`, {
                method: "POST"
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        likeCountSpan.textContent = data.totalLikes;

                        if (this.classList.contains("liked")) {
                            this.classList.remove("liked"); // Bỏ like
                        } else {
                            this.classList.add("liked"); // Thả like
                        }
                    } else {
                        alert("Có lỗi xảy ra!");
                    }
                });
        });
    });
});
