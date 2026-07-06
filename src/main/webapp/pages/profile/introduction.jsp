

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/animate.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/slicknav.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <!-- <link rel="stylesheet" href="css/responsive.css"> -->


        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">

        <style>
            .bradcam_area {
                padding: 20px 0 102px 0;
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

            <!--================Blog Area =================-->

            <div class="featured_candidates_area candidate_page_padding">
                <div class="container">
                    <h1 class="text-center mb-5">Người hướng dẫn</h1>
                    <div class="row d-flex justify-content-center">
                        <div class="single_candidates text-center">
                            <div class="thumb">
                                <img src="/HFManagementSystem/img/avatar/macdinh.jpg" alt="">
                            </div>
                            <a href="#"><h4>Nguyễn Văn Sang</h4></a>
                            <p>Giảng viên môn SWP391 - SE1841</p>
                        </div>
                    </div>
                    <h1 class="text-center mb-5">Đội ngũ phát triển</h1>
                    <div class="row d-flex justify-content-center">
                        <div class="col-md-6 col-lg-3">
                            <div class="single_candidates text-center">
                                <div class="thumb">
                                    <img src="/HFManagementSystem/img/avatar/macdinh.jpg" alt="">
                                </div>
                                <a href="#"><h4>Đỗ Đức Hanh</h4></a>
                                <p>Kỹ thuật phần mềm - SE1841</p>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-3">
                            <div class="single_candidates text-center">
                                <div class="thumb">
                                    <img src="/HFManagementSystem/img/avatar/macdinh.jpg" alt="">
                                </div>
                                <a href="#"><h4>Ngô Thị Thương</h4></a>
                                <p>Kỹ thuật phần mềm - SE1841</p>
                            </div>
                        </div>                        
                        <div class="col-md-6 col-lg-3">
                            <div class="single_candidates text-center">
                                <div class="thumb">
                                    <img src="/HFManagementSystem/img/avatar/macdinh.jpg" alt="">
                                </div>
                                <a href="#"><h4>Đặng Thị Huyền</h4></a>
                                <p>Kỹ thuật phần mềm - SE1841</p>
                            </div>
                        </div>

                    </div>


                    <h1 class="text-center mb-5">Giới thiệu về website</h1>
                    <p>Đây là phần mềm được phát triển với mục đích là giúp kết 
                        nối giữa các chủ cho thuê nhà với người có nhu cầu thuê nhà tại khu 
                        vực Trường Đại Học FPT University cơ sở Hòa Lạc. Hiện nay với số lượng
                        sinh viên ngày càng tăng qua các năm học thì nhu cầu tìm trọ đang rất cần thiết.
                        Hiện nay hầu hết các sinh viên hoặc người muốn thuê trọ nếu muốn tìm được
                        trọ thì đều thông qua các nền tảng mạng xã hội như các nhóm trên Facebook.
                        Đó cũng là một cách giúp sinh viên tìm trọ dễ dàng nhưng bên cạnh đó vẫn có các khó
                        khăn như là một bài viết cho thuê có thể bị lặp lại nhiều lần, mỗi lần
                        chỉ có thể đăng thông tin của 1 số phòng, nhiều khi thuê sẽ phải thông qua trung gian tốn kém...
                        Do đó nhóm phát triển đã quyết định tạo ra một phần mềm, một nền tảng giúp mọi người dễ
                        dàng tìm trọ hơn, một phần mềm với giao diện đơn giản, dễ sử dụng, có các chức năng cơ bản
                        cần thiết để phục vụ mục đích tìm kiếm</p>
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


</body>

</html>