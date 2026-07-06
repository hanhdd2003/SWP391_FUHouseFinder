<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
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
        <!-- <link rel="stylesheet" href="css/responsive.css"> -->
        <style>
            .bradcam_area {
                padding: 40px 0 102px 0;
                height: 40px;
            }
            .maincontainer{
                margin-top: 30px;
                width: 50%;
                margin-bottom: 40px;
            }
            h2{
                text-align: center;
                color: #009DFF;
            }
            .tieude{
                color: #003eff;
            }
            .img-thumbnail {
                display: inline-block;
                margin: 5px; /* Khoảng cách giữa các hình ảnh */
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

            <div class="container maincontainer">
                <h2>Thêm Thông Tin Trọ Mới</h2>
                <form action="PostServlet?action=addPost" method="post" id="add" class="needs-validation" enctype="multipart/form-data" novalidate>
                    <div class="form-group">
                        <label for="title" class="tieude">Tiêu đề:</label>
                        <input type="text" class="form-control" id="title" name="title" required>
                        <div class="invalid-feedback">Nhập tiêu đề bài viết.</div>
                    </div>
                    <div class="form-group">
                        <label for="price"  class="tieude">Giá:</label>
                        <input type="text" class="form-control" id="price" name="price" required>
                        <div class="invalid-feedback">Nhập giá của phòng.</div>
                    </div>
                    <div class="form-group">
                        <label for="address"  class="tieude">Địa chỉ:</label>
                        <input type="text" class="form-control" id="address" name="address" required>
                        <div class="invalid-feedback">Nhập địa chỉ nhà trọ.</div>
                    </div>
                    <div class="form-group">
                        <label for="area"  class="tieude">Diện tích:</label>
                        <input type="text" class="form-control" id="area" name="area" required>
                        <div class="invalid-feedback">Nhập diện tích phòng.</div>
                    </div>
                    <div class="form-group">
                        <label for="number_room"  class="tieude">Số lượng phòng cho thuê:</label>
                        <input type="text" class="form-control" id="number_room" name="number_room" required>
                        <div class="invalid-feedback">Nhập số lượng phòng muốn cho thuê.</div>
                    </div>
                    <div class="form-group">
                        <label for="description"  class="tieude">Mô tả:</label>
                        <textarea class="form-control" id="description" name="description"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="location_id"  class="tieude">Khu vực:</label>
                        <input type="text" class="form-control" id="location_id" name="location_id" required>
                        <div class="invalid-feedback">Nhập ID khu vực.</div>
                    </div>
                    <div>
                        <label for="image"  class="tieude">Ảnh:</label>
                        <input type="file" class="form-control" id="image" name="image" multiple onchange="ImagesFileAsURL()"  required>
                        <div id='displayImg'>

                        </div>
                    </div>
                    <br/>
                    <div class="form-group text-center">
                        <button type="submit" class="btn btn-primary">Thêm</button>
                    </div>
                </form>

                <!--                <form action="PostServlet?action=addPost" method="post" id="add">
                                    <div class="form-group">
                                        <label for="title">Title:</label>
                                        <input type="text" id="title" name="title" required>
                                        <div class="error" id="title-error"></div>
                                    </div>
                                    <div class="form-group">
                                        <label for="price">Price:</label>
                                        <input type="text" id="price" name="price" required>
                                        <div class="error" id="price-error"></div>
                                    </div>
                                    <div class="form-group">
                                        <label for="address">Address:</label>
                                        <input type="text" id="address" name="address" required>
                                        <div class="error" id="address-error"></div>
                                    </div>
                                    <div class="form-group">
                                        <label for="area">Area:</label>
                                        <input type="text" id="area" name="area" required>
                                        <div class="error" id="area-error"></div>
                                    </div>
                                    <div class="form-group">
                                        <label for="number_room">Number of Rooms:</label>
                                        <input type="text" id="number_room" name="number_room" required>
                                        <div class="error" id="number-room-error"></div>
                                    </div>
                                    <div class="form-group">
                                        <label for="description">Description:</label>
                                        <textarea id="description" name="description"></textarea>
                                        <div class="error" id="description-error"></div>
                                    </div>
                                    <div class="form-group">
                                        <label for="landlord_id">Landlord ID:</label>
                                        <input type="text" id="landlord_id" name="landlord_id" required>
                                        <div class="error" id="landlord-id-error"></div>
                                    </div>
                                    <div class="form-group">
                                        <label for="status">Status:</label>
                                        <input type="text" id="status" name="status" required>
                                        <div class="error" id="status-error"></div>
                                    </div>
                                    <div class="form-group">
                                        <label for="post_date">Post Date:</label>
                                        <input type="date" id="post_date" name="post_date" required>
                                        <div class="error" id="post-date-error"></div>
                                    </div>
                                    <div class="form-group">
                                        <label for="location_id">Location ID:</label>
                                        <input type="text" id="location_id" name="location_id" required>
                                        <div class="error" id="location-id-error"></div>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit">Add</button>
                                    </div>
                                </form>-->
            </div>

            <!--================ Blog Area end =================-->

            <!-- footer start -->
        <jsp:include page="pages/footer/footer.jsp"></jsp:include>
        <!--/ footer end  -->


        <!-- JS here -->
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
        <script type="text/javascript">
                            $(document).ready(function () {
                                $("#add").validate({
                                    rules: {
                                        title: {
                                            maxlength: 100,
                                            minlength: 1,
                                            required: true
                                        },
                                        price: {
                                            number: true,
                                            required: true
                                        },
                                        address: {
                                            maxlength: 100,
                                            minlength: 1,
                                            required: true
                                        },
                                        area: {
                                            required: true
                                        },
                                        number_room: {
                                            number: true,
                                            required: true
                                        },
                                        description: {
                                            required: true
                                        },
                                        landlord_id: {
                                            required: true
                                        },
                                        status: {
                                            required: true
                                        },
                                        post_date: {
                                            required: true
                                        },
                                        location_id: {
                                            required: true
                                        }
                                    },
                                    messages: {
                                        title: {
                                            required: "Please enter a title.",
                                            minlength: "Title must be at least 1 character.",
                                            maxlength: "Title must be at most 100 characters."
                                        },
                                        price: {
                                            required: "Please enter a price.",
                                            number: "Please enter a valid number."
                                        },
                                        address: {
                                            required: "Please enter an address.",
                                            minlength: "Address must be at least 1 character.",
                                            maxlength: "Address must be at most 100 characters."
                                        },
                                        area: {
                                            required: "Please enter an area."
                                        },
                                        number_room: {
                                            required: "Please enter the number of rooms.",
                                            number: "Please enter a valid number."
                                        },
                                        description: {
                                            required: "Please enter a description."
                                        },
                                        landlord_id: {
                                            required: "Please enter a landlord ID."
                                        },
                                        status: {
                                            required: "Please enter a status."
                                        },
                                        post_date: {
                                            required: "Please select a post date."
                                        },
                                        location_id: {
                                            required: "Please enter a location ID."
                                        }
                                    }
                                });
                            });
        </script>
        <script type="text/javascript">
            function ImagesFileAsURL() {
                var fileSelected = document.getElementById('image').files;
                if (fileSelected.length > 0) {
                    for (var i = 0; i < fileSelected.length; i++) {
                        var fileToLoad = fileSelected[i];
                        var fileReader = new FileReader();
                        fileReader.onload = function (fileLoaderEvent) {
                            var srcData = fileLoaderEvent.target.result;
                            var newImage = document.createElement('img');
                            newImage.src = srcData;
                            newImage.className = 'img-thumbnail'; // Thêm class để hình ảnh trở thành ảnh thu gọn
                            newImage.style.maxWidth = '100px'; // Đặt kích thước tối đa cho ảnh
                            newImage.style.maxHeight = '100px'; // Đặt kích thước tối đa cho ảnh
                            document.getElementById('displayImg').appendChild(newImage); // Thêm hình ảnh vào phần hiển thị
                        };
                        fileReader.readAsDataURL(fileToLoad);
                    }
                }
            }

        </script>
    </body>

</html>