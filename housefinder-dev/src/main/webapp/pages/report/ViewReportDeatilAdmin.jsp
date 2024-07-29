<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                padding: 5px 0 102px 0;
            }

            .me {
                height: 700px;
            }
        </style>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f0f0;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 80%;
                margin: 20px auto;
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
            }

            .reports,
            .replies {
                background-color: #fff;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 5px;
                flex: 1 1 100%;
                margin-bottom: 20px;
            }

            .reports h2,
            .replies h2 {
                border-bottom: 1px solid #ccc;
                padding-bottom: 10px;
            }

            .report,
            .reply {
                margin-bottom: 20px;
            }

            .report-header,
            .reply-header {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
            }

            .report-date,
            .reply-date {
                font-weight: bold;
            }

            .report-content,
            .reply-content {
                padding-left: 20px;
            }

            .report-content h3 {
                margin-top: 0;
                color: #333;
            }

            .reply-content p {
                margin: 0;
            }

            @media (max-width: 768px) {
                .container {
                    flex-direction: column;
                }
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

                    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
                        <div class="container">
                            <div class="reports">
                                <h2>Người dùng báo cáo</h2>
                            <c:if test="${not empty report}">
                                <div class="report">
                                    <div class="report-header">
                                        <span class="report-user">Họ và tên: ${report.user_report.firstName} ${report.user_report.lastName}</span>
                                    </div>
                                    <div class="report-content">
                                        <h3>Vấn đề ${report.report_problem}</h3>
                                        <p>Mô tả: ${report.report_description}</p>
                                    </div>
                                </div>
                            </c:if>
                        </div>

                        <div class="replies">
                            <h2>Admin</h2>
                            <c:if test="${not empty report.replyReport}">
                                <div class="reply">
                                    <div class="reply-header">
                                        <span class="reply-date">${report.replyReport.replyDate}</span>
                                    </div>
                                    <div class="reply-content">
                                        <p>Trả lời: ${report.replyReport.replyContent}</p>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${empty report.replyReport}">
                                <form id="reportForm" method="post" action="/HFManagementSystem/Sendreplay">
                                    <input type="text" id="report_id" hidden value="${report.report_id}" name="report_id" placeholder="Nhập vấn đề" required>
                                    <div class="form-group">
                                        <label for="replyContent">Nội dung trả lời</label>
                                        <textarea class="form-control" id="replyContent" name="report_description"  rows="3"></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </form>
                            </c:if>
                        </div>
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="/HFManagementSystem/js/main.js"></script>
    </body>
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
                                let reportId = $('#report_id').val();
                                window.location.href = "/HFManagementSystem/view-report-deatil-admin?id=" + reportId;
                            });
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('Error:', error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'An error occurred while processing your request.',
                            confirmButtonText: 'OK',
                            timer: 3500
                        });
                    }
                });
            });
        });
    </script>
</html>
