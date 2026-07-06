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

            .main{
                min-height:  500px
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

            <div class="main">
                <div class="container mt-4 mb-5">
                    <h2 class="text-center mb-3">Lịch sử giao dịch</h2>
                <c:choose>
                    <c:when test="${not empty data}">
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
                    </c:when>
                    <c:otherwise>
                        Bạn chưa có giao dịch nào
                    </c:otherwise>
                </c:choose>

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


    </body>

</html>
