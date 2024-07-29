<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách Blog</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.png">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }
            main {
                padding: 2em;
                max-width: 800px;
                margin: auto;
            }
            .bradcam_area {
                padding: 20px 0 102px 0;
            }
            .blog-post {
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            .blog-post h2 {
                margin-top: 0;
                color: #333;
            }
            .blog-post .date {
                color: #999;
                font-size: 0.9em;
            }
            .header-container {
                display: flex;
                justify-content: flex-end;
                margin-bottom: 20px;
            }
            .write-blog button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
            }
            .write-blog button:hover {
                background-color: #0056b3;
            }
            .sort-container {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                margin-bottom: 20px;
                gap: 10px;
            }
            .sort-container select, .sort-container input {
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .pagination {
                text-align: center;
                margin-top: 20px;
            }
            .pagination a {
                margin: 0 5px;
                padding: 8px 16px;
                text-decoration: none;
                color: #007bff;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            .pagination a:hover {
                background-color: #007bff;
                color: #fff;
            }
            .result{
                min-height: 500px
            }
        </style>
    </head>
    <body>
        <jsp:include page="/pages/header/header.jsp"></jsp:include>
            <div class="bradcam_area bradcam_bg_1"></div>
             
            <div class="container result">
                <div style="margin-top: 50px" class="header-container">
                    <div class="write-blog">
                        <a href="/HFManagementSystem/AddBlogPost">
                            <button>VIẾT BÀI ĐĂNG BLOG MỚI</button>
                        </a>
                    </div>
                </div>
                <div class="sort-container">
                    <select id="sortSelect" onchange="sortPosts()">
                        <option value="newest" ${sort == 'newest' ? 'selected' : ''}>Mới nhất</option>
                    <option value="oldest" ${sort == 'oldest' ? 'selected' : ''}>Cũ nhất</option>
                </select>
                <input type="text" id="searchInput" placeholder="Tìm kiếm..." onkeyup="searchPosts()">
            </div>
            <div id="blogList">
                <c:forEach var="post" items="${blogPosts}">
                    <div class="blog-post">
                        <h2>${post.title}</h2>
                        <p class="date">
                            Được xuất bản: ${post.publishDate} bởi Người ẩn danh
                        </p>
                        <p>${post.content}</p>
                    </div>
                </c:forEach>
            </div>
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="listBlogPosts?page=${currentPage - 1}&sort=${sort}">Previous</a>
                </c:if>
                <c:if test="${currentPage < totalPages}">
                    <a href="listBlogPosts?page=${currentPage + 1}&sort=${sort}">Next</a>
                </c:if>
            </div>
        </div>
        <script>
            function sortPosts() {
                const sort = document.getElementById('sortSelect').value;
                window.location.href = `listBlogPosts?page=1&sort=${sort}`;
            }

            function searchPosts() {
                const searchInput = document.getElementById('searchInput').value.toLowerCase();
                const blogPosts = document.querySelectorAll('.blog-post');
                blogPosts.forEach(post => {
                    const title = post.querySelector('h2').textContent.toLowerCase();
                    if (title.includes(searchInput)) {
                        post.style.display = '';
                    } else {
                        post.style.display = 'none';
                    }
                });
            }
        </script>
        <jsp:include page="/pages/footer/footer.jsp"></jsp:include>
<!--        <script src="${pageContext.request.contextPath}/js/vendor/modernizr-3.5.0.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/vendor/jquery-1.12.4.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/popper.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/owl.carousel.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/isotope.pkgd.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/ajax-form.js"></script>
        <script src="${pageContext.request.contextPath}/js/waypoints.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.counterup.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/imagesloaded.pkgd.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/scrollIt.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.scrollUp.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/wow.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/nice-select.min.js"></script>-->
<!--        <script src="${pageContext.request.contextPath}/js/jquery.slicknav.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.magnific-popup.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/plugins.js"></script>
        <script src="${pageContext.request.contextPath}/js/gijgo.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/contact.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.ajaxchimp.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/mail-script.js"></script>
        <script src="${pageContext.request.contextPath}/js/main.js"></script>-->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css"> 
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css"> 
        <script>
            window.onload = function () {
                var alertMessage = '<%= session.getAttribute("alertMessage") != null ? session.getAttribute("alertMessage") : ""%>';
                var alertType = '<%= session.getAttribute("alertType") != null ? session.getAttribute("alertType") : ""%>';
                if (alertMessage && alertType) {
                    Swal.fire({
                        icon: alertType,
                        title: alertMessage,
                        showConfirmButton: false,
                        timer: 2000
                    });
            <%
                        session.removeAttribute("alertMessage");
                        session.removeAttribute("alertType");
            %>
                }
            };
        </script>
    </body>
</html>
