<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 3/10/2025
  Time: 10:14 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>FaceEbook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous">
    </script>
</head>
<body>
    <div class="container" style="height: 100%; align-content: center">
        <div class="row" style="background-color: #00c0ff; border-top-left-radius: 8px; border-top-right-radius: 8px; border-top: 1px solid black; border-left: 1px solid black; border-right: 1px solid black;padding: 10px;">
            <h2>Tài khoản của bạn đã bị vô hiệu hóa vào thời điểm ${user.updateAt}</h2>
        </div>
        <div class="row" style="border-bottom-left-radius: 8px; border-bottom-right-radius: 8px; border: 1px solid black; padding: 10px; height: 75px;">
            <div class="d-flex" style="justify-content: space-between;align-self: center;">
                <p style="font-size: 20px ;margin: 0; align-content: center;">Bạn có muốn kích hoạt lại tài khoản ?</p>
                <span>
                    <a class="btn btn-primary" href="/users?action=activateAccount&userId=${user.userId}">Kích hoạt</a>
                    <a class="btn btn-secondary" href="/view/Login.jsp">Quay lại đăng nhập</a>
                </span>
            </div>
        </div>
    </div>
</body>
</html>
