<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thông tin ch? nhà và báo cáo</title>
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
            /* General Styles */
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
                color: #333;
            }

            /* Container Styles */
            .container {
                width: 80%;
                margin: 20px auto;
                padding: 20px;
/*                background-color: #fff;*/
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }

            /* Header Styles */
            h1 {
                text-align: center;
                color: #007BFF;
                margin-bottom: 20px;
            }

            /* Report List Styles */
            ul.report-list {
                list-style-type: none;
                padding: 0;
                margin: 0;
            }

            .report-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px;
                margin-bottom: 10px;
                border: 1px solid #ddd;
                border-radius: 6px;
                background-color: #fafafa;
                transition: background-color 0.3s, transform 0.2s;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }

            .report-item:hover {
                background-color: #f1f1f1;
                transform: scale(1.01);
            }

            .report-details {
                display: flex;
                flex-direction: column;
            }

            .report-problem {
                font-weight: bold;
                font-size: 1.1em;
            }

            .report-date {
                color: #888;
                font-size: 0.9em;
            }

            /* Button Styles */
            .details-button, .back-button {
                padding: 10px 15px;
                border: none;
                border-radius: 6px;
                background-color: #007BFF;
                color: white;
                text-decoration: none;
                transition: background-color 0.3s, box-shadow 0.3s;
                cursor: pointer;
                font-size: 0.9em;
            }

            .details-button:hover, .back-button:hover {
                background-color: #0056b3;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            }

            /* Details and Replies Styles */
            #report-details, #admin-replies {
                margin-bottom: 20px;
                background-color: #f9f9f9;
                padding: 15px;
                border-radius: 6px;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }

            h3 {
                margin-top: 20px;
                color: #333;
            }

            #admin-replies hr {
                border: none;
                border-top: 1px solid #ddd;
                margin: 10px 0;
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
            <div class="bradcam_area bradcam_bg_1"></div>

            <div class="container">
                <h1>Chi Tiết Báo Cáo</h1>

            <c:if test="${empty reportList}">
                <p>Chưa có báo cáo nào</p>
            </c:if>

            <c:forEach var="report" items="${reportList}">
                <div id="report-details">
                    <p><strong>Vấn đề: </strong>${report.report_problem}</p>

                               
                    <p><strong>Mô tả: </strong> ${report.report_description}</p>
                    <p class="${report.status ? "text-success":"text-danger"}">Trạng thái: ${report.status ? "Đã xử lý" : "Chưa xử lý"} </p>

                </div>
                <h3>Câu trả lời của quản trị viên:</h3>
                <c:if test="${report.replyReport ne null}">
                    <div id="admin-replies">
                        <p><strong>Date:</strong> ${report.replyReport.replyDate}</p>
                        <p>${report.replyReport.replyContent}</p>
                    </div>
                </c:if>
            </c:forEach>
        </div>



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
                window.onload = function () {
                    // Lấy thông báo và loại thông báo từ session
                    var alertMessage = '<%= session.getAttribute("alertMessage") != null ? session.getAttribute("alertMessage") : "" %>';
                    var alertType = '<%= session.getAttribute("alertType") != null ? session.getAttribute("alertType") : "" %>';
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
    </body>
</html>
