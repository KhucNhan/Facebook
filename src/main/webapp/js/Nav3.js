function confirmLogout() {
    window.location.href = '/login?action=logout';
}

function loadHome(){
    window.location.href = '/home';
}

function goToFriends(){
    window.location.href = '/friends?action=friendRequests';
}

function hideSearchInput(event) {
    const searchContainer = document.getElementById('search-container');
    const contactLabel = document.getElementById('contactLabel');

    if (!searchContainer.contains(event.relatedTarget) && !contactLabel.contains(event.relatedTarget)) {
        searchContainer.style.display = 'none';
        contactLabel.style.display = 'block';
        // contactLabel.style.marginLeft = '10px'
    }
}

document.getElementById('search-container').addEventListener('mouseout', hideSearchInput);
document.getElementById('contactLabel').addEventListener('mouseout', hideSearchInput);

document.getElementById("searchInputNav").addEventListener("keypress", function(event) {
    if (event.key === "Enter") {
        event.preventDefault(); // Ngăn chặn hành vi mặc định nếu cần
        this.closest("form").submit(); // Submit form
    }
});