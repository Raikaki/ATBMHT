<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Anime Template">
    <meta name="keywords" content="Anime, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Bill</title>
    <link rel="icon" href="${pageContext.request.contextPath}/anime-main/img/logonweb.png" type="image/png">

    <!-- Google Font -->
    <link
            href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
    <link
            href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;400;500;600;700;800;900&display=swap"
            rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="css/plyr.css" type="text/css">
    <link rel="stylesheet" href="css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="css/ds/style.css" />
    <script src="https://kit.fontawesome.com/9847adceef.js"></script>
</head>
<c:url var="movieDetail" value="/anime-main/MovieDetail" />
<body>

<!-- Page Preloder -->
<div id="preloder">
    <div class="loader"></div>
</div>
<div id="ah_wrapper">
    <!-- Header Section Begin -->
    <c:import url="/anime-main/header.jsp" />
    <!-- Header End -->

    <!-- Product Section Begin -->
    <section class="product spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="trending__product">
                        <div class="row">
                            <div class="col-lg-8 col-md-8 col-sm-8">
                                <div class="section-title">
                                    <h4>Danh sách hóa đơn</h4>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <c:forEach var="bill" items="${user.bills}">
                                <form class="col-lg-3 col-md-6">
                                    <div class="product__item">
                                        <c:url var="urlAvatarMovie"
                                               value="${movie.getFirstAvatar()}" />
                                        <a href="${movieDetail}?idMovie=${movie.id}">
                                            <div class="product__item__pic set-bg" data-setbg="${urlAvatarMovie}">
                                                <div class="ep">${movie.currentEpisode}/${movie.totalEpisode}</div>
                                            </div>
                                        </a>

                                    </div>
                                    <div class="product__item__text">
                                        <ul>
                                            <c:forEach var="genre" items="${movie.genres}">
                                                <li>${genre.description}</li>
                                            </c:forEach>
                                        </ul>
                                        <div class="movie-p">
                                            <h5>
                                                <a href="${movieDetail}?idMovie=${movie.id}">${movie.name}</a>
                                                <i class="fas fa-bars" style="color: white" onclick="showTimePurchased(event)"></i>
                                            </h5>
                                        </div>
                                        <div class="time-purchased" style="display: none;">
                                            <h5>Thời gian mua :</h5>
                                            <h5>${bill.creatAt}</h5>
                                            <h5> Giá đã mua ${movie.purchasePrice}đ</h5>
                                        </div>
                                    </div>
                                </form>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Product Section End -->

    <!-- Footer Section Begin -->
    <c:import url="/anime-main/footer.jsp" />
</div>
<!-- Footer Section End -->

<!-- Search model Begin -->

<!-- Search model end -->

<!-- Js Plugins -->

<script>
    function showTimePurchased(event) {
        var timePurchased = event.target.closest('.product__item__text').querySelector('.time-purchased');
        if (timePurchased.style.display === 'none') {
            timePurchased.style.display = 'block';
        } else {
            timePurchased.style.display = 'none';
        }
    }
</script>

</body>

</html>