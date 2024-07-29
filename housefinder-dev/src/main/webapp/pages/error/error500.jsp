

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
        <link rel="stylesheet" href="/HFManagementSystemcss/animate.min.css">
        <link rel="stylesheet" href="/HFManagementSystem/css/style.css">
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
        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <!-- bradcam_area  -->
            <div class="bradcam_area bradcam_bg_1">
            </div>
        </div>
        <!--/ bradcam_area  -->
        <div class="container me text-center">
            <h1 class="pt-5">Đã xảy ra lỗi trong hệ thống</h1>
            <a class="btn btn-primary" href="javascript:history.back()">Quay lại</a>
        </div>
        


    <jsp:include page="/pages/footer/footer.jsp"></jsp:include>
    <!-- JS here -->
    <script src="/HFManagementSystem/js/vendor/jquery-1.12.4.min.js"></script>
    <script src="/HFManagementSystem/js/isotope.pkgd.min.js"></script>
    <script src="/HFManagementSystem/js/wow.min.js"></script>
    <script src="/HFManagementSystem/js/jquery.slicknav.min.js"></script>

    <script src="js/main.js"></script>
</body>
</html>
