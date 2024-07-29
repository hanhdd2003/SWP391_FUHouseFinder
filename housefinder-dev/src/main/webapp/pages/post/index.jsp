<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!--<!DOCTYPE html>
<html>
    <head>
        <title>Start Page</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>-->


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
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/animate.min.css">
        <link rel="stylesheet" href="css/style.css">
        <!-- <link rel="stylesheet" href="css/responsive.css"> -->
        <style>
            .bradcam_area {
                padding: 40px 0 102px 0;
            }


            .me {
                height: 700px;
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
                    <div class="row">

                    </div>
                </div>
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
                                        <td><a href="#" class="nav-link text-dark active">Trang Chính</a></td>
                                    </tr>
                                    <tr>
                                        <td><a href="manageuser.html" class="nav-link text-dark">Quản Lý Người Dùng</a></td>
                                    </tr>
                                    <tr>
                                        <td><a href="managerpostadmin.html" class="nav-link text-dark">Quản Lý Bài Đăng</a></td>
                                    </tr>
                                    <tr>
                                        <td><a href="managerreport.html" class="nav-link text-dark">Quản Lý Báo Cáo</a></td>
                                    </tr>
                                    <tr>
                                        <td><a href="#" class="nav-link text-dark">Hỗ Trợ và Liên Hệ</a></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
                        <table class="table table-bordered">
                            <tr class="bg-warning">
                                <td>Họ</td>
                                <td>Tên</td>
                                <td>Email</td>
                                <td>Số điện thoại</td>
                                <td>Địa chỉ</td>
                                <td>Vai trò</td>
                                <td>Trạng thái</td>
                                <td>Chi tiết</td>
                                <td>Cấm</td>
                            </tr>

                            <tr>
                                <td>Ngô Thị</td>
                                <td>Thương</td>
                                <td>hoaithuong@gmail.com</td>
                                <td>0387006150</td>
                                <td>Thạch Thất - Hà Nội</td>
                                <td>Chủ Nhà</td>
                                <td>Đã xác minh</td>
                                <td><a href="#" class="text-dark">Chi tiết</a></td>
                                <td><a href="#" class="text-dark">Cấm</a></td>
                            </tr>
                            <tr>
                                <td>Đặng Thị</td>
                                <td>Huyền</td>
                                <td>danhuyn@gmail.com</td>
                                <td>0387006150</td>
                                <td>Thạch Thất - Hà Nội</td>
                                <td>khách thuê</td>
                                <td>Chưa xác minh</td>
                                <td><a href="#" class="text-dark">Chi tiết</a></td>
                                <td><a href="#" class="text-dark">Cấm</a></td>
                            </tr>
                            <tr>
                                <td>Đỗ Đức</td>
                                <td>Hanh</td>
                                <td>hanhddhe170929@fpt.edu.vn</td>
                                <td>0387006149</td>
                                <td>Thủy Nguyên - Hải Phòng</td>
                                <td>Chủ Nhà</td>
                                <td>Chưa xác minh</td>
                                <td><a href="#" class="text-dark">Chi tiết</a></td>
                                <td><a href="#" class="text-dark">Cấm</a></td>
                            </tr>
                        </table>
                    </main>
                </div>
            </div>




            <!--================ Blog Area end =================-->

            <!-- footer start -->

        <jsp:include page="pages/footer/footer.jsp"></jsp:include>
        <!--/ footer end  -->


        <!-- JS here -->
        <script src="js/vendor/jquery-1.12.4.min.js"></script>
        <script src="js/isotope.pkgd.min.js"></script>
        <script src="js/wow.min.js"></script>
        <script src="js/jquery.slicknav.min.js"></script>

        <script src="js/main.js"></script>


    </body>

</html>