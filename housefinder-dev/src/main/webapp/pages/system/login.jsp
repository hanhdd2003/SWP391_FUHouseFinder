

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
            .bradcam_area {
                padding: 40px 0 102px 0;
            }


            .main-container {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 80vh;
                background-color: #f8f9fa;
            }
            .login-container {
                width: 400px;
                background: #fff;
                padding: 2rem;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }
            .login-container h2 {
                margin-bottom: 1.5rem;
            }
            .btn-google {
                background: #fff;
                border: 1px solid #ddd;
                color: #555;
            }
            .btn-google img {
                width: 20px;
                margin-right: 8px;
            }
            .or-separator {
                margin: 1.5rem 0;
                font-size: 1rem;
                color: #888;
            }
            .form-control {
                margin-bottom: 1rem;
            }
            .btn-login {
                background: #000;
                color: #fff;
            }
            .links {
                margin-top: 1rem;
                font-size: 0.9rem;
            }
            .links a {
                color: #007bff;
            }
            /* CSS tùy chỉnh để định vị thông báo ở góc trên bên phải */
            .alert-container {
                position: fixed;
                top: 50px;
                right: 20px;
                z-index: 1050; /* Đảm bảo rằng thông báo xuất hiện trên các thành phần khác */
            }
            .alert-item {
                margin-top: 50px;
                margin-bottom: 10px; /* Khoảng cách giữa các thông báo */
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
            <div class="main-container">
                <div class="login-container">
                    <h2>Đăng nhập</h2>
                    <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile&redirect_uri=http://localhost:9999/HFManagementSystem/checkgmail&response_type=code&client_id=1046496172412-fvr217ib2m1jdcahbhprj1pbkodrg7eu.apps.googleusercontent.com&approval_prompt=force">
                        <button class="btn btn-google btn-block">
                            <img src="/HFManagementSystem/img/googleicon.webp" alt="Google logo">Đăng nhập với google
                        </button>
                    </a>
                    <div class="or-separator">hoặc</div>
                    <form action="/HFManagementSystem/home" method="post">
                        <input type="email" class="form-control" name="email" value="${email}" placeholder="Email" required maxlength="50">
                    <input type="password" id="passwordField" class="form-control" name="password" value="${password}" placeholder="Mật khẩu" required maxlength="20">
                    <label for="showPassword">
                        <input type="checkbox" id="showPassword"> Hiển thị mật khẩu
                    </label>
                    <!--<input id="checkbox" type="checkbox" class="form-check-input"/>-->
                    <!--<label for="checkbox" class="form-label">Ghi nhớ mật khẩu</label>-->
                    <button type="submit" class="btn btn-login btn-block">Đăng nhập</button>
                </form>
                <div class="links">
                    <a href="${pageContext.request.contextPath}/pages/system/resetpassword.jsp">Quên mật khẩu</a><br><br>
                    Chưa có tài khoản? <a href="${pageContext.request.contextPath}/pages/system/register.jsp">Đăng ký</a>
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
                        }, 10000); // Thời gian hiển thị là 3 giây
                    });
                }
            };





            document.getElementById("showPassword").addEventListener("change", function () {
                var passwordField = document.getElementById("passwordField");
                if (passwordField.type === "password") {
                    passwordField.type = "text";
                } else {
                    passwordField.type = "password";
                }
            });
        </script>
    </body>

</html>