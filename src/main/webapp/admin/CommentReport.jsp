<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 3/10/2025
  Time: 11:23 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>FaceEbook</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AdminNav.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Post.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/PostModal.css">
    <script src="${pageContext.request.contextPath}/js/AdminNav.js"></script>
    <script src="${pageContext.request.contextPath}/js/PostModal.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
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
                    <form style="width: 70%" action="reports?action=search&type=Post" method="post">
                        <div class="input-group mb-3" style="margin: 0">
                            <span class="input-group-text" id="basic-addon1">
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor"
                                     class="bi bi-search" viewBox="0 0 16 16">
                                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                                </svg>
                            </span>
                            <input id="searchInput" type="text" value="${value == null ? '' : value}" name="value" class="form-control" placeholder="Tìm kiếm bình luận bị tố cáo bởi tên người tố cáo..." aria-label="Tìm kiếm người dùng..."
                                   aria-describedby="basic-addon1">
                        </div>
                    </form>
                </div>

                <table cellpadding="5" class="table">
                    <thead style="place-items: stretch; display: block; text-transform: uppercase; width: 100%;">
                    <tr>
                        <th style="width: 10%;" class="text-center">#</th>
                        <th style="width: 20%" class="text-center">Người báo cáo</th>
                        <th style="width: 20%" class="text-center">Thời gian báo cáo</th>
                        <th style="width: 20%" class="text-center">Người đăng</th>
                        <th style="width: 30%" class="text-center">Hành động</th>
                    </tr>
                    </thead>
                    <tbody id="reportTable">

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

    const reports = [];
    <c:forEach var="report" items="${reports}">
    reports.push({
        reportId: "${report.reportId}",
        reporter: "${report.reporter != null ? report.reporter.name : "Unknown"}",
        postId: '${report.postId}',
        commentId: "${report.commentId}",
        poster: "${report.poster != null ? report.poster.name : "Unknown"}",
        time: "${report.createAt}",
        posterId: "${report.poster != null ? report.poster.userId : 0}"
    });
    </c:forEach>

    console.log(reports);

    const rowsPerPage = 5;
    let currentPage = 1;

    function displayReports(page) {
        const tableBody = document.getElementById('reportTable');
        tableBody.innerHTML = '';

        const start = (page - 1) * rowsPerPage;
        const end = start + rowsPerPage;
        const paginatedReports = reports.slice(start, end);

        if (reports.length !== 0) {
            paginatedReports.forEach(function (report, index) {
                const rowNumber = start + index + 1;
                const row = '<tr class="d-flex" style="height: 106.336px">' +
                    '<td style="width: 10%;align-content: center;" class="text-center">' + rowNumber + '</td>' +
                    '<td style="width: 20%;align-content: center;" class="text-center">' + report.reporter + '</td>' +
                    '<td style="width: 20%;align-content: center;" class="text-center">' + report.time + '</td>' +
                    '<td style="width: 20%;align-content: center;" class="text-center">' + report.poster + '</td>' +
                    '<td style="width: 30%;align-content: center;" class="text-center">' +
                    '<button class="btn btn-info me-2" onclick="showPostPopupScrollToComment(' + report.commentId + ',' + report.postId + ')">Xem chi tiết</button>' +
                    '<button class="btn btn-warning me-2" onclick="removeComment(' + report.commentId + ')">Xóa bình luận</button>' +
                    '<a id="removePostBtn" style="min-width:92px;" class="btn btn-status ' +
                    (report.posterStatus === 'Active' ? 'btn-danger' : report.posterStatus === 'Banned' ? 'btn-secondary disabled' : 'btn-success') +
                    '" data-userid="' + report.posterId + '" data-status="' + report.posterStatus + '">' +
                    (report.posterStatus === 'Blocked' ? 'Kích hoạt' : report.posterStatus === 'Banned' ? 'Đã cấm' : 'Chặn') +
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

        const rowsToAdd = rowsPerPage - paginatedReports.length;
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
        const pageCount = Math.ceil(reports.length / rowsPerPage);

        const prevLi = document.createElement('li');
        prevLi.classList.add('page-item');

        if (currentPage === 1) {
            prevLi.classList.add('disabled');
        }

        prevLi.innerHTML = '<a class="page-link" href="#">Previous</a>';
        prevLi.addEventListener('click', function () {
            if (currentPage > 1) {
                currentPage--;
                displayReports(currentPage);
                updateActivePage();
            }
        });
        if (reports.length !== 0) {
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
                displayReports(currentPage);
                setupPagination();
                updateActivePage();
            });
            if (reports.length !== 0) {
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
                displayReports(currentPage);
                updateActivePage();
            }
        });
        if (reports.length !== 0) {
            pagination.appendChild(nextLi);
        }

        attachStatusButtonEvents();
    }

    function updateActivePage() {
        const pageItems = document.querySelectorAll('.page-item');
        pageItems.forEach(item => item.classList.remove('active'));
        const activeItem = document.querySelectorAll('.page-item')[currentPage];
        if (activeItem) activeItem.classList.add('active');
    }

    displayReports(currentPage);
    setupPagination();

    function showPostPopupScrollToComment(commentId, postId) {
        fetch(`/posts?action=postModal&postId=` + postId + `&commentId=` + commentId)
            .then(response => response.text())
            .then(html => {
                let modalContainer = document.createElement("div");
                modalContainer.classList.add("modal-overlay");
                modalContainer.innerHTML = html;
                document.body.appendChild(modalContainer);

                setTimeout(() => {
                    let commentElement = document.getElementById("comment-" + commentId);
                    if (commentElement) {
                        commentElement.scrollIntoView({ behavior: "smooth", block: "center" });

                        let commentBody = commentElement.querySelector(".comment-body");
                        if (commentBody) {
                            commentBody.style.transition = "background-color 0.5s ease-in-out";
                            commentBody.style.backgroundColor = "yellow";

                            // Nhạt dần về màu nền ban đầu sau 1 giây
                            setTimeout(() => {
                                commentBody.style.backgroundColor = "#f0f2f5";
                            }, 1000);
                        }
                    }
                }, 100); // Đợi 0.5s để modal hiển thị hoàn toàn


            })
            .catch(error => console.error("Lỗi khi tải bài viết:", error));
    }

    function attachStatusButtonEvents() {
        document.querySelectorAll(".btn-status").forEach(button => {
            button.addEventListener("click", function () {
                let userId = this.getAttribute("data-userid");

                fetch("/users?action=changeStatus&userId=" + userId, { method: "POST" })
                    .then(response => response.text())
                    .then(newStatus => {
                        console.log(userId);
                        if (newStatus === "active" || newStatus === "blocked") {
                            let isActive = newStatus === "active";
                            this.setAttribute("data-status", isActive);
                            this.classList.toggle("btn-danger", isActive);
                            this.classList.toggle("btn-success", !isActive);
                            this.innerHTML = isActive ? "Chặn" : "Kích hoạt";
                        } else {
                            alert("Cập nhật trạng thái thất bại!");
                        }
                    })
                    .catch(error => console.error("Lỗi:", error));
            });
        });
    }

    function removeComment(commentId) {
        if(!confirm("Bạn có chắc chắn muốn gỡ bài viết này ?")) {
            return;
        }

        fetch(`/comments`, {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: `action=adminDeleteComment&commentId=` + commentId
        }).then(() => {
            document.getElementById("removePostBtn").disabled = true;
        }).catch(error => console.error("Error:", error));
    }

</script>

</body>
</html>
