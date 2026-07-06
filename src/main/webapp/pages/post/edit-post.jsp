<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Trang chủ</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">


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
            .containerm {
                max-width: 600px;
                margin: 0 auto;
                padding: 20px;
            }

            .form-group {
                margin-bottom: 15px;
            }

            label {
                display: block;
                margin-bottom: 5px;
            }

            input[type="text"],
            input[type="date"],
            textarea {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            button {
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            button:hover {
                background-color: #0056b3;
            }

            .error {
                color: red;
                float: left;
                text-align: left;
                width: 100%;
                font-size: 16px !important;
            }
            .bradcam_area {
                padding: 40px 0 102px 0;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <div class="bradcam_area bradcam_bg_1">
                <div class="container">
                    <div class="row">

                    </div>
                </div>
            </div>
            <div class="container containerm">
                <h2>Edit Post</h2>
                <form action="PostServlet?action=editPost" method="post" id="edit">
                    <div class="form-group">
                        <input type="hidden" name="id" value="${post.post_id}">
                    <label for="title">Title:</label>
                    <input type="text" id="title" name="title" value="${post.title}" required>
                    <div class="error" id="title-error"></div>
                </div>
                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="text" id="price" name="price" value="${post.price}" required>
                    <div class="error" id="price-error"></div>
                </div>
                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" id="address" name="address" value="${post.address}" required>
                    <div class="error" id="address-error"></div>
                </div>
                <div class="form-group">
                    <label for="area">Area:</label>
                    <input type="text" id="area" name="area" value="${post.area}" required>
                    <div class="error" id="area-error"></div>
                </div>
                <div class="form-group">
                    <label for="number_room">Number of Rooms:</label>
                    <input type="text" id="number_room" name="number_room" value="${post.number_room}" required>
                    <div class="error" id="number-room-error"></div>
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" required>${post.description}</textarea>
                    <div class="error" id="description-error"></div>
                </div>
<!--                <div class="form-group">
                    <label for="landlord_id">Landlord ID:</label>
                    <input type="text" id="landlord_id" name="landlord_id" value="${post.landlord_id}" required>
                    <div class="error" id="landlord-id-error"></div>
                </div>
                <div class="form-group">
                    <label for="status">Status:</label>
                    <input type="text" id="status" name="status" value="${post.status}" required>
                    <div class="error" id="status-error"></div>
                </div>
                <div class="form-group">
                    <label for="post_date">Post Date:</label>
                    <input type="date" id="post_date" name="post_date" value="${post.post_date}" required>
                    <div class="error" id="post-date-error"></div>
                </div>-->
                <div class="form-group">
                    <label for="location_id">Location ID:</label>
                    <input type="text" id="location_id" name="location_id" value="${post.location_id}" required>
                    <div class="error" id="location-id-error"></div>
                </div>
                <div class="form-group">
                    <button type="submit">Edit</button>
                </div>
            </form>
        </div>

        <jsp:include page="pages/footer/footer.jsp"></jsp:include>


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
        <!--    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
            <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>-->
        <script type="text/javascript">
            $(document).ready(function () {
                $("#edit").validate({
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
    </body>
</html>
