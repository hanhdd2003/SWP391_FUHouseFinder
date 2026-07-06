<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết nhà trọ</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
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
                height: 600px; /* Điều chỉnh chiều cao của khung chứa ảnh */
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
            .host-info, .user-review, .room-details {
                margin-bottom: 20px;
                padding: 20px;
                border-radius: 8px;
                background-color: #f8f8f8;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .host-info h3, .user-review h3, .room-details h3 {
                margin-top: 0;
            }
            .host-info p, .user-review p, .room-details p {
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
            .room-table th, .room-table td {
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
            .camera img{
                height: 40px;
                border-radius: 50%;
            }
            .rounded-circle{
                height: 170px;
                width: 170px;
                border-radius: 50%;
            }
            .alert-top-right {
                position: fixed;
                top: 100px;
                right: 20px;
                z-index: 1050; /* Đảm bảo rằng thông báo xuất hiện trên các thành phần khác */
            }


            .card-shadow {
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }
            .container {
                margin-top: 50px;
            }
            .card-body{
                background-color: rgb(238, 244, 255);
                height: 537px;
            }

            .img-icon img{
                width: 30px;
                height:30px;
                margin-right: 10px;
            }
            .sidebar .user-review .rating .star {
                color: #ccc; /* Màu mặc định cho các sao không được đánh dấu */
                cursor: pointer;
            }
            .sidebar .user-review .rating .star.selected {
                color: #d9534f; /* Màu cho các sao được đánh dấu */
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

            .comment-item {
                padding: 10px;
                border: 1px solid #ccc;
                margin-bottom: 10px;
                border-radius: 5px;
            }

            .comment-wrapper {
                margin-bottom: 20px;
            }

            .reply {
                padding: 10px;
                margin-left: 31px;
                border: 1px solid #ddd;
                background-color: #f9f9f9;
                margin-top: 10px;
                border-radius: 5px;
                font-size: 0.3em;

            }

        </style>
    </head>
    <body data-house-id="${list.id}"
          data-role-id="${sessionScope.user != null ? sessionScope.user.getRoleId() : -1}" data-tenant-id="${sessionScope.user != null ? sessionScope.user.id : -1}">

        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <div class="bradcam_area bradcam_bg_1">

            </div>
            <div class="container">
                <div class="breadcrumb">
                    <a href="/HFManagementSystem/view_house">Trang chủ</a>  <span class="ml-2"> >  Chi tiết nhà trọ</span>
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
                    <div class="sidebar">
                        <div class="host-info">
                            <h3>Thông tin chủ trọ</h3>
                            <p><strong>Họ và tên:</strong><a class="text-dark" href="/HFManagementSystem/ViewDetailProfile?email=${user.email}"> ${user.landlordMder.first_name} ${user.landlordMder.last_name} </a></p>
                            <p><strong>Số điện thoại:</strong> <a href="tel:0123456789">${user.landlordMder.phone} </a></p>
                            <p><strong>Địa chỉ:</strong> ${user.landlordMder.address}</p>
                        </div>


                    </div>
                    <div class="room-details">
                        <h3 id="house-id" data-house-id="${list.id}">${list.house_name}</h3>
                        <p>${list.address}</p>
                        <p>${list.descriptionHouse}</p>
                    </div>
                    <div class="map-container">
                        <iframe src="${maphouse.location_link}" allowfullscreen="" loading="lazy"></iframe>
                    </div>
                    <div class="room-details">
                        <c:if test="${not empty rooms}">
                            <table class="room-table">
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
                                                <fmt:formatNumber value="${room.price}" type="number" pattern="#,###"/>₫
                                            </td>
                                            <td>
                                                <div class="img-icon">
                                                    <c:forEach items="${room.utilities}" var="utility">
                                                        <img src="/HFManagementSystem/img/utility/${utility.utilityImg()}" title="${utility.name}">
                                                    </c:forEach>                
                                                </div>
                                            </td>
                                            <td>${room.statusString}</td>
                                            <td>${room.area} m²</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${room.status == '1' && sessionScope.user.roleId == 3}">
                                                        <div>
                                                            <input type="hidden" name="houseID" value="${houseID}">
                                                            <input type="hidden" name="roomID" value="${room.roomId}">
                                                            <input type="hidden" name="landlordID" value="${user.landlordMder.id}">
                                                            <button class="book-button"  data-toggle="modal" data-target="#bookRoomModal" data-room="${room.roomNumber}"
                                                                    data-roomid="${room.roomId}"
                                                                    data-utility="${room.utilityString}"
                                                                    data-status="${room.statusString}"
                                                                    data-area="${room.area}"
                                                                    data-price="${room.price}">Thuê Phòng</button>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div >
                                                            <input type="hidden" name="houseID" value="${houseID}">
                                                            <input type="hidden" name="roomID" value="${room.roomId}">
                                                            <input type="hidden" name="landlordID" value="${user.landlordMder.id}">
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>

                                                <form action="detail_house?service=BookHouse" method="POST">
                                                    <div class="modal fade" id="bookRoomModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                        <input type="hidden" name="houseID" value="${houseID}">
                                                        <input type="hidden" name="roomID" id="bookingroomid" value="${room.roomId}">
                                                        <input type="hidden" name="landlordID" value="${user.landlordMder.id}">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content" style="width: 100%">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" style="color: black" >Xác nhận thuê phòng</h5>
                                                                    <button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <label style="color: black">Bạn có chắc chắc muốn thuê phòng này?</label>

                                                                    <div><b>Phòng: </b> <span id="roomNumber"></span></div>
                                                                    <div>
                                                                        <b>Giá: </b><span id="price"></span>
                                                                    </div>
                                                                    <div>
                                                                        <b>Dịch vụ: </b> <span id="utilityString"></span>
                                                                    </div>
                                                                    <div>
                                                                        <b>Trạng thái: </b> <span id="statusString"></span>
                                                                    </div>
                                                                    <div>
                                                                        <b>Diện tích: </b>
                                                                        <span id="area"></span> m²
                                                                    </div>

                                                                    <label style="color: black"><i>Vui lòng kiểm tra kĩ lại thông tin trước khi xác nhận yêu cầu</i></label>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                                                    <button type="submit" class="btn btn-success">Xác nhận</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div class="d-flex justify-content-end mb-3 mt-3">
                                <ul class="pagination">
                                    <c:if test="${totalPages > 1}">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${currentPage - 1}&id=${houseId}">&laquo;
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
                                                                             href="?page=${i}&id=${houseId}">${i}</a></li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${currentPage + 1}&id=${houseId}">Next
                                                    &raquo;</a>
                                            </li>
                                        </c:if>
                                    </c:if>
                                </ul>
                            </div>
                        </c:if>
                    </div>
                    <div class="sidebar">
                        <div class="user-review">
                            <h3>Người dùng đánh giá</h3>
                            <p>Bình luận:</p>
                            <textarea id="feedback-content" placeholder="Viết bình luận..."></textarea>

                            <div class="rating">
                                <span>Đánh giá:</span>
                                <i class="star" data-rating="1">&#9733;</i>
                                <i class="star" data-rating="2">&#9733;</i>
                                <i class="star" data-rating="3">&#9733;</i>
                                <i class="star" data-rating="4">&#9733;</i>
                                <i class="star" data-rating="5">&#9733;</i>
                            </div>


                            <button onclick="submitFeedback()">Đăng</button>
                        </div>
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
                </div>
            </div>
        </div>

        <script>
            function handleFilterChange() {
                let ratingFilter = document.getElementById('filter-rating').value;
                let sort = document.getElementById('filter-sort').value;
                loadComments(1, ratingFilter, sort);
            }

            function loadComments(page = 1, ratingFilter = 'all', sort = 'newest') {
                fetch('/HFManagementSystem/api/comments?page=' + page + '&rating=' + ratingFilter + '&sort=' + sort)
                        .then(response => response.json())
                        .then(data => {
                            let commentsList = document.getElementById('comments-list');
                            commentsList.innerHTML = '';
                            data.comments.forEach(comment => {
                                let commentItem = document.createElement('div');
                                commentItem.classList.add('comment-item');
                                commentItem.innerHTML = '<p><strong>' + comment.tenantName + '</strong></p>' +
                                        '<p>' + '&#9733;'.repeat(comment.rating) + '&#9734;'.repeat(5 - comment.rating) + '</p>' +
                                        '<p>' + comment.content + '</p>' +
                                        '<p><em>' + new Date(comment.feedbackDate).toLocaleDateString() + '</em></p>';


                                let commentWrapper = document.createElement('div');
                                commentWrapper.classList.add('comment-wrapper');


                                commentWrapper.appendChild(commentItem);


                                if (comment.replyContent) {
                                    let replyItem = document.createElement('div');
                                    replyItem.classList.add('reply');
                                    replyItem.innerHTML =
                                            '<p><strong>Chủ nhà:</strong></p>' +
                                            '<p>' + comment.replyContent + '</p>' +
                                            '<p><em>' + new Date(comment.replyDate).toLocaleDateString() + '</em></p>';

                                    // Thêm thẻ phản hồi vào thẻ div lớn
                                    commentWrapper.appendChild(replyItem);
                                }

                                // Thêm thẻ div lớn vào danh sách comment
                                commentsList.appendChild(commentWrapper);
                            });

                            let pagination = document.getElementById('pagination');
                            pagination.innerHTML = '';
                            if (data.totalPages > 1) {
                                let startPage = Math.max(page - 1, 1);
                                let endPage = Math.min(page + 1, data.totalPages);

                                if (startPage > 1) {
                                    let firstPageLink = document.createElement('button');
                                    firstPageLink.textContent = '<';
                                    firstPageLink.classList.add('page-link');
                                    firstPageLink.onclick = () => loadComments(page - 1, ratingFilter, sort);
                                    pagination.appendChild(firstPageLink);
                                }

                                if (startPage > 2) {
                                    let dots = document.createElement('span');
                                    dots.textContent = '...';
                                    pagination.appendChild(dots);
                                }

                                for (let i = startPage; i <= endPage; i++) {
                                    let pageLink = document.createElement('button');
                                    pageLink.textContent = i;
                                    pageLink.classList.add('page-link');
                                    if (i === page) {
                                        pageLink.classList.add('active');
                                    }
                                    pageLink.onclick = () => loadComments(i, ratingFilter, sort);
                                    pagination.appendChild(pageLink);
                                }

                                if (endPage < data.totalPages - 1) {
                                    let dots = document.createElement('span');
                                    dots.textContent = '...';
                                    pagination.appendChild(dots);
                                }

                                if (endPage < data.totalPages) {
                                    let lastPageLink = document.createElement('button');
                                    lastPageLink.textContent = '>';
                                    lastPageLink.classList.add('page-link');
                                    lastPageLink.onclick = () => loadComments(page + 1, ratingFilter, sort);
                                    pagination.appendChild(lastPageLink);
                                }
                            }
                        })
                        .catch(error => console.error('Error:', error));
            }

            function checkUserFeedback(tenantId, houseId) {
                fetch('/HFManagementSystem/api/check-feedback?tenant_id=' + tenantId + '&house_id=' + houseId)
                        .then(response => response.json())
                        .then(data => {
                            console.log('Server response:', data); // Log received data to check in console
                            if (!data.hasFeedback) {
                                console.log('Has feedback:', data.hasFeedback);
                                document.querySelector('.user-review').style.display = 'none'; // Hide review section if feedback exists
                            } else {
                                console.log('No feedback:', data.hasFeedback);
                                document.querySelector('.user-review').style.display = 'block'; // Show review section if no feedback found
                            }
                        })
                        .catch(error => console.error('Error:', error));
            }


            document.addEventListener('DOMContentLoaded', (event) => {
                function checkUserRole() {
                    const roleId = document.body.getAttribute('data-role-id');
                    if (roleId == 3) {
                        document.querySelector('.user-review').style.display = 'block';

                        let tenantId = document.body.getAttribute('data-tenant-id'); // Lấy tenantId từ attribute của body
                        let houseId = document.getElementById('house-id').getAttribute('data-house-id'); // Lấy houseId từ attribute của element có id là 'house-id'

                        checkUserFeedback(tenantId, houseId);
                    }
                }
                checkUserRole();

                let tenantId = document.body.getAttribute('data-tenant-id');
                let houseId = document.getElementById('house-id').getAttribute('data-house-id');


                // Tải dữ liệu ban đầu khi trang được tải
                loadComments();
            });
        </script>

        <script>             document.addEventListener('DOMContentLoaded', (event) => {

                let tenantId = document.body.getAttribute('data-tenant-id');
                let houseId = document.getElementById('house-id').getAttribute('data-house-id');
                let stars = document.querySelectorAll('.star');
                let rating = 0;
                stars.forEach(star => {
                    star.addEventListener('click', function () {
                        rating = this.getAttribute('data-rating');
                        highlightStars(rating);
                    });
                    star.addEventListener('mouseover', function () {
                        let hoverRating = this.getAttribute('data-rating');
                        highlightStars(hoverRating);
                    });
                    star.addEventListener('mouseout', function () {
                        highlightStars(rating);
                    });
                });
                function highlightStars(rating) {
                    stars.forEach(star => {
                        if (star.getAttribute('data-rating') <= rating) {
                            star.classList.add('selected');
                        } else {
                            star.classList.remove('selected');
                        }
                    });
                }
                console.log('Server response:', tenantId); // Log received data to check in console


                window.submitFeedback = function () {
                    let content = document.getElementById('feedback-content').value;
                    if (content && rating > 0 && rating <= 5) {
                        let data = {
                            content: content,
                            rating: parseInt(rating),
                            tenant_id: parseInt(tenantId),
                            house_id: parseInt(houseId)
                        };
                        fetch('/HFManagementSystem/api/submit-feedback', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify(data)
                        })
                                .then(response => response.json())
                                .then(data => {
                                    if (data.success) {
                                        Swal.fire({
                                            icon: 'success',
                                            title: 'Đánh giá thành công!',
                                            showConfirmButton: false,
                                            timer: 2000
                                        });
                                        document.querySelector('.user-review').style.display = 'none';
                                        loadComments();
                                    } else {
                                        alert('Có lỗi xảy ra, vui lòng thử lại sau.');
                                    }
                                })
                                .catch(error => console.error('Error:', error));
                    } else {
                        alert('Vui lòng nhập nội dung và đánh giá hợp lệ.');
                    }
                }
            });
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
                    delay: 5000
                }
            });
            </script>
            <script>
                window.onload = function () {
                    var alertMessage = '<%= session.getAttribute("alertMessage") != null ? session.getAttribute("alertMessage") : ""%>';
                    var alertType = '<%= session.getAttribute("alertType") != null ? session.getAttribute("alertType") : ""%>';
                    if (alertMessage && alertType) {
                        Swal.fire({
                            icon: alertType,
                            title: alertMessage,
                            showConfirmButton: false,
                            timer: 2000
                        });
            <%
                session.removeAttribute("alertMessage");
                session.removeAttribute("alertType");
            %>
                    }
                };
        </script>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

        <!--sử lý bookmodal-->
        <script>
                $(document).ready(function () {
                    // Khi mở modal, cập nhật nội dung modal với dữ liệu của room
                    $('#bookRoomModal').on('show.bs.modal', function (event) {
                        // Lấy thông tin room từ button đã được nhấn
                        var button = $(event.relatedTarget); // button mà modal đã được kích hoạt
                        var room = button.data('room'); // Lấy giá trị của data-room
                        var roomid = button.data('roomid'); // lấy giá trị của data-roomid
                        var utility = button.data('utility');
                        var statusString = button.data('status');
                        var area = button.data('area');
                        var price = button.data('price');
                        var inputroomid = document.getElementById("bookingroomid");
                        inputroomid.value = roomid;

                        // Khởi tạo đối tượng Intl.NumberFormat với tùy chọn cơ bản
                        var numberFormat = new Intl.NumberFormat('vi-VN', {
                            style: 'currency',
                            currency: 'VND',
                            minimumFractionDigits: 0,
                            maximumFractionDigits: 0
                        });
                        var formattedPrice = numberFormat.format(price);
                        // Cập nhật nội dung của modal
                        var modal = $(this);
                        modal.find('#roomNumber').text(room);
                        modal.find('#utilityString').text(utility);
                        modal.find('#statusString').text(statusString);
                        modal.find('#area').text(area);
                        modal.find('#price').text(formattedPrice);
                    });
                });

        </script>



    </body>
</html>
