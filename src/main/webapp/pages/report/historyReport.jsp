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
            body {
                font-family: 'Roboto', sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }

            .container {
                width: 80%;
                margin: 50px auto;
                padding: 20px;
                /*background-color: #fff;*/
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }

            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }

            .report-filters {
                display: flex;
                justify-content: flex-end;
                margin-bottom: 20px;
            }

            .report-filters form {
                display: flex;
                gap: 10px;
            }

            ul.report-list {
                list-style-type: none;
                padding: 0;
            }

            .report-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px;
                margin-bottom: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                background-color: #f9f9f9;
                transition: background-color 0.3s;
            }

            .report-item:hover {
                background-color: #ececec;
            }

            .report-details {
                display: flex;
                flex-direction: column;
                max-width: 70%;
            }

            .report-problem {
                font-weight: bold;
                margin-bottom: 5px;
            }

            .report-description, .report-dates {
                margin-bottom: 5px;
            }

            .details-button, .back-button {
                padding: 10px 15px;
                border: none;
                border-radius: 4px;
                background-color: #007BFF;
                color: white;
                text-decoration: none;
                transition: background-color 0.3s;
                font-size: 14px;
            }

            .details-button:hover, .back-button:hover {
                background-color: #0056b3;
            }

            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .pagination .page-item {
                margin: 0 5px;
            }

            .pagination .page-link {
                color: #007BFF;
                text-decoration: none;
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                transition: background-color 0.3s;
            }

            .pagination .page-link:hover {
                background-color: #007BFF;
                color: white;
            }

            .pagination .active .page-link {
                background-color: #007BFF;
                color: white;
                border: none;
            }
            .bradcam_area {
                padding: 20px 0 102px 0;
            }
            .result{
                min-height: 500px;
                overflow: scroll
            }
        </style>
    </head>
    <body>
        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <div class="bradcam_area bradcam_bg_1"></div>
            <div class="container result">
                <h1>Danh sách báo cáo</h1>
                <div class="report-filters">
                    <form id="filterForm" action="/HFManagementSystem/history-report" method="get">
                        <select name="sort" id="sort" onchange="document.getElementById('filterForm').submit();">
                            <option value="newest" ${sort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                            <option value="oldest" ${sort == 'oldest' ? 'selected' : ''}>Cũ nhất</option>
                        </select>
                        <select name="status" id="status" onchange="document.getElementById('filterForm').submit();">
                            <option value="all" ${status == 'all' ? 'selected' : ''}>Tất cả</option>
                            <option value="processed" ${status == 'processed' ? 'selected' : ''}>Đã xử lý</option>
                            <option value="unprocessed" ${status == 'unprocessed' ? 'selected' : ''}>Chưa xử lý</option>
                        </select>
                    </form>
                </div>
                <ul class="report-list">
                    <c:forEach var="report" items="${reportList}">
                        <li class="report-item">
                            <div class="report-details">
                                <div class="report-problem">Vấn đề báo cáo: ${report.report_problem}</div>
                                <div class="report-description">Mô tả: ${report.report_description}</div>
                                <div class="report-dates">
                                    <p class="${report.status ? 'text-success' : 'text-danger'}">
                                        Trạng thái: ${report.status ? 'Đã xử lý' : 'Chưa xử lý'}
                                    </p>
                                    <p>Ngày báo cáo: ${report.report_date}</p>
                                    <c:if test="${report.replyReport ne null}">
                                        <p>Ngày phản hồi: ${report.replyReport.replyDate}</p>
                                        <p>Nội dung phản hồi: ${report.replyReport.replyContent}</p>
                                    </c:if>
                                </div>
                            </div>
                            <a href="/HFManagementSystem/history-report-detail?id=${report.report_id}" class="details-button">Xem chi tiết</a>
                        </li>
                    </c:forEach>
                </ul>

                <ul class="pagination">
                    <c:if test="${totalPages > 1}">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="?page=${currentPage - 1}&sort=${sort}&status=${status}">&laquo; Previous</a>
                            </li>
                        </c:if>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <li class="page-item active"><span class="page-link">${i}</span></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="?page=${i}&sort=${sort}&status=${status}">${i}</a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="?page=${currentPage + 1}&sort=${sort}&status=${status}">Next &raquo;</a>
                            </li>
                        </c:if>
                    </c:if>
                </ul>
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
        <script>
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
                    <% session.removeAttribute("alertMessage");
                        session.removeAttribute("alertType");%>
                }
            };
        </script>
    </body>
</html>
