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
                min-height: 500px
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
            .hidden {
                display: none;
            }
            .table{
                overflow: scroll
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
                            <input type="hidden" name="service" value="ViewRequestBooking"/>
                            <div style="margin-right: 15px"> Tìm kiếm</div>
                            <select name="status" style="width: 150px">
                                <option  value="">Tất cả</option> 
                                <option ${status == 'Pending' ? 'selected' : ''} value="Pending"> Chờ xác nhận </option> 
                            <option ${status == 'Approve' ? 'selected' : ''} value="Approve"> Đã được xác nhận </option> 
                            <option ${status == 'Reject' ? 'selected' : ''} value="Reject">Đã từ chối </option> 
                        </select>
                        <button class="btn btn-success" type="submit" style="margin-left: 15px">Lọc</button>
                    </form>
                </div>

                <select id="sort" name="sort"  style="display: none;" class="hidden" onchange="updateAndSubmit()">
                    <option value="newest" ${sessionScope.sort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                    <option value="oldest" ${sessionScope.sort == 'oldest' ? 'selected' : ''}>Cũ nhất</option>
                </select>
                <div class="form-group">
                    <table class="table table-bordered">
                        <tr>
                            <th>Tên Nhà</th>
                            <th>Tên Phòng</th>
                            <th>Giá Phòng</th>
                            <th>Người đặt phòng</th>
                            <th>Số điện thoại</th>
                            <th>Địa chỉ</th>
                            <th>Ngày Đặt Phòng</th>  
                            <th>Note</th>  
                            <th>Trạng thái</th>

                            <th>Hành Động</th>
                        </tr>
                        <tbody>
                            <% if (request.getAttribute("message") != null) { %>
                        <p style="color: red;"><%= request.getAttribute("message") %></p>
                        <%}%>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td><a style="color: black" href="view_landrord_detail?id=${order.house.id}">${order.house.house_name}</a></td>
                                <td>${order.roomModel.roomNumber}</td>
                                <td>${order.roomModel.price}</td>
                                <td>${order.tenant.firstName} ${order.tenant.lastName}</td>
                                <td>${order.tenant.phone}</td>
                                <td>${order.tenant.address}</td>
                                <td>${order.order.orderDate}</td>
                                <td>${order.order.note}</td>
                                <td>
                                    <c:if test="${order.order.status == 'Approve'}">
                                        <p style="color: green">Đã xác nhận</p>
                                    </c:if>
                                    <c:if test="${order.order.status == 'Reject'}">
                                        <p style="color: red">Đã từ chối</p>
                                    </c:if>
                                    <c:if test="${order.order.status == 'Pending'}">
                                        <p style="color: black">Chờ xác nhận</p>
                                    </c:if>
                                    <c:if test="${order.order.status == 'CheckOut'}">
                                        <p style="color: black">Trả phòng</p>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${order.order.status == 'Pending'}">
                                        <a class="btn btn-danger mb-3"  data-toggle="modal" data-target="#reject-booking-${order.order.orderID}">Từ chối</a>
                                        <div class="modal fade" id="reject-booking-${order.order.orderID}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <form action="Booking">
                                                <input type="hidden" name="service" value="RejectRequestBooking"/>                                                <input type="hidden" name="service" value="ViewRequestBooking"/>
                                                <input type="hidden" name="orderId" value="${order.order.orderID}"/>                                                <input type="hidden" name="service" value="ViewRequestBooking"/>

                                                <div class="modal-dialog">
                                                    <div class="modal-content" style="width: 100%">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="confirmModalLabel">Xác Nhận Yêu Cầu</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>

                                                        <div class="modal-body">
                                                            <label style="color: black">Bạn có chắc chắc <b>không muốn</b> cho phép <b>[${order.tenant.firstName} ${order.tenant.lastName}]</b> thuê phòng <b>[${order.roomModel.roomNumber}]</b> này?</label>
                                                            <div>
                                                                Note: <textarea id="note" name="note" style="width: 100%; height: 100px"></textarea>
                                                            </div>
                                                            <label style="color: black"><i>Vui lòng kiểm tra kĩ lại thông tin trước khi xác nhận yêu cầu</i></label>
                                                        </div>

                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                                            <button class="btn btn-success" type="submit">Xác nhận</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>

                                        </div>


                                        <a class="btn btn-success"  data-toggle="modal" data-target="#approve-booking-${order.order.orderID}">Đồng ý</a>
                                        <div class="modal fade" id="approve-booking-${order.order.orderID}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <form action="Booking">
                                                <input type="hidden" name="service" value="AcceptRequestBooking"/>                                             
                                                <input type="hidden" name="orderId" value="${order.order.orderID}"/>  
                                                <input type="hidden" name="roomId" value="${order.roomModel.roomId}"/>  
                                                <div class="modal-dialog">
                                                    <div class="modal-content" style="width: 100%">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="confirmModalLabel">Xác Nhận Yêu Cầu</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>

                                                        <div class="modal-body">
                                                            <label style="color: black">Bạn có chắc chắc <b>muốn</b> cho phép <b>[${order.tenant.firstName} ${order.tenant.lastName}]</b> thuê phòng <b>[${order.roomModel.roomNumber}]</b> này?</label>
                                                            <div>
                                                                Note: <textarea id="note" name="note" style="width: 100%; height: 100px"></textarea>
                                                            </div>
                                                            <label style="color: black"><i>Vui lòng kiểm tra kĩ lại thông tin trước khi xác nhận yêu cầu</i></label>
                                                        </div>

                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                                            <button class="btn btn-success" type="submit">Xác nhận</button>
                                                        </div>

                                                    </div>
                                                </div>
                                        </div>
                                        </form>
                                    </c:if>
                                    <c:if test="${order.order.status == 'CheckOut' && order.roomModel.status == '0' && !order.roomBookedByOther() && !order.order.isIsConfirm()}">
                                        <a class="btn btn-primary" href="/HFManagementSystem/Booking?service=confirm&roomId=${order.roomModel.roomId}&tenantId=${order.order.tenantID}">Xác nhận</a>
                                    </c:if>        
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <jsp:include page="/pages/footer/footer.jsp"></jsp:include>
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

    </body>
</html>
