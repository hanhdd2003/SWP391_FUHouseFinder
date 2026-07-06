<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html class="no-js" lang="zxx">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>FU House Finder</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- CSS here -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <style>
            .bradcam_area {
                padding: 20px 0 102px 0;
            }
            .update{
                min-height: 600px
            }
            .table{
                overflow: scroll
            }
        </style>

    </head>

    <body>

        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <div class="bradcam_area bradcam_bg_1"></div>
            <div class="container update text-center">

            <c:if test="${empty history}">
                <h1 class="mt-5">Bạn chưa có lịch sử đặt phòng</h1>
            </c:if>
            <c:if test="${not empty history }">
                <h1 class="text-center mb-5 mt-5">Lịch sử yêu cầu thuê nhà</h1>
                <table class="table table-borderless">
                    <tr>
                        <td>STT</td>
                        <td>Tên nhà</td>
                        <td>Số phòng</td>
                        <td>Trạng thái</td>
                        <td>Thời gian</td>
                    </tr>
                    <c:forEach items="${history}" var="history" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${history.house_name}</td>
                            <td>${history.room_number}</td>
                            <td>${history.getStatusString()}</td>
                            <td>${history.dateString()}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>


        </div>

        <jsp:include page="/pages/footer/footer.jsp"></jsp:include>

            <!-- JS here -->
            <script src="${pageContext.request.contextPath}/js/vendor/jquery-1.12.4.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/main.js"></script>
    </body>

</html>
