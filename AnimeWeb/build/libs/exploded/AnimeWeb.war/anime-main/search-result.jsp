<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
  <meta charset="UTF-8">
  <meta name="description" content="Anime">
  <meta name="keywords" content="Anime, unica, creative, html">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Anime</title>
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
  <link rel="stylesheet" type="text/css" href="css/ds/style.css" />
  <script src="https://kit.fontawesome.com/9847adceef.js"></script>

  <fmt:setLocale value="${sessionScope.LANG}" />
  <fmt:setBundle basename="app" />
</head>

<body>

<fmt:setLocale value="${sessionScope.LANG}" />
<c:url var="profileServlet" value="/anime-main/profile.jsp" />
<c:url var="MovieDetail" value="/anime-main/MovieDetail" />
<c:url var="Index" value="/anime-main/Index"/>
<!-- Page Preloder -->
<div id="preloder">
  <div class="loader"></div>
</div>
<div id="ah_wrapper">
  <!-- Header Section Begin -->
  <c:import url="/anime-main/header.jsp" />
  <!-- Header End -->

  <!-- Hero Section Begin -->
  <!-- Hero Section End -->

  <!-- Product Section Begin -->
  <section class="product spad">
    <div class="container">

      <div class="row">
        <div class="col-lg-8">
          <div class="trending__product">
            <div class="row">
              <div class="col-lg-8 col-md-8 col-sm-8">
                <div class="section-title">

                  <h4>

<%--                    <fmt:message>content.listnewanime</fmt:message>--%>
                  </h4>
                  <form action="${Index}" method="post">


                    <label for="filter">Lọc</label><select name="filter" onchange="this.form.submit()" id="filter">
                    <option value="isAtoZ">A-Z</option>
                    <option value="notAtoZ">Z-A</option>
                    <option value="isDescPrice">Giá giảm dần</option>
                    <option value="notDescPrice">Giá tăng dần</option>
                    <option value="isDescDate">Cũ nhất</option>
                    <option value="notDescDate">Mới thêm</option>
                  </select>
                  </form>
                </div>
              </div>

            </div>
            <div class="row">
<%--              <c:if test="${empty requestScope.index}">--%>
<%--                <c:set var="offset" scope="page" value="0" />--%>
<%--              </c:if>--%>
              <c:forEach var="movie"
                         items="${requestScope.renderMovies}">
                <div class="col-lg-4 col-md-6 col-sm-6">
                  <a href="${MovieDetail}?idMovie=${movie.id}">
                    <div class="product__item">
                      <c:url var="urlAvatarMovie"
                             value="${movie.getFirstAvatar()}" />
                      <div class="product__item__pic set-bg"
                           data-setbg="${urlAvatarMovie}">
                        <div class="ep">${movie.currentEpisode}/${movie.totalEpisode}</div>

                          <%--                                        <div class="rate">--%>
                          <%--                                                ${movie.getAvgScore()} <i class='fa fa-star'--%>
                          <%--                                                                          style='color: #f3da35'></i>--%>
                          <%--                                        </div>--%>
                          <%--                                        <div class="comment">--%>
                          <%--                                            <i class="fa fa-comments"></i> ${movie.listComment.size()}--%>
                          <%--                                        </div>--%>
                        <div class="view">
                          <i class="fa fa-eye"></i> ${movie.views}
                        </div>
                        <c:if test="${!movie.isFree()}">
                          <a href="${MovieDetail}?idMovie=${movie.id}">
                            <div class="price_film">
                                ${movie.getRenderPrice()}đ
                            </div>
                          </a>
                        </c:if>
                      </div>
                      <div class="product__item__text">
                        <ul>
                          <c:forEach var="genre" items="${movie.genres}">
                            <li>${genre.description}</li>
                          </c:forEach>

                        </ul>

                        <h5>
                          <a href="${MovieDetail}?idMovie=${movie.id}">${movie.name}</a>
                        </h5>
                        <h5>${movie.renderPrice} đ</h5>
                      </div>
                    </div>
                  </a>
                </div>
              </c:forEach>

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


        <div class="col-md-6">
          <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-end mb-0">
              <li class="page-item disabled"><a class="page-link"
                                                href="" tabindex="-1"
                                                aria-disabled="true">Previous</a></li>
              <c:forEach var="i" begin="1" end="${requestScope.totalMovie}">
                <c:if test="${i==requestScope.index+1}">
                  <li class="page-item active">
                </c:if>
                <c:if test="${i!=requestScope.index+1}">
                  <li class="page-item">
                </c:if>
                <a class="page-link" href="${Index}?&&index=${i-1}&&filter=${requestScope.param}">${i}</a>
                </li>
              </c:forEach>

              <li class="page-item"><a class="page-link"
                                       href="">Next</a></li>
            </ul>
          </nav>

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
  $(document).ready(function(){
    let selectElement = $('#filter');
    let optionElements = selectElement.find('option');
    optionElements.each(function() {
      let optionValue = $(this).val();

      if(optionValue=="${requestScope.param}"){
        $(this).prop("selected", true);
      }
    });
  })
</script>

</body>

</html>