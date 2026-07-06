

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
            /* CSS tùy chỉnh để định vị thông báo ở góc trên bên phải */
            .alert-top-right {
                position: fixed;
                top: 100px;
                right: 20px;
                z-index: 1050; /* Đảm bảo rằng thông báo xuất hiện trên các thành phần khác */
            }
            .note{
                color: red;
            }
            .input-form{
                width: 300px
            }
        </style>
    </head>

    <body>


        <jsp:include page="/pages/header/header.jsp"></jsp:include>

            <!-- header-end -->

            <!-- bradcam_area  -->
            <div class="bradcam_area bradcam_bg_1">
                <div class="container">
                </div>
            </div>
            <!--/ bradcam_area  -->

            <!-- Start Sample Area -->
            <section class="sample-text-area ">
                <div class="container box_1170">
                    <h3 class="text-heading">Thay đổi mật khẩu của bạn theo các bước dưới đây:</h3>
                    <h4 >1. Nhập email của bạn vào ô ở dưới <br/><br/>
                        2. Mật khẩu mới sẽ được gửi đến bạn qua email được nhập <br/><br/>
                        3. Nhập mật khẩu mới ở trang kế tiếp</h4><br/>
                    <form action="/HFManagementSystem/resetpassword" method="get">
                        <table>
                            <tr>Vui lòng nhập email của bạn <span class="note">*</span> <br/><br/></tr>
                        <tr><input class="input-form" type="email" name="email" value="${email}" placeholder="...@gmail.com" required > <br/><br/></tr>
                        <tr><button class="btn btn-primary profile-button" type="submit">Xác Nhận</button> <button class="btn btn-primary profile-button ml-1" type="button" onclick="clearAlertsAndGoBack()">Quay Lại</button></tr>
                    </table> 

                </form>

            </div>
        </section>
        <!-- End Sample Area -->

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
            function clearAlertsAndGoBack() {
                var alertPlaceholder = document.getElementById('alertPlaceholder');
                alertPlaceholder.innerHTML = ''; // Xóa bỏ tất cả các thông báo
                window.history.back();
            }
            window.onload = function () {
                var alertMessage = '<%= request.getAttribute("alertMessage") != null ? request.getAttribute("alertMessage") : "" %>';
                var alertType = '<%= request.getAttribute("alertType") != null ? request.getAttribute("alertType") : "" %>';
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
        </script>      
    </body>

</html>