<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            .bradcam_area {
                padding: 40px 0 102px 0;
            }
            .property-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            .property-table th,
            .property-table td {
                border: 1px solid #ddd;
                padding: 12px; /* T?ng padding cho ô */
                text-align: left;
                color: #212529; /* Màu ch? */
            }

            .property-table th {
                background-color: #f2f2f2;
            }

            .property-table tbody tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            .property-table tbody tr:hover {
                background-color: #ddd;
            }

            .add-button {
                margin-bottom: 20px;
            }

            .add-button a.btn {
                background-color: #212529;
                color: #fff;
                text-decoration: none;
                padding: 12px 24px; /* T?ng kích th??c nút */
                border-radius: 5px;
            }

            .add-button a.btn:hover {
                background-color: #343a40;
            }

            .property-table tbody tr td form button.btn-danger {
                background-color: #dc3545;
                color: #fff;
                border: none;
                padding: 10px 20px; /* T?ng kích th??c nút */
                border-radius: 5px;
            }

            .property-table tbody tr td form button.btn-danger:hover {
                background-color: #c82333;
            }

            .property-table tbody tr td a.btn-warning {
                background-color: #ffc107;
                color: #212529;
                text-decoration: none;
                padding: 10px 20px; /* T?ng kích th??c nút */
                border-radius: 5px;
            }

            .property-table tbody tr td a.btn-warning:hover {
                background-color: #e0a800;
            }
            .ro{
                height: 200px;
                overflow: scroll;
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

            <div class="container">

                 
                <h2 style="text-align:center;">List All Posts</h2>
                <table class="property-table">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Title</th>
                            <th>Price</th>
                            <th>Address</th>
                            <th>Area</th>
                            <th>Number of Rooms</th>
                            <th>Description</th>
                            <th>Landlord ID</th>
                            <th>Status</th>
                            <th>Post Date</th>
                            <th>Location ID</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="p" items="${post}">
                        <tr class="ro">
                            <td>${p.post_id}</td>
                            <td>${p.title}</td>
                            <td>${p.price}</td>
                            <td>${p.address}</td>
                            <td>${p.area}</td>
                            <td>${p.number_room}</td>
                            <td>${p.description}</td>
                            <td>${p.landlord_id}</td>
                            <td>${p.status}</td>
                            <td>${p.post_date}</td>
                            <td>${p.location_id}</td>
                            <td>
                                <a href="PostServlet?action=edit-post&id=${p.post_id}" class="btn btn-warning">
                                    <span style="font-weight:bold; font-size:15px; margin-top:5px;">Edit</span>
                                </a> 
                            </td> 
                            <td style="width:10%; padding-top: 18px;">
                                <form action="PostServlet?action=deletePost" method="post">
                                    <input type="hidden" name="action" value="deletePost">
                                    <input type="hidden" name="id" value="${p.post_id}">
                                    <button class="btn btn-danger" type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
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
    </body>
</html>
