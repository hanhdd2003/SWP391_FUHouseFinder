<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý báo cáo</title>
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
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }

            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }

            .d-flex {
                display: flex;
                justify-content: flex-end;
                margin-bottom: 20px;
            }

            .d-flex a {
                padding: 10px 15px;
                border-radius: 4px;
                text-decoration: none;
                transition: background-color 0.3s;
            }

            .d-flex .btn-primary {
                background-color: #007BFF;
                color: white;
            }

            .d-flex .btn-secondary {
                background-color: #6c757d;
                color: white;
            }

            .d-flex .btn-primary:hover {
                background-color: #0056b3;
            }

            .d-flex .btn-secondary:hover {
                background-color: #5a6268;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            table, th, td {
                border: 1px solid #ddd;
            }

            th, td {
                padding: 10px;
                text-align: left;
            }

            th {
                background-color: #f2f2f2;
            }

            .text-success {
                color: green;
            }

            .text-danger {
                color: red;
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
        </style>
        <style>
            .bradcam_area {
                padding: 40px 0 102px 0;
            }


            .me {
                min-height: 700px;
            }
            .alert-top-right {
                position: fixed;
                top: 100px;
                right: 20px;
                z-index: 1050; /* Đảm bảo rằng thông báo xuất hiện trên các thành phần khác */
            }
            .tb{
                overflow: scroll
            }
            .nice-select{
                height: 45px
            }
        </style>
    </head>
    <body>
        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <div class="bradcam_area bradcam_bg_1">
            </div>
            <div class="container-fluid mt-3 mb-3">
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
                    <div class="container">
                        <h1 class="pt-3">Quản lý báo cáo</h1>
                        <div class="d-flex row">
                            <a class="btn btn-primary mr-2" href="?sort=newest&status=${status}">Mới nhất</a>
                        <a class="btn btn-secondary" href="?sort=oldest&status=${status}">Cũ nhất</a>
                        <div class="ml-3 mr-5 h-47"> 
                            <form id="filterForm" action="/HFManagementSystem/managereport" method="get">
                                <input type="hidden" name="sort" value="${sort}">
                                <select name="status" id="status" onchange="document.getElementById('filterForm').submit();">
                                    <option value="all" ${status == 'all' ? 'selected' : ''}>Tất cả</option>
                                    <option value="processed" ${status == 'processed' ? 'selected' : ''}>Đã xử lý</option>
                                    <option value="unprocessed" ${status == 'unprocessed' ? 'selected' : ''}>Chưa xử lý</option>
                                </select>
                            </form>  
                        </div>  
                    </div>


                    <table class="table table-bordered table-striped">
                        <tr class="bg-warning">
                            <td>Người báo cáo</td>
                            <td>Thời gian báo cáo</td>
                            <td>Trạng thái</td>
                          
                            <td></td>
                        </tr>
                        <c:forEach items="${list}" var="report">
                            <tr>
                                <td>${report.getUser_report().getFirstName()} ${report.getUser_report().getLastName()}</td>
                                <td>${report.report_problem}</td>
                                <td class="${report.isStatus() ? 'text-success' : 'text-danger'}">
                                    ${report.isStatus() ? 'Đã xử lý' : 'Chưa xử lý'}
                                </td>
                                <td><a href="/HFManagementSystem/view-report-deatil-admin?id=${report.report_id}" class="text-dark">Xem chi tiết</a></td>
                            </tr>
                        </c:forEach>
                    </table>
                    <ul class="pagination">
                        <c:if test="${totalPages > 1}">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage - 1}&sort=${sort}&status=${status}">&laquo;</a>
                                </li>
                            </c:if>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <li class="page-item active"><span class="page-link">${i}</span></li>
                                        </c:when>
                                        <c:when test="${i == 1 || i == totalPages || (i >= currentPage - 1 && i <= currentPage + 1)}">
                                        <li class="page-item"><a class="page-link" href="?page=${i}&sort=${sort}&status=${status}">${i}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${i == currentPage - 2 || i == currentPage + 2}">
                                            <li class="page-item disabled"><span class="page-link">...</span></li>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage + 1}&sort=${sort}&status=${status}">&raquo;</a>
                                </li>
                            </c:if>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>

        <div id="myModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h2>Báo cáo </h2>
                <form id="reportForm" method="post" action="/HFManagementSystem/Sendreplay">
                    <input type="text" id="report_id" name="report_id" placeholder="Nhập vấn đề" required>

                
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
     
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <jsp:include page="/pages/footer/footer.jsp"></jsp:include>

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

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        
    </body>
</html>
