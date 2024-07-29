

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    /* Các phần tử trong dropdown menu */
    .dropdown {
        position: relative;
        display: inline-block;
    }

    .dropdown-content {
        display: none;
        position: absolute;
        background-color: #ffffff;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
        z-index: 1;
        border-radius: 10px;
        border: 1px solid #ccc;
        overflow: hidden;
        right: 0; /* Hiển thị menu bên phải của màn hình */
    }

    .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
        transition: background-color 0.3s ease, color 0.3s ease;
    }

    .dropdown-content a:hover {
        background-color: #f1f1f1;
        color: black;
    }

    /* Hiển thị dropdown khi hover */
    .dropdown:hover .dropdown-content {
        display: block;
    }

    /* Avatar styling */
    .avatar img {
        border-radius: 50%;
        width: 50px;
        height: 50px;
        object-fit: cover;
        border: 2px solid #ccc;
    }

</style>
<style>
    .avatar img {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        margin-right: 10px;
    }
    .logoimg{
        border-radius: 50%;
        height: 70px;
        margin-right: 10px;
    }

    .logoall{
        margin-top: 5px;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .text-warning{
        margin-top: 5px;
        text-align: center;
    }
    .dangnhap{
        margin-right: 10px;
    }


    .row .col-lg-3 .Appointment .dropdown-content a {
        color: black;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
        transition: background-color 0.3s ease, color 0.3s ease;
    }

    .dropdown-content a:hover {
        background-color: #f1f1f1;
        color: black; /* Đảm bảo chữ vẫn màu đen khi hover */
    }

    /* Modal */
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.4);
        padding-top: 60px;
    }

    /* Nội dung của modal */
    .modal-content {
        background-color: #fefefe;
        margin: 5% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 400px;
        border-radius: 10px;
    }

    /* Button để đóng modal */
    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        cursor: pointer;
    }

    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
    }

    /* Nút xác nhận và hủy */
    #confirmLogoutBtn,
    #cancelLogoutBtn {
        background-color: #007bff;
        color: #fff;
        border: none;
        padding: 10px 20px;
        margin-right: 10px;
        border-radius: 5px;
        cursor: pointer;
        width: 100px;
    }

    #cancelLogoutBtn {
        background-color: #6c757d;
    }

    #navigation{
        min-width: 830px;
        padding-right: 30px;
        font-size: 30px;
        margin-left: 50px
    }


</style>

