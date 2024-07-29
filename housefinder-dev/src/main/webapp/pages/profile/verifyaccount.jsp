<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!doctype html>
<html class="no-js" lang="xxx">

    <head>

        <meta charset="UTF-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>FU House Finder</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- <link rel="manifest" href="site.webmanifest"> -->
        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">
        <!-- Place favicon.ico in the root directory -->

        <!-- CSS here -->
        <link rel="stylesheet" href="/HFManagementSystem/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HFManagementSystem/css/owl.carousel.min.css">
        <link rel="stylesheet" href="/HFManagementSystem/css/magnific-popup.css">
        <link rel="stylesheet" href="/HFManagementSystem/css/font-awesome.min.css">
        <link rel="stylesheet" href="/HFManagementSystem/css/themify-icons.css">
        <link rel="stylesheet" href="/HFManagementSystem/css/nice-select.css">
        <link rel="stylesheet" href="/HFManagementSystem/css/flaticon.css">
        <link rel="stylesheet" href="/HFManagementSystem/css/gijgo.css">
        <link rel="stylesheet" href="/HFManagementSystem/css/animate.css">
        <link rel="stylesheet" href="/HFManagementSystem/css/slicknav.css">
        <link rel="stylesheet" href="/HFManagementSystem/css/style.css">
        <!-- <link rel="stylesheet" href="css/responsive.css"> -->
        <style>
            .custom-form-width {
                width: 40%;

            }

            .bradcam_area {
                padding: 40px 0 102px 0;
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
            .note{
                color:red;
            }
        </style>
    </head>

    <body>

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
            <div class="container-fluid">
                <section class="vh-100 d-flex justify-content-center align-items-center my-5">
                    <div class="card custom-form-width">
                        <div class="card-body">
                            <h5 class="card-title text-center">Nhập Mã Xác Thực Email</h5>
                            <form action="/HFManagementSystem/verify"  method="post">
                                <div class="form-group">
                                    <label for="verify">Mã xác thực <span class="note">*</span> </label>
                                    <input type="text" class="form-control" id="code" value="${verify}" name="verify" required
                                       placeholder="Nhập mã xác thực đã được gửi đến gmail của bạn...">
                                <br>
                                <input type="text" value="${code}" name="code" hidden="">
                                <button type="submit" class="btn btn-primary btn-block">Xác nhận</button>
                            </div>
                        </form> 
                    </div>
                </div>
            </section>
        </div>
        <!-- End Sample Area -->

        <div id="alertPlaceholder" class="mt-3 alert-container"></div>
        <!-- footer start -->
        <jsp:include page="/pages/footer/footer.jsp"></jsp:include>
            <!--/ footer end  -->

            <!-- JS here -->
            <script src="/HFManagementSystem/js/vendor/modernizr-3.5.0.min.js"></script>
            <script src="/HFManagementSystem/js/vendor/jquery-1.12.4.min.js"></script>
            <script src="/HFManagementSystem/js/popper.min.js"></script>
            <script src="/HFManagementSystem/js/bootstrap.min.js"></script>
            <script src="/HFManagementSystem/js/owl.carousel.min.js"></script>
            <script src="/HFManagementSystem/js/isotope.pkgd.min.js"></script>
            <script src="/HFManagementSystem/js/ajax-form.js"></script>
            <script src="/HFManagementSystem/js/waypoints.min.js"></script>
            <script src="/HFManagementSystem/js/jquery.counterup.min.js"></script>
            <script src="/HFManagementSystem/js/imagesloaded.pkgd.min.js"></script>
            <script src="/HFManagementSystem/js/scrollIt.js"></script>
            <script src="/HFManagementSystem/js/jquery.scrollUp.min.js"></script>
            <script src="/HFManagementSystem/js/wow.min.js"></script>
            <script src="/HFManagementSystem/js/nice-select.min.js"></script>
            <script src="/HFManagementSystem/js/jquery.slicknav.min.js"></script>
            <script src="/HFManagementSystem/js/jquery.magnific-popup.min.js"></script>
            <script src="/HFManagementSystem/js/plugins.js"></script>
            <script src="/HFManagementSystem/js/gijgo.min.js"></script>

            <!--contact js-->
            <script src="/HFManagementSystem/js/contact.js"></script>
            <script src="/HFManagementSystem/js/jquery.ajaxchimp.min.js"></script>
            <script src="/HFManagementSystem/js/jquery.form.js"></script>
            <script src="/HFManagementSystem/js/jquery.validate.min.js"></script>
            <script src="/HFManagementSystem/js/mail-script.js"></script>

            <script src="/HFManagementSystem/js/main.js"></script>
            <script>
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
    </body>

</html>