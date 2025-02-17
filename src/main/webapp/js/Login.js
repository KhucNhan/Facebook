function togglePassword() {
    var passwordField = document.getElementById('passwordField');
    var eyeIcon = document.getElementById('eyeIcon');

    if (passwordField.value === "") {
        eyeIcon.style.visibility = 'hidden';
    } else {
        eyeIcon.style.visibility = 'visible';
    }
}

function togglePasswordVisibility() {
    var passwordField = document.getElementById('passwordField');
    var eyeIcon = document.getElementById('eyeIcon');

    if (passwordField.type === 'password') {
        passwordField.type = 'text';
        eyeIcon.src = "https://img.icons8.com/ios/50/000000/invisible.png";
    } else {
        passwordField.type = 'password';
        eyeIcon.src = "https://cdn2.iconfinder.com/data/icons/ui-essential-10/24/hide-512.png";
    }
}

window.onload = function () {
    togglePassword();
};


var users = [
    {email: "admin@gmail.com", password: "123456"},
    {email: "user@gmail.com", password: "654321"}
];

function validateLogin() {

    var emailField = document.getElementById('emailField');
    var passwordField = document.getElementById('passwordField');
    var emailWarning = document.getElementById('emailWarning');
    var emailError = document.getElementById('emailError');
    var passwordError = document.getElementById('passwordError');

    var pass = document.getElementById('pass');

    emailField.classList.remove('error');
    passwordField.classList.remove('error');
    emailWarning.style.display = "none";
    emailError.style.display = "none";
    passwordError.style.display = "none";

    var user = users.find(user => user.email === email);

    if (!email) {
        emailField.classList.add('error');
        emailWarning.style.display = "inline";
        emailError.textContent = "Vui lòng nhập email!";
        emailError.style.display = "block";
        return;
    }
    // if (!user) {
    //     emailField.classList.add('error');
    //     emailWarning.style.display = "inline";
    //     emailError.textContent = "Email hoặc số di động bạn nhập không kết nối với tài khoản nào. Hãy tìm tài khoản của bạn và đăng nhập!";
    //     emailError.style.display = "block";
    //     emailError.style.color = "red";
    //     emailError.style.fontSize = "14px";
    //     emailField.style.borderColor = "red";
    //     emailError.style.marginBottom = "-25px";
    //     emailError.style.marginTop = "5px";
    //
    //     return;
    // }

    if (!password) {
        emailField.style.borderColor = "gainsboro";

        passwordField.classList.add('error');
        passwordField.classList.add('error');
        passwordError.textContent = "Vui lòng nhập mật khẩu!";
        passwordError.style.display = "block";
        passwordError.style.color = "red";
        passwordError.style.fontSize = "14px";
        pass.style.borderColor = " red";
        return;
    }

    emailField.style.borderColor = "gainsboro";
    pass.style.borderColor = "gainsboro";
    showModal();
}

function showModal() {
    var modal = document.getElementById("successModal");
    modal.style.display = "block";

    setTimeout(function () {
        closeModal();
    }, 3000);

}

function closeModal() {
    var modal = document.getElementById("successModal");
    modal.style.display = "none";
}

