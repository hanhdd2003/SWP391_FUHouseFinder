<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thông tin chủ nhà và báo cáo</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
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
        <style>


            .form-group {
                margin-bottom: 20px;
            }
            .form-group label {
                display: block;
                font-weight: bold;
                margin-bottom: 5px;
                color: #333;
            }
            .form-group input, .form-group textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 14px;
            }
            .button-container {
                text-align: center;
            }
            .button-container button {
                padding: 12px 24px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s;
            }
            .button-container button:hover {
                background-color: #0056b3;
            }
            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0,0,0,0.4);
            }
            .modal-content {
                background-color: #fefefe;
                margin: 10% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
                max-width: 600px;
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(0,0,0,0.2);
            }
            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
            }
            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
            .modal-content h2 {
                margin-top: 0;
                color: #333;
            }
            .content{
                width: 400px;
                margin-bottom: 10px
            }
        </style>
    </head>
    <body>
        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <div class="bradcam_area bradcam_bg_1"></div>
            <div class="container content">
                <h2 style="text-align: center; margin-bottom: 20px;">Thông tin ADMIN</h2>
                <c:if  test="${not empty err and err eq 'sent'}">
                <p style="color: #007bff" class="success-message">Đã gửi thành công!</p>
            </c:if>
            <div class="form-group">
                <label for="first_name">Tên:</label>
                <p class="text-dark">${user.fname} ${user.lname}</p>
            </div>
            <div class="form-group">
                <label for="address">Địa chỉ:</label>
                <p class="text-dark">${user.add}</p>
            </div>
            <div class="form-group">
                <label for="phone">Số điện thoại:</label>
                <a href="tel:${user.phone}">${user.phone}</a>
                
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <a href="mailTo:${user.email}">${user.email}</a>
            </div>
            <div class="button-container">
                <button onclick="openModal()">Báo cáo</button>
            </div>
        </div>

        <div id="myModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h2>Báo cáo </h2>
                <form id="reportForm" method="post" action="/HFManagementSystem/Send-report">
                    <div class="form-group">
                        <label for="report_problem">Vấn đề báo cáo:</label>
                        <input type="text" id="report_problem" name="report_problem" placeholder="Nhập vấn đề" required>
                    </div>
                    <div class="form-group">
                        <label for="report_description">Mô tả chi tiết:</label>
                        <textarea id="report_description" name="report_description" placeholder="Nhập mô tả" required></textarea>
                    </div>
                    <div class="button-container">
                        <button type="submit" style="background-color: #28a745;">Gửi báo cáo</button>
                    </div>
                </form>
            </div>
        </div>
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">    <script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
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

        <jsp:include page="/pages/footer/footer.jsp"></jsp:include>
        <script >
function openModal() {
                            document.getElementById('myModal').style.display = 'block';
        }
function closeModal() {
                            document.getElementById('myModal').style.display = 'none';
            }
        </script>
      <script>
        $(document).ready(function () {
            $('#reportForm').on('submit', function (event) {
                event.preventDefault();

                $.ajax({
                    url: $(this).attr('action'),
                    method: $(this).attr('method'),
                    data: $(this).serialize(),
                    dataType: 'json',
                    success: function (data) {
                        if (data.error) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Lỗi!',
                                text: data.error,
                                confirmButtonText: 'OK',
                                timer: 3500
                            });
                        } else if (data.success) {
                            Swal.fire({
                                icon: 'success',
                                title: 'Thành công!',
                                text: 'Báo cáo đã được gửi.',
                                confirmButtonText: 'OK',
                                timer: 3500
                            }).then(() => {
                                window.location.href = "view-report";
                            });
                        }
                    },
                    error: function (xhr, status, error) {
                       Swal.fire({
                                icon: 'success',
                                title: 'Thành công!',
                                text: 'Báo cáo đã được gửi.',
                                confirmButtonText: 'OK',
                                timer: 3500
                            }).then(() => {
                                window.location.href = "view-report";
                            });
                    }
                });
            });
        });
    </script>
    </body>
</html>
