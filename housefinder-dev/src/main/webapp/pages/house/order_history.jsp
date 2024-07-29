<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách nhà trọ</title>

        <!-- <link rel="manifest" href="site.webmanifest"> -->
        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">
        <!-- Place favicon.ico in the root directory -->
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <!-- CSS here -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/owl.carousel.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/magnific-popup.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/themify-icons.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/nice-select.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/flaticon.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/gijgo.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slicknav.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <!-- <link rel="stylesheet" href="css/responsive.css"> -->

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f8f8;
                margin: 0;
                padding: 0;
            }
            .container {
                display: flex;
                padding: 20px;
            }
            .filter, .results {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                margin-right: 20px;
            }
            .filter {
                width: 250px;
            }
            .filter h3 {
                margin-bottom: 20px;
                color: #d9534f;
            }
            .filter label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            .filter select, .filter input {
                width: 100%;
                padding: 8px;
                margin-bottom: 15px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .filter .range-input {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
            }
            .filter .range-input input {
                width: 45%;
                margin-right: 5%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .filter .range-input input:last-child {
                margin-right: 0;
            }
            .filter button {
                padding: 8px 12px;
                border: none;
                background-color: #d9534f;
                color: #fff;
                border-radius: 4px;
                cursor: pointer;
            }
            .results {
                flex-grow: 1;
            }
            .results h3 {
                margin-bottom: 20px;
            }
            .result-item {
                border: 1px solid #ddd;
                border-radius: 8px;
                overflow: hidden;
                margin-bottom: 20px;
                background-color: #fff;
                transition: box-shadow 0.3s;
            }
            .result-item:hover {
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .result-item img {
                width: 100%;
                height: 200px; /* Đặt chiều cao cố định */
                object-fit: cover; /* Đảm bảo hình ảnh được cắt đúng cách */
            }
            .result-item-content {
                padding: 10px;
            }
            .result-item h3 {
                margin: 10px 0;
                color: #d9534f;
                font-size: 18px;
            }
            .result-item p {
                margin: 5px 0;
                color: #333;
                font-size: 14px;
            }
            .result-item .price {
                font-weight: bold;
                color: #d9534f;
            }
            .result-item .distance {
                color: #777;
            }
            .result-item .info-icons {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .result-item .info-icons i {
                color: #d9534f;
                margin-right: 10px;
            }
            .result-item .favorite {
                cursor: pointer;
            }
            .search-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            .search-bar input {
                width: calc(100% - 60px);
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .search-bar button {
                padding: 8px 12px;
                border: none;
                background-color: #d9534f;
                color: #fff;
                border-radius: 4px;
                cursor: pointer;
            }
            .stats {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
                background-color: #fff;
                padding: 10px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .stat {
                text-align: center;
                flex: 1;
                padding: 10px;
                border-right: 1px solid #ddd;
            }
            .stat:last-child {
                border-right: none;
            }
            .stat p {
                margin: 5px 0;
                color: #d9534f;
                font-weight: bold;
            }
            .sort-bar {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                margin-bottom: 20px;
            }
            .sort-bar select {
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .results-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 20px;
            }

            .icon-margin {
                margin-right: 0.5em;
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
        </style>
    </head>
    <body>
        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <div class="bradcam_area bradcam_bg_1"></div>
            <div class="container">
                <div class="results">
                    <div class="row">
                        <div class="col-md-7 d-flex justify-content-start">
                            <h1>Danh sách yêu cầu thuê trọ</h1>
                        </div>
                        <form action="Booking" class="col-md-5 d-flex justify-content-start" style="align-items: center">
                            <input type="hidden" name="service" value="ViewListOrderHistory"/>
                            <div style="margin-right: 15px"> Tìm kiếm</div>
                            <select name="status" style="width: 150px">
                                <option value="">Tất cả</option> 
                                <option ${status == 'Approve' ? 'selected' : ''} value="Approve"> Đã được xác nhận </option> 
                            <option ${status == 'Reject' ? 'selected' : ''} value="Reject">Bị từ chối </option> 
                            <option ${status == 'Pending' ? 'selected' : ''} value="Pending">Đang chờ </option>
                            <option ${status == 'Cancel' ? 'selected' : ''} value="Cancel">Đã hủy yêu cầu</option> 
                        </select>
                        <button class="btn btn-success" type="submit" style="margin-left: 15px">Lọc</button>
                    </form>
                    <div class="col-md-8 search-bar d-flex justify-content-end">
                        <input type="text" id="searchKeyword" name="keyword" value="${sessionScope.keyword}" hidden="">
                    </div>
                </div>
                <style>
                    .hidden {
                        display: none;
                    }
                </style>
                <select id="sort" name="sort" style="display: none;" class="hidden" onchange="updateAndSubmit()">
                    <option value="newest" ${sessionScope.sort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                    <option value="oldest" ${sessionScope.sort == 'oldest' ? 'selected' : ''}>Cũ nhất</option>
                </select>
                <div class="results-grid" id="resultsGrid">
                    <c:forEach var="order" items="${orders}">
                        <div class="result-item" data-toggle="modal" data-target="#roomDetail" style="cursor: pointer"
                             data-roomnumber="${order.roomModel.roomNumber}"
                             data-price="${order.roomModel.price}"
                             data-area="${order.roomModel.area}"
                             data-note="${order.order.note}"
                             data-status="${order.order.status}"
                             data-roomid="${order.order.roomID}"
                             data-landlord="${order.landlord.first_name} ${order.landlord.last_name}"
                             data-sdt="${order.landlord.phone}"
                             data-namehouse="${order.house.house_name}"
                             data-orderid="${order.order.orderID}"
                             >
                            <img src="img/fu_house/${order.house.img}" alt="House Image">
                            <div class="result-item-content">
                                <h3><a href="/HFManagementSystem/detail_house?id=${order.house.id}">${order.house.house_name}</a></h3>
                                <p class="distance"><i class="fas fa-coins icon-margin"></i> 
                                    <fmt:formatNumber value="${order.roomModel.price}" type="currency" currencySymbol=" " groupingUsed="true" /> VND
                                </p>
                                <p class="distance"><i class="fas fa-ruler-combined icon-margin"></i> <fmt:formatNumber value="${order.roomModel.area}" type="number" minFractionDigits="0" maxFractionDigits="0" /> m²</p>
                                <p class="distance"><i class="fas fa-user icon-margin"></i> ${order.landlord.first_name} ${order.landlord.last_name}</p>
                                <p class="distance"><i class="fas fa-phone-alt icon-margin"></i> ${order.landlord.phone}</p>
                                <div class="info-icons">
                                    <c:if test="${not empty sessionScope.user and sessionScope.user.roleId == 2}">
                                        <i class="fas fa-heart favorite"></i>
                                    </c:if>
                                </div>                               
                            </div>
                            <c:choose>
                                <c:when test="${order.order.status == 'Pending'}">
                                    <a class="btn btn-danger w-100" style="cursor: default !important;">Đang chờ</a>
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${order.order.status == 'Reject'}">
                                        <div class="btn btn-danger w-100" style="cursor: default !important;">Bị từ chối</div>
                                    </c:if>
                                    <c:if test="${order.order.status == 'Approve'}">
                                        <div class="btn btn-success w-100" style="cursor: default !important;">Đã được xác nhận</div>
                                    </c:if>
                                    <c:if test="${order.order.status == 'Cancel'}">
                                        <div class="btn btn-secondary w-100" style="cursor: default !important;">Đã hủy yêu cầu</div>
                                    </c:if>
                                    <c:if test="${order.order.status == 'CheckOut'}">
                                        <div class="btn btn-dark w-100" style="cursor: default !important;">Đã trả phòng</div>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                        </div>


                    </c:forEach>    
                </div>
                <div class="modal fade" id="roomDetail" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content" style="width: 100%">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmModalLabel">Chi Tiết Yêu Cầu</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div class="modal-body">
                                <label style="color: black">Thông Tin Phòng</label>
                                <div><b>Chủ nhà:</b> <span id="landlordname"></span></div>                       
                                <div><b>Số điện thoại:</b> <span id="sdt"></span></div>
                                <div><b>Nhà:</b> <span id="namehouse"></span></div>
                                <div><b>Phòng: </b> <span id="roomNumber"></span></div>
                                <div>
                                    <b>Giá: </b> <span id="price"></span> ₫
                                </div>
                                <div>
                                    <b>Diện tích: </b>
                                    <span id="area"></span> m²
                                </div>
                                <div>
                                    <b>Note: </b>
                                    <span id="note"></span> 
                                </div>
                                <div>
                                    <b>Trạng thái: </b>
                                    <span id="statusString"></span>

                                </div>
                            </div>
                            <div class="modal-footer" id="modal-end">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                <c:if test="${order.order.status == 'Pending'}"> 
                                    <a  class="btn btn-danger w-30" href="Booking?service=CancelBookRoom&roomId=${order.roomModel.roomId}">Hủy yêu cầu</a>
                                </c:if>
                                <c:if test="${order.order.status == 'Approve'}">
                                    <a id="returnRoomLink" class="btn btn-danger w-30" href="Booking?service=ReturnRoom&roomId=${order.roomModel.roomId}&orderId=${order.order.orderID}">Trả Phòng</a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/pages/footer/footer.jsp"></jsp:include>


            <script>
                // Lắng nghe sự kiện click vào liên kết "Trả Phòng"
                document.getElementById('returnRoomLink').addEventListener('click', function (event) {
                    event.preventDefault(); // Ngăn chặn hành động mặc định của liên kết

                    // Lấy href của liên kết để redirect sau khi xác nhận
                    var href = this.getAttribute('href');

                    // Gán href cho nút Xác nhận trong modal
                    document.getElementById('confirmButton').setAttribute('href', href);

                    // Hiển thị modal
                    var modal = new bootstrap.Modal(document.getElementById('confirmModal'));
                    modal.show();
                });
            </script>

            <script>
                function updateAndSubmit() {
                    var searchKeyword = document.getElementById('searchKeyword').value;
                    var sort = document.getElementById('sort').value;

                    var hiddenKeyword = document.getElementById('hiddenKeyword');
                    var hiddenSort = document.getElementById('hiddenSort');

                    if (hiddenKeyword) {
                        hiddenKeyword.value = searchKeyword;
                    }

                    if (hiddenSort) {
                        hiddenSort.value = sort;
                    }

                    var form = document.getElementById('filterForm');
                    form.submit();
                }

                window.onload = function () {
                    var hiddenSort = document.getElementById('hiddenSort');
                    if (hiddenSort) {
                        document.getElementById('sort').value = hiddenSort.value;
                    }
                };
            </script>

            <script src="${pageContext.request.contextPath}/js/vendor/modernizr-3.5.0.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/vendor/jquery-1.12.4.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/owl.carousel.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/isotope.pkgd.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/ajax-form.js"></script>
        <script src="${pageContext.request.contextPath}/js/waypoints.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.counterup.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/imagesloaded.pkgd.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/scrollIt.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.scrollUp.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/wow.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/nice-select.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.slicknav.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.magnific-popup.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/js/gijgo.min.js"></script>
        <!--contact js-->
        <script src="${pageContext.request.contextPath}/js/contact.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.ajaxchimp.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/mail-script.js"></script>
        <script src="${pageContext.request.contextPath}/js/main.js"></script>

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
                            showConfirmButton: true,
                            timer: 3000
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


        <!--sử lý bookmodal-->
        <script>
                $(document).ready(function () {
                    // Khi mở modal, cập nhật nội dung modal với dữ liệu của room
                    $('#roomDetail').on('show.bs.modal', function (event) {
                        // Lấy thông tin room từ button đã được nhấn
                        var button = $(event.relatedTarget); // button mà modal đã được kích hoạt
                        var room = button.data('roomnumber'); // Lấy giá trị của data-room
                        var price = button.data('price');
                        var area = button.data('area');
                        var note = button.data('note');
                        var statusString = button.data('status');
                        var roomid = button.data('roomid'); // lấy giá trị của data-roomid
                        var landlord = button.data('landlord');
                        var sdt = button.data('sdt');
                        var namehouse = button.data('namehouse');
                        var orderid = button.data('orderid');
                        var modal_end = document.getElementById('modal-end');
                        // Tạo thẻ a
                        var link = document.createElement('a');

                        // Tạo thẻ <button> hủy
                        var button = document.createElement('button');
                        // Thiết lập thuộc tính cho nút
                        button.type = 'button';
                        button.className = 'btn btn-secondary'; // Thêm các lớp CSS
                        button.setAttribute('data-dismiss', 'modal'); // Thiết lập thuộc tính dữ liệu
                        // Thêm nội dung cho nút
                        button.textContent = 'Hủy';


                        modal_end.innerHTML = '';
                        modal_end.appendChild(button);

                        if (statusString === 'Reject') {
                            statusString = 'Bị từ chối';
                        } else if (statusString === 'Approve') {
                            link.href = 'Booking?service=ReturnRoom&roomId=' + roomid + '&orderId=' + orderid;
                            link.className = 'btn btn-danger w-30';
                            link.textContent = 'Trả Phòng';
                            modal_end.appendChild(link);

                            statusString = 'Đã được duyệt';
                        } else if (statusString === 'Cancel') {
                            statusString = 'Đã hủy yêu cầu';
                        } else if (statusString === 'Pending') {
                            link.href = 'Booking?service=CancelBookRoom&roomId=' + roomid;
                            link.className = 'btn btn-danger w-30';
                            link.textContent = 'Hủy yêu cầu';
                            modal_end.appendChild(link);
                            statusString = 'Chờ xác nhận';
                        } else if (statusString === 'CheckOut') {
                            statusString = 'Đã trả phòng';
                        }
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
                        modal.find('#landlordname').text(landlord);
                        modal.find('#sdt').text(sdt);
                        modal.find('#namehouse').text(namehouse);
                        modal.find('#note').text(note);
                        modal.find('#statusString').text(statusString);
                        modal.find('#area').text(area);
                        modal.find('#price').text(formattedPrice);
                    });
                });



        </script>



    </body>
</html>
