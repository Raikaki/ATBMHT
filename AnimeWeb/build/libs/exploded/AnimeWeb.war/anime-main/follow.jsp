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
<title>Anime</title>
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
				<div class="col-lg-12">
					<div class="trending__product">
						<div class="row">
							<div class="col-lg-8 col-md-8 col-sm-8">
								<div class="section-title">
									<h4>Danh sách phim theo dõi</h4>
								</div>
							</div>

						</div>
						<div class="row">
							<c:forEach var="movie" items="${requestScope.user.moviesFollow}">
								<form class="col-lg-3 col-md-6 col-sm-6">
									<div class="product__item">
										<c:url var="urlAvatarMovie"
											   value="${movie.getFirstAvatar()}" />
										<div class="product__item__pic set-bg"
											 data-setbg="${movie.getFirstAvatar()}">
											<div class="ep">${movie.getCurrentEpisode()}/
													${movie.totalEpisode}</div>
<%--																							<div class="rate">--%>
<%--																								${movie.getAvgScore()}--%>
<%--																									<i class='fa fa-star'--%>
<%--																									style='color: #f3da35'></i>--%>
<%--																							</div>--%>
<%--																							<div class="comment">--%>
<%--																								<i class="fa fa-comments"></i> ${movie.listComment.size()}--%>
<%--																							</div>--%>
																							<div class="view">
																								<i class="fa fa-eye"></i> ${movie.views}
																							</div>
										</div>
										<div class="product__item__text">
																							<ul>

																								<c:forEach var="genre" items="${movie.genres}">
																									<li>${genre.description}</li>
																								</c:forEach>
																							</ul>
											<h5>
												<a href="${movieDetail}?idMovie=${movie.id}">${movie.name}</a>
											</h5>
											<c:if test="${!movie.isFree()}">
												<button type="submit" style="color: white;background: red">Mua ngay ${movie.renderPrice} </button>
											</c:if>
										</div>
									</div>
								</form>
							</c:forEach>

						</div>
					</div>


				</div>
				<%--				<c:import url="/anime-main/topview.jsp" />--%>




			</div>
		</div>
	</section>
	<!-- Product Section End -->

	<!-- Footer Section Begin -->
	<c:import url="/anime-main/footer.jsp" />
</div>




</body>

</html>