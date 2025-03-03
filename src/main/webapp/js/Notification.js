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


