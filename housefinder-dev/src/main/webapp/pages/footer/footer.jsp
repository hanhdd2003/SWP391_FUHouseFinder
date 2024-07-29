

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

<style>
    .logo{
        border-radius: 50%;
        height: 100px;
    }
</style>
<footer class="footer">
    <div class="footer_top">
        <div class="container">
            <div class="row">
                <div class="footer_logo col-xl-2 col-md-2 col-lg-2">
                    <a href="#">
                        <img class="logo" src="${pageContext.request.contextPath}/img/logo1.png" alt="">
                    </a>
                </div>
                <div class="col-xl-3 col-md-6 col-lg-3">
                    <div class="footer_widget wow fadeInUp" data-wow-duration="1s" data-wow-delay=".3s">

                        <h3 class="footer_title">
                            LIÊN LẠC
                        </h3>
                        <p class="mb-4">Nơi tốt nhất dành cho những người đang tìm kiếm nhà trọ gần khu vực trường Đại học FPT.
                            Chúng tôi cung cấp dữ liệu tin rao lớn với đa dạng loại hình nhà trọ giúp bạn có những
                            lựa chọn phù hợp với nhu cầu của mình.</p>
                        <p class="mb-2"><i class="fas fa-map-marker-alt text-primary mr-3"></i>Thạch Thất - Hà Nội</p>
                        <p class="mb-2"><i class="fa fa-envelope text-primary mr-3"></i>fuhousefinder@gmail.com</p>
                        <p class="mb-0"><i class="fas fa-phone text-primary mr-3"></i>+84 39999 3155</p>

                        <div class="socail_links">
                            <ul>
                                <li>
                                    <a href="#" target="_blank">
                                        <i class="fab fa-facebook-f"></i> <!-- Icon Facebook -->
                                    </a>
                                </li>
                                <li>
                                    <a href="#" target="_blank">
                                        <i class="fab fa-instagram"></i> <!-- Icon Instagram -->
                                    </a>
                                </li>
                                <li>
                                    <a href="#" target="_blank">
                                        <i class="fab fa-twitter"></i> <!-- Icon Twitter -->
                                    </a>
                                </li>
                                <li>
                                    <a href="#" target="_blank">
                                        <i class="fab fa-google-plus-g"></i> <!-- Icon Google -->
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                    
                <div class="col-xl-2 col-md-2 col-lg-2">
                    <div class="footer_widget wow fadeInUp footer_title" data-wow-duration="1.1s" data-wow-delay=".4s">

                        <ul>
                            <li><a href="#"><i class="fa fa-angle-right mr-2"></i>Trang Chủ </a></li>
                            <li><a href="#"><i class="fa fa-angle-right mr-2"></i>Thuê Nhà</a></li>
                            <li><a href="#"><i class="fa fa-angle-right mr-2"></i>Liên Hệ</a></li>
                            <li><a href="#"><i class="fa fa-angle-right mr-2"></i>Nâng Cấp Tài Khoản</a></li>
                        </ul>

                    </div>
                </div>
                <div class="col-xl-4 col-md-5 col-lg-4">
                    <div class="footer_widget wow fadeInUp" data-wow-duration="1.3s" data-wow-delay=".6s">
                        <h3 class="footer_title text-uppercase mb-4">
                            Lời nhắn
                        </h3>

                        <form action="#" class="newsletter_form">
                            <input type="text" placeholder="Lời nhắn ...">
                            <button type="submit">Gửi</button>
                        </form>
                        <p class="newsletter_text">Cảm ơn các bạn đã góp ý. Mỗi lời góp ý của các bạn sẽ là bài học lớn cho chúng tôi phát triển thêm.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="copy-right_text wow fadeInUp" data-wow-duration="1.4s" data-wow-delay=".3s">
        <div class="container">
            <div class="footer_border"></div>
            <div class="row">
                <div class="col-xl-12">
                    <p class="copy_right text-center">
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        Copyright &copy;
                        <script>document.write(new Date().getFullYear());</script> All rights reserved <i class="fa fa-heart-o" aria-hidden="true"></i> by <a
                            href="#" target="_blank">TEAM 2 SE1841</a>
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    </p>
                </div>
            </div>
        </div>
    </div>
</footer>
