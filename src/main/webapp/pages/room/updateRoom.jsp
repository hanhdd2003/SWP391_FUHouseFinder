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
            .container {
                border-radius: 8px;
                padding: 30px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);

            }

            h1 {
                margin-bottom: 30px;
            }

            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
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
            .update{
                width: 600px;
                margin-top: 20px;
                margin-bottom: 30px
            }
        </style>

    </head>

    <body>

        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <div class="bradcam_area bradcam_bg_1"></div>
            <div class="container update">
                <h1>Cập Nhật Phòng</h1>
                <form id="updateRoomForm" action="update_room" method="post" onsubmit="return validateUpdateRoomForm()">
                    <input type="hidden" name="room_id" value="${roomid}">
                <input type="hidden" class="form-control" id="house_id" name="house_id" value="${house_id}" required>

                <div class="form-group">
                    <label for="room_number">Số Phòng<samp style="color: red">*</samp></label>
                    <input type="number" class="form-control" id="room_number" name="room_number" value="${room.roomNumber}" required min="0">
                    <div id="roomNumberError" class="text-danger"></div>
                </div>


                <div class="form-group">
                    <label for="price">Giá<samp style="color: red">*</samp></label>
                    <input type="number" step="100000" class="form-control" id="price" name="price" value="${room.price}" required min="0">
                    <div id="priceError" class="text-danger"></div>
                </div>
                <div class="form-group">
                    <label for="area">Diện Tích<samp style="color: red">*</samp></label>
                    <input type="number" step="0.5" class="form-control" id="area" name="area" value="${room.area}" required min="0">
                    <div id="areaError" class="text-danger"></div>
                </div>

                <div class="form-group">
                    <label for="utilities">Tiện ích</label>
                    <div id="utilities">
                        <c:forEach var="utility" items="${allUtilities}">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="utilities" value="${utility.id}" <c:if test="${fn:contains(room.utilityString, utility.name)}">checked</c:if>>
                                <label class="form-check-label">${utility.name}</label>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="row d-flex justify-content-center">
                    <a class="btn btn-primary" href="javascript:history.back()">Quay lại</a>
                    <button type="submit" class="btn btn-primary ml-4">Cập Nhật Phòng</button>                    
                </div>
            </form>
        </div>

        <jsp:include page="/pages/footer/footer.jsp"></jsp:include>

            <!-- JS here -->
            <script src="${pageContext.request.contextPath}/js/vendor/jquery-1.12.4.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/main.js"></script>
    </body>

</html>
