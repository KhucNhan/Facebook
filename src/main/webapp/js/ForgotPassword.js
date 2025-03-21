function checkPhone() {
    const phoneNumber = document.getElementById('phone').value;
    const phoneError = document.getElementById('phoneError');
    const phoneError_1 = document.getElementById('phoneError_1');


    var phoneRegex = /^0\d{9}$/;
    if (!phoneRegex.test(phoneNumber)) {
        phoneError.textContent = "Số điện thoại không hợp lệ. Vui lòng nhập lại.";
        phoneError_1.style.borderColor= "rep";
        phoneError.style.display = "block";
        return false;
    } else {
        fetch('/forgotPassword?action=checkPhone', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: `phone=${phoneNumber}`
        })
            .then(response => response.json())
            .then(data => {
                if (data.exists) {
                    document.getElementById('phoneForm').style.display = 'none';
                    document.getElementById('newPasswordFields').style.display = 'block';
                } else {
                    phoneError.textContent = "Số điện thoại không tồn tại trong hệ thống.";
                    phoneError.style.display = "block";
                }
            })
        return false;
    }
}

function checkPassword() {

    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const passError = document.getElementById('passError');

    if(newPassword !== confirmPassword){
        passError.style.display = "block";
        passError.textContent= "Mật khẩu không khớp. Hãy nhập lại!"

        return false;
    }else {
        return true;
    }
}


