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

<!-- Css Styles -->
<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
<link rel="stylesheet" href="css/plyr.css" type="text/css">
<link rel="stylesheet" href="css/nice-select.css" type="text/css">
<link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
<link rel="stylesheet" type="text/css" href="css/ds/style.css" />
	<link rel="icon" href="${pageContext.request.contextPath}/anime-main/img/logonweb.png" type="image/png">

	<script src="https://kit.fontawesome.com/9847adceef.js"></script>
<link rel="stylesheet" href="css/ds/font-awesome.min.css"
	type="text/css">
<script src="https://www.google.com/recaptcha/api.js?hl=vi"></script>
</head>

<body>
	<!-- Page Preloder -->
	<div id="preloder">
		<div class="loader"></div>
	</div>
	<fmt:setLocale value="${sessionScope.LANG}" />
	<fmt:setBundle basename="app" />


	<!-- Header Section Begin -->

	<fmt:setBundle basename="app" />
	<div id="ah_wrapper">
	<c:import url="/anime-main/header.jsp" />
	<!-- Header End -->

	<!-- Normal Breadcrumb Begin -->
	<section class="normal-breadcrumb set-bg"
		data-setbg="img/normal-breadcrumb.jpg">

		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<div class="normal__breadcrumb__text">
						<h2>
							<fmt:message>menu.login</fmt:message>
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

	<!-- Login Section Begin -->
	<section class="login spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-6">
					<div class="login__form">
						<h3>
							<fmt:message>menu.login</fmt:message>
						</h3>
						<form action="login" method="post">
							<div class="input__item">
								<input required="required" type="text" placeholder="User Name"
									name="loginName" value="${requestScope.usName}"> <span
									class="icon_mail"></span>
							</div>
							<div class="input__item">
								<input type="password" required="required"
									placeholder="Password" name="loginPassword"> <span
									class="icon_lock"></span>
							</div>

							<div class="g-recaptcha"
								data-sitekey="6Lf2nYwkAAAAADknQvj1Os2Ht92MMORFX3RhbQDo"></div>
							<button type="submit" class="site-btn" value="login"
								name="accountBtn">
								<fmt:message>button.login</fmt:message>
							</button>
							 <a href="forgotPassword.jsp">&nbsp;&nbsp;<span><fmt:message>content.forgotpassword</fmt:message></span></a>
						</form>
						<br>
						<div style="color: red">${requestScope.errorLogin}</div>

					</div>
				</div>
				<div class="col-lg-6">
					<div class="login__register">
						<h3>
							<fmt:message>signup.message</fmt:message>
						</h3>
						<a href="signup.jsp" class="primary-btn"><fmt:message>button.signup</fmt:message></a>
						<br> <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile%20openid&redirect_uri=https://animeweb.site/anime-main/login-google&response_type=code&client_id=653759297281-qjl19np77aug293a6tahskvbfri39e4v.apps.googleusercontent.com&approval_prompt=force"
							class="primary-btn"><i class="fa fa-google-plus "
							aria-hidden="true"> </i> <fmt:message>content.logingg</fmt:message></a>

						<br>
						<div class="loginfb">
							<a class="primary-btn"
							   href="https://www.facebook.com/dialog/oauth?client_id=530089069113837&amp;redirect_uri=https://animeweb.site/anime-main/loginWithFacebook">
								<i class="fab fa-facebook-f"></i> &nbsp;&nbsp;<fmt:message>content.fb</fmt:message></a>
						</div>
					</div>
				</div>
			</div>
			<div class="login__social">
				<div class="row d-flex justify-content-center">
					<div class="col-lg-6">
						<div class="login__social__links"></div>
					</div>
				</div>
			</div>
		</div>

	</section>
		<c:import url="/anime-main/footer.jsp" />
	</div>
	<!-- Login Section End -->

	<!-- Footer Section Begin -->


	<!-- Footer Section End -->

	<!-- Search model Begin -->
	<!-- Search model end -->

	<!-- Js Plugins -->

	<!-- script dang nhap bang facebook -->
	<script>
		function statusChangeCallback(response) {
			console.log('statusChangeCallback');
			console.log(response);
			if (response.status === 'connected') {
				testAPI();
			} else {
				document.getElementById('status').innerHTML = 'Please log '
						+ 'into this app.';
			}
		}

		function checkLoginState() {
			FB.getLoginStatus(function(response) {
				statusChangeCallback(response);
			});
			FB.api(
					'/me',
					'POST',
					{fields : 'first_name,last_name,picture, email,id'},
					function(response) {
						var pictureUrl = response.picture.data.url;
						console.log(pictureUrl);
						// Chuyển hướng đến trang mới với URL của hình ảnh đại diện
						window.location.href = 'loginWithFacebook?action=Face&&first_name='
								+ response.first_name
								+ '&&last_name='
								+ response.last_name
								+ '&&picture='
								+ pictureUrl
								+ '&&email='
								+ response.email + '&&id=' + response.id;
					}
			);
		}

		window.fbAsyncInit = function() {
			FB.init({
				appId : '530089069113837',
				cookie : true,
				xfbml : true,
				version : 'v12.0'
			});

			FB.getLoginStatus(function(response) {
				statusChangeCallback(response);
			});

		};

		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id))
				return;
			js = d.createElement(s);
			js.id = id;
			js.src = "//connect.facebook.net/en_US/sdk.js";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));

		function testAPI() {
			console.log('Welcome!  Fetching your information.... ');
			FB
					.api(
							'/me',
							function(response) {
								console.log('Successful login for: '
										+ response.name);
								document.getElementById('status').innerHTML = 'Thanks for logging in, '
										+ response.name + '!';
							});
		}
	</script>

</body>

</html>