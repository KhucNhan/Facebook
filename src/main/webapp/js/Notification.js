function gotoNotification(event) {
    let notification = document.getElementById("notification");
    let message = document.getElementById("notificationMess");

    let iconTB = document.getElementById("iconTB");
    let iconMessage = document.getElementById("iconMessage");

    message.style.display = "none";
    iconMessage.style.fill = "silver";

    notification.style.display = "block";
    iconTB.style.fill = "#0866ff";

    event.stopPropagation();
}

function gotoNotificationMess(event) {
    let notification = document.getElementById("notification");
    let message = document.getElementById("notificationMess");
    let iconTB = document.getElementById("iconTB");
    let iconMessage = document.getElementById("iconMessage");

    notification.style.display = "none";
    iconTB.style.fill = "silver";

    message.style.display = "block";
    iconMessage.style.fill = "#0866ff";
    event.stopPropagation();
}

document.addEventListener("click", function (event) {
    let notification = document.getElementById("notification");
    let message = document.getElementById("notificationMess");
    let buttonTB = document.getElementById("notificationIcon");
    let buttonMessage = document.getElementById("notificationMessage");
    let iconTB = document.getElementById("iconTB");
    let iconMessage = document.getElementById("iconMessage");

    if (
        notification.style.display === "block" &&
        !notification.contains(event.target) &&
        event.target !== buttonTB
    ) {
        notification.style.display = "none";
        iconTB.style.fill = "silver";
    }

    if (
        message.style.display === "block" &&
        !message.contains(event.target) &&
        event.target !== buttonMessage
    ) {
        message.style.display = "none";
        iconMessage.style.fill = "silver";
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
            el.style.fontSize = "12px";
        }
    });
}
function updateTimeAgoMess() {
    const elements = document.querySelectorAll('.notificationMess-time');

    elements.forEach(el => {
        const isoTime = el.getAttribute('data-time'); // Lấy thời gian từ thuộc tính data-time
        if (isoTime) {
            const timeAgo = timeSinceMess(new Date(isoTime));
            el.textContent = timeAgo;
            el.style.marginTop="-22px"
            el.style.marginLeft = "240px";
            el.style.fontSize = "13px";
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

function timeSinceMess(date) {
    const seconds = Math.floor((new Date() - date) / 1000);
    let interval = Math.floor(seconds / 31536000);

    if (interval > 1) return interval + " năm";
    interval = Math.floor(seconds / 2592000);
    if (interval > 1) return interval + " tháng";
    interval = Math.floor(seconds / 86400);
    if (interval >= 1) return interval + " ngày";
    interval = Math.floor(seconds / 3600);
    if (interval >= 1) return interval + " giờ";
    interval = Math.floor(seconds / 60);
    if (interval >= 1) return interval + " phút";
    return "Vừa xong";
}

document.addEventListener("DOMContentLoaded", function () {
    console.log("DOM đã tải xong, bắt đầu cập nhật thời gian...");
    setTimeout(updateTimeAgo, 500);
    setInterval(updateTimeAgo, 60000);

    setTimeout(updateTimeAgoMess, 500);
    setInterval(updateTimeAgoMess, 60000);
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
function updateIsReadNotificationMess(event, notificationID, statusNotification) {

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
                    let notificationElement = event.target.closest(".notificationMess-content");

                    notificationElement.classList.remove('unread');
                    notificationElement.classList.add('read');

                    let dotIcon = notificationElement.querySelector('.readAndUnRead');
                    dotIcon.style.display = 'none';

                    notificationElement.onclick = null;
                }
            })
    }
}
