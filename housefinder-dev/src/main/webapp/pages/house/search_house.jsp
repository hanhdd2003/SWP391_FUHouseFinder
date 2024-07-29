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
            .filter .filter-group {
                margin-bottom: 20px;
            }
            .filter .filter-group label {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
                font-weight: bold;
                font-size: 14px;
                cursor: pointer;
            }
            .filter .filter-group input[type="radio"] {
                appearance: none;
                -webkit-appearance: none;
                -moz-appearance: none;
                width: 18px;
                height: 18px;
                border: 1px solid #d9534f;
                border-radius: 4px;
                margin-right: 10px;
                outline: none;
                cursor: pointer;
                position: relative;
            }
            .filter .filter-group input[type="radio"]:checked {
                background-color: #d9534f;
            }
            .filter .filter-group input[type="radio"]:checked::after {
                content: '';
                display: block;
                width: 10px;
                height: 10px;
                background-color: white;
                position: absolute;
                top: 4px;
                left: 4px;
                border-radius: 2px;
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
                height: 200px;
                object-fit: cover;
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
            #filterForm label {
                font-size: 12px;
            }
        </style>

    </head>
    <body>
        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <div class="bradcam_area bradcam_bg_1"></div>
            <div class="container">
                <div class="filter">
                    <h3>Lọc kết quả</h3>
                    <form id="filterForm" action="/HFManagementSystem/search_houses" method="get">
                        <div>
                            <label for="khoangcach">Khoảng cách đến trường:</label>
                            <div>
                                <input type="radio" id="distanceRangeAll" name="distanceRange" value="" ${empty sessionScope.distanceMin && empty sessionScope.distanceMax ? 'checked' : ''} onchange="submitForm()">
                            <label for="distanceRangeAll">All</label>
                        </div>
                        <div>
                            <input type="radio" id="distanceRange0-3" name="distanceRange" value="0-3" ${empty sessionScope.distanceMin && empty sessionScope.distanceMax ? 'checked' : ''} onchange="submitForm()">
                            <label for="distanceRange0-3">0 - 3 km</label>
                        </div>
                        <div>
                            <input type="radio" id="distanceRange3-5" name="distanceRange" value="3-5" ${sessionScope.distanceMin == '3' && sessionScope.distanceMax == '5' ? 'checked' : ''} onchange="submitForm()">
                            <label for="distanceRange3-5">3 - 5 km</label>
                        </div>
                        <div>
                            <input type="radio" id="distanceRange5-7" name="distanceRange" value="5-7" ${sessionScope.distanceMin == '5' && sessionScope.distanceMax == '7' ? 'checked' : ''} onchange="submitForm()">
                            <label for="distanceRange5-7">5 - 7 km</label>
                        </div>
                        <div>
                            <input type="radio" id="distanceRange7-" name="distanceRange" value="7-" ${sessionScope.distanceMin == '7' ? 'checked' : ''} onchange="submitForm()">
                            <label for="distanceRange7-">Trên 7 km</label>
                        </div>
                    </div>
                    <div>
                        <label for="giatien">Giá tiền (VND/Tháng):</label>
                        <div>
                            <input type="radio" id="priceRangeAll" name="priceRange" value="" ${empty sessionScope.priceMin && empty sessionScope.priceMax ? 'checked' : ''} onchange="submitForm()">
                            <label for="priceRangeAll">All</label>
                        </div>
                        <div>
                            <input type="radio" id="priceRange0-2000000" name="priceRange" value="0-2000000" ${empty sessionScope.priceMin && empty sessionScope.priceMax ? 'checked' : ''} onchange="submitForm()">
                            <label for="priceRange0-2000000">0 - 2,000,000 VND</label>
                        </div>
                        <div>
                            <input type="radio" id="priceRange2000000-4000000" name="priceRange" value="2000000-4000000" ${sessionScope.priceMin == '2000000' && sessionScope.priceMax == '4000000' ? 'checked' : ''} onchange="submitForm()">
                            <label for="priceRange2000000-4000000">2,000,000 - 4,000,000 VND</label>
                        </div>
                        <div>
                            <input type="radio" id="priceRange4000000-8000000" name="priceRange" value="4000000-8000000" ${sessionScope.priceMin == '4000000' && sessionScope.priceMax == '8000000' ? 'checked' : ''} onchange="submitForm()">
                            <label for="priceRange4000000-8000000">4,000,000 - 8,000,000 VND</label>
                        </div>
                        <div>
                            <input type="radio" id="priceRange8000000-" name="priceRange" value="8000000-" ${sessionScope.priceMin == '8000000' ? 'checked' : ''} onchange="submitForm()">
                            <label for="priceRange8000000-">Trên 8,000,000 VND</label>
                        </div>
                    </div>
                    <input type="hidden" id="hiddenKeyword" name="keyword" value="${sessionScope.keyword}">
                    <input type="hidden" id="hiddenSort" name="sort" value="newest">
                </form>
            </div>
            <div class="results">
                <div class="search-bar">
                    <input type="text" id="searchKeyword" name="keyword" placeholder="Nhập tên trọ" value="${sessionScope.keyword}">
                    <button type="button" class="btn ml-2" onclick="updateAndSubmit()">Tìm kiếm</button>
                </div>
                <div class="sort-bar">
                    <label for="sort">Sắp xếp theo:</label>
                    <select id="sort" name="sort" onchange="updateAndSubmit()">
                        <option value="newest" ${sessionScope.sort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                        <option value="oldest" ${sessionScope.sort == 'oldest' ? 'selected' : ''}>Cũ nhất</option>
                    </select>
                </div>
                <h3>Danh sách nhà trọ</h3> 
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
                                            <fmt:formatNumber value="${house.maxPrice}" type="currency" currencySymbol="" groupingUsed="true" />đ </p>
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${house.minPrice}" type="currency" currencySymbol="" groupingUsed="true" />đ - 
                                            <fmt:formatNumber value="${house.maxPrice}" type="currency" currencySymbol="" groupingUsed="true" />đ </p>
                                    </c:otherwise>
                                </c:choose>


                                <p class="distance"><i class="fas fa-bed"></i> ${house.status} </p>
                                <div class="info-icons">
                                    <c:if test="${not empty sessionScope.user and sessionScope.user.roleId == 2}">
                                        <i class="fas fa-heart favorite"></i>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <jsp:include page="/pages/footer/footer.jsp"></jsp:include>
            <script>
                window.onload = function () {
                    var distanceRange = "${sessionScope.distanceRange}";
                    var priceRange = "${sessionScope.priceRange}";


                    if (distanceRange) {
                        var distanceRadio = document.querySelector(`input[name="distanceRange"][value="${distanceRange}"]`);
                        if (distanceRadio)
                            distanceRadio.checked = true;
                    } else {
                        document.getElementById('distanceRangeAll').checked = true;
                    }

                    if (priceRange) {
                        var priceRadio = document.querySelector(`input[name="priceRange"][value="${priceRange}"]`);
                        if (priceRadio)
                            priceRadio.checked = true;
                    } else {
                        document.getElementById('priceRangeAll').checked = true;
                    }
                };

                function submitForm() {
                    document.getElementById("filterForm").submit();
                }

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
    </body>
</html>
