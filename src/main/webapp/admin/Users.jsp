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
                <form action="users?action=search" method="post">
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
                        <%--                        <th style="width: 10%" class="text-center">Vai trò</th>--%>
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
            phone: '0${user.phone}',
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

        paginatedUsers.forEach(function (user) {
            const row = '<tr class="d-flex">' +
                '<td style="width: 5%;" class="text-center">' + user.userId + '</td>' +
                '<td style="width: 10%;" class="text-center"><img style="width: 100%;" src="' + user.image + '" /></td>' +
                '<td style="width: 10%;" class="text-center">' + user.name + '</td>' +
                '<td style="width: 15%;" class="text-center">' + user.email + '</td>' +
                '<td style="width: 10%;" class="text-center">' + user.phone + '</td>' +
                '<td style="width: 10%;" class="text-center">' + user.gender + '</td>' +
                '<td style="width: 10%;" class="text-center">' + user.dateOfBirth + '</td>' +
                '<td style="width: 15%;" class="text-center">' + (user.status ? 'Active' : 'Blocked') + '</td>' +
                '<td style="width: 15%;" class="text-center">' +
                '<a class="btn btn-warning" style="margin-right: 10px;" href="#">Edit</a>' +
                '<a class="btn ' + (user.status ? 'btn-danger' : 'btn-success') + '" href="#">' +
                (user.status ? 'Block' : 'Activate') +
                '</a>' +
                '</td>' +
                '</tr>';
            tableBody.innerHTML += row;
        });

    }

    function setupPagination() {
        const pagination = document.getElementById('pagination');
        pagination.innerHTML = '';  // Xóa nội dung cũ của phân trang
        const pageCount = Math.ceil(users.length / rowsPerPage);

        // Thêm trang trước (Previous)
        const prevLi = document.createElement('li');
        prevLi.classList.add('page-item');
        prevLi.innerHTML = '<a class="page-link" href="#">Previous</a>';
        prevLi.addEventListener('click', function () {
            if (currentPage > 1) {
                currentPage--;
                displayUsers(currentPage);
                updateActivePage();
            }
        });
        pagination.appendChild(prevLi);

        // Thêm các trang số
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
                updateActivePage();
            });
            pagination.appendChild(li);
        }

        // Thêm trang sau (Next)
        const nextLi = document.createElement('li');
        nextLi.classList.add('page-item');
        nextLi.innerHTML = '<a class="page-link" href="#">Next</a>';
        nextLi.addEventListener('click', function () {
            if (currentPage < pageCount) {
                currentPage++;
                displayUsers(currentPage);
                updateActivePage();
            }
        });
        pagination.appendChild(nextLi);
    }

    // Cập nhật lớp active cho trang hiện tại
    function updateActivePage() {
        const pageItems = document.querySelectorAll('.page-item');
        pageItems.forEach(item => item.classList.remove('active'));
        const activeItem = document.querySelectorAll('.page-item')[currentPage];
        if (activeItem) activeItem.classList.add('active');
    }


    displayUsers(currentPage);
    setupPagination();
</script>
</body>
</html>
