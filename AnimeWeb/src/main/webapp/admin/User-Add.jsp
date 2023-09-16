<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en">
<head>
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport"
		  content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Thêm người dùng</title>
	<!-- Favicon -->
	<link rel="shortcut icon" href="images/favicon.ico" />
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<!-- Typography CSS -->
	<link rel="stylesheet" href="css/typography.css">
	<!-- Style CSS -->
	<link rel="stylesheet" href="css/style.css">
	<!-- Responsive CSS -->
	<link rel="stylesheet" href="css/responsive.css">
	<c:url var="addUser" value="/admin/UserAdd" />
</head>
<body>
<!-- loader Start -->
<div id="loading">
	<div id="loading-center"></div>
</div>
<!-- loader END -->
<!-- Wrapper Start -->
<div class="wrapper">
	<!-- Sidebar  -->
	<c:import url="/admin/sidebar.jsp" />
	<!-- TOP Nav Bar -->
	<c:import url="/admin/header.jsp" />
	<!-- TOP Nav Bar END -->
	<!-- Page Content  -->
	<div id="content-page" class="content-page">
		<div class="container-fluid">
			<form method="post" action="${addUser}" enctype="multipart/form-data">
				<div class="row">
					<div class="col-lg-3">
						<div class="iq-card">
							<div class="iq-card-header d-flex justify-content-between">
								<div class="iq-header-title">
									<h4 class="card-title">Thêm người dùng mới</h4>
								</div>
							</div>
							<div class="iq-card-body">

								<div class="form-group">
									<div class="add-img-user profile-img-edit">
										<img class="profile-pic img-fluid imgUserCustom" src="images/user/11.png"
											 alt="profile-pic">
										<div class="p-image">
											<label href="javascript:void();"
											   class="upload-button btn iq-bg-primary">Ảnh đại diện<input
												class="img-upload " style="display: none" type="file" accept="image/*" name="avatar"></label>
										</div>
									</div>
									<div class="img-extension mt-3">
										<div class="d-inline-block align-items-center">
											<span>Only</span> <label href="javascript:void();">.jpg</label> <label
												href="javascript:void();">.png</label> <label
												href="javascript:void();">.jpeg</label> <span>allowed</span>
										</div>
									</div>
								</div>


							</div>
						</div>
					</div>
					<div class="col-lg-9">
						<div class="iq-card">
							<div class="iq-card-header d-flex justify-content-between">
								<div class="iq-header-title">
									<h4 class="card-title">Thông tin người dùng mới</h4>
								</div>
							</div>
							<div class="iq-card-body">
								<div class="new-user-info">

									<div class="row">
										<div class="form-group col-md-6">
											<label for="fullName">Tên người dùng: </label> <input type="text"
																							 class="form-control" id="fullName" name="fullName" placeholder="Full Name">
										</div>


										<div class="form-group col-md-6">
											<label for="phone">Số điện thoại:</label> <input type="text"
																							class="form-control" id="phone" name="phone" placeholder="Phone Number">
										</div>
										<div class="form-group col-md-6">
											<label for="email">Email:</label> <input type="email"
																					 class="form-control" id="email" name="email" placeholder="Email">
										</div>


									</div>
									<hr>
									<h5 class="mb-3">Bảo mật</h5>
									<div class="row">
										<div class="form-group col-md-12">
											<label for="uname">Tên tài khoản:</label> <input type="text"
																						 class="form-control" id="uname" name="userName" placeholder="Tên tài khoản">
										</div>
										<div class="form-group col-md-6">
											<label for="pass">Mật khẩu:</label> <input type="password"
																					   class="form-control" id="pass" name="password" placeholder="Mật khẩu">
										</div>

									</div>

									<button type="submit" class="btn btn-primary">Xác nhận</button>
									<p>${requestScope.error}</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- Wrapper END -->
<!-- Footer -->
<footer class="bg-white iq-footer">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-6">
				<ul class="list-inline mb-0">
					<li class="list-inline-item"><a href="privacy-policy.html">Privacy
						Policy</a></li>
					<li class="list-inline-item"><a href="terms-of-service.html">Terms
						of Use</a></li>
				</ul>
			</div>
			<div class="col-lg-6 text-right">
				Copyright 2020 <a href="#">FinDash</a> All Rights Reserved.
			</div>
		</div>
	</div>
</footer>
<!-- Footer END -->

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="js/jquery.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<!-- Appear JavaScript -->
<script src="js/jquery.appear.js"></script>
<!-- Countdown JavaScript -->
<script src="js/countdown.min.js"></script>
<!-- Counterup JavaScript -->
<script src="js/waypoints.min.js"></script>
<script src="js/jquery.counterup.min.js"></script>
<!-- Wow JavaScript -->
<script src="js/wow.min.js"></script>
<!-- Apexcharts JavaScript -->
<script src="js/apexcharts.js"></script>
<!-- Slick JavaScript -->
<script src="js/slick.min.js"></script>
<!-- Select2 JavaScript -->
<script src="js/select2.min.js"></script>
<!-- Owl Carousel JavaScript -->
<script src="js/owl.carousel.min.js"></script>
<!-- Magnific Popup JavaScript -->
<script src="js/jquery.magnific-popup.min.js"></script>
<!-- Smooth Scrollbar JavaScript -->
<script src="js/smooth-scrollbar.js"></script>
<!-- lottie JavaScript -->
<script src="js/lottie.js"></script>
<!-- am core JavaScript -->
<script src="js/core.js"></script>
<!-- am charts JavaScript -->
<script src="js/charts.js"></script>
<!-- am animated JavaScript -->
<script src="js/animated.js"></script>
<!-- am kelly JavaScript -->
<script src="js/kelly.js"></script>
<!-- am maps JavaScript -->
<script src="js/maps.js"></script>
<!-- am worldLow JavaScript -->
<script src="js/worldLow.js"></script>
<!-- Style Customizer -->
<script src="js/style-customizer.js"></script>
<!-- Chart Custom JavaScript -->
<script src="js/chart-custom.js"></script>

<!-- Custom JavaScript -->
<script src="js/custom.js"></script>
</body>
</html>