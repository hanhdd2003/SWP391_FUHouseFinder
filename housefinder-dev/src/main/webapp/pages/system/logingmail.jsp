<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slicknav.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <!-- <link rel="stylesheet" href="css/responsive.css"> -->
        <style>
            .custom-form-width {
                width: 40%;
                /* Đặt độ rộng mong muốn */
            }

            /* độ cao của bradcam*/
            .bradcam_area {
                padding: 40px 0 102px 0;
            }



            .bg-image {
                /* Đặt hình nền */
                background-image: url('img/bg.jpg');
                /* Chỉnh kích thước hình nền */
                background-size: cover;
                /* Tạo hiệu ứng chồng lên */
                position: relative;
                /* Thiết lập độ cao cho phần tử, tùy thuộc vào nội dung bên trong */
                min-height: 100vh;
            }

            /* CSS để cải thiện phần tử container */
            .container {
                position: relative;
                z-index: 1;
            }

            .card {
                margin-bottom: 85px;
            }
            .note{
                color: red;
            }
            /* CSS tùy chỉnh để định vị thông báo ở góc trên bên phải */
            .alert-container {
                position: fixed;
                top: 50px;
                right: 20px;
                z-index: 1050; /* Đảm bảo rằng thông báo xuất hiện trên các thành phần khác */
            }
            .alert-item {
                margin-bottom: 10px; /* Khoảng cách giữa các thông báo */
            }

            /* Modal */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.4);
                padding-top: 60px;
            }

            /* Nội dung của modal */
            .modal-content {
                background-color: #fefefe;
                margin: 5% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 350px;
                border-radius: 10px;
            }

            /* Button để đóng modal */
            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
            }

            /* Nút xác nhận và hủy */
            #confirmVerificationBtn,
            #cancelVerificationBtn {
                background-color: #007bff;
                color: #fff;
                border: none;
                padding: 10px 20px;
                margin-right: 10px;
                border-radius: 5px;
                cursor: pointer;
                width: 100px;
            }

            #cancelVerificationBtn {
                background-color: #6c757d;
            }


        </style>
    </head>

    <body class="bg-image">

        <!-- header-start -->
        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <!-- header-end -->

            <!-- bradcam_area  -->
            <div class="bradcam_area bradcam_bg_1">
                <div class="container">
                </div>
            </div>
            <!--/ bradcam_area  -->

            <!-- Start Sample Area -->

            <div class="container mt-5 ">
                <div class="row justify-content-center">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-header text-center">
                                <h4>Cung cấp thêm thông tin</h4>
                            </div>
                            <div class="card-body">
                                <form id="registrationForm" action="/HFManagementSystem/register" method="post">
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label for="ho">Họ <span class="note">*</span></label>
                                            <input type="text" class="form-control" id="ho" value="${ho}" name="ho" required maxlength="30">
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="ten">Tên <span class="note">*</span></label>
                                        <input type="text" class="form-control" id="ten" value="${ten}" name="ten" required maxlength="10">
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label for="email">Email <span class="note">*</span></label>
                                        <input type="email" class="form-control" id="email" value="${email}" name="email" readonly="re" required>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="sdt">Số điện thoại <span class="note">*</span></label>
                                        <input type="tel" class="form-control" id="sdt" value="${sdt}" oninput="limitNumericInput(event)" name="sdt" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="diaChi">Địa chỉ <span class="note">*</span></label>
                                    <input type="text" class="form-control" id="diaChi" value="${diachi}" name="diaChi" required maxlength="250">
                                </div>
                                <div class="form-group">
                                    <label for="matKhau">Mật khẩu <span class="note">*</span></label>
                                    <input type="password" class="form-control" id="matKhau" value="${matkhau}" name="matKhau" required maxlength="100">
                                </div>
                                <div class="form-group">
                                    <label for="loaiTaiKhoan">Vai trò <span class="note">*</span></label><br>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="loaiTaiKhoan" id="khachThue"
                                               value="3" checked ${role eq 3 ?"checked":""}>
                                        <label class="form-check-label" for="khachThue">Khách thuê</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="loaiTaiKhoan" id="chuNha"
                                               value="2" ${role eq 2 ?"checked":""}>
                                        <label class="form-check-label" for="chuNha">Chủ nhà</label>
                                    </div>
                                </div>   
                                <div><input name="img" value="${avatar}" hidden=""></div>
                                <button type="submit" class="btn btn-primary btn-block">Đăng ký</button><br>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>



        <!-- Modal -->
        <div id="confirmationModal" class="modal">
            <div class="modal-content">
                <span class="close d-flex flex-column align-items-end mb-2" id="closeConfirmationModal">&times;</span>
                <p class="confirm-text d-flex flex-column align-items-start mb-4">Bạn có muốn xác minh email?</p>
                <div class="d-flex flex-column align-items-end">
                    <div class="row">
                        <button id="confirmVerificationBtn" class="btn btn-sm">Xác minh</button>
                        <button id="cancelVerificationBtn" class="btn btn-sm">Để sau</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- End Sample Area -->

        <div id="alertPlaceholder" class="mt-3 alert-container"></div>
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
            function limitNumericInput(event) {
                const inputField = event.target;
                const maxLength = 10;

                // Loại bỏ các ký tự không phải là số
                inputField.value = inputField.value.replace(/\D/g, '');

                // Giới hạn độ dài chuỗi nhập vào không quá 10 ký tự
                if (inputField.value.length > maxLength) {
                    inputField.value = inputField.value.slice(0, maxLength);
                }
            }


            window.onload = function () {
                var alertMessages = <%= request.getAttribute("alertMessages") %>;
                if (alertMessages && alertMessages.length > 0) {
                    var alertPlaceholder = document.getElementById('alertPlaceholder');
                    alertMessages.forEach(function (alert) {
                        var alertDiv = document.createElement('div');
                        alertDiv.className = 'alert alert-' + alert.type + ' alert-dismissible fade show alert-item';
                        alertDiv.role = 'alert';
                        alertDiv.innerHTML = alert.message +
                                '<button type="button" class="close" data-dismiss="alert" aria-label="Close">' +
                                '<span aria-hidden="true">&times;</span>' +
                                '</button>';
                        alertPlaceholder.appendChild(alertDiv);

                        // Tự động ẩn thông báo sau 3 giây
                        setTimeout(function () {
                            alertDiv.classList.remove('show');
                            alertDiv.classList.add('fade');
                            setTimeout(function () {
                                alertDiv.parentNode.removeChild(alertDiv);
                            }, 150); // Thời gian cho hiệu ứng 'fade'
                        }, 3000); // Thời gian hiển thị là 3 giây
                    });
                }
            };

        </script>


        <script>
            var confirmationModal = document.getElementById("confirmationModal");
            var openConfirmationModalBtn = document.getElementById("openConfirmationModalBtn");
            var closeConfirmationModal = document.getElementById("closeConfirmationModal");
            var confirmVerificationBtn = document.getElementById("confirmVerificationBtn");
            var cancelVerificationBtn = document.getElementById("cancelVerificationBtn");
            var registrationForm = document.getElementById("registrationForm");

            openConfirmationModalBtn.onclick = function () {
                confirmationModal.style.display = "block";
            };

            closeConfirmationModal.onclick = function () {
                confirmationModal.style.display = "none";
            };

            window.onclick = function (event) {
                if (event.target === confirmationModal) {
                    confirmationModal.style.display = "none";
                }
            };

            confirmVerificationBtn.onclick = function () {
                // Thu thập dữ liệu từ các trường nhập liệu
                var ho = document.getElementById("ho").value;
                var ten = document.getElementById("ten").value;
                var email = document.getElementById("email").value;
                var sdt = document.getElementById("sdt").value;
                var diaChi = document.getElementById("diaChi").value;
                var matKhau = document.getElementById("matKhau").value;
                var loaiTaiKhoan = document.querySelector('input[name="loaiTaiKhoan"]:checked').value;

                // Chuẩn bị dữ liệu để gửi đến trang xác minh email (ví dụ: dùng query string)
                var verificationData = "ho=" + encodeURIComponent(ho) +
                        "&ten=" + encodeURIComponent(ten) +
                        "&email=" + encodeURIComponent(email) +
                        "&sdt=" + encodeURIComponent(sdt) +
                        "&diaChi=" + encodeURIComponent(diaChi) +
                        "&matKhau=" + encodeURIComponent(matKhau) +
                        "&loaiTaiKhoan=" + encodeURIComponent(loaiTaiKhoan);

                // Chuyển hướng đến trang xác minh email và truyền dữ liệu
                window.location.href = "/HFManagementSystem/verifyemail?" + verificationData;
            };

            cancelVerificationBtn.onclick = function () {
                // Gửi form đăng ký
                registrationForm.submit();
            };


        </script>
    </body>

</html>