<header>
    <div class="header-area ">
        <div id="sticky-header" class="main-header-area">
            <div class="container-fluid ">
                <div class="header_bottom_border">
                    <div class="row align-items-center">
                        <div class=" col-md-3 col-lg-2">
                            <div class="logoall">

                                <a href="/HFManagementSystem/home">
                                    <img class="logoimg" src="${pageContext.request.contextPath}/img/logo1.png" alt="">
                                </a>
                                <a style="font-size: 30px" href="/HFManagementSystem/home">
                                    <span class="text-warning">House</span>Finder
                                </a>
                            </div>
                        </div>
                        <div class=" col-lg-7 col-md-7">
                            <div class="main-menu  d-none d-lg-block">
                                <nav>
                                    <ul id="navigation"  >
                                        <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
                                        <li><a href="${pageContext.request.contextPath}/view_house">Thuê nhà</a></li>
                                        <li><a href="/HFManagementSystem/view-report">Liên hệ và báo cáo</a></li>
                                        <li><a href="/HFManagementSystem/pages/profile/introduction.jsp">Giới thiệu</a></li>
                                
                                        <c:if test="${sessionScope.user.roleId == 1}">
                                        <li><a href="/HFManagementSystem/dashboard">Quản lý</a></li>
                                        </c:if>
                                        <c:if test="${not empty sessionScope.user and sessionScope.user.roleId == 2}">
                                        <li><a href="/HFManagementSystem/view_landrord">Nhà </a></li>
                                        <li><a href="/HFManagementSystem/Booking?service=ViewRequestBooking">Yêu cầu thuê</a></li>
                                        </c:if>
                                        <c:if test="${not empty sessionScope.user and sessionScope.user.roleId == 3}">
                                        <li><a href="/HFManagementSystem/Booking?service=ViewListOrderHistory">Yêu cầu thuê</a></li>
                                        </c:if>


                                </ul>
                            </nav>
                            </div>
                        </div>
                        <div class="col-lg-3 d-none d-lg-block col-md-2">
                            <div class="Appointment">
                                <c:choose>
                                    <c:when test="${sessionScope.user != null}">
                                        <div class="phone_num d-none d-xl-block avatar dropdown">
                                            <a href="#">
                                                <c:choose>
                                                    <c:when test="${sessionScope.user.hashed_password == null}">
                                                        <img src="${sessionScope.user.avatarUrl}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="/HFManagementSystem/img/avatar/${sessionScope.user.avatarUrl}">
                                                    </c:otherwise>    
                                                </c:choose>
                                            </a>
                                            <div class="dropdown-content">                                               
                                          
                                            <c:if test="${not empty sessionScope.user and sessionScope.user.roleId == 1}">
                                                <a href="/HFManagementSystem/Profile">Thông tin cá nhân</a>
                                                <a href="/HFManagementSystem/change">Đổi mật khẩu</a>
                                                <a id="openModalBtn" href="#">Đăng xuất</a>
                                            </c:if>
                                            <c:if test="${not empty sessionScope.user and sessionScope.user.roleId == 2}">
                                                <a href="/HFManagementSystem/upgrade">Nâng cấp tài khoản</a>
                                                <a href="Profile">Thông tin cá nhân</a>
                                                <a href="/HFManagementSystem/history-report">Lịch sử Báo cáo</a>
                                                <a href="/HFManagementSystem/historytransaction">Lịch sử Giao dịch</a>
                                                <a href="/HFManagementSystem/change">Đổi mật khẩu</a>
                                                <a id="openModalBtn" href="#">Đăng xuất</a>
                                            </c:if>
                                            <c:if test="${not empty sessionScope.user and sessionScope.user.roleId == 3}">
                                                <a href="Profile">Thông tin cá nhân</a>
                                                <a href="/HFManagementSystem/history-report">Lịch sử Báo cáo</a>
                                                <a href="/HFManagementSystem/historyorder">Lịch sử Đặt phòng</a>
                                                <a href="/HFManagementSystem/favorite">Yêu thích</a>
                                                <a href="/HFManagementSystem/listBlogPosts">Blog</a>
                                                <a href="/HFManagementSystem/change">Đổi mật khẩu</a>
                                                <a id="openModalBtn" href="#">Đăng xuất</a>
                                            </c:if>

                                        </div>
                                    </div>
                                    <!--<div class="d-none d-lg-block">
                                            <a class="boxed-btn3" href="add-post.jsp">Đăng Bài</a>
                                        </div>   -->
                                    <!--                                        <div class="d-none d-lg-block">
                                                                                <a id="openModalBtn" class="boxed-btn3" href="#">Đăng xuất</a>   /HFManagementSystem/logout
                                                                            </div>-->
                                </c:when>
                                <c:otherwise>
                                    <div class="dangnhap d-none d-lg-block">
                                        <a class="boxed-btn3" href="/HFManagementSystem/pages/system/login.jsp">Đăng nhập</a>
                                    </div>
                                    <div class="d-none d-lg-block">
                                        <a class="boxed-btn3" href="/HFManagementSystem/pages/system/register.jsp">Đăng Ký</a>
                                    </div>
                                </c:otherwise>
                            </c:choose>


                        </div>
                    </div>
                    <div class="col-12">
                        <div class="mobile_menu d-block d-lg-none"></div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
</header>

<div id="logoutModal" class="modal">
    <div class="modal-content">
        <span class="close d-flex flex-column align-items-end mb-2" id="closeModal">&times;</span>
        <p class="confirm-text d-flex flex-column align-items-start mb-4">Bạn chắc chắn muốn đăng xuất?</p>
        <div class="d-flex flex-column align-items-end">
            <div class="row">
                <button id="confirmLogoutBtn" class="btn btn-sm"><a class="text-white" href="/HFManagementSystem/logout">Xác
                        Nhận</a></button>
                <button id="cancelLogoutBtn" class="btn btn-sm">Hủy </button>
            </div>
        </div>
    </div>
</div>

<script>
    // Lấy tham chiếu tới modal và button mở modal
    var modal = document.getElementById("logoutModal");
    var openModalBtn = document.getElementById("openModalBtn");
    var closeModalBtn = document.getElementById("closeModal");

    // Khi người dùng nhấp vào nút mở modal, hiển thị modal
    openModalBtn.onclick = function () {
        modal.style.display = "block";
    };

    // Khi người dùng nhấp vào nút đóng hoặc bất kỳ đâu bên ngoài modal, đóng modal
    window.onclick = function (event) {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    };

    // Khi người dùng nhấp vào nút đóng modal, đóng modal
    closeModalBtn.onclick = function () {
        modal.style.display = "none";
    };

    // Khi người dùng nhấp vào nút xác nhận đăng xuất, thực hiện hành động đăng xuất và đóng modal
    var confirmLogoutBtn = document.getElementById("confirmLogoutBtn");
    confirmLogoutBtn.onclick = function () {
        modal.style.display = "none";
    };

    // Khi người dùng nhấp vào nút hủy, đóng modal
    var cancelLogoutBtn = document.getElementById("cancelLogoutBtn");
    cancelLogoutBtn.onclick = function () {
        modal.style.display = "none";
    };
</script>
