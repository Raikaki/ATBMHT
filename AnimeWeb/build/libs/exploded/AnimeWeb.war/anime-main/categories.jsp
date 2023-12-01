<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Anime Template">
    <meta name="keywords" content="Anime, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Anime</title>
    <script>
        window.dataLayer = window.dataLayer || [];

        function gtag() {
            dataLayer.push(arguments);
        }

        gtag('js', new Date());

        gtag('config', 'G-Q5H83WY80P');
    </script>
    <!-- Google Font -->
    <link
            href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
    <link
            href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;400;500;600;700;800;900&display=swap"
            rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Css Styles -->
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="css/plyr.css" type="text/css">
    <link rel="icon" href="${pageContext.request.contextPath}/anime-main/img/logonweb.png" type="image/png">

    <link rel="stylesheet" href="css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="css/ds/style.css"/>
    <script src="https://kit.fontawesome.com/9847adceef.js"></script>
</head>

<body>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app"/>
<c:url var="profileServlet" value="/anime-main/profile.jsp"/>
<c:url var="MovieDetail" value="/anime-main/MovieDetail"/>
<c:url var="urlAvatar"
       value="/anime-main/storage/avatarUser/${sessionScope.user.avatar}"/>
<c:url var="sort" value="/anime-main/genre"/>

<!-- Page Preloder -->
<div id="preloder">
    <div class="loader"></div>
