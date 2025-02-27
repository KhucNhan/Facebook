function acceptFriend(userID) {
    fetch(`/friends?action=acceptFriend&friendId=${encodeURIComponent(userID)}`, {
        method: "POST"
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                let acceptBtn = document.querySelector(`.accept-btn[data-id="${userID}"]`);
                let deleteBtn = document.querySelector(`.delete-btn[data-id="${userID}"]`);

                let confirmedBtn = document.querySelector(`.acceptFriend[data-id="${userID}"]`);

                acceptBtn.style.display = "none";
                deleteBtn.style.display = "none";

                confirmedBtn.style.display = "block";
            } else {
                alert("Có lỗi xảy ra!")
            }
        })
}


function acceptFriendSearch(userID) {
    fetch(`/friends?action=acceptFriend&friendId=${encodeURIComponent(userID)}`, {
        method: "POST"
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                let acceptBtn = document.querySelector(`.accept-search[data-id="${userID}"]`);
                let userCard = acceptBtn.closest('.user-card');

                let actionDiv = userCard.querySelector('.actions');
                if (actionDiv) {
                    actionDiv.innerHTML = `
                    <a class="btn btn-primary btn-sm message-search" data-id="${userID}">Nhắn tin</a>
                `;
                }
                let statusText = userCard.querySelector('.text-muted');
                if (statusText) {
                    statusText.innerText = "Bạn bè";
                    statusText.classList.remove("text-muted");
                    statusText.style.color = "var(--bs-secondary-color)";
                }
            } else {
                alert("Có lỗi xảy ra!")
            }
        })
}

function deleteFriend(userID) {
    fetch(`/friends?action=deleteFriend&friendId=${encodeURIComponent(userID)}`, {
        method: "POST"
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                let acceptBtn = document.querySelector(`.accept-btn[data-id="${userID}"]`);
                let deleteBtn = document.querySelector(`.delete-btn[data-id="${userID}"]`);

                let deletes = document.querySelector(`.deleteFriend[data-id="${userID}"]`);

                acceptBtn.style.display = "none";
                deleteBtn.style.display = "none";

                deletes.style.display = "block";
            } else {
                alert("Có lỗi xảy ra!")
            }
        })
}

function addFriend(userID) {
    fetch(`/friends?action=addFriend&friendId=${encodeURIComponent(userID)}`, {
        method: "POST"
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                let addBtn = document.querySelector(`.add-search[data-id="${userID}"]`);
                let userCard = addBtn.closest('.user-card');

                let actionDiv = userCard.querySelector('.actions');

                if (actionDiv) {
                    actionDiv.innerHTML = `
                    <a class="btn btn-warning btn-sm cancel-friend-search" data-id="${userID}" onclick="cancelFriend(${userID})">Hủy lời mời</a>
                `;
                }
                let statusText = userCard.querySelector('.text-muted');
                if (statusText) {
                    statusText.innerText = "Chưa kết bạn";
                    statusText.classList.remove("text-muted");
                    statusText.style.color = "var(--bs-secondary-color)";
                }
            } else {
                alert("Có lỗi xảy ra!")
            }
        })
}

function cancelFriend(userID) {
    fetch(`/friends?action=cancelFriend&friendId=${encodeURIComponent(userID)}`, {
        method: "POST"
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                let cancelFriend = document.querySelector(`.cancel-friend-search[data-id="${userID}"]`);
                let userCard = cancelFriend.closest('.user-card');

                let actionDiv = userCard.querySelector('.actions');

                if (actionDiv) {
                    actionDiv.innerHTML = `
                    <a class="btn btn-success btn-sm add-search" data-id="${userID}"  onclick="addFriend(${userID})">Thêm bạn bè</a>
                `;
                }
                let statusText = userCard.querySelector('.text-muted');
                if (statusText) {
                    statusText.innerText = "Chưa kết bạn";
                    statusText.classList.remove("text-muted");
                    statusText.style.color = "var(--bs-secondary-color)";
                }
            } else {
                alert("Có lỗi xảy ra!")
            }
        })
}

function unFriend(userID) {
    fetch(`/friends?action=unfriend&friendId=${encodeURIComponent(userID)}`, {
        method: "POST"
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                let friend = document.querySelector(`.friend[data-id="${userID}"]`);
                let unFriend = document.querySelector(`.unFiend[data-id="${userID}"]`);

                friend.style.display= "none";
                unFriend.style.display = "block"


            } else {
                alert("Có lỗi xảy ra!")
            }
        })
}