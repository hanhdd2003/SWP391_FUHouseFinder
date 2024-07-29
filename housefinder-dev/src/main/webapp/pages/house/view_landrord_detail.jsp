<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết nhà trọ</title>
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap"
              rel="stylesheet">
        <!-- CSS here -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/magnific-popup.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/themify-icons.css">
        <link rel="stylesheet" href="css/nice-select.css">
        <link rel="stylesheet" href="css/flaticon.css">
        <link rel="stylesheet" href="css/gijgo.css">
        <link rel="stylesheet" href="css/animate.min.css">
        <link rel="stylesheet" href="css/slicknav.css">
        <link rel="stylesheet" href="css/style.css">
        <style>
            .modal-dialog-centered {
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: calc(100% - 1rem);
            }

            .modal-dialog {
                max-width: 90%;
                margin: 1.75rem auto;
            }

            .modal-content {
                width: 100%;
                border-radius: 10px;
            }
        </style>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f8f8;
                margin: 0;
                padding: 0;
            }


            .container {
                width: 90%;
                margin: auto;
                padding: 20px;
                /*background-color: #fff;*/
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .breadcrumb {
                margin-bottom: 20px;
            }

            .breadcrumb a {
                color: #d9534f;
                text-decoration: none;
            }

            .breadcrumb a:hover {
                text-decoration: underline;
            }

            .content {
                display: flex;
                justify-content: space-between;
            }

            .main-content {
                flex-grow: 2;
                margin-right: 20px;
            }

            .sidebar {
                flex-basis: 300px;
            }

            .swiper-container {
                width: 100%;
                height: 600px;
                margin-bottom: 20px;
                border-radius: 8px;
                overflow: hidden;
                position: relative;
            }

            .swiper-slide {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
                height: 100%;
            }

            .swiper-slide img {
                width: 100%;
                height: auto;
                object-fit: cover;
            }

            .swiper-pagination {
                position: absolute;
                text-align: center;
                transition: .3s opacity;
                transform: translate3d(0, 0, 0);
                z-index: 10;
                left: 0;
                right: 0;
                bottom: 10px;
            }

            .host-info,
            .user-review,
            .room-details {
                margin-bottom: 20px;
                padding: 20px;
                border-radius: 8px;
                background-color: #f8f8f8;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .host-info h3,
            .user-review h3,
            .room-details h3 {
                margin-top: 0;
            }

            .host-info p,
            .user-review p,
            .room-details p {
                margin: 5px 0;
            }

            .user-review textarea {
                width: 100%;
                height: 100px;
                margin-bottom: 10px;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            .user-review .rating {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }

            .user-review .rating i {
                color: #d9534f;
                margin-right: 5px;
            }

            .user-review button {
                padding: 10px 20px;
                border: none;
                background-color: #d9534f;
                color: #fff;
                border-radius: 4px;
                cursor: pointer;
            }

            .map-container {
                margin-bottom: 20px;
            }

            .map-container iframe {
                width: 100%;
                border: none;
                border-radius: 8px;
            }

            .room-table {
                width: 100%;
                border-collapse: collapse;
            }

            .room-table th,
            .room-table td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: left;
            }

            .room-table th {
                background-color: #f8f8f8;
            }

            .room-table .icon {
                color: #d9534f;
            }

            /*            .room-table .book-button {
                    padding: 5px 10px;
                    background-color: #d9534f;
                    color: #fff;
                    border: none;
                    border-radius: 4px;
                    cursor: pointer;
                    text-align: center;
                }*/
            .modal-backdrop.show {
                display: none;
            }

            .bradcam_area {
                padding: 20px 0 102px 0;
            }

            .camera img {
                height: 40px;
                border-radius: 50%;
            }

            .rounded-circle {
                height: 170px;
                width: 170px;
                border-radius: 50%;
            }

            .alert-top-right {
                position: fixed;
                top: 100px;
                right: 20px;
                z-index: 1050;
            }

            .sidebar {
                padding: 20px;
                background-color: #f8f9fa;
                border: 1px solid #ddd;
                border-radius: 8px;
            }

            .host-info {
                margin-bottom: 20px;
            }

            .btn-update .btn {
                width: 100%;
                margin-bottom: 10px;
            }

            .form-group {
                display: flex;
                flex-direction: column;
                align-items: flex-start;
            }

            .form-group label {
                margin-bottom: 5px;
            }

            .form-group select {
                width: 100%;
                max-width: 100%;
                display: block;
            }
        </style>
        <style>
            .modal-body {
                max-width: 100%;
                /* Đảm bảo modal body có chiều rộng tối đa */
            }

            .form-control {
                width: 100%;
                /* Đảm bảo select box chiếm toàn bộ chiều rộng của form-group */
            }
        </style>
        <style>
            .content p {
                word-wrap: break-word;
                white-space: normal;
                overflow-wrap: break-word;
                word-break: break-all;
            }


            .img-icon img {
                width: 30px;
                height: 30px;
                margin-right: 10px;
            }
        </style>
        <style>
            body {
                font-family: Arial, sans-serif;
                /*background-color: #f8f8f8;*/
                margin: 0;
                padding: 0;
            }

            .container {
                width: 90%;
                margin: auto;
                padding: 20px;
                /*background-color: #fff;*/
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .breadcrumb {
                margin-bottom: 20px;
            }

            .breadcrumb a {
                color: #d9534f;
                text-decoration: none;
            }

            .breadcrumb a:hover {
                text-decoration: underline;
            }

            .content {
                display: flex;
                justify-content: space-between;
            }

            .main-content {
                flex-grow: 2;
                margin-right: 20px;
            }

            .sidebar {
                flex-basis: 300px;
            }

            .swiper-container {
                width: 100%;
                height: 600px;
                /* Điều chỉnh chiều cao của khung chứa ảnh */
                margin-bottom: 20px;
                border-radius: 8px;
                overflow: hidden;
                position: relative;
            }

            .swiper-slide {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .swiper-slide img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .swiper-pagination {
                position: absolute;
                bottom: 10px;
                left: 50%;
                transform: translateX(-50%);
                width: auto;
                text-align: center;
            }

            .swiper-pagination-bullet {
                background-color: #000;
                opacity: 0.7;
            }

            .swiper-pagination-bullet-active {
                background-color: #fff;
                opacity: 1;
            }

            .host-info,
            .user-review,
            .room-details {
                min-width: 200px;
                margin-bottom: 20px;
                padding: 20px;
                border-radius: 8px;
                background-color: #f8f8f8;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .host-info h3,
            .user-review h3,
            .room-details h3 {
                margin-top: 0;
            }

            .host-info p,
            .user-review p,
            .room-details p {
                margin: 5px 0;
            }

            .user-review textarea {
                width: 100%;
                height: 100px;
                margin-bottom: 10px;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            .user-review .rating {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }

            .user-review .rating i {
                color: #d9534f;
                margin-right: 5px;
            }

            .user-review button {
                padding: 10px 20px;
                border: none;
                background-color: #d9534f;
                color: #fff;
                border-radius: 4px;
                cursor: pointer;
            }

            .map-container {
                margin-bottom: 20px;
            }

            .map-container iframe {
                width: 100%;
                border: none;
                border-radius: 8px;
            }

            .room-table {
                width: 100%;
                border-collapse: collapse;
            }

            .room-table th,
            .room-table td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: left;
            }

            .room-table th {
                background-color: #f8f8f8;
            }

            .room-table .icon {
                color: #d9534f;
            }

            .room-table .book-button {
                padding: 5px 10px;
                background-color: #d9534f;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                text-align: center;
            }

            .user-review {
                display: none;
            }
        </style>
        <style>
            .bradcam_area {
                padding: 20px 0 102px 0;
            }

            .camera img {
                height: 40px;
                border-radius: 50%;
            }

            .rounded-circle {
                height: 170px;
                width: 170px;
                border-radius: 50%;
            }

            .alert-top-right {
                position: fixed;
                top: 100px;
                right: 20px;
                z-index: 1050;
                /* Đảm bảo rằng thông báo xuất hiện trên các thành phần khác */
            }


            .card-shadow {
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }

            .container {
                margin-top: 50px;
            }

            .card-body {
                background-color: rgb(238, 244, 255);
                height: 537px;
            }

            .img-icon img {
                width: 30px;
                height: 30px;
                margin-right: 10px;
            }

            .sidebar .user-review .rating .star {
                color: #ccc;
                /* Màu mặc định cho các sao không được đánh dấu */
                cursor: pointer;
            }

            .sidebar .user-review .rating .star.selected {
                color: #d9534f;
                /* Màu cho các sao được đánh dấu */
            }
        </style>



        <style>
            .comment-item {
                padding: 10px;
                margin: 10px 0;
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #f9f9f9;
            }

            .page-link {
                margin: 0 5px;
                padding: 5px 10px;
                border: none;
                border-radius: 5px;
                background-color: #007bff;
                color: #fff;
                cursor: pointer;
            }

            .page-link.active {
                background-color: #0056b3;
            }

            .page-link:hover {
                background-color: #0056b3;
            }

            #pagination {
                display: flex;
                /*        justify-content: center;*/
                align-items: center;
                margin-top: 20px;
            }

            .filters {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
            }


            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 80%;
                margin: 20px auto;
                /*background-color: #fff;*/
                padding: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h1 {
                text-align: center;
                color: #333;
            }

            .filters {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .filters label {
                margin-right: 10px;
            }

            .filters select {
                padding: 5px;
            }

            #comments-list {
                margin-bottom: 20px;
            }

            .comment-item {
                padding: 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                margin-bottom: 10px;
                background-color: #f9f9f9;
            }

            .comment-item .content {
                margin-bottom: 10px;
            }

            .comment-item .replies {
                margin-top: 10px;
                border-top: 1px solid #ddd;
                padding-top: 10px;
            }

            .comment-item .reply-item {
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                margin-bottom: 10px;
                background-color: #fff;
            }

            .comment-item .reply-form {
                display: flex;
                flex-direction: column;
                margin-top: 10px;
            }

            .comment-item .reply-form textarea {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border-radius: 5px;
                border: 1px solid #ddd;
                resize: vertical;
            }

            .comment-item .reply-form button {
                align-self: flex-end;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                background-color: #007bff;
                color: #fff;
                cursor: pointer;
            }

            .comment-item .reply-form button:hover {
                background-color: #0056b3;
            }

            #pagination {
                text-align: center;
            }

            .page-link {
                display: inline-block;
                padding: 10px 15px;
                margin: 0 5px;
                border-radius: 5px;
                background-color: #007bff;
                color: #fff;
                cursor: pointer;
            }

            .page-link:hover {
                background-color: #0056b3;
            }

            .page-link.active {
                background-color: #0056b3;
                cursor: default;
            }
        </style>

    </head>
</head>

<body>
    <jsp:include page="/pages/header/header.jsp"></jsp:include>
        <div class="bradcam_area bradcam_bg_1"></div>
        <div style="margin-top: 150px" class="container">
            <div class="breadcrumb">
                <a href="#">Trang chủ</a> > <span>Chi tiết nhà trọ</span>
            </div>
            <div class="content">
                <div class="main-content">
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                        <c:forEach var="houseImages" items="${houseImages}">
                            <div class="swiper-slide">
                                <img src="img/fu_house/${houseImages.imageUrl}" alt="Nhà trọ Tâm Nguyễn 1">
                            </div>
                        </c:forEach>
                    </div>
                    <!-- Add Pagination -->
                    <div class="swiper-pagination"></div>
                </div>
                <div class="room-details">
                    <h3>${list.house_name}</h3>
                    <p>${list.address}</p>
                    <p>${list.descriptionHouse}</p>
                </div>
                <div class="map-container">
                    <iframe src="${maphouse.location_link}" allowfullscreen="" loading="lazy"></iframe>
                </div>
                <div class="room-details">
                    <c:if test="${not empty rooms}">
                        <table class="room-table ">
                            <thead>
                                <tr>
                                    <th>Tên phòng</th>
                                    <th>Giá phòng</th>
                                    <th>Tiện ích</th>
                                    <th>Trạng thái</th>
                                    <th>Diện tích</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="room" items="${rooms}">
                                    <tr>
                                        <td>${room.roomNumber}</td>
                                        <td>
                                            <fmt:formatNumber value="${room.price}" type="number"
                                                              pattern="#,###" />₫
                                        </td>


                                        <td>
                                            <div class="img-icon">
                                                <c:forEach items="${room.utilities}" var="utility">
                                                    <img src="/HFManagementSystem/img/utility/${utility.utilityImg()}"
                                                         title="${utility.name}">
                                                </c:forEach>
                                            </div>
                                        </td>
                                        <td>${room.statusString}</td>
                                        <td>${room.area} m²</td>
                                        <td>
                                            <div class="btn-group-vertical">
                                                <button class="book-button btn btn-danger m-2">
                                                    <a class="text-white"
                                                       href="/HFManagementSystem/update_room?id=${room.roomId}&house_id=${idParam}">Sửa
                                                        phòng</a>
                                                </button>


                                                <button type="button" class="book-button btn btn-danger m-2"
                                                        data-toggle="modal" data-target="#deleteRoomModal">
                                                    Xóa phòng
                                                </button>

                                                <button style="margin-bottom: 10px" type="button"
                                                        class="book-button btn btn-danger m-2"
                                                        data-toggle="modal" data-target="#updateStatusModal"
                                                        onclick="setRoomData(${room.roomId}, ${room.status})">
                                                    Cập nhật trạng thái
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>
                <div class="d-flex justify-content-end mb-3">
                    <ul class="pagination">
                        <c:if test="${totalPages > 1}">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage - 1}&id=${idParam}">&laquo;
                                        Previous</a>
                                </li>
                            </c:if>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <li class="page-item active"><span class="page-link">${i}</span></li>
                                        </c:when>
                                        <c:otherwise>
                                        <li class="page-item"><a class="page-link"
                                                                 href="?page=${i}&id=${idParam}">${i}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage + 1}&id=${idParam}">Next
                                        &raquo;</a>
                                </li>
                            </c:if>
                        </c:if>
                    </ul>
                </div>
                <div class="sidebar">
                    <div class="comments">
                        <h3>Danh sách bình luận</h3>
                        <div class="filters">
                            <label for="filter-rating">Lọc theo số sao:</label>
                            <select id="filter-rating" onchange="handleFilterChange()">
                                <option value="all">Tất cả</option>
                                <option value="5">5 sao</option>
                                <option value="4">4 sao</option>
                                <option value="3">3 sao</option>
                                <option value="2">2 sao</option>
                                <option value="1">1 sao</option>
                            </select>
                            <label for="filter-sort">Sắp xếp:</label>
                            <select id="filter-sort" onchange="handleFilterChange()">
                                <option value="newest">Mới nhất</option>
                                <option value="oldest">Cũ nhất</option>
                            </select>
                        </div>
                        <div id="comments-list">
                            <!-- Bình luận sẽ được tải ở đây -->
                        </div>
                        <div id="pagination">
                            <!-- Phân trang sẽ được tạo ở đây -->
                        </div>
                    </div>
                </div>

                <!-- Form để trả lời feedback -->
                <div id="reply-modal" class="modal">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <h2>Trả lời bình luận</h2>
                        <form id="reply-form">
                            <input type="hidden" id="feedback-id" name="feedback-id">
                            <textarea id="reply-content" name="reply-content" rows="4"
                                      placeholder="Nhập phản hồi của bạn..."></textarea>
                            <button type="submit">Gửi</button>
                        </form>
                    </div>
                </div>

            </div>
            <div class="sidebar">
                <div class="host-info">
                    <div class="btn-update">
                        <button class="btn btn-primary" data-toggle="modal"
                                data-target="#updateHouseModal">Sửa nhà</button>
                        <!--                        <button class="btn btn-primary" data-toggle="modal"
                                                        data-target="#updateStatusModals">Cập nhật trạng thái</button>-->
                        <button class="btn btn-primary" data-toggle="modal" data-target="#addRoomModal">Thêm
                            phòng</button>
                        <form id="deleteHouseForm" action="deleteHouse" method="get">

                            <input type="hidden" name="houseId" value="${idParam}">

                            <button type="button" class="btn btn-primary" onclick="confirmDeleteHouse()">Xóa
                                nhà</button>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            loadComments();
        });

        function loadComments(page = 1) {
            const ratingFilter = document.getElementById('filter-rating').value;
            const sortFilter = document.getElementById('filter-sort').value;

            fetch('/HFManagementSystem/feedback-landrords?page=' + page + '&rating=' + ratingFilter + '&sort=' + sortFilter)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.json();
                    })
                    .then(data => {
                        const commentsList = document.getElementById('comments-list');
                        commentsList.innerHTML = '';

                        data.feedbacks.forEach(commentWithReplies => {
                            const feedback = commentWithReplies.feedback;
                            const replies = commentWithReplies.replies;

                            const commentDiv = document.createElement('div');
                            commentDiv.classList.add('comment-item');

                            const contentDiv = document.createElement('div');
                            contentDiv.classList.add('content');
                            contentDiv.innerHTML = '<p><strong>' + feedback.tenantName + '</strong></p>' +
                                    '<p>' + feedback.content + '</p>' +
                                    '<p>Đánh giá: ' + '&#9733;'.repeat(feedback.rating) + '&#9734;'.repeat(5 - feedback.rating) + '</p>';

                            const repliesDiv = document.createElement('div');
                            repliesDiv.classList.add('replies');
                            (replies || []).forEach(reply => {
                                const replyDiv = document.createElement('div');
                                replyDiv.classList.add('reply-item');
                                replyDiv.innerHTML = '<p><strong>' + (reply.adminReply ? 'Chủ nhà' : 'Chủ nhà') + ':</strong></p>' +
                                        '<p>' + reply.replyContent + '</p>' +
                                        '<p><small>' + reply.replyDate + '</small></p>';
                                repliesDiv.appendChild(replyDiv);
                            });

                            const replyFormDiv = document.createElement('div');
                            replyFormDiv.classList.add('reply-form');
                            if (feedback.hasReply) {
                                replyFormDiv.style.display = 'none'; // Ẩn form nếu đã phản hồi
                            }
                            replyFormDiv.innerHTML = `
            <textarea class="reply-content" placeholder="Nhập phản hồi của bạn..."></textarea>
            <button class="reply-submit-btn" data-feedback-id="` + feedback.feedbackId + `">Gửi</button>
        `;

                            replyFormDiv.querySelector('.reply-submit-btn').addEventListener('click', function () {
                                const feedbackId = this.getAttribute('data-feedback-id');
                                const replyContent = replyFormDiv.querySelector('.reply-content').value;
                                submitReply(feedbackId, replyContent, replyFormDiv);
                            });

                            commentDiv.appendChild(contentDiv);
                            commentDiv.appendChild(repliesDiv);
                            commentDiv.appendChild(replyFormDiv);
                            commentsList.appendChild(commentDiv);
                        });

                        const paginationDiv = document.getElementById('pagination');
                        paginationDiv.innerHTML = '';
                        if (data.totalPages > 1) {
                            let startPage = Math.max(page - 1, 1);
                            let endPage = Math.min(page + 1, data.totalPages);

                            if (startPage > 1) {
                                let firstPageLink = document.createElement('button');
                                firstPageLink.textContent = '<';
                                firstPageLink.classList.add('page-link');
                                firstPageLink.onclick = () => loadComments(page - 1, ratingFilter, sortFilter);
                                paginationDiv.appendChild(firstPageLink);
                            }

                            if (startPage > 2) {
                                let dots = document.createElement('span');
                                dots.textContent = '...';
                                paginationDiv.appendChild(dots);
                            }

                            for (let i = startPage; i <= endPage; i++) {
                                let pageLink = document.createElement('button');
                                pageLink.textContent = i;
                                pageLink.classList.add('page-link');
                                if (i === page) {
                                    pageLink.classList.add('active');
                                }
                                pageLink.onclick = () => loadComments(i, ratingFilter, sortFilter);
                                paginationDiv.appendChild(pageLink);
                            }

                            if (endPage < data.totalPages - 1) {
                                let dots = document.createElement('span');
                                dots.textContent = '...';
                                paginationDiv.appendChild(dots);
                            }

                            if (endPage < data.totalPages) {
                                let lastPageLink = document.createElement('button');
                                lastPageLink.textContent = '>';
                                lastPageLink.classList.add('page-link');
                                lastPageLink.onclick = () => loadComments(page + 1, ratingFilter, sortFilter);
                                paginationDiv.appendChild(lastPageLink);
                            }
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Có lỗi xảy ra khi tải dữ liệu. Vui lòng thử lại.');
                    });
        }

        function submitReply(feedbackId, replyContent, replyFormDiv) {
            fetch('/HFManagementSystem/reply_feedback', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    feedbackId: feedbackId,
                    replyContent: replyContent
                })
            })
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.json();
                    })
                    .then(data => {
                        if (data.success) {
                            // Ẩn form phản hồi sau khi gửi thành công
                            replyFormDiv.style.display = 'none';
                            loadComments(); // Tải lại danh sách feedbacks
                        } else {
                            replyFormDiv.style.display = 'none';
                            loadComments(); // Tải lại danh sách feedbacks
                        }
                    })
                    .catch(error => {
                        replyFormDiv.style.display = 'none';
                        loadComments(); // Tải lại danh sách feedbacks
                    });
        }
    </script>


    <div class="modal fade" id="bookRoomModal" tabindex="-1" aria-labelledby="bookRoomModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-lg-custom">
            <div class="modal-content" style="width: 600px">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateHouseModalLabel">Danh Sách Người Đặt Phòng</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Tên</th>
                                    <th>Địa Chỉ</th>
                                    <th>Số điện thoại</th>
                                    <th>Tên phòng</th>
                                    <th>Hành Động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="orderDetail" items="${orderDetails}">
                                    <tr>
                                        <td>${orderDetail.tenant.firstName} ${orderDetail.tenant.lastName}
                                        </td>
                                        <td>${orderDetail.tenant.address}</td>
                                        <td>${orderDetail.tenant.phone}</td>
                                        <td>${orderDetail.roomName}</td>
                                        <td>
                                            <form action="view_landrord_detail?service=AcceptBookRoom"
                                                  method="post">
                                                <input type="hidden" name="tenantID"
                                                       value="${orderDetail.tenant.tenant_ID}">
                                                <input type="hidden" name="roomID"
                                                       value="${orderDetail.order.roomID}">
                                                <button type="submit" class="btn btn-success btn-sm">Chấp
                                                    Nhận</button>
                                            </form>
                                            <form action="view_landrord_detail?service=RejectBookRoom"
                                                  method="post">
                                                <input type="hidden" name="tenantID"
                                                       value="${orderDetail.tenant.tenant_ID}">
                                                <input type="hidden" name="roomID"
                                                       value="${orderDetail.order.roomID}">
                                                <button type="submit" class="btn btn-danger btn-sm">Từ
                                                    Chối</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                </div>

            </div>




        </div>


    </div>

    <!-- Update Status Modal room-->
    <div class="modal fade" id="updateStatusModal" tabindex="-1" role="dialog"
         aria-labelledby="updateStatusModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateStatusModalLabel">Cập nhật trạng thái phòng</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="updateStatusForm" method="post" action="updateRoomStatus">
                        <input type="hidden" name="houseId" value="${idParam}">
                        <input type="hidden" id="roomId" name="roomId">
                        <div class="form-group">
                            <label for="status">Trạng thái</label>
                            <select class="form-control" id="status" name="status">
                                <option value="1">Còn phòng</option>
                                <option value="0">Hết phòng</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function setRoomData(id, status) {
            document.getElementById('roomId').value = id;
            document.getElementById('status').value = status;
        }
    </script>

    <script>
        function setRoomData(id, status) {
            document.getElementById('roomId').value = id;
            document.getElementById('status').value = status;
        }
    </script>

    <!-- Modal Xóa phòng -->
    <div class="modal fade" id="deleteRoomModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Chọn phòng để xóa</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <form id="deleteRoomForm" action="deleteRoom" method="post">
                        <input type="hidden" name="houseId" value="${idParam}">
                        <div class="form-group">
                            <label for="roomIdSelect">Chọn phòng:</label>
                            <select class="form-control" id="roomIdSelect" name="roomId">
                                <c:forEach var="room" items="${roomss}">
                                    <option value="${room.roomId}">${room.roomNumber} </option>
                                </c:forEach>
                            </select>
                        </div>
                    </form>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                    <button type="submit" form="deleteRoomForm" class="btn btn-danger">Xóa Phòng</button>
                </div>
            </div>
        </div>
    </div>


    <script>
        function confirmDeleteHouse() {
            // Hiển thị hộp thoại xác nhận
            Swal.fire({
                title: 'Bạn có chắc chắn muốn xóa nhà này?',
                text: "Hành động này không thể hoàn tác!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Có, xóa nó!',
                cancelButtonText: 'Không'
            }).then((result) => {
                if (result.isConfirmed) {

                    document.getElementById("deleteHouseForm").submit();
                }
            });
        }
    </script>

    <!-- Modal update status house-->
    <div class="modal fade" id="updateStatusModals" tabindex="-1" role="dialog"
         aria-labelledby="updateStatusModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateStatusModalLabel">Cập nhật trạng thái</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="updateStatusHouseForm" action="updatestatushouse" method="post">
                        <input type="hidden" name="house_id" value="${idParam}">
                        <div class="form-group">
                            <label for="newStatus">Trạng thái mới </label>
                            <select class="form-control" id="newStatus" name="status" required>
                                <option value="Còn phòng">Còn phòng</option>
                                <option value="Hết phòng">Hết phòng</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- Update House Modal -->
    <div class="modal fade" id="updateHouseModal" tabindex="-1" aria-labelledby="updateHouseModalLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="width: 600px">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateHouseModalLabel">Cập Nhật Thông Tin Nhà</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form id="updateHouseForm" action="update_house" method="post"
                      enctype="multipart/form-data">
                    <input type="hidden" name="house_id" value="${house.id}">
                    <input type="hidden" name="landlord_id" value="${users.landlordMder.id}">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="house_name">Tên Nhà<samp style="color: red">*</samp></label>
                            <input type="text" class="form-control" id="house_name" name="name"
                                   value="${house.house_name}" required>
                            <div id="houseNameError" class="text-danger"></div>
                        </div>
                        <div class="form-group">
                            <label for="address">Địa Chỉ<samp style="color: red">*</samp></label>
                            <input type="text" class="form-control" id="address" name="address"
                                   value="${house.address}" required maxlength="255">
                            <div id="addressError" class="error"></div>
                        </div>
                        <div class="form-group">
                            <label for="description_house">Mô Tả<samp style="color: red">*</samp></label>
                            <textarea class="form-control" id="description_house" name="description_house"
                                      rows="3" required maxlength="255">${house.descriptionHouse}</textarea>
                            <div id="descriptionHouseError" class="error"></div>
                        </div>

                        <div class="form-group">
                            <label for="location_id">Vị Trí<samp style="color: red">*</samp></label>
                            <select class="form-control" id="location_id" name="location_id" required>
                                <c:forEach var="location" items="${locations}">
                                    <option value="${location.location_id}"
                                            ${location.location_id==house.locationModer.location_id ? 'selected'
                                              : '' }>${location.location_name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="existingImages">Ảnh hiện có</label>
                            <div id="existingImages" style="display: flex; flex-wrap: wrap;">
                                <c:forEach var="image" items="${house.houseImagess}">
                                    <div class="existing-image" id="image-${image.id}"
                                         style="position: relative; margin: 10px; width: 100px; height: 100px;">
                                        <img src="img/fu_house/${image.imageUrl}" alt="${image.imageUrl}"
                                             style="width: 100%; height: 100%; object-fit: cover;">
                                        <button type="button" class="btn btn-danger btn-sm"
                                                style="position: absolute; top: 5px; right: 5px;"
                                                onclick="removeExistingImage('${image.id}')">X</button>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="img">Thêm ảnh mới</label>
                            <input type="file" class="form-control" id="img" name="img" multiple>
                            <div id="imageList" class="form-group" style="display: flex; flex-wrap: wrap;">
                            </div>
                        </div>
                        <input type="hidden" id="removedImages" name="removedImages">
                        <input type="hidden" id="jsonImages" name="jsonImages">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-primary">Cập nhật nhà</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <script>
        let images = [];
        let removedImages = [];
        document.getElementById('img').addEventListener('change', function (event) {
            let files = event.target.files;
            for (let i = 0; i < files.length; i++) {
                let file = files[i];
                let reader = new FileReader();
                reader.onload = function (e) {
                    images.push({imageUrl: e.target.result, fileName: file.name});
                    updateImageList();
                };
                reader.readAsDataURL(file);
            }
        });
        function updateImageList() {
            let imageList = document.getElementById('imageList');
            imageList.innerHTML = '';
            images.forEach((img, index) => {
                let imageDiv = document.createElement('div');
                imageDiv.className = 'image-item';
                imageDiv.style.position = 'relative';
                imageDiv.style.margin = '10px';
                imageDiv.style.width = '100px';
                imageDiv.style.height = '100px';
                let imgTag = document.createElement('img');
                imgTag.src = img.imageUrl;
                imgTag.alt = img.fileName;
                imgTag.style.width = '100%';
                imgTag.style.height = '100%';
                imgTag.style.objectFit = 'cover';
                let removeButton = document.createElement('button');
                removeButton.textContent = 'Xóa';
                removeButton.style.position = 'absolute';
                removeButton.style.top = '5px';
                removeButton.style.right = '5px';
                removeButton.style.backgroundColor = 'rgba(255, 0, 0, 0.7)';
                removeButton.style.color = 'white';
                removeButton.style.border = 'none';
                removeButton.style.borderRadius = '5px';
                removeButton.style.cursor = 'pointer';
                removeButton.onclick = function () {
                    removeImage(index);
                };
                imageDiv.appendChild(imgTag);
                imageDiv.appendChild(removeButton);
                imageList.appendChild(imageDiv);
            });
            let jsonImages = JSON.stringify(images.map(img => ({imageUrl: img.fileName})));
            document.getElementById('jsonImages').value = jsonImages;
        }

        function removeImage(index) {
            images.splice(index, 1);
            updateImageList();
        }

        function removeExistingImage(imageId) {
            removedImages.push(imageId);
            document.getElementById('removedImages').value = removedImages.join(',');
            document.getElementById('image-' + imageId).remove();
        }

        document.getElementById('updateHouseForm').addEventListener('submit', function (event) {
            if (images.length === 0 && removedImages.length === 0) {
                document.getElementById('imgError').textContent = 'Vui lòng thêm ít nhất một ảnh.';
                event.preventDefault();
            }
        });</script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Add Room Modal -->
    <!-- Add Room Modal -->
    <div class="modal fade" id="addRoomModal" tabindex="-1" aria-labelledby="addRoomModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" style="max-width: 90%;">
            <div class="modal-content" style="width: 600px">
                <div class="modal-header">
                    <h5 class="modal-title" id="addRoomModalLabel">Thêm Phòng</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form id="addRoomForm" action="/HFManagementSystem/add_room" method="post"
                      onsubmit="return validateAddRoomForm()">
                    <div class="modal-body">
                        <input type="hidden" class="form-control" id="add_room_house_id" name="house_id"
                               value="${idParam}" required>
                        <div class="form-group">
                            <label for="add_room_number">Số Phòng<samp style="color: red">*</samp></label>
                            <input type="text" class="form-control" id="add_room_number" name="room_number"
                                   required maxlength="255">
                            <div id="addRoomNumberError" class="text-danger"></div>
                        </div>

                        <div class="form-group">
                            <label for="add_room_price">Giá<samp style="color: red">*</samp></label>
                            <input type="number" min="100000" max="1000000000" step="100000"
                                   class="form-control" id="add_room_price" name="price" required>
                            <div id="addRoomPriceError" class="text-danger"></div>
                        </div>
                        <div class="form-group">
                            <label for="add_room_area">Diện Tích<samp style="color: red">*</samp></label>
                            <input type="number" min="0.1" max="100" step="0.1" class="form-control"
                                   id="add_room_area" name="area" required>
                            <div id="addRoomAreaError" class="text-danger"></div>
                        </div>
                        <div class="form-group">
                            <label for="utilities">Tiện ích</label>
                            <div id="utilities">
                                <c:forEach var="utility" items="${utilities}">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="utilities"
                                               value="${utility.id}">
                                        <label class="form-check-label">${utility.name}</label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                        <button type="submit" class="btn btn-primary">Thêm Phòng</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var roomNumberInput = document.getElementById('add_room_number');
            var houseId = document.getElementById('add_room_house_id').value;
            var roomNumberError = document.getElementById('addRoomNumberError');
            roomNumberInput.addEventListener('blur', function () {
                var roomNumber = roomNumberInput.value;
                if (roomNumber) {
                    var xhr = new XMLHttpRequest();
                    xhr.open('POST', '/HFManagementSystem/check_room_number', true);
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                            if (xhr.responseText === 'exists') {
                                roomNumberError.textContent = 'Số phòng đã tồn tại!';
                            } else {
                                roomNumberError.textContent = '';
                            }
                        }
                    };
                    xhr.send('house_id=' + houseId + '&room_number=' + roomNumber);
                }
            });
        });
        function validateAddRoomForm() {
            var roomNumberError = document.getElementById('addRoomNumberError').textContent;
            if (roomNumberError) {
                return false;
            }
            return true;
        }
    </script>

    <jsp:include page="/pages/footer/footer.jsp"></jsp:include>
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
        <script src="js/vendor/modernizr-3.5.0.min.js"></script>
        <script src="js/vendor/jquery-1.12.4.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/isotope.pkgd.min.js"></script>
        <script src="js/ajax-form.js"></script>
        <script src="js/waypoints.min.js"></script>
        <script src="js/jquery.counterup.min.js"></script>
        <script src="js/imagesloaded.pkgd.min.js"></script>
        <script src="js/scrollIt.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/wow.min.js"></script>
        <script src="js/nice-select.min.js"></script>
        <script src="js/jquery.slicknav.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/plugins.js"></script>
        <script src="js/gijgo.min.js"></script>
        <!--contact js-->
        <script src="js/contact.js"></script>
        <script src="js/jquery.ajaxchimp.min.js"></script>
        <script src="js/jquery.form.js"></script>
        <script src="js/jquery.validate.min.js"></script>
        <script src="js/mail-script.js"></script>
        <script src="js/main.js"></script>
        <script>
        var swiper = new Swiper('.swiper-container', {
            direction: 'vertical',
            loop: true,
            pagination: {
                el: '.swiper-pagination',
                clickable: true
            },
            autoplay: {
                delay: 10000
            }
        });
        </script>
        <script>
            window.onload = function () {
                // Lấy thông báo và loại thông báo từ session
                var alertMessage = '<%= session.getAttribute("alertMessage") != null ? session.getAttribute("alertMessage") : ""%>';
                var alertType = '<%= session.getAttribute("alertType") != null ? session.getAttribute("alertType") : ""%>';
                // Kiểm tra nếu thông báo và loại thông báo không rỗng
                if (alertMessage && alertType) {
                    Swal.fire({
                        icon: alertType,
                        title: alertMessage,
                        showConfirmButton: false,
                        timer: 2000
                    });
                    // Xóa attribute alertMessage và alertType khỏi session sau khi hiển thị thông báo
        <%
                        session.removeAttribute("alertMessage");
                    session.removeAttribute("alertType");
        %>
                }
            };
    </script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>


            function validateAddRoomForm() {
                let roomNumber = document.getElementById('add_room_number').value;
                let floorNumber = document.getElementById('add_floor_number').value;
                let descriptionRoom = document.getElementById('add_description_room').value.trim();
                let price = document.getElementById('add_room_price').value;
                let area = document.getElementById('add_room_area').value;
                let isValid = true;
                / Kiểm tra số phòng
                        if (roomNumber.trim() === '' || roomNumber <= 0 || roomNumber > 255) {
                    document.getElementById('addRoomNumberError').textContent = 'Số phòng là bắt buộc và phải là số dương không vượt quá 255.';
                    isValid = false;
                } else {
                    document.getElementById('addRoomNumberError').textContent = '';
                }

                if (floorNumber < 0 || floorNumber > 255) {
                    document.getElementById('addFloorNumberError').textContent = 'Số tầng phải là số dương và không vượt quá 255.';
                    isValid = false;
                } else {
                    document.getElementById('addFloorNumberError').textContent = '';
                }


                if (!descriptionRoom || descriptionRoom.length > 255 || descriptionRoom.trim() === '') {
                    document.getElementById('addDescrtrtriptionRoomError').textContent = 'Mô tả không được để trống                            và không được vượt quá 255 ký tự.';
                    isValid = false;
                } else {
                    document.getElementById('addDescriptionRoomError').textContent = '';
                }

                if (price < 0 || price > 1000000000) {
                    document.getElementById('addRoomPriceError').textContent = 'Giá phải là số dương và không vượt quá 1000000000.';
                    isValid = false;
                } else {
                    document.getElementById('addRoomPriceError').textContent = '';
                }

                if (area < 0 || area > 200) {
                    document.getElementById('addRoomAreaError').textContent = 'Diện tích phải là số dương và không vượt quá 200.';
                    isValid = false;
                } else {
                    document.getElementById('addRoomAreaError').textContent = '';
                }

                return isValid;
            }
    </script>

    <script>
        function validateForm() {
            let houseName = document.getElementById('house_name').value.trim();
            let address = document.getElementById('address').value.trim();
            let description_house = document.getElementById('description_house').value.trim();
            let room_status = document.getElementById('room_status').value;
            let price = document.getElementById('price').value;

            let isValid = true;
            if (!houseName || houseName.length > 255) {
                document.getElementById('houseNameError').textContent = 'Tên nhà không được để trống và không được vượt quá 255 ký tự.';
                isValid = false;
            } else {
                document.getElementById('houseNameError').textContent = '';
            }

            if (!address || address.length > 255) {
                document.getElementById('addressError').textContent = 'Địa chỉ không được để trống và không được vượt quá 255 ký tự.';
                isValid = false;
            } else {
                document.getElementById('addressError').textContent = '';
            }

            if (!description_house) {
                document.getElementById('descriptionHouseError').textContent = 'Mô tả không được để trống.';
                isValid = false;
            } else {
                document.getElementById('descriptionHouseError').textContent = '';
            }

            if (!room_status) {
                document.getElementById('roomStatusError').textContent = 'Trạng thái không được để trống.';
                isValid = false;
            } else {
                document.getElementById('roomStatusError').textContent = '';
            }

            if (price < 0 || price > 5000000) {
                document.getElementById('priceError').textContent = 'Giá tiền phải là số dương và không vượt quá 5000000.';
                isValid = false;
            } else {
                document.getElementById('priceError').textContent = '';
            }


            return isValid;
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</body>

</html>