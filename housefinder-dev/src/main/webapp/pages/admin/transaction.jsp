<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>FU House Finder</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">


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
            .bradcam_area {
                padding: 40px 0 102px 0;
            }


            .me {
                min-height: 700px;
            }
            .alert-top-right {
                position: fixed;
                top: 100px;
                right: 20px;
                z-index: 1050; /* Đảm bảo rằng thông báo xuất hiện trên các thành phần khác */
            }
            .tb{
                overflow: scroll
            }
        </style>

    </head>

    <body>
        <!-- header-start -->
        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <!-- header-end -->

            <!-- bradcam_area  -->
            <div class="bradcam_area bradcam_bg_1">
            </div>
            <!--/ bradcam_area  -->

            <!--================Blog Area =================-->


            <div class="container-fluid mt-3">
                <div class="row me">
                    <div class="col-md-2">
                        <div class="bg-light">
                            <table class="table table-borderless ">
                                <tbody>
                                    <tr>
                                        <td><a href="/HFManagementSystem/dashboard" class="nav-link text-dark">Bảng Điều Khiển</a></td>
                                    </tr>
                                    <tr>
                                        <td><a href="/HFManagementSystem/manageuser" class="nav-link text-dark">Quản Lý Người Dùng</a></td>
                                    </tr>
                                    <tr>
                                        <td><a href="/HFManagementSystem/managepost" class="nav-link text-dark">Danh Sách Các Nhà</a></td>
                                    </tr>
                                    <tr>
                                        <td><a href="/HFManagementSystem/managereport" class="nav-link text-dark">Quản Lý Báo Cáo</a></td>
                                    </tr>
                                    <tr>
                                        <td><a href="/HFManagementSystem/transaction" class="nav-link text-dark">Quản Lý Giao Dịch</a></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4 tb">
                        <h2 class="text-center">Quản lý giao dịch</h2>

                    <table class="table table-bordered table-striped">
                        <tr class="bg-warning">
                            <td>STT</td>
                            <td>Mã giao dịch</td>
                            <td>Người giao dịch</td>
                            <td>Thời gian giao dịch</td>
                            <td>Số tiền</td>
                            <td>Nội dung</td>
                            <td>Mã Ngân Hàng</td>
                            <td>Trạng thái</td>
                        </tr>
                        <c:forEach items="${data}" var="u" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>                                
                                <td>${u.transaction_id}</td>
                                <td><a href="/HFManagementSystem/manageuser?action=viewdetail&email=${u.getLandlord().email}" class="text-dark">${u.getLandlord().firstName} ${u.getLandlord().lastName}</a></td>
                                <td>${u.time_transaction}</td>
                                <td>${u.amount}</td>
                                <td>${u.description}</td>
                                <td>${u.bank_code}</td>
                                <td>${u.getStatus()}</td>

                            </tr>
                        </c:forEach>
                    </table>
                    <div class="d-flex justify-content-end mt-5">
                        <ul class="pagination">
                            <c:if test="${totalPages > 1}">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="?action=${action}&page=${currentPage - 1}">&laquo; </a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <c:choose>
                                        <c:when test="${i == currentPage}">
                                            <li class="page-item active"><span class="page-link">${i}</span></li>
                                            </c:when>
                                            <c:otherwise>
                                            <li class="page-item"><a class="page-link" href="?action=${action}&page=${i}">${i}</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="?action=${action}&page=${currentPage + 1}"> &raquo;</a>
                                    </li>
                                </c:if>
                            </c:if>
                        </ul>
                    </div>
                </main>
            </div>
        </div>



        <!-- Modal -->
        <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmModalLabel">Xác nhận hành động</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="confirmMessage"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        <button type="button" class="btn btn-primary" id="confirmActionBtn">Xác nhận</button>
                    </div>
                </div>
            </div>
        </div>




        <!--================ Blog Area end =================-->
        <div id="alertPlaceholder" class="mt-3"></div>
        <!-- footer start -->

        <jsp:include page="/pages/footer/footer.jsp"></jsp:include>
            <!--/ footer end  -->


            <!-- JS here -->
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
                var alertMessage = '<%= session.getAttribute("alertMessage") != null ? session.getAttribute("alertMessage") : "" %>';
                var alertType = '<%= session.getAttribute("alertType") != null ? session.getAttribute("alertType") : "" %>';
                if (alertMessage) {
                    var alertPlaceholder = document.getElementById('alertPlaceholder');
                    var alertDiv = document.createElement('div');
                    alertDiv.className = 'alert alert-' + alertType + ' alert-dismissible fade show alert-top-right';
                    alertDiv.role = 'alert';
                    alertDiv.innerHTML = `
            ${alertMessage}
                               <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                   <span aria-hidden="true">&times;</span>
                               </button>
                           `;
                    alertPlaceholder.appendChild(alertDiv);

                    // Tự động ẩn thông báo sau 3 giây
                    setTimeout(function () {
                        alertDiv.classList.remove('show');
                        alertDiv.classList.add('fade');
                        setTimeout(function () {
                            alertPlaceholder.removeChild(alertDiv);
                        }, 150); // Thời gian cho hiệu ứng 'fade'
                    }, 3000); // Thời gian hiển thị là 3 giây
                }
            };

            <% 
             session.removeAttribute("alertMessage");
             session.removeAttribute("alertType");
            %>
        </script>


        <script>
            $(document).ready(function () {
                $('#confirmModal').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget); // Nút đã kích hoạt Modal
                    var email = button.data('email'); // Trích xuất thông tin từ data-email attribute
                    var action = button.data('action'); // Trích xuất thông tin từ data-action attribute
                    var actionText = (action === 'ban') ? 'Cấm' : 'Hủy cấm'; // Lấy nội dung của nút đã kích hoạt

                    var modal = $(this);
                    modal.find('.modal-body #confirmMessage').text(`Bạn có chắc chắn muốn ` + actionText + ` người dùng có email ` + email + ` ?`);

                    // Xử lý khi người dùng nhấn nút Xác nhận
                    $('#confirmActionBtn').off('click').on('click', function () {
                        var url = `/HFManagementSystem/manageuser?action=` + action + `&email=` + email;
                        window.location.href = url; // Chuyển hướng đến URL để thực hiện hành động
                    });
                });

                // Ngăn chặn hành vi mặc định của thẻ <a>
                $('a[data-toggle="modal"]').click(function (event) {
                    event.preventDefault();
                });
            });
        </script>

    </body>
    <!-- cách sửa modal là trong file bootstrap.min.js thay  
    appendTo(document.body) thành insertBefore(this.$element) -->
</html>
