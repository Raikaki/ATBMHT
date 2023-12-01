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
	<link rel="icon" href="${pageContext.request.contextPath}/anime-main/img/logonweb.png" type="image/png">

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
<link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
<link rel="stylesheet" type="text/css" href="css/ds/style.css" />
<script src="https://kit.fontawesome.com/9847adceef.js"></script>
</head>
<script async src="https://www.googletagmanager.com/gtag/js?id=G-Q5H83WY80P"></script>
<script>
	window.dataLayer = window.dataLayer || [];

	function gtag() {
		dataLayer.push(arguments);
	}

	gtag('js', new Date());

	gtag('config', 'G-Q5H83WY80P');
</script>
<c:url var="urlAvatarMovie"
	   value="${requestScope.movie.getFirstAvatar()}"/>
<c:url var="watchingMovie" value="/anime-main/WatchingMovie"/>
<c:url var="updateView" value="/anime-main/UpView"/>
<body>
	<fmt:setLocale value="${sessionScope.LANG}" />
	<fmt:setBundle basename="app" />


	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>
	<div id="ah_wrapper">
	<!-- Header Section Begin -->
	<c:import url="/anime-main/header.jsp" />
	<!-- Header End -->
	<script src="js/player.js"></script>
	<!-- Breadcrumb Begin -->
	<div class="breadcrumb-option">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb__links">
						<a href="index.jsp"><i class="fa fa-home"></i> <fmt:message>menu.hompage</fmt:message></a>
						<span>${sessionScope.watchingMovie.name}</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Breadcrumb End -->

	<!-- Anime Section Begin -->
	<section class="anime-details spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="anime__video__player">
						<video id="player" controls data-poster="${urlAvatarMovie}" preload="metadata">
							<c:url var="chapterSource" value="${requestScope.watchChapter.name}"/>
							<source src="${chapterSource}" type="video/mp4">
							<!-- Captions are optional -->

						</video>
						<input type="text" id="openingValue" value="${requestScope.watchChapter.opening}"
							hidden>
					</div>
					<div class="anime__details__episodes">
						<div class="section-title">
							<h5>
								<fmt:message>button.episodes</fmt:message>
							</h5>
						</div>
						<c:forEach var="chap" items="${sessionScope.watchingMovie.listChapter}">
							<c:if test="${chap.index==requestScope.chapter}">

								<a href="${watchingMovie}?chapter=${chap.index}" style="color: #000000!important;
	background: #ffffff!important;">Ep ${chap.index}</a>
							</c:if>
							<c:if test="${chap.index!=requestScope.chapter}">

								<a href="${watchingMovie}?chapter=${chap.index}">Ep ${chap.index}</a>
							</c:if>
						</c:forEach>

					</div>
				</div>
			</div>
			<div class="row">
				<c:import url="movieComment.jsp"/>
			</div>
		</div>
	</section>
	<!-- Anime Section End -->

	<!-- Footer Section Begin -->
	<c:import url="/anime-main/footer.jsp" />
	</div>
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


	<script type="text/javascript">

		function skip() {
			let vd = document.getElementById("player");
			vd.currentTime = $("#openingValue").val();
		}
	</script>
	<script type="text/javascript">
		window.onload = function() {
			$(".plyr__controls")
					.append(
							"<i id=\"\skipOpening\"\ class=\"\plyr__controls__item plyr__volume fa fa-fast-forward\"\ onclick=\"\skip()\"\ style=\"\left:110px;bottom: 14px;\"\ aria-hidden=\"\true\"\></i>")
		};
	</script>
	<script>
		let video = document.getElementById("player");
		let durationNeed;
		let countdownTimer = null;
			video.addEventListener('loadedmetadata', function() {
			durationNeed = video.duration/2;
			countdownTimer = setInterval(function() {
				durationNeed -= 1;
				if (durationNeed <= 0) {
					clearInterval(countdownTimer);
					sendAjaxRequestToUpdateViewCount();
				}
			}, 1000);
		});
		function sendAjaxRequestToUpdateViewCount(){
			$.ajax({
				type: "POST",
				url: "${updateView}",
				data: {

					"idMovie": ${sessionScope.watchingMovie.id},
				},
				success: function (response) {
					console.log("success");
				},
				error: function (xhr) {
					console.log(xhr.responseText);
				}
		})
		}
	</script>

</body>

</html>