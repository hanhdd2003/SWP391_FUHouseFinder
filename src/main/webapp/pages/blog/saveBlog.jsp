<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách nhà trọ</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
        <style>
            .no-house-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100%;
                text-align: center;
                margin-top: 20px;
            }

            .no-house-message {
                font-size: 18px;
                color: #555;
                margin-bottom: 20px;
            }

            .add-house-button {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                cursor: pointer;
                border-radius: 5px;
                transition: background-color 0.3s;
            }

            .add-house-button:hover {
                background-color: #218838;
            }
        </style>
        <style>
            .modal-backdrop.show {
                display: none;
            }
        </style>

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f8f8;
                margin: 0;
                padding: 0;
            }
            .container {
                display: flex;
                padding: 20px;

            }
            .filter, .results {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                margin-right: 20px;
            }
            .filter {
                width: 250px;
            }
            .filter h3 {
                margin-bottom: 20px;
                color: #d9534f;
            }
            .filter label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            .filter select, .filter input {
                width: 100%;
                padding: 8px;
                margin-bottom: 15px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .filter .range-input {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
            }
            .filter .range-input input {
                width: 45%;
                margin-right: 5%;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .filter .range-input input:last-child {
                margin-right: 0;
            }
            .filter .range-input button {
                padding: 8px 12px;
                border: none;
                background-color: #d9534f;
                color: #fff;
                border-radius: 4px;
                cursor: pointer;
            }
            .results {
                flex-grow: 1;
            }
            .results h3 {
                margin-bottom: 20px;
            }
            .result-item {
                border: 1px solid #ddd;
                border-radius: 8px;
                overflow: hidden;
                margin-bottom: 20px;
                background-color: #fff;
                transition: box-shadow 0.3s;
            }
            .result-item:hover {
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .result-item img {
                width: 100%;
                height: auto;
            }
            .result-item-content {
                padding: 10px;
            }
            .result-item h3 {
                margin: 10px 0;
                color: #d9534f;
                font-size: 18px;
            }
            .result-item p {
                margin: 5px 0;
                color: #333;
                font-size: 14px;
            }
            .result-item .price {
                font-weight: bold;
                color: #d9534f;
            }
            .result-item .distance {
                color: #777;
            }
            .result-item .info-icons {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .result-item .info-icons i {
                color: #d9534f;
                margin-right: 10px;
            }
            .result-item .favorite {
                cursor: pointer;
            }
            .search-bar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            .search-bar input {
                width: calc(100% - 60px);
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .search-bar button {
                padding: 8px 12px;
                border: none;
                background-color: #d9534f;
                color: #fff;
                border-radius: 4px;
                cursor: pointer;
            }
            .stats {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
                background-color: #fff;
                padding: 10px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .stat {
                text-align: center;
                flex: 1;
                padding: 10px;
                border-right: 1px solid #ddd;
            }
            .stat:last-child {
                border-right: none;
            }
            .stat p {
                margin: 5px 0;
                color: #d9534f;
                font-weight: bold;
            }
            .sort-bar {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                margin-bottom: 20px;
            }
            .sort-bar select {
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .results-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 20px;
            }
            .no-resize {
                resize: none;
            }
        </style>

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
            .form-group {
                display: flex;
                flex-direction: column;
                align-items: flex-start;
            }

            .form-group label {
                margin-bottom: 5px;
            }

            .form-group select {
                width: 100%;
                max-width: 100%;
                display: block;
            }

            .result-item .fixed-size-image {
                width: 400px;
                height: 300px;
                object-fit: cover;
            }
        </style>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }

            main {
                padding: 1em;
                max-width: 800px;
                margin: auto;
            }

            form {
                background: #fff;
                padding: 2em;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            form input[type="text"],
            form textarea {
                width: 100%;
                padding: 0.5em;
                margin-bottom: 1em;
                border-radius: 5px;
                border: 1px solid #ccc;
            }

            form button {
                padding: 0.5em 2em;
                background-color: #333;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .breadcrumb {
                margin-bottom: 20px;
            }

            .breadcrumb a {
                color: #d9534f;
                text-decoration: none;
            }

            .breadcrumb a:hover {
                text-decoration: underline;
            }

        </style>
    </head>
    <body>
        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <div class="bradcam_area bradcam_bg_1">

            </div>

            <div class="container">

                <div class="results">
                    <div style="    margin-top: 20px; " class="breadcrumb">
                        <a href="/HFManagementSystem/listBlogPosts">Danh sách blog >  </a>  <span> Viết blog</span>
                    </div>
                    <main>
                        <form action="AddBlogPost" method="post" onsubmit="return validateForm()">
                            <input type="text" name="title" placeholder="Tiêu đề" required>
                            <textarea name="content" rows="10" placeholder="Viết nội dung blog của bạn ở đây..." required></textarea>
                            <button type="submit">Đăng </button>
                            <a href="javascript:history.back()" class="btn btn-dark text-white">Quay lại</a>
                        </form>
                    </main>
                </div>
            </div>


        <jsp:include page="/pages/footer/footer.jsp"></jsp:include>
            <script>
                function validateForm() {
                    const title = document.getElementById('title').value;
                    const content = document.getElementById('content').value;

                    if (title.trim() === '') {
                        alert('Title is required');
                        return false;
                    }
                    if (content.trim() === '') {
                        alert('Content is required');
                        return false;
                    }
                    return true;
                }
            </script>

        <jsp:include page="/pages/footer/footer.jsp"></jsp:include>

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


            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css"> 
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css"> 
            <script>
                window.onload = function () {
                    // Lấy thông báo và loại thông báo từ session
                    var alertMessage = '<%= session.getAttribute("alertMessage") != null ? session.getAttribute("alertMessage") : ""%>';
                    var alertType = '<%= session.getAttribute("alertType") != null ? session.getAttribute("alertType") : ""%>';
                    // Kiểm tra nếu thông báo và loại thông báo không rỗng
                    if (alertMessage && alertType) {
                        Swal.fire({
                            icon: alertType,
                            title: alertMessage,
                            showConfirmButton: false,
                            timer: 2000
                        });
                        // Xóa attribute alertMessage và alertType khỏi session sau khi hiển thị thông báo
            <%
                session.removeAttribute("alertMessage");
                session.removeAttribute("alertType");
            %>
                    }
                };
        </script>
        <!-- Thư viện SweetAlert -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

    </body>
</html>
