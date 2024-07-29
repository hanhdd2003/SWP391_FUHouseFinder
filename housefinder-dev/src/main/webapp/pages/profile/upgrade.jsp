<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="/HFManagementSystem/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HFManagementSystem/css/animate.min.css">
        <link rel="stylesheet" href="/HFManagementSystem/css/style.css">
        <!-- <link rel="stylesheet" href="css/responsive.css"> -->
        <style>
            .bradcam_area {
                padding: 40px 0 102px 0;
            }


            .textMain{
                color: rgb(241, 16, 91);
            }
            .item {
                height: 330px;
                max-width: 300px;
                border: 1px solid black;
                margin: 40px;
                margin-bottom: 200px;
                padding-top: 5px;
            }

            .typeName p {
                color: black;
            }

            .typeName a {
                display: flex;
                justify-content: center;
            }

            .label {
                color: rgb(244, 10, 123);
            }
            .oldPrice{
                font-style: italic;
                text-decoration: line-through;
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
            <!-- bradcam_area  -->

            <!--================Blog Area =================-->

        <c:set var="isUpgradedNormal" value="false"/>
        <c:set var="isUpgradedStandard" value="false"/>
        <c:set var="isUpgradedPremium" value="false"/>

        <c:forEach items="${requestScope.list}" var="upgraded">
            <c:choose>
                <c:when test="${upgraded.amount == 499000}">
                    <c:set var="isUpgradedNormal" value="true"/>
                </c:when>
                <c:when test="${upgraded.amount == 899000}">
                    <c:set var="isUpgradedStandard" value="true"/>
                </c:when>
                <c:when test="${upgraded.amount == 1499000}">
                    <c:set var="isUpgradedPremium" value="true"/>
                </c:when>
            </c:choose>
        </c:forEach>                                   


        <div class="container">

            <h1 class="text-center textMain mt-3">Lựa chọn nâng cấp</h1>

            <div class="row d-flex justify-content-center align-items-center">
                <div class="col-md-4 item typeName">
                    <p class="text-center">Gói Cơ bản</p>
                    <p>- <span class="label">Đặc quyền:</span> <br>+ Có thể thêm thông tin của 1 ngôi nhà đang sở hữu (Sở hữu 2 nhà). <br>+
                        Nâng cấp vĩnh viễn <br>+ Được đề xuất hiển thị</p>
                    <p>- <span class="label">Giá tiền:</span> <span class="oldPrice">799.000VND</span> <br> <span class="label">- Ưu đãi:</span> <strong>499.000 VND</strong> </p>
                    <form class="frmCreateOrder" action="/HFManagementSystem/vnpayajax" method="post">
                        <input name="amount" type="number" value="499000" hidden="" />
                        <input type="text" name="content" value="Nang cap tai khoan chu nha len goi Co Ban" hidden="">
                        <input type="text" name="email" value="${sessionScope.user.email}" hidden="">



                        <c:choose>
                            <c:when test="${isUpgradedNormal}">
                                <p class="text-success">Đã Nâng Cấp</p>
                            </c:when>
                            <c:otherwise>
                                <input type="submit" value="Nâng cấp ngay" class="btn btn-danger">
                            </c:otherwise>
                        </c:choose>    


                    </form>
                </div>
                <div class="col-md-4 item typeName">
                    <p class="text-center">Gói Tiêu chuẩn</p>
                    <p>- <span class="label">Đặc quyền:</span> <br>+ Có thể thêm thông tin của 2 ngôi nhà đang sở hữu (Sở hữu 3 nhà). <br>+
                        Nâng cấp vĩnh viễn <br>+ Được đề xuất hiển thị</p>
                    <p>- <span class="label">Giá tiền:</span> <span class="oldPrice">1.199.000VND</span> <br> <span class="label">- Ưu đãi:</span> <strong>899.000 VND</strong> </p>
                    <form class="frmCreateOrder" action="/HFManagementSystem/vnpayajax" method="post">
                        <input name="amount" type="number" value="899000" hidden="" />
                        <input type="text" name="content" value="Nang cap tai khoan chu nha len goi Tieu Chuan" hidden="">
                        <input type="text" name="email" value="${sessionScope.user.email}" hidden="">
                        <c:choose>
                            <c:when test="${isUpgradedStandard}">
                                <p class="text-success">Đã Nâng Cấp</p>
                            </c:when>
                            <c:otherwise>
                                <input type="submit" value="Nâng cấp ngay" class="btn btn-danger">
                            </c:otherwise>
                        </c:choose>    
                    </form>
                </div>
                <div class="col-md-4 item typeName">
                    <p class="text-center">Gói Nâng cao</p>
                    <p>- <span class="label">Đặc quyền:</span> <br>+ Có thể thêm thông tin 4 ngôi nhà đang sở hữu (Sở hữu 5 nhà).
                        <br>+ Nâng cấp vĩnh viễn <br>+ Được đề ưu tiên xuất hiển thị
                    </p>
                    <p>- <span class="label">Giá tiền:</span> <span class="oldPrice">1.799.000VND</span> <br> <span class="label">- Ưu đãi:</span> <strong>1.499.000 VND</strong> </p>
                    <form class="frmCreateOrder" action="/HFManagementSystem/vnpayajax" method="post">
                        <input name="amount" type="number" value="1499000" hidden="" />
                        <input type="text" name="content" value="Nang cap tai khoan chu nha len goi Nang Cao" hidden="">
                        <input type="text" name="email" value="${sessionScope.user.email}" hidden="">
                        <c:choose>
                            <c:when test="${isUpgradedPremium}">
                                <p class="text-success">Đã Nâng Cấp</p>
                            </c:when>
                            <c:otherwise>
                                <input type="submit" value="Nâng cấp ngay" class="btn btn-danger">
                            </c:otherwise>
                        </c:choose>    
                    </form>
                </div>
            </div>

        </div>





        <!--================ Blog Area end =================-->

        <!-- footer start -->

        <jsp:include page="/pages/footer/footer.jsp"></jsp:include>
        <!--/ footer end  -->


        <!-- JS here -->
        <script src="/HFManagementSystem/js/vendor/jquery-1.12.4.min.js"></script>
        <script src="/HFManagementSystem/js/isotope.pkgd.min.js"></script>
        <script src="/HFManagementSystem/js/wow.min.js"></script>
        <script src="/HFManagementSystem/js/jquery.slicknav.min.js"></script>

        <script src="/HFManagementSystem/js/main.js"></script>


        <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
        <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
        <script type="text/javascript">
            $(".frmCreateOrder").submit(function (event) {
                event.preventDefault(); // Ngăn chặn hành động mặc định của form
                var postData = $(this).serialize(); // Serialize form hiện tại
                var submitUrl = $(this).attr("action"); // Lấy action của form hiện tại
                $.ajax({
                    type: "POST",
                    url: submitUrl,
                    data: postData,
                    dataType: 'json',
                    success: function (response) {
                        if (response.code === '00') {
                            if (window.vnpay) {
                                vnpay.open({width: 768, height: 600, url: response.data});
                            } else {
                                location.href = response.data;
                            }
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function () {
                        alert('Đã xảy ra lỗi khi gửi yêu cầu.');
                    }
                });
            });
        </script>

    </body>

</html>
