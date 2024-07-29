<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js" lang="zxx">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>FU Hourse Finder</title>
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
                width: 40%;
                /* Đặt độ rộng mong muốn */
            }

            /* độ cao của bradcam*/
            .bradcam_area {
                padding: 20px 0 102px 0;
            }


            .card {
                width: 80%;
            }

            .post-author {
                display: flex;
                align-items: center;
            }

            .post-author img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                margin-right: 10px;
            }

            /* .post-images {
                width: 250px;
                height: 250px;
                
            }  */
            .post-body {
                padding: 20px;
                border-top: 1px solid #ddd;
            }

            .post-images img {
                /* width: 100%; */
                max-width: 100%;
                height: 100%;
                object-fit: cover;
                margin-bottom: 10px;
            }

            .image-post {
                width: 350px;
                height: 350px;
                padding-right: 10px;
            }

            .current-image {
                display: none;
            }

            .current-image:first-of-type {
                display: block;
                margin: 0 auto;
                /* Margin auto sẽ căn giữa hình ảnh theo chiều ngang */
            }

            .post_detail {
                width: 480px;
                height: 200px;
                overflow: scroll;
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
        <c:forEach var="p" items="${post}"> 

            <div class="container mt-5 d-flex justify-content-center">
                <div class="card">
                    <div class="card-body">
                        <div class="post-author">
                            <img src="/HFManagementSystem/img/avatar/${p.avatarLandlord}" alt="Avatar">
                            <div>
                                <p class="mb-0">${p.lanlord.firstName} ${p.lanlord.lastName}</p>
                                <small class="text-muted">${p.getTimeAgo()}</small>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-5 ">
                                <div class="post-images carousel text-center image-post">
                                    <c:forEach items="${p.img}" var="ima">
                                        <img class="current-image" src="img/fu_post/${ima}" alt="Image">
                                    </c:forEach>

                                </div>
                                <br>
                                <div class="text-center">
                                    <button class="btn btn-sm btn-light prev-image">
                                        < </button>
                                    <button class="btn btn-sm btn-light next-image"> > </button>
                                </div>
                            </div>
                            <div class="col-md-7">
                                <h5 class="mt-3">${p.title}</h5>
                                <div class="text-muted text-center">
                                    <table class="table">
                                        <tbody>
                                            <tr>
                                                <td>Giá:</td>
                                                <td>Diện tích:</td>
                                                <td>Số phòng:</td>
                                            </tr>
                                            <tr>
                                                <td>${p.price}</td>
                                                <td>${p.area} m²</td>
                                                <td>${p.number_room}</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <p class="post_detail">${p.description}</p>
                            </div>
                        </div>
                    </div>
                    <div class="post-body">
                        <c:choose>
                            <c:when test="${user.roleId == 1}">
                                <div class="text-right">
                                    <button type="button" class="btn btn-success mr-2"> Đồng ý</button>
                                    <button type="button" class="btn btn-danger"> Từ chối</button>
                                </div>
                            </c:when>
                            <c:when test="${user.roleId == 2 && user.id == p.landlord_id}">
                                <div class="text-right row justify-content-end">
                                    <a href="PostServlet?action=edit-post&id=${p.post_id}"><button type="button" class="btn btn-success mr-2">Sửa</button></a>

                                    <form action="PostServlet?action=deletePost" method="post">
                                        <input type="hidden" name="action" value="deletePost">
                                        <input type="hidden" name="id" value="${p.post_id}">
                                        <button class="btn btn-danger" type="submit">Xóa</button>
                                    </form>
                                    <!--<button type="button" class="btn btn-danger">Xóa</button>-->
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-right">
                                    <button type="button" class="btn btn-success mr-2">Thêm vào danh sách yêu thích</button>
                                    <button type="button" class="btn btn-success">Xem chi tiết</button>
                                </div>
                            </c:otherwise>
                        </c:choose>



                    </div>
                </div>
            </div>



        </c:forEach>








        <!-- End Sample Area -->


        <!-- footer start -->
        <jsp:include page="pages/footer/footer.jsp"></jsp:include>
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
            $('#datepicker').datepicker({
                iconsLibrary: 'fontawesome',
                icons: {
                    rightIcon: '<span class="fa fa-caret-down"></span>'
                }
            });
            $('#datepicker2').datepicker({
                iconsLibrary: 'fontawesome',
                icons: {
                    rightIcon: '<span class="fa fa-caret-down"></span>'
                }

            });
            //=========================================================
            $(document).ready(function () {
                $(".card").each(function () {
                    var $thisCard = $(this);
                    var $images = $thisCard.find(".current-image");
                    var currentIndex = 0;

                    function showImage(index) {
                        $images.hide().eq(index).show();
                    }

                    $thisCard.find(".next-image").click(function () {
                        currentIndex = (currentIndex + 1) % $images.length;
                        showImage(currentIndex);
                    });

                    $thisCard.find(".prev-image").click(function () {
                        currentIndex = (currentIndex - 1 + $images.length) % $images.length;
                        showImage(currentIndex);
                    });
                });
            });


        </script>
    </body>

</html>