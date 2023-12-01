<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
  <link rel="icon" href="${pageContext.request.contextPath}/anime-main/img/logonweb.png" type="image/png">
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
</head>

<body>

<fmt:setLocale value="${sessionScope.LANG}"/>
<c:url var="profileServlet" value="/anime-main/profile.jsp"/>
<c:url var="MovieDetail" value="/anime-main/MovieDetail"/>
<c:url var="bonus" value="/anime-main/Bonus"/>
<!-- Page Preloder -->
<div id="preloder">
  <div class="loader"></div>
</div>
<div id="ah_wrapper">
  <!-- Header Section Begin -->
  <c:import url="/anime-main/header.jsp"/>
  <!-- Header End -->

  <!-- Hero Section Begin -->
  <section class="hero">
    <div class="container">
      <div class="hero__slider owl-carousel">
        <div class="hero__items set-bg" data-setbg="img/hero/thangtu.jpg">
          <div class="row">
            <div class="col-lg-6">
              <div class="hero__text">
                <div class="label">Romance</div>
                <h2>Shigatsu wa Kimi no Uso</h2>
                <p>Nội dung Câu chuyện kể về Arima Kousei, một thần đồng
                  piano. Nhưng kể từ sau chấn động tâm lí do cái sự qua đời của
                  mẹ cậu, Kosei đã không thể nghe thấy bất kì âm thanh nào....</p>

              </div>
            </div>
          </div>
        </div>
        <div class="hero__items set-bg" data-setbg="img/hero/overlord.jpg">
          <div class="row">
            <div class="col-lg-6">
              <div class="hero__text">
                <div class="label">Adventure</div>
                <h2>Overlord</h2>
                <p>Cốt truyện anime sẽ đưa khán giả đến năm 2138 trong tương
                  lai, khi khoa học công nghệ phát triển vượt bậc và ngành game
                  thực tế ảo đang nở rộ hơn bao giờ hết...</p>

              </div>
            </div>
          </div>
        </div>
        <div class="hero__items set-bg" data-setbg="img/hero/dptk.jpg">
          <div class="row">
            <div class="col-lg-6">
              <div class="hero__text">
                <div class="label">Adventure</div>
                <h2>Fights Break Sphere Season 5</h2>
                <p>Đấu Phá Thương Khung kể về một thế giới thuộc về Đấu Khí,
                  không hề có ma pháp hoa tiếu diễm lệ, chỉ có đấu khí cương mãnh
                  phồn thịnh! ....</p>

              </div>
            </div>
          </div>
        </div>

      </div>
    </div>
  </section>
  <!-- Hero Section End -->

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

                      <fmt:message>content.bonus</fmt:message>
                    </h4>
                    <form class="sort" action="${Index}" method="post">


                      <label for="filter">Lọc</label><select name="filter"
                                                             onchange="this.form.submit()"
                                                             id="filter">
                      <option value="isAtoZ">A-Z</option>
                      <option value="notAtoZ">Z-A</option>
                      <option value="isDescPrice"><fmt:message>sort.decrease</fmt:message></option>
                      <option value="notDescPrice"><fmt:message>sort.ascending</fmt:message></option>
                      <option value="isDescDate"><fmt:message>sort.oldest</fmt:message></option>
                      <option value="notDescDate"><fmt:message>sort.new</fmt:message></option>
                    </select>
                    </form>
                  </div>
                </div>

              </div>
              <div class="row">
                <c:if test="${empty requestScope.index}">
                  <c:set var="offset" scope="page" value="0"/>
                </c:if>
                <c:forEach var="movie"
                           items="${requestScope.renderMovies}">
                  <div class="col-lg-4 col-md-6 col-sm-6">
                    <a href="${MovieDetail}?idMovie=${movie.id}">
                      <div class="product__item">
                        <c:url var="urlAvatarMovie"
                               value="${movie.getFirstAvatar()}"/>
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
                          <c:if test="${user ==null}">
                            <c:if test="${!movie.isFree()}">
                              <a href="${MovieDetail}?idMovie=${movie.id}">


                                <div class="price_film">

                                  <c:if test="${movie.percent>0.0}">
                                    <div class="proloop-price--compare">
                                      <del><fmt:formatNumber
                                              value="${movie.oldPrice}"
                                              type="number" pattern="#,##0"/>VND
                                      </del>
                                    </div>
                                    <div class="proloop-price--default">
                                                                            <span class="proloop-price--highlight"> <fmt:formatNumber
                                                                                    value="${movie.renderPrice}"
                                                                                    type="number"
                                                                                    pattern="#,##0"/>VND</span>
                                      <span class="proloop-label--on-sale">   ${movie.percent}%</span>
                                    </div>


                                  </c:if>
                                  <c:if test="${movie.percent == 0.0}">
                                    <fmt:formatNumber value="${movie.renderPrice}"
                                                      type="number"
                                                      pattern="#,##0"/>VND
                                  </c:if>

                                </div>

                              </a>
                            </c:if>
                          </c:if>

                          <c:if test="${user !=null }">

                            <c:choose>
                              <c:when test="${ sessionScope.purchasedIds.contains(movie.id)}">
                              </c:when>
                              <c:when test="${!movie.isFree()&& !sessionScope.purchasedIds.contains(movie.id)&& movie.percent == 0.0}">
                                <div class="price_film">
                                  <fmt:formatNumber value="${movie.renderPrice}"
                                                    type="number" pattern="#,##0"/>đ
                                </div>
                              </c:when>
                              <c:when test="${!movie.isFree()&& !sessionScope.purchasedIds.contains(movie.id) && movie.percent>0.0}">
                                <a href="${MovieDetail}?idMovie=${movie.id}">


                                  <div class="price_film">


                                    <div class="proloop-price--compare">
                                      <del><fmt:formatNumber
                                              value="${movie.oldPrice}"
                                              type="number" pattern="#,##0"/>VND
                                      </del>
                                    </div>
                                    <div class="proloop-price--default">
                                                                            <span class="proloop-price--highlight"> <fmt:formatNumber
                                                                                    value="${movie.renderPrice}"
                                                                                    type="number"
                                                                                    pattern="#,##0"/>VND</span>
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



        </div>
        <c:import url="/anime-main/topview.jsp"/>


        <div class="col-md-6">
          <nav aria-label="Page navigation example">
            <ul class="pagination justify-content-end mb-0">
              <li class="page-item"><a class="page-link"
                                                href="${bonus}?&&index=${requestScope.index+1}&&filter=${requestScope.param}&&idBonus=${requestScope.idBonus}" tabindex="-1"
                                                >Previous</a></li>
              <c:forEach var="i" begin="1" end="${requestScope.totalMovie}">
                <c:if test="${i==requestScope.index+1}">
                  <li class="page-item active">
                </c:if>
                <c:if test="${i!=requestScope.index+1}">
                  <li class="page-item">
                </c:if>
                <a class="page-link"
                   href="${bonus}?&&index=${i-1}&&filter=${requestScope.param}&&idBonus=${requestScope.idBonus}">${i}</a>
                </li>
              </c:forEach>

              <li class="page-item"><a class="page-link"
                                       href="${bonus}?&&index=${requestScope.index+1}&&filter=${requestScope.param}&&idBonus=${requestScope.idBonus}">Next</a></li>
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

<script>
  $(document).ready(function () {
    let selectElement = $('#filter');
    let optionElements = selectElement.find('option');
    optionElements.each(function () {
      let optionValue = $(this).val();

      if (optionValue === "${requestScope.param}") {
        $(this).prop("selected", true);
      }
    });
  })
</script>

</body>

</html>