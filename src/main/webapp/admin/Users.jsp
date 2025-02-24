<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
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
            margin: 5px;
            padding: 10px;
        }

        .container-fluid > .row > div:last-child > .row {
            border-radius: 8px;
            background-color: #d3d3d373;
            margin: 5px;
            padding: 10px;
        }

        td {
            word-break: break-word;
            max-width: 100%;
        }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row d-flex justify-content-center">
        <%--    Left    --%>
        <jsp:include page="/AdminList.jsp"></jsp:include>

        <%--       Right        --%>
        <div class="col-md-9">
            <%--            Nav            --%>
            <jsp:include page="/AdminNav.jsp"></jsp:include>

            <%--       Center         --%>
            <div class="row d-flex justify-content-center">
                <div style="display:flex; justify-content: space-between">
                    <a style="height: fit-content" href="/users?action=add" class="btn btn-primary">Thêm tài khoản</a>
                    <form style="width: 70%" action="users?action=search" method="post">
                        <div class="input-group mb-3" style="margin: 0">
                        <span class="input-group-text" id="basic-addon1">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
                                 class="bi bi-search" viewBox="0 0 16 16">
                            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                            </svg>
                        </span>
                            <input type="text" name="value" class="form-control" placeholder="Search here..." aria-label="Search here..."
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
                        <th style="width: 15%" class="text-center">Email</th>
                        <th style="width: 10%" class="text-center">SĐT</th>
                        <th style="width: 10%" class="text-center">Giới tính</th>
                        <th style="width: 10%" class="text-center">Ngày sinh</th>
                        <th style="width: 15%" class="text-center">Trạng thái</th>
                        <th style="width: 15%" class="text-center">Hành động</th>
                    </tr>
                    </thead>
                    <tbody id="userTable">

                    </tbody>
                </table>
                <div class="d-flex justify-content-center">
                    <nav>
                        <ul class="pagination" id="pagination" style="margin: 0"></ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    const users = [
        <c:forEach var="user" items="${users}" varStatus="status">
        {
            userId: ${user.userId},
            name: '${user.name}',
            email: '${user.email}',
            phone: '${user.phone}',
            gender: '${user.gender ? "Nam" : "Nữ"}',
            dateOfBirth: '${user.dateOfBirth}',
            image: '${user.image}',
            status: '${user.status ? "Active" : "Blocked"}'
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
            paginatedUsers.forEach(function (user) {
                const row = '<tr class="d-flex">' +
                    '<td style="width: 5%;" class="text-center">' + user.userId + '</td>' +
                    '<td style="width: 10%;" class="text-center"><img style="width: 100%;" src="${pageContext.request.contextPath}/uploads/avatars/' + user.image + '" /></td>' +
                    '<td style="width: 10%;" class="text-center">' + user.name + '</td>' +
                    '<td style="width: 15%;" class="text-center">' + user.email + '</td>' +
                    '<td style="width: 10%;" class="text-center">' + user.phone + '</td>' +
                    '<td style="width: 10%;" class="text-center">' + user.gender + '</td>' +
                    '<td style="width: 10%;" class="text-center">' + user.dateOfBirth + '</td>' +
                    '<td style="width: 15%;" class="text-center">' + (user.status ? 'Active' : 'Blocked') + '</td>' +
                    '<td style="width: 15%;" class="text-center">' +
                    '<a class="btn btn-warning" style="margin-right: 5px;" href="/users?action=update&userId=' + user.userId + '">Edit</a>' +
                    '<a class="btn btn-status ' + (user.status ? 'btn-danger' : 'btn-success') + '" data-userid="' + user.userId + '" data-status="' + user.status + '"">' +
                    (user.status ? 'Block' : 'Activate') +
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

    document.addEventListener("DOMContentLoaded", function () {
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

                            let statusColumn = this.closest("tr").querySelectorAll("td")[7];
                            statusColumn.innerHTML = isActive ? "Active" : "Blocked";
                        } else {
                            alert("Cập nhật trạng thái thất bại!");
                        }
                    })
                    .catch(error => console.error("Lỗi:", error));
            });
        });
    });
</script>
</body>
</html>
