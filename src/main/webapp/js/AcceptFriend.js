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

                acceptBtn.style.display="none";
                deleteBtn.style.display="none";

                confirmedBtn.style.display = "block";
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

                acceptBtn.style.display="none";
                deleteBtn.style.display="none";

                deletes.style.display = "block";
            } else {
                alert("Có lỗi xảy ra!")
            }
        })
}