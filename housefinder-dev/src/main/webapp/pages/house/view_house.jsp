<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách nhà trọ</title>

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
            .filter button {
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
                height: 200px; /* Đặt chiều cao cố định */
                object-fit: cover; /* Đảm bảo hình ảnh được cắt đúng cách */
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
        </style>
    </head>
    <body>
        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <div class="bradcam_area bradcam_bg_1"></div>
            <div class="container">
                <!--                <div class="filter">
                                    <h3>Lọc kết quả</h3>-->
                <form id="filterForm" action="/HFManagementSystem/search_houses" method="get">
                    <!--                        <div>
                                                <label for="khoangcach">Khoảng cách đến trường:</label>-->
                    <input  hidden type="number" id="distance-min" name="distanceMin" placeholder="km" value="${sessionScope.distanceMin}">
                <input hidden type="number" id="distance-max" name="distanceMax" placeholder="km" value="${sessionScope.distanceMax}">
                <!--                        <button type="submit">Áp dụng</button>
                                    </div>
                                    <div>-->
                <!--                        <label for="giatien">Giá tiền (VND/Tháng):</label>-->
                <input hidden type="number" id="price-min" name="priceMin" placeholder="VND" value="${sessionScope.priceMin}">
                <input hidden type="number" id="price-max" name="priceMax" placeholder="VND" value="${sessionScope.priceMax}">
                <!--                        <button type="submit">Áp dụng</button>
                                    </div>-->
                <input type="hidden" id="hiddenKeyword" name="keyword" value="${sessionScope.keyword}">
                <input type="hidden" id="hiddenSort" name="sort" value="newest">
            </form>
            <!--            </div>-->
            <div class="results">
                <div class="row">
                    <div class="col-md-4 d-flex justify-content-start">
                        <h1>Danh sách nhà trọ</h1>
                    </div>

                    <div class="col-md-8 search-bar d-flex justify-content-end">
                        <input type="text" id="searchKeyword" name="keyword" value="${sessionScope.keyword}" hidden="">
                        <button type="button" class="btn" onclick="updateAndSubmit()">Tìm kiếm</button>
                    </div>
                </div>
                <style>
                    .hidden {
                        display: none;
                    }
                </style>




                <select id="sort" name="sort"  style="display: none;" class="hidden" onchange="updateAndSubmit()">
                    <option value="newest" ${sessionScope.sort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                    <option value="oldest" ${sessionScope.sort == 'oldest' ? 'selected' : ''}>Cũ nhất</option>
                </select>
                <div class="results-grid" id="resultsGrid">
                    <c:forEach var="house" items="${list}">
                        <div class="result-item">

                            <img src="img/fu_house/${house.avatarImage}" alt="${house.img}">
                            <div class="result-item-content">
                                <h3><a href="/HFManagementSystem/detail_house?id=${house.id}">${house.house_name}</a></h3>
                                <p class="distance"><i class="fas fa-map-marker-alt"></i> ${house.distance_km}</p>
                                <p class="distance"><i class="fas fa-solid fa-coins"></i> 
                                    <c:choose>
                                        <c:when test="${house.minPrice == house.maxPrice}">
                                            <fmt:formatNumber value="${house.maxPrice}" type="currency" currencySymbol="" groupingUsed="true" />đ</p>
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${house.minPrice}" type="currency" currencySymbol="" groupingUsed="true" />đ - 
                                            <fmt:formatNumber value="${house.maxPrice}" type="currency" currencySymbol="" groupingUsed="true" />đ</p>
                                        </c:otherwise>
                                    </c:choose>

                                <p class="distance"><i class="fas fa-bed"></i> ${house.status} </p>
                                <div class="info-icons">
                                    <c:if test="${not empty sessionScope.user and sessionScope.user.roleId == 3}">
                                        <i class="fas fa-heart favorite ${house.favorite ? 'favorite-active' : ''}" 
                                           data-house-id="${house.id}" 
                                           data-is-favorite="${house.favorite}" 
                                           onclick="toggleFavorite(this)"></i>
                                    </c:if>
                        
                                </div>
                            </div>
                        </div>
                    </c:forEach>    
                </div>
                      <ul class="pagination">
                        <c:if test="${totalPages > 1}">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage - 1}">&laquo; </a>
                                </li>
                            </c:if>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <li class="page-item active"><span class="page-link">${i}</span></li>
                                        </c:when>
                                        <c:otherwise>
                                        <li class="page-item"><a class="page-link" href="?page=${i}">${i}</a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage + 1}"> &raquo;</a>
                                </li>
                            </c:if>
                        </c:if>
                    </ul>

            </div>
        </div>

        <script>
            function toggleFavorite(element) {
                var houseId = element.getAttribute("data-house-id");
                var isFavorite = element.getAttribute("data-is-favorite") === "true";

                $.ajax({
                    url: '/HFManagementSystem/toggleFavorite',
                    type: 'POST',
                    data: {
                        houseId: houseId,
                        isFavorite: !isFavorite
                    },
                    success: function (response) {
                        if (response.status === 'success') {
                            // Toggle class to change icon color
                            element.classList.toggle("favorite-active");

                            // Toggle data-is-favorite attribute
                            element.setAttribute("data-is-favorite", String(!isFavorite));
                        }
                    },
                    error: function (error) {
                        console.error('Error:', error);
                    }
                });
            }

        </script>

        <style>
            .results-grid .result-item .info-icons .favorite {
                color: black;
            }

            .results-grid .result-item .info-icons .favorite-active {
                color: red;
            }

        </style>

        <jsp:include page="/pages/footer/footer.jsp"></jsp:include>
            <script>
                function updateAndSubmit() {
                    var searchKeyword = document.getElementById('searchKeyword').value;
                    var sort = document.getElementById('sort').value;

                    var hiddenKeyword = document.getElementById('hiddenKeyword');
                    var hiddenSort = document.getElementById('hiddenSort');

                    if (hiddenKeyword) {
                        hiddenKeyword.value = searchKeyword;
                    }

                    if (hiddenSort) {
                        hiddenSort.value = sort;
                    }

                    var form = document.getElementById('filterForm');
                    form.submit();
                }

                window.onload = function () {
                    var hiddenSort = document.getElementById('hiddenSort');
                    if (hiddenSort) {
                        document.getElementById('sort').value = hiddenSort.value;
                    }
                };
            </script>

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

            <!-- Thư viện SweetAlert -->
           <!-- Thư viện SweetAlert -->
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
           
    </body>
</html>
