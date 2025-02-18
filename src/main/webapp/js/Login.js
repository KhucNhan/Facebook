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



    if (emailField.value === "") {
        emailField.classList.add('error');
        emailWarning.style.display = "inline";
        emailError.textContent = "Vui lòng nhập email hoặc số điện thoại!";
        emailError.style.display = "block";
        emailError.style.color = "red";
        emailError.style.marginBottom= "-20px"
        emailField.style.borderColor = "red";
        return;
    }

    var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com|vn|org|net|edu|gov|info)$/;
    var phonePattern = /^[0-9]{10,11}$/;

    if (!emailPattern.test(emailField.value)  && !phonePattern.test(emailField.value)) {
        emailField.classList.add('error');
        emailWarning.style.display = "inline";
        emailError.textContent = "Vui lòng nhập email hợp lệ hoặc số điện thoại!";
        emailError.style.display = "block";
        emailError.style.marginBottom= "-20px";
        emailError.style.color = "red";
        emailField.style.borderColor = "red";
        return;
    }

    if (passwordField.value === "") {
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



    fetch('/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: `email=${encodeURIComponent(emailField.value)}&password=${encodeURIComponent(passwordField.value)}`
    })
        .then(response => response.json())
        .then(data => {
            console.log(data)
            if (data.success) {
                if (data.message === "Admin") {
                    console.log("Admin")
                    window.location.href = '/users';
                } else {
                    console.log("User")
                    // window.location.href = '/user';
                }
            } else {
                passwordError.textContent = data.message;
                passwordError.style.display = "block";
                passwordError.style.color = "red";
                passwordError.style.fontSize = "15px";
                emailField.style.borderColor = "red";
                passwordField.style.borderColor = "red";


            }
        })
        .catch(error => {
            console.error('Lỗi kết nối:', error);
        });

    emailField.style.borderColor = "gainsboro";
    passwordField.style.borderColor = "gainsboro";
}





