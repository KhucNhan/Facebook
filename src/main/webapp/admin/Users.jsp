<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Facebook</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminNav.css">
    <script src="${pageContext.request.contextPath}/js/AdminNav.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>

        td {
            word-break: break-word;
            max-width: 100%;
            align-content: center;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row d-flex justify-content-center">
        <%--       Right        --%>
        <div class="col-md-12">
            <%--            Nav            --%>
            <jsp:include page="/AdminNav.jsp"></jsp:include>

            <%--       Center         --%>
            <div class="row d-flex justify-content-center" style="margin: 0; padding-top:10px;">
                <div style="display:flex; justify-content: space-between">
                    <a style="height: fit-content" href="/users?action=add" class="btn btn-primary">Thêm tài khoản</a>
                    <form id="searchForm" style="width: 70%" action="users?action=search" method="post">
                        <div class="input-group mb-3" style="margin: 0">
                        <span class="input-group-text" id="basic-addon1">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
                                 class="bi bi-search" viewBox="0 0 16 16">
                            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                            </svg>
                        </span>
                            <input id="searchInput" type="text" value="${value == null ? '' : value}" name="value" class="form-control" placeholder="Tìm kiếm người dùng..." aria-label="Tìm kiếm người dùng..."
                                   aria-describedby="basic-addon1">
                        </div>
                    </form>
                </div>

                <table cellpadding="5" class="table">
                    <thead style="place-items: stretch; display: block; text-transform: uppercase; width: 100%;">
                    <tr>
                        <th style="width: 5%;" class="text-center">#</th>
                        <th style="width: 10%" class="text-center">Ảnh</th>
                        <th style="width: 10%" class="text-center">Tên</th>
                        <th style="width: 20%" class="text-center">Email</th>
                        <th style="width: 10%" class="text-center">SĐT</th>
                        <th style="width: 10%" class="text-center">Giới tính</th>
                        <th style="width: 10%" class="text-center">Ngày sinh</th>
                        <th style="width: 10%" class="text-center">Trạng thái</th>
                        <th style="width: 15%" class="text-center">Hành động</th>
                    </tr>
                    </thead>
                    <tbody id="userTable">

                    </tbody>
                </table>
                <div style="margin-bottom: 10px;" class="d-flex justify-content-center">
                    <nav>
                        <ul class="pagination" id="pagination" style="margin: 0"></ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="sidePanel" class="side-panel">
    <button class="close-btn" onclick="togglePanel()">X</button>
    <nav class="nav flex-column">
        <a class="nav-link" aria-current="page" href="/home">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
                <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293z"/>
                <path d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293z"/>
            </svg>
            Trang chủ
        </a>
        <a class="nav-link" aria-current="page" href="/home?action=goToUsers">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-people-fill" viewBox="0 0 16 16">
                <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6m-5.784 6A2.24 2.24 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.3 6.3 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1zM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5"/>
            </svg>
            Quản lý người dùng
        </a>
        <a class="nav-link" aria-current="page" href="/reports?action=postReports">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-file-post" viewBox="0 0 16 16">
                <path d="M4 3.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 .5.5v8a.5.5 0 0 1-.5.5h-7a.5.5 0 0 1-.5-.5z"/>
                <path d="M2 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2zm10-1H4a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1"/>
            </svg>
            Bài viết bị báo cáo
        </a>
        <a class="nav-link" aria-current="page" href="/reports?action=commentReports">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-chat-text-fill" viewBox="0 0 16 16">
                <path d="M16 8c0 3.866-3.582 7-8 7a9 9 0 0 1-2.347-.306c-.584.296-1.925.864-4.181 1.234-.2.032-.352-.176-.273-.362.354-.836.674-1.95.77-2.966C.744 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7M4.5 5a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1zm0 2.5a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1zm0 2.5a.5.5 0 0 0 0 1h4a.5.5 0 0 0 0-1z"/>
            </svg>
            Bình luận bị báo cáo
        </a>
        <a class="nav-link" aria-current="page" href="/reports?action=blockedUsers">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-ban" viewBox="0 0 16 16">
                <path d="M15 8a6.97 6.97 0 0 0-1.71-4.584l-9.874 9.875A7 7 0 0 0 15 8M2.71 12.584l9.874-9.875a7 7 0 0 0-9.874 9.874ZM16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0"/>
            </svg>
            Quản lý người dùng vi phạm
        </a>
    </nav>
</div>
<script>
    let timeout;

    document.getElementById('searchInput').addEventListener('input', function () {
        clearTimeout(timeout);
        timeout = setTimeout(() => {
            document.getElementById('searchForm').submit();
        }, 2000);
    });

    document.getElementById('basic-addon1').addEventListener('click', function () {
        document.getElementById('searchForm').submit();
    });

    const users = [
        <c:forEach var="user" items="${users}" varStatus="status">
        {
            userId: '${user.userId}',
            name: '${user.name}',
            email: '${user.email}',
            phone: '${user.phone}',
            gender: '${user.gender ? "Nam" : "Nữ"}',
            dateOfBirth: '${user.dateOfBirth}',
            image: '${user.image}',
            status: '${user.status}',
        }<c:if test="${!status.last}">, </c:if>
        </c:forEach>
    ];

    const rowsPerPage = 5;
    let currentPage = 1;

    function displayUsers(page) {
        const tableBody = document.getElementById('userTable');
        tableBody.innerHTML = '';

        const start = (page - 1) * rowsPerPage;
        const end = start + rowsPerPage;
        const paginatedUsers = users.slice(start, end);

        if (users.length !== 0) {
            paginatedUsers.forEach(function (user, index) {
                const rowNumber = start + index + 1;
                const row = '<tr class="d-flex">' +
                    '<td style="width: 5%;" class="text-center">' + rowNumber + '</td>' +
                    '<td style="width: 10%;" class="text-center"><img style="width: 70%;height: 94.08px" src="${pageContext.request.contextPath}/uploads/avatars/' + user.image + '" /></td>' +
                    '<td style="width: 10%;" class="text-center">' + user.name + '</td>' +
                    '<td style="width: 20%;" class="text-center">' + user.email + '</td>' +
                    '<td style="width: 10%;" class="text-center">' + user.phone + '</td>' +
                    '<td style="width: 10%;" class="text-center">' + user.gender + '</td>' +
                    '<td style="width: 10%;" class="text-center">' + user.dateOfBirth + '</td>' +
                    '<td style="width: 10%;" class="text-center">' + (user.status === 'Active' ? 'Active' : user.status === 'Blocked' ? 'Blocked' : 'Banned') + '</td>' +
                    '<td style="width: 15%;" class="text-center">' +
                    '<a class="btn btn-warning ' + (user.status === 'Banned' ? 'disabled' : '') + '" style="margin-right: 5px;" href="/users?action=update&userId=' + user.userId + '">Edit</a>' +
                    '<a style="min-width:83px;" class="btn btn-status ' +
                    (user.status === 'Active' ? 'btn-danger' : user.status === 'Banned' ? 'btn-secondary disabled' : 'btn-success') +
                    '" data-userid="' + user.userId + '" data-status="' + user.status + '">' +
                    (user.status === 'Blocked' ? 'Activate' : user.status === 'Banned' ? 'Banned' : 'Block') +
                    '</a>' +
                    '</td>' +
                    '</tr>';
                tableBody.innerHTML += row;
            });
        } else {
            tableBody.innerHTML = '<tr class="d-flex">' +
                '<td style="width: 100%; text-align: center">Không tìm thấy kết quả phù hợp.</td>' +
                '</tr>';
        }

        const rowsToAdd = rowsPerPage - paginatedUsers.length;
        for (let i = 0; i < rowsToAdd; i++) {
            const emptyRow = '<tr class="d-flex" style="height: 106.336px;">' +
                '<td colspan="9" class="text-center"></td>' +
                '</tr>';
            tableBody.innerHTML += emptyRow;
        }

        attachStatusButtonEvents();
    }


    function setupPagination() {
        const pagination = document.getElementById('pagination');
        pagination.innerHTML = '';
        const pageCount = Math.ceil(users.length / rowsPerPage);

        const prevLi = document.createElement('li');
        prevLi.classList.add('page-item');

        if (currentPage === 1) {
            prevLi.classList.add('disabled');
        }

        prevLi.innerHTML = '<a class="page-link" href="#">Previous</a>';
        prevLi.addEventListener('click', function () {
            if (currentPage > 1) {
                currentPage--;
                displayUsers(currentPage);
                updateActivePage();
            }
        });
        if (users.length !== 0) {
            pagination.appendChild(prevLi);
        }
        if (currentPage === 1) {

        }

        for (let i = 1; i <= pageCount; i++) {
            const li = document.createElement('li');
            li.classList.add('page-item');
            if (i === currentPage) {
                li.classList.add('active');
            }
            li.innerHTML = `<a class="page-link" href="#">` + i + `</a>`;
            li.addEventListener('click', function () {
                currentPage = i;
                displayUsers(currentPage);
                setupPagination();
                updateActivePage();
            });
            if (users.length !== 0) {
                pagination.appendChild(li);
            }
        }

        const nextLi = document.createElement('li');
        nextLi.classList.add('page-item');

        if (currentPage === pageCount) {
            nextLi.classList.add('disabled');
        }

        nextLi.innerHTML = '<a class="page-link" href="#">Next</a>';
        nextLi.addEventListener('click', function () {
            if (currentPage < pageCount) {
                currentPage++;
                displayUsers(currentPage);
                updateActivePage();
            }
        });
        if (users.length !== 0) {
            pagination.appendChild(nextLi);
        }
    }

    function updateActivePage() {
        const pageItems = document.querySelectorAll('.page-item');
        pageItems.forEach(item => item.classList.remove('active'));
        const activeItem = document.querySelectorAll('.page-item')[currentPage];
        if (activeItem) activeItem.classList.add('active');
    }

    displayUsers(currentPage);
    setupPagination();

    function attachStatusButtonEvents() {
        document.querySelectorAll(".btn-status").forEach(button => {
            button.addEventListener("click", function () {
                let userId = this.getAttribute("data-userid");

                fetch("/users?action=changeStatus&userId=" + userId, { method: "POST" })
                    .then(response => response.text())
                    .then(newStatus => {
                        if (newStatus === "active" || newStatus === "blocked") {
                            let isActive = newStatus === "active";
                            this.setAttribute("data-status", isActive);
                            this.classList.toggle("btn-danger", isActive);
                            this.classList.toggle("btn-success", !isActive);
                            this.innerHTML = isActive ? "Block" : "Activate";
                            let user = users.find(u => u.userId === userId);
                            user.status = isActive ? "Activate" : "Block";

                            let statusColumn = this.closest("tr").querySelectorAll("td")[7];
                            statusColumn.innerHTML = isActive ? "Active" : "Blocked";
                        } else {
                            alert("Cập nhật trạng thái thất bại!");
                        }
                    })
                    .catch(error => console.error("Lỗi:", error));
            });
        });
    }
</script>
</body>
</html>
