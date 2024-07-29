<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Thêm Phòng</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                padding: 20px;
                margin-top: 150px;
            }
            .container {
                max-width: 800px;
                margin: auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
                text-align: center;
                color: #333;
            }
            label {
                display: block;
                margin-top: 10px;
                font-weight: bold;
                color: #555;
            }
            input[type="text"], textarea {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            input[type="file"] {
                margin-top: 10px;
            }
            .image-preview {
                display: flex;
                flex-wrap: wrap;
                margin-top: 10px;
            }
            .image-preview div {
                position: relative;
                margin-right: 10px;
                margin-bottom: 10px;
            }
            .image-preview img {
                width: 100px;
                height: 100px;
                object-fit: cover;
                border-radius: 4px;
            }
            .image-preview .remove-image {
                position: absolute;
                top: 5px;
                right: 5px;
                background: rgba(0, 0, 0, 0.5);
                color: #fff;
                border: none;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
            }
            .btn-submit {
                width: 100%;
                padding: 10px;
                margin-top: 20px;
                background-color: #28a745;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
            }
            .btn-submit:hover {
                background-color: #218838;
            }
            .error-message {
                color: red;
                font-size: 12px;
                margin-top: 5px;
            }

        </style>
    </head>
    <body>
        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <div class="container">
                <h1>Thêm Phòng</h1>
                <form id="addRoomForm" enctype="multipart/form-data">

                    <input hidden="" type="text" id="house_id" name="house_id" value="${house_id}" required>
                <input hidden="" type="text" id="house_id" name="house_id" value="${roomid}" required>

                <label for="room_number">Room Number:</label>
                <input type="number" id="room_number" name="room_number" required>
                <div class="error-message" id="error-room_number"></div>


                <label for="price">Price:</label>
                <input type="text" min="100000" max="1000000000" step="100000" id="price" name="price" required>
                <div class="error-message" id="error-price"></div>

                <label for="area">Area:</label>
                <input type="text" min="0.1" max="100" step="0.1" id="area" name="area" required>
                <div class="error-message" id="error-area"></div>

                <label for="description_room">Description:</label>
                <textarea id="description_room" name="description_room" required></textarea>
                <div class="error-message" id="error-description_room"></div>

                <label for="status">Status:</label>
                <input type="text" id="status" name="status" required>
                <div class="error-message" id="error-status"></div>

                <!--            <label for="room_images">Upload Room Images:</label>
                            <input type="file" id="room_images" name="room_images[]" multiple accept="image/*">
                            <div class="image-preview" id="imagePreview"></div>-->

                <input type="submit" value="Add Room" class="btn-submit">
            </form>
        </div>




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
        <script>
            // Hàm kiểm tra dữ liệu form
            function validateForm() {
                let isValid = true;

                // Xóa thông báo lỗi trước đó
                document.getElementById('houseIdError').innerText = '';

                document.getElementById('roomNumberError').innerText = '';
                document.getElementById('floorNumberError').innerText = '';
                document.getElementById('statusError').innerText = '';
                document.getElementById('descriptionRoomError').innerText = '';
                document.getElementById('priceError').innerText = '';
                document.getElementById('areaError').innerText = '';
                //        document.getElementById('createDateError').innerText = '';

                // Lấy giá trị các trường
                const houseId = document.getElementById('house_id').value;
                const roomNumber = document.getElementById('room_number').value;
                const floorNumber = document.getElementById('floor_number').value;
                const status = document.getElementById('status').value;
                const descriptionRoom = document.getElementById('description_room').value;
                const price = document.getElementById('price').value;
                const area = document.getElementById('area').value;
                //        const createDate = document.getElementById('create_date').value;

                // Kiểm tra ID Nhà
                if (houseId === '') {
                    document.getElementById('houseIdError').innerText = 'ID Nhà là bắt buộc.';
                    isValid = false;
                }



                // Kiểm tra Số Phòng
                if (roomNumber === '' || isNaN(roomNumber) || !Number.isInteger(Number(roomNumber))) {
                    document.getElementById('roomNumberError').innerText = 'Số Phòng là một số nguyên';
                    isValid = false;

                }
                //        else if (roomNumber.length > 255) {
                //            document.getElementById('roomNumberError').innerText = 'Số Phòng không được vượt quá 255 ký tự.';
                //            isValid = false;
                //        }

                // Kiểm tra Số Tầng
                if (floorNumber === '') {
                    document.getElementById('floorNumberError').innerText = 'Số Tầng là bắt buộc.';
                    isValid = false;
                } else if (floorNumber.length > 255) {
                    document.getElementById('floorNumberError').innerText = 'Số Tầng không được vượt quá 255 ký tự.';
                    isValid = false;
                }

                // Kiểm tra Trạng Thái
                if (status === '') {
                    document.getElementById('statusError').innerText = 'Trạng thái là bắt buộc.';
                    isValid = false;
                } else if (status.length > 255) {
                    document.getElementById('statusError').innerText = 'Trạng thái không được vượt quá 255 ký tự.';
                    isValid = false;
                }

                // Kiểm tra Mô Tả
                if (descriptionRoom === '') {
                    document.getElementById('descriptionRoomError').innerText = 'Mô tả là bắt buộc.';
                    isValid = false;
                } else if (descriptionRoom.length > 255) {
                    document.getElementById('descriptionRoomError').innerText = 'Mô tả không được vượt quá 255 ký tự.';
                    isValid = false;
                }

                // Kiểm tra Giá
                if (price === '') {
                    document.getElementById('priceError').innerText = 'Giá là bắt buộc.';
                    isValid = false;
                }

                // Kiểm tra Diện Tích
                if (area === '') {
                    document.getElementById('areaError').innerText = 'Diện tích là bắt buộc.';
                    isValid = false;
                }

                //        // Kiểm tra Ngày Tạo
                //        if (createDate === '') {
                //            document.getElementById('createDateError').innerText = 'Ngày tạo là bắt buộc.';
                //            isValid = false;
                //        }

                return isValid;
            }
        </script>
    </body>
</html>
