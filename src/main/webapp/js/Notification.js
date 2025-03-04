function gotoNotification(event) {
    let include = document.getElementById("notification");
    let icon = document.getElementById("iconTB");

    include.style.display = "block";
    icon.style.fill = "#0866ff";
    event.stopPropagation();
}

document.addEventListener("click", function (event) {
    let include = document.getElementById("notification");
    let button = document.getElementById("notificationIcon");
    let icon = document.getElementById("iconTB");

    if (include.style.display === "block" && !include.contains(event.target) && event.target !== button) {
        include.style.display = "none";
        icon.style.fill = "silver";
    }
});

// Hàm để cập nhật thời gian theo dạng "x phút trước"
function updateTimeAgo() {
    const elements = document.querySelectorAll('.notification-time');

    elements.forEach(el => {
        const isoTime = el.getAttribute('data-time'); // Lấy thời gian từ thuộc tính data-time
        if (isoTime) {
            const timeAgo = timeSince(new Date(isoTime));
            el.textContent = timeAgo; // Hiển thị thời gian đã xử lý
            el.style.marginLeft = "60px";
            el.style.fontSize = "0.9em";
            el.style.color="#0866ff"
        }
    });
}

// Hàm tính thời gian "x phút trước"
function timeSince(date) {
    const seconds = Math.floor((new Date() - date) / 1000);
    let interval = Math.floor(seconds / 31536000);

    if (interval > 1) return interval + " năm trước";
    interval = Math.floor(seconds / 2592000);
    if (interval > 1) return interval + " tháng trước";
    interval = Math.floor(seconds / 86400);
    if (interval >= 1) return interval + " ngày trước";
    interval = Math.floor(seconds / 3600);
    if (interval >= 1) return interval + " giờ trước";
    interval = Math.floor(seconds / 60);
    if (interval >= 1) return interval + " phút trước";
    return "Vừa xong";
}

// Đợi DOM tải xong rồi mới cập nhật thời gian
document.addEventListener("DOMContentLoaded", function () {
    console.log("DOM đã tải xong, bắt đầu cập nhật thời gian...");
    setTimeout(updateTimeAgo, 500);  // Chạy ngay khi tải xong
    setInterval(updateTimeAgo, 60000); // Cập nhật mỗi phút
});

