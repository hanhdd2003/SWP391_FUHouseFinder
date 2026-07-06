


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
            /* CSS tùy chỉnh để định vị thông báo ở góc trên bên phải */
            .alert-container {
                position: fixed;
                top: 50px;
                right: 20px;
                z-index: 1050; /* Đảm bảo rằng thông báo xuất hiện trên các thành phần khác */
            }
            .alert-item {
                margin-bottom: 10px; /* Khoảng cách giữa các thông báo */
            }

            .card-shadow {
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            }
            .container {
                margin-top: 50px;
            }
            .card-body{
                background-color: rgb(238, 244, 255);
                height: 537px;
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
            <div class="container rounded bg-white mt-5 mb-5">
                <div class="row">
                    <!-- Form thay đổi ảnh đại diện -->
                    <div class="col-md-4">
                        <div class="card card-shadow">
                            <div class="card-body">
                                <form id="uploadForm" action="/HFManagementSystem/uploadavatar" method="post" enctype="multipart/form-data">
                                    <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                                        <div id="previewImage">
                                        <c:choose>
                                            <c:when test="${user.hashed_password != null}">
                                                <img  class="rounded-circle mt-5" width="150px" src="/HFManagementSystem/img/avatar/${user.avatarUrl}">
                                            </c:when>
                                            <c:otherwise>
                                                <img  class="rounded-circle mt-5" width="150px" src="${user.avatarUrl}">
                                            </c:otherwise>    
                                        </c:choose>
                                    </div>
                                    <label for="avatar" class="file-input-label camera">
                                        <img src="/HFManagementSystem/img/icon-camera.png" alt="Camera Icon" class="camera-icon">
                                    </label>
                                    <span class="font-weight-bold">${sessionScope.profile.firstName} ${sessionScope.profile.lastName}</span>
                                    <span class="text-black-50">${user.email}</span>
                                    <div class="mt-5 d-flex flex-column align-items-center text-center ">
                                        <!--                                 Đổi input file thành icon máy ảnh và ẩn input file -->
                                        <input type="file" name="avatar" id="avatar" accept="image/*" style="display:none;" onchange="ImagesFileAsURL()">
                                        <button class="btn btn-primary profile-button" type="button" onclick="validateAndSubmit()">Đổi Ảnh Đại Diện</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Form cập nhật thông tin cá nhân -->
                <div class="col-md-8">
                    <div class="card card-shadow">
                        <div class="card-body">
                            <form action="/HFManagementSystem/editprofile" method="post">
                                <div class="p-3 py-5">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h4 class="text-right">THÔNG TIN CÁ NHÂN</h4>
                                    </div>
                                    <div class="row mt-2">
                                        <div class="col-md-6">
                                            <h6 class="text-left">Họ và tên đệm: <span class="text-danger">*</span></h6>

                                            <% if (request.getAttribute("inputtedFirstname") != null) { %>
                                            <input type="text" maxlength="5" class="form-control" placeholder="Họ và tên đệm" name="firstName" value="<%= request.getAttribute("inputtedFirstname") %>">
                                            <% } else { %>
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.profile.firstName}">
                                                    <input type="text" class="form-control" placeholder="Họ và tên đệm" name="firstName" value="${sessionScope.profile.firstName}">
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="text" class="form-control" placeholder="Họ và tên đệm" name="firstName" value="">
                                                </c:otherwise>
                                            </c:choose>
                                            <% } %>

                                        </div>
                                        <div class="col-md-6">
                                            <h6 class="text-left">Tên: <span class="text-danger">*</span></h6>
                                            <% if (request.getAttribute("inputtedLastName") != null) { %>
                                            <input type="text" class="form-control" placeholder="Tên" name="lastName" value="<%= request.getAttribute("inputtedLastName") %>">
                                            <% } else { %>
                                            <c:if test="${not empty sessionScope.profile.lastName}">
                                                <input type="text" class="form-control" placeholder="Tên" name="lastName" value="${sessionScope.profile.lastName}">
                                            </c:if>
                                            <% } %>

                                        </div>
                                    </div>
                                    <div class="row mt-2">
                                        <div class="col-md-3">
                                            <h6 class="text-left">Số Điện Thoại: <span class="text-danger">*</span></h6>

                                            <% if (request.getAttribute("inputtedPhone") != null) { %>
                                            <input type="text" class="form-control" required="" placeholder="Nhập số điện thoại" name="phoneNumber" value="<%= request.getAttribute("inputtedPhone") %>">
                                            <% } else { %>
                                            <c:if test="${not empty sessionScope.profile.phoneNumber}">
                                                <input type="text" class="form-control" placeholder="Nhập số điện thoại" name="phoneNumber" value="${sessionScope.profile.phoneNumber}">
                                            </c:if>
                                            <% } %>
                                        </div>
                                    </div>
                                    <div class="row mt-2">
                                        <div class="col-md-12">
                                            <h6 class="text-left">Địa Chỉ: <span class="text-danger">*</span></h6>
                                            <input type="text" class="form-control" placeholder="Nhập địa chỉ " name="address" required="" value="${sessionScope.profile.address}">
                                        </div>
                                    </div>
                                    <div class="row mt-2">
                                        <div class="col-md-3">
                                            <h6 class="text-left">Vai Trò:</h6>
                                            <input type="text" class="form-control" placeholder="vai trò" value="${sessionScope.user.roleId == 1 ? "Admin" : sessionScope.user.roleId == 2 ? "Chủ Nhà" : sessionScope.user.roleId == 3 ? "Người Thuê" : "Chưa Xác Định"}" readonly>
                                        </div>
                                    </div>
                                </div>
                                <div class="mt-1">
                                    <input type="hidden" name="id" value="${sessionScope.profile.person_id}">
                                    <button class="btn btn-primary profile-button" type="submit">Lưu Thông Tin</button>
                                    <button class="btn btn-primary profile-button" type="button" onclick="clearAlertsAndGoBack()">Quay Lại</button>
