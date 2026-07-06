

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
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
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/magnific-popup.css">
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/themify-icons.css">
        <link rel="stylesheet" href="css/nice-select.css">
        <link rel="stylesheet" href="css/flaticon.css">
        <link rel="stylesheet" href="css/gijgo.css">
        <link rel="stylesheet" href="css/animate.css">
        <link rel="stylesheet" href="css/slicknav.css">
        <link rel="stylesheet" href="css/style.css">
        <!-- <link rel="stylesheet" href="css/responsive.css"> -->
        <style>
            .custom-form-width {
                width: 40%; /* Đặt độ rộng mong muốn */
            }

            .bradcam_area {
                padding: 50px 0 102px 0;
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
                color: red;
            }
        </style>
    </head>

    <body>

        <!-- header-start -->

        <jsp:include page="../header/header.jsp"></jsp:include>

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
                            <h5 class="card-title text-center">Đặt Lại Mật Khẩu Mới</h5>
                            <form action="/HFManagementSystem/resetpassword" method="post">
                                <div class="form-group">
                                    <label for="code">Mã <span class="note">*</span></label>
                                    <input type="text" class="form-control" id="code" value="${requestScope.code}" name="codeverify" required placeholder="Mã đặt lại mật khẩu... ">
                            </div>
                            <div class="form-group">
                                <label for="password">Mật Khẩu Mới <span class="note">*</span></label>
                                <input type="password" class="form-control" id="password" value="${newpassword}" name="newpassword" required placeholder="Mật khẩu mới...">
                            </div>
                            <div class="form-group">
                                <label for="confirmPassword">Xác Nhận Mật Khẩu Mới <span class="note">*</span></label>
                                <input type="password" class="form-control" id="confirmPassword" value="${confirmpassword}" name="confirmPassword"
                                       required placeholder="Xác nhận mật khẩu mới...">
                            </div>
                            <button type="submit" class="btn btn-primary btn-block">Xác Nhận</button>
                 
                        </form>
                    </div>
                </div>
            </section>
        </div>
        <!-- End Sample Area<c:if test="${requestScope.error != null}">
                                <p style="color: red ; text-align: center; padding-top: 10px">${requestScope.error}</p>
                            </c:if> -->

        <div id="alertPlaceholder" class="mt-3 alert-container"></div>
        <!-- footer start -->
        <jsp:include page="/pages/footer/footer.jsp"></jsp:include>
            <!--/ footer end  -->

            <!-- JS here -->
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