</div>
<div id="ah_wrapper">
    <!-- Header Section Begin -->
    <c:import url="/anime-main/header.jsp"/>
    <!-- Header End -->

    <!-- Breadcrumb Begin -->
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="/AnimeWeb/anime-main/Index"><i class="fa fa-home"></i>
                            <fmt:message>menu.hompage</fmt:message> </a>
                        <a href="#"><fmt:message>menu.categories</fmt:message> </a> <span>${genreDescription}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb End -->

    <!-- Product Section Begin -->
    <section class="product spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <div class="contain">
                        <div class="trending__product" id="list__movie__render">
                            <div class="row">
                                <div class="col-lg-8 col-md-8 col-sm-8">
                                    <div class="section-title">

                                        <h4>
                                            ${genreDescription}
                                        </h4>
                                        <div>
                                            <form class="sort" action="?genre=${idGenre}" method="post">


                                                <label for="filter">Lọc</label><select name="filter"
                                                                                       id="filter">
                                                <option value="isAtoZ">A-Z</option>
                                                <option value="notAtoZ">Z-A</option>
                                                <option value="isDescPrice"><fmt:message>sort.decrease</fmt:message></option>
                                                <option value="notDescPrice"><fmt:message>sort.ascending</fmt:message></option>
                                                <option value="isDescDate"><fmt:message>sort.oldest</fmt:message></option>
                                                <option value="notDescDate"><fmt:message>sort.new</fmt:message></option>

                                            </select>
                                                <select name="type"
                                                        id="type">
                                                    <option value="all"><fmt:message>sort.choose</fmt:message></option>
                                                    <option value="free">Free</option>
                                                    <option value="pay">Pay</option>

                                                </select>
                                                <button type="submit"><fmt:message>sort.sort</fmt:message></button>
                                            </form>

                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="row">
                                <c:if test="${empty requestScope.index}">
                                    <c:set var="offset" scope="page" value="0" />
                                </c:if>
                                <c:forEach var="movie"
                                           items="${requestScope.renderMoviesGenre}">
                                    <div class="col-lg-4 col-md-6 col-sm-6">
                                        <a href="${MovieDetail}?idMovie=${movie.id}">
                                            <div class="product__item">
                                                <c:url var="urlAvatarMovie"
                                                       value="${movie.getFirstAvatar()}" />
                                                <div class="product__item__pic set-bg"
                                                     data-setbg="${urlAvatarMovie}">
                                                    <div class="ep">${movie.currentEpisode}/${movie.totalEpisode}</div>

                                                    <div class="rate">
                                                            ${movie.avgRate} <i class='fa fa-star'
                                                                                style='color: #f3da35'></i>
                                                    </div>
                                                        <%--                                        <div class="comment">--%>
                                                        <%--                                            <i class="fa fa-comments"></i> ${movie.listComment.size()}--%>
                                                        <%--                                        </div>--%>
                                                    <div class="view">
                                                        <i class="fa fa-eye"></i> ${movie.views}
                                                    </div>
                                                    <c:if test="${user ==null}">
                                                        <c:if test="${!movie.isFree()}">
                                                            <a href="${MovieDetail}?idMovie=${movie.id}">


                                                                <div class="price_film">

                                                                    <c:if test="${movie.percent>0.0}">
                                                                        <div class="proloop-price--compare">
                                                                            <del><fmt:formatNumber
                                                                                    value="${movie.oldPrice}"
                                                                                    type="number" pattern="#,##0"/> VND
                                                                            </del>
                                                                        </div>
                                                                        <div class="proloop-price--default">
                                                                            <span class="proloop-price--highlight"> <fmt:formatNumber
                                                                                    value="${movie.renderPrice}"
                                                                                    type="number"
                                                                                    pattern="#,##0"/> VND</span>
                                                                            <span class="proloop-label--on-sale">   ${movie.percent}%</span>
                                                                        </div>


                                                                    </c:if>
                                                                    <c:if test="${movie.percent == 0.0}">
                                                                        <fmt:formatNumber value="${movie.renderPrice}"
                                                                                          type="number"
                                                                                          pattern="#,##0"/> VND
                                                                    </c:if>

                                                                </div>

                                                            </a>
                                                        </c:if>
                                                    </c:if>

                                                    <c:if test="${sessionScope.user !=null }">

                                                        <c:choose>
                                                            <c:when test="${ sessionScope.purchasedIds.contains(movie.id)}">
                                                            </c:when>
                                                            <c:when test="${!movie.isFree()&& !sessionScope.purchasedIds.contains(movie.id)&& movie.percent == 0.0}">
                                                                <div class="price_film">
                                                                    <fmt:formatNumber value="${movie.renderPrice}"
                                                                                      type="number" pattern="#,##0"/> VND
                                                                </div>
                                                            </c:when>
                                                            <c:when test="${!movie.isFree()&& !sessionScope.purchasedIds.contains(movie.id) && movie.percent>0.0}">
                                                                <a href="${MovieDetail}?idMovie=${movie.id}">


                                                                    <div class="price_film">


                                                                        <div class="proloop-price--compare">
                                                                            <del><fmt:formatNumber
                                                                                    value="${movie.oldPrice}"
                                                                                    type="number" pattern="#,##0"/> VND
                                                                            </del>
                                                                        </div>
                                                                        <div class="proloop-price--default">
                                                                            <span class="proloop-price--highlight"> <fmt:formatNumber
                                                                                    value="${movie.renderPrice}"
                                                                                    type="number"
                                                                                    pattern="#,##0"/> VND</span>
                                                                            <span class="proloop-label--on-sale">   ${movie.percent}%</span>
                                                                        </div>
                                                                    </div>

                                                                </a>
                                                            </c:when>
                                                            <c:otherwise>

                                                            </c:otherwise>
                                                        </c:choose>

                                                    </c:if>

                                                </div>
                                                <div class="product__item__text">
                                                    <h5>
                                                        <a href="${MovieDetail}?idMovie=${movie.id}">${movie.name}</a>
                                                    </h5>

                                                </div>
                                            </div>
                                        </a>
                                    </div>
                                </c:forEach>

                            </div>
                        </div>
                    </div>

                    <%--                <div>--%>
                    <%--                    <c:url var="changePage" value=""></c:url>--%>
                    <%--                    <c:forEach var="i" begin="1"--%>
                    <%--                               end="${listMovie.totalPage(listMovie.listMovie)}">--%>
                    <%--                        <form action="${changePage}?type=index&&number=${i}"--%>
                    <%--                              method="post" style="display: inline-block;">--%>


                    <%--                            <c:if test="${i==offset}">--%>
                    <%--                                <button name="pageNumber" type="submit" value="${i}"--%>
                    <%--                                        style="background-color: red;">${i}</button>--%>
                    <%--                            </c:if>--%>

                    <%--                            <c:if test="${i!=offset}">--%>
                    <%--                                <button name="pageNumber" type="submit" value="${i}">${i}</button>--%>
                    <%--                            </c:if>--%>
                    <%--                        </form>--%>

                    <%--                    </c:forEach>--%>
                    <%--                </div>--%>

                </div>
                <c:import url="/anime-main/topview.jsp"/>

                <c:url var="genreMovie" value="/anime-main/genre"/>
                <div class="col-md-6">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-end mb-0">
                            <li class="page-item "><a class="page-link"
                                                              href="${genreMovie}?genre=${idGenre}&&index=${requestScope.index-1}&&filter=${requestScope.param}&&type=${requestScope.type}" tabindex="-1"
                                                              aria-disabled="true">Previous</a></li>
                            <c:forEach var="i" begin="1" end="${requestScope.totalMovie}">
                                <c:if test="${i==requestScope.index+1}">
                                    <li class="page-item active">
                                </c:if>
                                <c:if test="${i!=requestScope.index+1}">
                                    <li class="page-item">
                                </c:if>

                                <a class="page-link"
                                   href="${genreMovie}?genre=${idGenre}&&index=${i-1}&&filter=${requestScope.param}&&type=${requestScope.type}">${i}</a>
                                </li>
                            </c:forEach>

                            <li class="page-item"><a class="page-link"
                                                     href="${genreMovie}?genre=${idGenre}&&index=${requestScope.index+1}&&filter=${requestScope.param}&&type=${requestScope.type}">Next</a></li>
                        </ul>
                    </nav>

                </div>
            </div>
        </div>
    </section>
    <!-- Product Section End -->

    <!-- Footer Section Begin -->
    <c:import url="/anime-main/footer.jsp"/>
</div>

<!-- Footer Section End -->

<!-- Search model Begin -->

<!-- Search model end -->

<!-- Js Plugins -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/player.js"></script>
<%--<script src="js/jquery.nice-select.min.js"></script>--%>
<script src="js/mixitup.min.js"></script>
<script src="js/jquery.slicknav.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>

<script>
    $(document).ready(function () {
        let selectElement = $('#filter');
        let optionElements = selectElement.find('option');
        let selectElement2 = $('#type');
        let optionElements2 = selectElement2.find('option');
        optionElements2.each(function () {
            let optionValue2 = $(this).val();

            if (optionValue2 == "${requestScope.type}") {
                $(this).prop("selected", true);
            }
        });
        optionElements.each(function () {
            let optionValue = $(this).val();

            if (optionValue == "${requestScope.param}") {
                $(this).prop("selected", true);
            }

        });
    })
</script>


</body>

</html>