<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

	<!-- Google Font -->
	<link
			href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;600;700&display=swap"
			rel="stylesheet">
	<link
			href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;400;500;600;700;800;900&display=swap"
			rel="stylesheet">
	<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
	<link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
	<link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
	<link rel="stylesheet" href="css/plyr.css" type="text/css">
	<link rel="stylesheet" href="css/nice-select.css" type="text/css">
	<link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
	<link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="css/ds/style.css" />
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

<body>
<fmt:setLocale value="${sessionScope.LANG}" />
<fmt:setBundle basename="app" />
<c:url var="urlAvatar"
	   value="${request.rervletContext.realPath}${sessionScope.user.avatar}" />



<div id="ah_wrapper">
	<!-- Page Preloder -->
	<%--	<div id="preloder ">--%>
	<%--	</div>--%>

	<!-- Header Section Begin -->
	<c:import url="/anime-main/header.jsp" />
	<!-- Header End -->

	<!-- Normal Breadcrumb Begin -->
	<section class="normal-breadcrumb set-bg"
			 data-setbg="img/normal-breadcrumb.jpg"  >
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="normal__breadcrumb__text">
						<h2>
							<fmt:message>menu.ourblog</fmt:message>
						</h2>
						<p>
							<fmt:message>content.welcome</fmt:message>
						</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Normal Breadcrumb End -->

	<!-- Blog Section Begin -->
	<section class="blog spad">
		<div class="container">

			<div class="row">
				<c:if test="${listBlog != null}">
				<c:forEach var="i" begin="0" end="${listBlog.size()-1}"
						   step="1">
					<div class="col-lg-4 ">
						<div class="row">
							<div class="col-lg-12">
								<div class="blog__item set-bg blog-item-1"
									 data-setbg="/${listBlog.get(i).getAvatar()}">
									<div class="blog__item__text">
										<p>
											<span class="icon_calendar"></span>${listBlog.get(i).getReleaseAt()}
										</p>
										<h4>
											<a
													href="DetailBlog?idBlog=${listBlog.get(i).getId()}">${listBlog.get(i).getTitle()}</a>
										</h4>
									</div>
								</div>
							</div>

						</div>

					</div>
				</c:forEach>
				</c:if>
			</div>


		</div>
	</section>
	<!-- Blog Section End -->

	<!-- Footer Section Begin -->
	<c:import url="/anime-main/footer.jsp" /></div>

<!-- Footer Section End -->

<!-- Search model Begin -->
<div class="search-model">
	<div class="h-100 d-flex align-items-center justify-content-center">
		<div class="search-close-switch">
			<i class="icon_close"></i>
		</div>
		<form class="search-model-form">
			<input type="text" id="search-input" placeholder="Search here.....">
		</form>
	</div>
</div>
<!-- Search model end -->

<!-- Js Plugins -->
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/player.js"></script>
<script src="js/jquery.nice-select.min.js"></script>
<script src="js/mixitup.min.js"></script>
<script src="js/jquery.slicknav.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>

</body>

</html>