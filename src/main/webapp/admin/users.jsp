<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Facebook</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .container-fluid {
            height: 100%;
            padding: 2%;
            font-size: large;
        }
        .container-fluid > .row > div:first-child {
            border-radius: 8px;
            background-color: #d3d3d373;
            margin:5px;
            padding:10px;
        }

        .container-fluid > .row > div:last-child > .row {
            border-radius: 8px;
            background-color: #d3d3d373;
            margin:5px;
            padding:10px;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row d-flex justify-content-center">
        <%--    Left    --%>
        <div class="col-md-2">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="#">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house"
                             viewBox="0 0 16 16">
                            <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L2 8.207V13.5A1.5 1.5 0 0 0 3.5 15h9a1.5 1.5 0 0 0 1.5-1.5V8.207l.646.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293zM13 7.207V13.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V7.207l5-5z"/>
                        </svg>
                        Trang chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-people"
                             viewBox="0 0 16 16">
                            <path d="M15 14s1 0 1-1-1-4-5-4-5 3-5 4 1 1 1 1zm-7.978-1L7 12.996c.001-.264.167-1.03.76-1.72C8.312 10.629 9.282 10 11 10c1.717 0 2.687.63 3.24 1.276.593.69.758 1.457.76 1.72l-.008.002-.014.002zM11 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4m3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0M6.936 9.28a6 6 0 0 0-1.23-.247A7 7 0 0 0 5 9c-4 0-5 3-5 4q0 1 1 1h4.216A2.24 2.24 0 0 1 5 13c0-1.01.377-2.042 1.09-2.904.243-.294.526-.569.846-.816M4.92 10A5.5 5.5 0 0 0 4 13H1c0-.26.164-1.03.76-1.724.545-.636 1.492-1.256 3.16-1.275ZM1.5 5.5a3 3 0 1 1 6 0 3 3 0 0 1-6 0m3-2a2 2 0 1 0 0 4 2 2 0 0 0 0-4"/>
                        </svg>
                        Quản lý người dùng
                        </a>
                </li>
            </ul>
        </div>

        <%--       Right        --%>
        <div class="col-md-9">
            <%--            Nav            --%>
            <div class="row">
                <ul class="nav justify-content-end">
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="#">Active</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Dropdown
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">Action</a></li>
                            <li><a class="dropdown-item" href="#">Another action</a></li>
                            <li><a class="dropdown-item" href="#">Log out</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <br>

            <%--       Center         --%>
            <div class="row d-flex justify-content-center">
                <form action="" method="post">
                    <div class="input-group mb-3" style="margin: 0">
                        <span class="input-group-text" id="basic-addon1">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                 class="bi bi-search" viewBox="0 0 16 16">
                            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                            </svg>
                        </span>
                        <input type="text" class="form-control" placeholder="Search here..." aria-label="Search here..."
                               aria-describedby="basic-addon1">
                    </div>
                </form>

                <table cellpadding="5" class="table">
                    <thead style="place-items: stretch; display: block; text-transform: uppercase; width: 99%;">
                    <tr>
                        <th style="width: 3%;" class="text-center">#</th>
                        <th style="width: 10%" class="text-center">Ảnh</th>
                        <th style="width: 10%" class="text-center">Tên</th>
                        <th style="width: 10%" class="text-center">Email</th>
                        <th style="width: 10%" class="text-center">SĐT</th>
                        <th style="width: 10%" class="text-center">Giới tính</th>
                        <th style="width: 10%" class="text-center">Ngày sinh</th>
                        <th style="width: 10%" class="text-center">Vai trò</th>
                        <th style="width: 12%" class="text-center">Trạng thái</th>
                        <th style="width: 15%" class="text-center">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
<%--                    <c:forEach var="user" items="${users}">--%>
<%--                        <tr class="d-flex">--%>
<%--                            <td style="width: 3%;" class="text-center">${user.userID}</td>--%>
<%--                            <td style="width: 10%;" class="text-center"><img style="" src="${user.image}"></td>--%>
<%--                            <td style="width: 10%;" class="text-center">${user.name}</td>--%>
<%--                            <td style="width: 10%;" class="text-center">${user.email}</td>--%>
<%--                            <td style="width: 10%;" class="text-center">${user.phone}</td>--%>
<%--                            <td style="width: 10%;" class="text-center">${user.gender ? 'Nam' : 'Nữ'}</td>--%>
<%--                            <td style="width: 10%;" class="text-center">${user.dateOfBirth}</td>--%>
<%--                            <td style="width: 10%;" class="text-center">${user.role}</td>--%>
<%--                            <td style="width: 12%;" class="text-center">${user.status ? 'Active' : 'Blocked'}</td>--%>
<%--                            <td style="width: 15%;" class="text-center">--%>
<%--                                <a class="btn btn-warning" href="/users?action=edit&userID=${user.userID}">Edit</a>--%>

<%--                                <c:if test="${user.status == true}">--%>
<%--                                    <a class="btn btn-danger" href="/users?action=delete&userID=${user.userID}">Inactive</a>--%>
<%--                                </c:if>--%>
<%--                                <c:if test="${!user.status == true}">--%>
<%--                                    <a class="btn btn-success" href="/users?action=active&userID=${user.userID}">Active</a>--%>
<%--                                </c:if>--%>
<%--                            </td>--%>
<%--                        </tr>--%>
<%--                    </c:forEach>--%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
