<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
        <link rel="stylesheet" href="/HFManagementSystem/css/bootstrap.min.css">
        <link rel="stylesheet" href="/HFManagementSystem/css/animate.min.css">
        <link rel="stylesheet" href="/HFManagementSystem/css/style.css">
        <!-- <link rel="stylesheet" href="css/responsive.css"> -->
        <style>
            .bradcam_area {
                padding: 40px 0 102px 0;
            }


            .me {
                min-height: 700px;
            }
            .tb{
                overflow: scroll
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
                            <table class="table table-borderless">
                                <tbody>
                                    <tr>
                                        <td><a href="/HFManagementSystem/dashboard" class="nav-link text-dark">Bảng Điều Khiển</a></td>
                                    </tr>
                                    <tr>
                                        <td><a href="/HFManagementSystem/manageuser" class="nav-link text-sm text-dark">Quản Lý Người Dùng</a></td>
                                    </tr>
                                    <tr>
                                        <td><a href="/HFManagementSystem/managepost" class="nav-link text-sm text-dark">Danh Sách Các Nhà</a></td>
                                    </tr>
                                    <tr>
                                        <td><a href="/HFManagementSystem/managereport" class="nav-link text-sm text-dark">Quản Lý Báo Cáo</a></td>
                                    </tr>
                                    <tr>
                                        <td><a href="/HFManagementSystem/transaction" class="nav-link text-sm text-dark">Quản Lý Giao Dịch</a></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4 tb">
                        <h1 class="text-center mt-4 mb-4">Danh sách các nhà đã đăng</h1>
                        <table class="table table-bordered table-striped">
                            <tr class="bg-warning">
                                <td>STT</td>
                                <td>Tên Nhà</td>
                                <td>Tên chủ nhà</td>
                                <td>Thời gian đăng</td>
                                <td>Xem chi tiết</td>
                            </tr>
                        <c:forEach items="${houses}" var="house">
                            <tr>
                                <td>${house.id}</td>
                                <td>${house.house_name}</td>
                                <td><a class="text-dark" href="/HFManagementSystem/manageuser?action=viewdetail&email=${house.landlord.getEmail()}">${house.landlord.getFirstName()} ${house.landlord.getLastName()} </a></td>
                                <td>${house.getCreateDate()} </td>
                                <td><a href="/HFManagementSystem/detail_house?id=${house.id}" class="text-dark">Xem chi tiết</a></td>
             
                            </tr>
                        </c:forEach>


                    </table>
                        <div class="d-flex justify-content-end mt-5">
                        <ul class="pagination">
                            <c:if test="${totalPages > 1}">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage - 1}">&laquo; </a>
                                    </li>
                                </c:if>
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <c:choose>
                                        <c:when test="${i == currentPage}">
                                            <li class="page-item active"><span class="page-link">${i}</span></li>
                                            </c:when>
                                            <c:otherwise>
                                            <li class="page-item"><a class="page-link" href="?page=${i}">${i}</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage + 1}"> &raquo;</a>
                                    </li>
                                </c:if>
                            </c:if>
                        </ul>
                    </div>
                </main>
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

        <script src="js/main.js"></script>


    </body>

</html>
