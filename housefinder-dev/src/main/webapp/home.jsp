<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Trang chủ</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">


        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

        <!-- CSS here -->
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
            /* CSS tùy chỉnh để định vị thông báo ở góc trên bên phải */
            .alert-top-right {
                position: fixed;
                top: 100px;
                right: 20px;
                z-index: 1050; /* Đảm bảo rằng thông báo xuất hiện trên các thành phần khác */
            }
            .thumb img{
                width: 82px;
                height: 82px
            }
            .thumb2 img{
                width: 70px;
                height: 110px
            }
            .single_candidates{
                height: 300px
            }
        </style>
    </head>

    <body>

        <!-- header-start -->
        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <!-- header-end -->

            <!-- slider_area_start -->
            <div class="slider_area">
                <div class="single_slider  d-flex align-items-center slider_bg_1">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-lg-7 col-md-6">
                                <div class="slider_text">
                                    <h5 class="wow fadeInLeft" data-wow-duration="1s" data-wow-delay=".2s">Hệ Thống Tìm Kiếm Nhà
                                        Trọ FHF</h5>
                                    <h3 class="wow fadeInLeft" data-wow-duration="1s" data-wow-delay=".3s">Tìm phòng trọ mong
                                        muốn của bạn!</h3>
                                    <p class="wow fadeInLeft" data-wow-duration="1s" data-wow-delay=".4s">
                                        Nơi tốt nhất dành cho những người đang tìm kiếm nhà trọ gần khu vực trường Đại học FPT.
                                        Chúng tôi cung cấp dữ liệu tin rao lớn với đa dạng loại hình nhà trọ giúp bạn có những
                                        lựa chọn phù hợp với nhu cầu của mình.</p>
                                    <div class="sldier_btn wow fadeInLeft" data-wow-duration="1s" data-wow-delay=".5s">
                                        <a href="#" class="boxed-btn3">ĐĂNG KÝ NGAY</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="ilstration_img wow fadeInRight d-none d-lg-block text-right" data-wow-duration="1s"
                     data-wow-delay=".2s">
                    <img src="img/banner/illustration.png" alt="">
                </div>
            </div>
            <!-- slider_area_end -->

            <!-- popular_catagory_area_start  -->
            <div class="popular_catagory_area">
                <div class="container">

                </div>
            </div>
            <!-- popular_catagory_area_end  -->

            <!-- job_listing_area_start  -->
            <div class="job_listing_area">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-6">
                            <div class="section_title">
                                <h3>DANH SÁCH NHÀ TRỌ</h3>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="brouse_job text-right">
                                <a href="/HFManagementSystem/view_house" class="boxed-btn4">Xem Thêm</a>
                            </div>
                        </div>
                    </div>
                    <div class="job_lists">
                        <div class="row">
                        <c:forEach items="${data}" var="house">
                            <div class="col-lg-12 col-md-12">
                                <div class="single_jobs white-bg d-flex justify-content-between">
                                    <div class="jobs_left d-flex align-items-center">
                                        <div class="thumb">
                                            <img src="img/fu_house/${house.avatarImage}" alt="">
                                        </div>
                                        <div class="jobs_conetent">
                                            <a href="/HFManagementSystem/detail_house?id=${house.id}">
                                                <h4>${house.house_name}</h4>
                                            </a>
                                            <div class="links_locat d-flex align-items-center">
                                                <div class="location">
                                                    <p> <i class="fa fa-map-marker"></i> ${house.address}</p>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="jobs_right">
                                        <div class="apply_now">
                                            <c:if test="${not empty sessionScope.user and sessionScope.user.roleId == 3}">
                                                <i class="fas fa-heart favorite mr-3 ${house.favorite ? 'favorite-active' : ''}" 
                                                   data-house-id="${house.id}" 
                                                   data-is-favorite="${house.favorite}" 
                                                   onclick="toggleFavorite(this)"></i>
                                            </c:if>
                                            <!--<a class="heart_mark" href="#"> <i class="ti-heart"></i> </a>-->
                                            <a href="/HFManagementSystem/detail_house?id=${house.id}" class="boxed-btn3">Xem Chi Tiết</a>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                    </div>
                </div>
            </div>
        </div>
        <!-- job_listing_area_end  -->

        <!-- featured_candidates_area_start  -->
        <div class="featured_candidates_area">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section_title text-center mb-40">
                            <h3>CHỦ NHÀ TRỌ</h3>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="candidate_active owl-carousel">
                            <!-- ------------------------------------------------------------------------------------- -->
                            <c:forEach items="${data}" var="house">
                                <div class="single_candidates text-center">
                                    <div class="thumb thumb2">
                                        <img src="img/avatar/${house.landlord.avatarUrl}" alt="">
                                    </div>
                                    <a href="/HFManagementSystem/ViewDetailProfile?email=${house.landlord.email}">
                                        <h4>${house.landlord.firstName} ${house.landlord.lastName}</h4>
                                    </a>
                                    <p>${house.house_name}</p>
                                </div>
                            </c:forEach>

                            <!-- ------------------------------------------------------------------------------------- -->

                        </div>
                    </div>
                </div>
            </div>
        </div>



        <div class="job_searcing_wrap overlay">
            <div class="container">
                <div class="row">
                    <div class="col-lg-5 offset-lg-1 col-md-6">
                        <div class="searching_text">
                            <h3>Tìm Nhà Trọ?</h3>
                            <p>Chúng tôi cung cấp các bài đăng đầy đủ thông tin, đảm bảo uy tin dành cho bạn.</p>
                            <c:if test="${sessionScope.user == null}">
                                <a href="/HFManagementSystem/pages/system/register.jsp" class="boxed-btn3">TÌM THUÊ NGAY</a>
                            </c:if>
                        </div>
                    </div>
                    <div class="col-lg-5 offset-lg-1 col-md-6">
                        <div class="searching_text">
                            <h3>Tìm Người Thuê?</h3>
                            <p>Chúng tôi sẽ giúp bạn tiếp cận tới khách thuê qua các bài đăng đầy đủ thông tin trên trang.</p>
                            <c:if test="${sessionScope.user == null}">
                                <a href="/HFManagementSystem/pages/system/register.jsp" class="boxed-btn3">TRỞ THÀNH CHỦ NHÀ NGAY</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- job_searcing_wrap end  -->



        <!-- Alert placeholder -->
        <div id="alertPlaceholder" class="mt-3"></div>
        <!-- footer start -->

        <jsp:include page="pages/footer/footer.jsp"></jsp:include>
            <!--/ footer end  -->

            <!-- link that opens popup -->
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


            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <script>
                                                       window.onload = function () {
                                                           var alertMessage = '<%= request.getAttribute("alertMessage") != null ? request.getAttribute("alertMessage") : "" %>';
                                                           var alertType = '<%= request.getAttribute("alertType") != null ? request.getAttribute("alertType") : "" %>';

                                                           // Kiểm tra nếu alertMessage và alertType không rỗng thì hiển thị Swal.fire
                                                           if (alertMessage.trim() !== "" && alertType.trim() !== "") {
                                                               Swal.fire({
                                                                   icon: alertType,
                                                                   title: alertMessage,
                                                                   showConfirmButton: false,
                                                                   timer: 2000
                                                               });
                                                           }
                                                       };
        </script>
        <script>
            function toggleFavorite(element) {
                var houseId = element.getAttribute("data-house-id");
                var isFavorite = element.getAttribute("data-is-favorite") === "true";

                $.ajax({
                    url: '/HFManagementSystem/toggleFavorite',
                    type: 'POST',
                    data: {
                        houseId: houseId,
                        isFavorite: !isFavorite
                    },
                    success: function (response) {
                        if (response.status === 'success') {
                            // Toggle class to change icon color
                            element.classList.toggle("favorite-active");

                            // Toggle data-is-favorite attribute
                            element.setAttribute("data-is-favorite", String(!isFavorite));
                        }
                    },
                    error: function (error) {
                        console.error('Error:', error);
                    }
                });
            }

        </script>

        <style>
            .favorite {
                color: black;
            }

            .favorite-active {
                color: red;
            }

        </style>
    </body>

</html>