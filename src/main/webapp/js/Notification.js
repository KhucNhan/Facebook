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

function updateTimeAgo() {
    const elements = document.querySelectorAll('.notification-time');

    elements.forEach(el => {
        const isoTime = el.getAttribute('data-time'); // Lấy thời gian từ thuộc tính data-time
        if (isoTime) {
            const timeAgo = timeSince(new Date(isoTime));
            el.textContent = timeAgo;
            el.style.marginLeft = "60px";
            el.style.fontSize = "0.9em";
        }
    });
}

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

document.addEventListener("DOMContentLoaded", function () {
    console.log("DOM đã tải xong, bắt đầu cập nhật thời gian...");
    setTimeout(updateTimeAgo, 500);
    setInterval(updateTimeAgo, 60000);
});


function updateIsReadNotification(event, notificationID, statusNotification) {

    if (!statusNotification) {

        fetch(`/notification?action=updateIsRead&notificationID=${notificationID}`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
        })
            .then(response => response.json())
            .then(data => {

                if (data.success) {
                    let notificationElement = event.target.closest(".notification-content");

                    notificationElement.classList.remove('unread');
                    notificationElement.classList.add('read');

                    let dotIcon = notificationElement.querySelector('.readAndUnRead');
                    dotIcon.style.display = 'none';

                    notificationElement.onclick = null;
                }
            })
    }
}
