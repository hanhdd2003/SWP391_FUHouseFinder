

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

        <style>
            .bradcam_area {
                padding: 20px 0 102px 0;
            }
            .camera img{
                height: 40px;
                border-radius: 50%;
            }
            .rounded-circle{
                height: 170px;
                width: 170px;
                border-radius: 50%;
            }
            .alert-top-right {
                position: fixed;
                top: 100px;
                right: 20px;
                z-index: 1050; /* Đảm bảo rằng thông báo xuất hiện trên các thành phần khác */
            }


            .card-shadow {
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);

            }
            .container {
                margin-top: 50px;
            }
            .card-body{
                background-color: rgb(238, 244, 255);
                height: 400px;

            }
            .form-control-plaintext {
                display: inline;
                margin-left: 10px;
            }
            .label-group {
                display: flex;
                align-items: center;
            }

        </style>
    </head>

    <body>

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
            <div class="container rounded bg-white mt-5 mb-5">
                <div class="row">
                    <!-- Form thay đổi ảnh đại diện -->
                    <div class="col-md-4 border-right">

                        <div class="card card-shadow">
                            <div class="card-body">
                                <form id="uploadForm" action="/HFManagementSystem/uploadavatar" method="post" enctype="multipart/form-data">
                                    <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                                        <div id="previewImage">
                                        <c:choose>
                                            <c:when test="${u.hased_password != null}">
                                                <img  class="rounded-circle mt-5" width="150px" src="/HFManagementSystem/img/avatar/${u.avatarUrl}">
                                            </c:when>
                                            <c:otherwise>
                                                <img  class="rounded-circle mt-5" width="150px" src="${u.avatarUrl}">
                                            </c:otherwise>    
                                        </c:choose>
                                    </div>
                                    <span class="font-weight-bold">${u.firstName} ${u.lastName}</span>
                                    <span class="text-black-50">${u.email}</span>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>

                <!-- Form cập nhật thông tin cá nhân -->
                <div class="col-md-8 border-right">
                    <div class="card card-shadow">
                        <div class="card-body">
                            <form action="/HFManagementSystem/editprofile" method="post">
                                <div class="p-3 py-5">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h4 class="text-right">THÔNG TIN CÁ NHÂN</h4>
                                    </div>
                                    <div class="row mt-2">
                                        <div class="col-md-6">
                                            <label class="labels">Họ và Tên:</label>
                                            <div class="form-control-plaintext">${u.firstName} ${u.lastName}</div>
                                        </div>
                                    </div>
                                    <div class="row mt-2">
                                        <div class="col-md-12 ">
                                            <label class="labels">Số Điện Thoại:</label>
                                            <div class="form-control-plaintext">${u.phoneNumber}</div>
                                        </div>
                                    </div> 
                                    <div class="row mt-2"> 
                                        <div class="col-md-12 ">
                                            <label class="labels">Địa Chỉ:</label>
                                            <div class="form-control-plaintext">${u.address}</div>
                                        </div>
                                    </div >
                                    <div class="row mt-2 ">
                                        <div class="col-md-6">
                                            <label class="labels">Vai Trò:</label>
                                            <div class="form-control-plaintext">${u.role == 1 ? 'Admin' : u.role == 2 ? 'Chủ Nhà' : u.role == 3 ? 'Người Thuê' : 'Chưa Xác Định'}</div>
                                        </div> 
                                    </div>
                                    <div class="row mt-2 ">
                                        <div class="col-md-12">
                                            <label class="labels">Trạng thái</label>
                                            <div class="form-control-plaintext ${u.status eq 'Đã xác minh' ? 'text-success' : 'text-danger'}">
                                                ${u.status}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mt-2 ">
                                        <a href="javascript:history.back()" class="btn btn-primary ml-3 back-button">Quay lại</a>
                                    </div>
                                </div>
                        </div>
                        </form>
                    </div>
                </div>
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
    <script>
        function validateAndSubmit() {
            var fileInput = document.getElementById('avatar');
            if (fileInput.files.length === 0) {
                alert("Vui lòng chọn một ảnh.");
                return;
            }
            document.getElementById('uploadForm').submit();
        }
    </script>
    <script>
        window.onload = function () {
            var alertMessage = '<%= request.getAttribute("alertMessage") != null ? request.getAttribute("alertMessage") : "" %>';
            var alertType = '<%= request.getAttribute("alertType") != null ? request.getAttribute("alertType") : "" %>';
            if (alertMessage) {
                var alertPlaceholder = document.getElementById('alertPlaceholder');
                var alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-' + alertType + ' alert-dismissible fade show alert-top-right';
                alertDiv.role = 'alert';
                alertDiv.innerHTML = `${alertMessage}
                   <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                       <span aria-hidden="true">&times;</span>
                   </button> `;
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