<!--                                    <button class="btn btn-primary profile-button" type="button" onclick="goBack()">Quay Lại</button>--> 
                                </div>

                        </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>



        <!--================ Blog Area end =================-->
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
                                        function validateAndSubmit() {
                                            var fileInput = document.getElementById('avatar');
                                            if (fileInput.files.length === 0) {
                                                alert("Vui lòng chọn một ảnh.");
                                                return;
                                            }
                                            document.getElementById('uploadForm').submit();
                                        }
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
                                                    }, 3000); // Thời gian hiển thị là 3 giây
                                                });
                                            }
                                        };
        </script>
        <script type="text/javascript">
            function ImagesFileAsURL() {
                var fileSelected = document.getElementById('avatar').files;
                if (fileSelected.length > 0) {
                    var previewImage = document.getElementById('previewImage');
                    previewImage.innerHTML = ''; // Xóa ảnh hiện tại

                    for (var i = 0; i < fileSelected.length; i++) {
                        var fileToLoad = fileSelected[i];
                        var fileReader = new FileReader();
                        fileReader.onload = function (fileLoaderEvent) {
                            var srcData = fileLoaderEvent.target.result;
                            var newImage = document.createElement('img');
                            newImage.src = srcData;
                            newImage.className = 'rounded-circle mt-5'; // Thêm class để làm tròn và căn giữa
                            newImage.width = '150px'; // Đặt kích thước ảnh
                            previewImage.appendChild(newImage); // Thêm ảnh mới vào
                        };
                        fileReader.readAsDataURL(fileToLoad);
                    }
                }
            }

            function goBack() {
                window.history.back();
            }
        </script>
        <script type="text/javascript">
            function ImagesFileAsURL() {
                var fileSelected = document.getElementById('avatar').files;
                if (fileSelected.length > 0) {
                    var previewImage = document.getElementById('previewImage');
                    previewImage.innerHTML = ''; // Xóa ảnh hiện tại

                    for (var i = 0; i < fileSelected.length; i++) {
                        var fileToLoad = fileSelected[i];
                        var fileReader = new FileReader();
                        fileReader.onload = function (fileLoaderEvent) {
                            var srcData = fileLoaderEvent.target.result;
                            var newImage = document.createElement('img');
                            newImage.src = srcData;
                            newImage.className = 'rounded-circle mt-5'; // Thêm class để làm tròn và căn giữa
                            newImage.width = '150px'; // Đặt kích thước ảnh
                            previewImage.appendChild(newImage); // Thêm ảnh mới vào
                        };
                        fileReader.readAsDataURL(fileToLoad);
                    }
                }
            }

            function clearAlertsAndGoBack() {
                var alertPlaceholder = document.getElementById('alertPlaceholder');
                alertPlaceholder.innerHTML = ''; // Xóa bỏ tất cả các thông báo
                window.history.back();
            }

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
                        }, 3000); // Thời gian hiển thị là 3 giây
                    });
                }
            };
        </script>

    </body>

</html>