function togglePanel() {
    const panel = document.getElementById('sidePanel');
    panel.classList.toggle('show'); // Thêm hoặc xóa class 'show'
}

// Đóng panel khi click ra ngoài
document.addEventListener("click", function(event) {
    const panel = document.getElementById('sidePanel');
    const button = document.querySelector(".toggle-btn");

    if (!panel.contains(event.target) && !button.contains(event.target)) {
        panel.classList.remove("show");
    }
});