<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/anime-main/img/logonweb.png" type="image/png">


    <meta charset="UTF-8">
    <meta name="description" content="Anime Template">
    <meta name="keywords" content="Anime, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Anime|Check-Out</title>
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
    <%--    <link rel="stylesheet" href="css/nice-select.css" type="text/css">--%>
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="css/ds/style.css"/>
    <script src="https://kit.fontawesome.com/9847adceef.js"></script>
    <fmt:setLocale value="${sessionScope.LANG}"/>
    <fmt:setBundle basename="app"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

</head>
<body>
<fmt:setLocale value="${sessionScope.LANG}"/>
<c:url var="profileServlet" value="/anime-main/profile.jsp"/>
<c:url var="MovieDetail" value="/anime-main/MovieDetail"/>
<c:url var="Index" value="/anime-main/Index"/>
<c:url var="check" value="/anime-main/checkout" />
<div id="ah_wrapper">
    <header class="checkout__detail">

        <h2>Hóa đơn bán hàng</h2>
        <div>(Hóa đơn điện tử)</div>
        <div>Ngày ${day}, Tháng ${month}, Năm ${year}</div>
        <br>
        <div class="information">
            <div class="header__logo">
                <img src="img/logo.png" alt="">
            </div>
            <br>
            <div>Mã số thuế: 02343253</div>
            <div>Mã hóa đơn: ${number}</div>
            <div>Họ tên khách hàng: ${user.fullName}</div>
        </div>

    </header>
    <section class="product spad">
        <div class="container">

            <div class="row">
                <div class="col-lg-8">
                    <div class="trending__product">
                        <div class="row">
                            <div class="col-lg-8 col-md-8 col-sm-8">
                                <div class="section-title">

                                    <h4>
                                        Check Out | Detail
                                    </h4>

                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="table_film">
                                <table>

                                    <tr>
                                        <th>Avatar</th>
                                        <th>Name</th>
                                        <th>Movie genre</th>
                                        <th>Producer</th>
                                        <th>Price</th>
                                    </tr>
                                </table>
                                <div class="table__film_detail">
                                <table>
                                    <c:forEach var="movie" items="${sessionScope.order.getSelectedMovies()}">
                                        <tr>
                                            <td><img src=${movie.getFirstAvatar()} alt=${movie.getFirstAvatar()}
                                                     width="100"
                                                     height="150"></td>
                                            <td>${movie.name}</td>
                                            <td>

                                                <c:forEach var="genre" items="${movie.genres}">
                                                    <div>${genre.description}</div>
                                                </c:forEach>
                                            </td>
                                            <td>
                                                <c:forEach var="producer" items="${movie.listProducer}">
                                                    <div>${producer.name}</div>
                                                </c:forEach>
                                            </td>
                                            <td>${movie.getRenderPrice()} VND</td>
                                        </tr>
                                    </c:forEach>
                                </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="payment">
                    <div class="bill">
                        <div>Total : ${order.selectedMovies.size()}</div>
                        <div class="name_film_buy">
                            <c:forEach var="movie" items="${sessionScope.order.getSelectedMovies()}">
                                <div>
                                   <p>Name: ${movie.name}   <br> Price: ${movie.getRenderPrice()} VND</p>

                                </div>
                            </c:forEach>
                        </div>
                        <div class="price_total">
                            <div>
                                Total Price: ${sessionScope.order.totalPrice} VND
                            </div>
                        </div>

                    </div>
                    <a href="${check}?action=checkout">
                        <button id="buyMovie" >Pay</button>
                    </a>
                    <a href="${check}?action=back">
                        <button id="buyMovie">Back</button>
                    </a>
                </div>
                <div class="col-md-6">

                </div>
            </div>
        </div>
    </section>
    <c:if test="${empty sessionScope.done}">

        <c:choose>
            <c:when test="${success ==true}">
                <script>

                    Swal.fire({
                        title: 'Thanh toán thành công' ,

                        icon: 'success',
                        confirmButtonText: 'OK'
                    }).then((result) => {
                        window.location.href = "${pageContext.request.contextPath}/anime-main/wishList";
                    });
                </script>
            </c:when>
            <c:when test="${success ==false}">
                <script>
                    Swal.fire({
                        title: 'Thanh toán thất bại' ,
                        icon: 'error',
                        confirmButtonText: 'OK'
                    }).then((result) => {
                        window.location.href = "${pageContext.request.contextPath}/anime-main/wishList";
                    });
                </script>
            </c:when>
        </c:choose>

    </c:if>
    <c:import url="/anime-main/footer.jsp"/>
</div>
<script>

</script>
</body>

</html>
