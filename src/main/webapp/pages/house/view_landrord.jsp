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
    </head>
    <body>
        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <div class="bradcam_area bradcam_bg_1">
            </div>
            <div class="container">

                <div class="results">

<!--                    <button  class="add-house-button" data-toggle="modal" data-target="#addHouseModal">Thêm Nhà</button>-->
                    <button class="add-house-button" onclick="checkAndShowModal()">Thêm Nhà</button>

                    <div style="margin-top: 20px" class="results-grid" id="resultsGrid">

                    <c:choose>
                        <c:when test="${not empty list}">
                            <c:forEach var="house" items="${list}">

                                <c:set var="houseIdStr" value="${houseItem.id}" />

                                <div class="result-item">
                                    <img src="img/fu_house/${house.avatarImage}"  class="fixed-size-image" alt="${house.avatarImage}" width="400" height="300">
                                    <div class="result-item-content">
                                        <h3><a href="/HFManagementSystem/view_landrord_detail?id=${house.id}">${house.house_name}</a></h3>

                                        <p class="distance"><i class="fas fa-map-marker-alt"></i> ${house.distance_km}</p>
                                        <p class="distance"><i class="fas fa-dollar-sign"></i>
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
                                    </div>
                                </div>
                            </c:forEach>
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
                        </c:when>

                    </c:choose>
                </div>
            </div>
        </div>
        <div id="alertPlaceholder"></div>
        <!-- Add House Modal -->
        <div class="modal fade" id="addHouseModal" tabindex="-1" aria-labelledby="addHouseModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 600px">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addHouseModalLabel">Thêm Nhà</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="addHouseForm" method="post" action="addhouse" enctype="multipart/form-data">
                            <input type="hidden" minlength="5" maxlength="50" name="landlord_id" value="${user.landlordMder.id}">
                            <div class="form-group">
                                <label for="house_name">Tên Nhà<samp style="color: red">*</samp></label>
                                <input type="text" class="form-control" id="house_name" name="name" required>
                                <div id="houseNameError" class="text-danger"></div>
                            </div>
                            <div class="form-group">
                                <label for="house_address">Vị trí<samp style="color: red">*</samp></label>
                                <select class="form-control" id="house_location" name="location_id" required>
                                    <c:forEach var="location" items="${locations}">
                                        <option value="${location.location_id}">${location.location_name}</option>
                                    </c:forEach>
                                </select>
                                <div id="houseAddressError" class="text-danger"></div>
                            </div>
                            <div class="form-group">
                                <label for="house_description">Địa chỉ <samp style="color: red">*</samp></label>
                                <textarea class="form-control no-resize" id="house_description" name="address" required></textarea>
                                <div id="houseDescriptionError" class="text-danger"></div>
                            </div>
                            <div class="form-group">
                                <label for="house_description">Mô Tả<samp style="color: red">*</samp></label>
                                <textarea class="form-control no-resize" id="house_description" name="house_description" required></textarea>
                                <div id="houseDescriptionError" class="text-danger"></div>
                            </div>

                        
                            <div class="form-group">
                                <label for="img">Ảnh<samp style="color: red">*</samp></label>
                                <input type="file" class="form-control" id="img" name="img" multiple required>
                                <div id="imgError" class="text-danger"></div>
                            </div>
                            <div id="imageList" class="form-group" style="display: flex; flex-wrap: wrap;">

                            </div>
                            <input type="hidden" id="jsonImages" name="jsonImages">
                            <button type="submit" class="btn btn-primary">Thêm</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>



        <jsp:include page="/pages/footer/footer.jsp"></jsp:include>
            <script>
                function updateAndSubmit() {
                    var searchKeyword = document.getElementById('searchKeyword').value;
                    var sort = document.getElementById('sort').value;

                    document.getElementById('hiddenKeyword').value = searchKeyword;
                    document.getElementById('hiddenSort').value = sort;

                    var form = document.getElementById('filterForm');
                    form.submit();
                }

                window.onload = function () {
                    // Initialize sort select value based on the hidden input value
                    document.getElementById('sort').value = document.getElementById('hiddenSort').value;
                };
            </script>
            <script>
                let images = [];

                document.getElementById('img').addEventListener('change', function (event) {
                    let files = event.target.files;
                    for (let i = 0; i < files.length; i++) {
                        let file = files[i];
                        let reader = new FileReader();

                        reader.onload = function (e) {
                            images.push({imageUrl: e.target.result, fileName: file.name});
                            updateImageList();
                        };

                        reader.readAsDataURL(file);
                    }
                });

                function updateImageList() {
                    let imageList = document.getElementById('imageList');
                    imageList.innerHTML = '';

                    images.forEach((img, index) => {
                        let imageDiv = document.createElement('div');
                        imageDiv.className = 'image-item';
                        imageDiv.style.position = 'relative';
                        imageDiv.style.margin = '10px';
                        imageDiv.style.width = '100px';
                        imageDiv.style.height = '100px';

                        let imgTag = document.createElement('img');
                        imgTag.src = img.imageUrl;
                        imgTag.alt = img.fileName;
                        imgTag.style.width = '100%';
                        imgTag.style.height = '100%';
                        imgTag.style.objectFit = 'cover';

                        let removeButton = document.createElement('button');
                        removeButton.textContent = 'Xóa';
                        removeButton.style.position = 'absolute';
                        removeButton.style.top = '5px';
                        removeButton.style.right = '5px';
                        removeButton.style.backgroundColor = 'rgba(255, 0, 0, 0.7)';
                        removeButton.style.color = 'white';
                        removeButton.style.border = 'none';
                        removeButton.style.borderRadius = '5px';
                        removeButton.style.cursor = 'pointer';
                        removeButton.onclick = function () {
                            removeImage(index);
                        };

                        imageDiv.appendChild(imgTag);
                        imageDiv.appendChild(removeButton);
                        imageList.appendChild(imageDiv);
                    });

                    let jsonImages = JSON.stringify(images.map(img => ({imageUrl: img.fileName})));
                    document.getElementById('jsonImages').value = jsonImages;
                }

                function removeImage(index) {
                    images.splice(index, 1);
                    updateImageList();
                }

                document.getElementById('addHouseForm').addEventListener('submit', function (event) {
                    if (images.length === 0) {
                        document.getElementById('imgError').textContent = 'Vui lòng thêm ít nhất một ảnh.';
                        event.preventDefault();
                    }
                });
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
            <script>
                document.getElementById('addHouseForm').addEventListener('submit', function (event) {
                    let houseName = document.getElementById('house_name').value.trim();
                    let houseAddress = document.getElementById('house_address').value.trim();
                    let houseDescription = document.getElementById('house_description').value.trim();
                    let price = document.getElementById('price').value;
               
                    let img = document.getElementById('img').value;
                    let isValid = true;

                    // Kiểm tra các trường không được để trống
                    if (houseName === '' || houseName.length > 255) {
                        document.getElementById('houseNameError').textContent = 'Tên nhà không được để trống và không được vượt quá 255 ký tự.';
                        isValid = false;
                    } else {
                        document.getElementById('houseNameError').textContent = '';
                    }

                    if (houseAddress === '' || houseAddress.length > 255) {
                        document.getElementById('houseAddressError').textContent = 'Địa chỉ không được để trống và không được vượt quá 255 ký tự.';
                        isValid = false;
                    } else {
                        document.getElementById('houseAddressError').textContent = '';
                    }

                    if (houseDescription === '' || houseDescription.length > 255) {
                        document.getElementById('houseDescriptionError').textContent = 'Mô tả không được để trống và không được vượt quá 255 ký tự.';
                        isValid = false;
                    } else {
                        document.getElementById('houseDescriptionError').textContent = '';
                    }

                    // Kiểm tra giá trị price và km
                    if (price < 100000 || price > 1000000000) {
                        document.getElementById('priceError').textContent = 'Giá tiền phải là số dương và không vượt quá 1000000000.';
                        isValid = false;
                    } else {
                        document.getElementById('priceError').textContent = '';
                    }

               

                    // Kiểm tra file ảnh
                    if (!img) {
                        document.getElementById('imgError').textContent = 'Ảnh không được để trống.';
                        isValid = false;
                    } else {
                        document.getElementById('imgError').textContent = '';
                    }

                    if (!isValid) {
                        event.preventDefault();
                    }
                });
                document.getElementById('addHouseForm').addEventListener('submit', function (event) {
                    let houseName = document.getElementById('house_name').value.trim();
                    let houseAddress = document.getElementById('house_address').value.trim();
                    let houseDescription = document.getElementById('house_description').value.trim();
                    let price = document.getElementById('price').value;
                
                    let img = document.getElementById('img').value;
                    let isValid = true;

                    // Kiểm tra các trường không được để trống
                    if (houseName === '' || houseName.length > 255) {
                        document.getElementById('houseNameError').textContent = 'Tên nhà không được để trống và không được vượt quá 255 ký tự.';
                        isValid = false;
                    } else {
                        document.getElementById('houseNameError').textContent = '';
                    }

                    if (houseAddress === '' || houseAddress.length > 255) {
                        document.getElementById('houseAddressError').textContent = 'Địa chỉ không được để trống và không được vượt quá 255 ký tự.';
                        isValid = false;
                    } else {
                        document.getElementById('houseAddressError').textContent = '';
                    }

                    if (houseDescription === '' || houseDescription.length > 255) {
                        document.getElementById('houseDescriptionError').textContent = 'Mô tả không được để trống và không được vượt quá 255 ký tự.';
                        isValid = false;
                    } else {
                        document.getElementById('houseDescriptionError').textContent = '';
                    }

                    // Kiểm tra giá trị price và km
                    if (price < 100000 || price > 1000000000) {
                        document.getElementById('priceError').textContent = 'Giá tiền phải là số dương và không vượt quá 1000000000.';
                        isValid = false;
                    } else {
                        document.getElementById('priceError').textContent = '';
                    }

                

                    // Kiểm tra file ảnh
                    if (!img) {
                        document.getElementById('imgError').textContent = 'Ảnh không được để trống.';
                        isValid = false;
                    } else {
                        document.getElementById('imgError').textContent = '';
                    }

                    if (!isValid) {
                        event.preventDefault();
                    }
                });
            </script>

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
        <script>
                function checkAndShowModal() {
                    var numberhousecanadd = ${numberhousecanadd}
                    if (numberhousecanadd !== 0) {
                        $('#addHouseModal').modal('show'); // Show modal if numberhousecanadd is not zero
                    } else {
                        // Use SweetAlert to display an error message
                        Swal.fire({
                            icon: 'error',
                            title: 'Không thể thêm nhà!',
                            text: 'Bạn không thể thêm nhà, hãy nâng cấp tài khoản để được thêm nhà.',
                            confirmButtonText: 'OK',
                            timer: 3500 // Optional timer to automatically close the alert
                        });
                    }
                }
        </script>
    </body>
</html>
