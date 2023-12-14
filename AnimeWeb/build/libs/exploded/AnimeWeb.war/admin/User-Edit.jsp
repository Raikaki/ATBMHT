<%@ page import="database.DAOPermission" %>
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
<title>Chỉnh sửa người dùng</title>
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
</head>
<c:url var="accountAvatar" value="${requestScope.account.avatar}" />
<c:url var="SubmitEditAccount" value="/admin/UserEdit" />
<c:url var="EditPasswordAccount" value="/admin/EditPasswordAccount"/>
<body class="sidebar-main-active right-column-fixed">
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
				<div class="row">
					<div class="col-lg-12">
						<div class="iq-card">
							<div class="iq-card-body p-0">
								<div class="iq-edit-list">
									<ul class="iq-edit-profile d-flex nav nav-pills">
										<li class="col-md-3 p-0"><a class="nav-link active"
											data-toggle="pill" href="#personal-information"> Thông tin người dùng </a></li>
										<li class="col-md-3 p-0"><a class="nav-link"
											data-toggle="pill" href="#chang-pwd"> Mật khẩu </a></li>
										<li class="col-md-3 p-0"><a class="nav-link"
																	data-toggle="pill" href="#chang-role"> Quyền hạn </a></li>

									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-12">
						<div class="iq-edit-list-data">
							<div class="tab-content">
								<div class="tab-pane fade active show" id="personal-information"
									role="tabpanel">
									<div class="iq-card">
										<div class="iq-card-header d-flex justify-content-between">
											<div class="iq-header-title">
												<h4 class="card-title">Thông tin cá nhân</h4>
											</div>
										</div>
										<div class="iq-card-body">
											<form method="post" action="${SubmitEditAccount}?idUser=${requestScope.account.id}&&typeId=${requestScope.account.type.id}" enctype="multipart/form-data">
												<div class="form-group row align-items-center">
													<div class="col-md-12 add-img-user" >
														<div class="profile-img-edit">
															<img class="profile-pic imgUserCustom" src="${accountAvatar}"
																alt="profile-pic">
															<div class="p-image">
																<i class="ri-pencil-line upload-button"></i> <input
																	class="img-upload" type="file" accept="image/*" name="imageUser"/>
															</div>
														</div>
													</div>
												</div>
												<div class=" row align-items-center">
													<div class="form-group col-sm-6">
														<label for="fname">Tên người dùng :</label> <input type="text"
															class="form-control" id="fname"
															value="${requestScope.account.fullName}" name="fullName" required="required">
													</div>

													<div class="form-group col-sm-6">
														<label for="email">Email :</label> <input type="text"
															class="form-control" id="email" value="${requestScope.account.email}" name="email" required="required">
													</div>
													<div class="form-group col-sm-6">
														<label >Loại tài khoản :</label>
														
														<p>${requestScope.account.getTypeAccount()}</p>
														
													</div>

													<div class="form-group col-sm-6">
														<label for="dob">Số điện thoại :</label> <input
															class="form-control" id="dob"
															value="${requestScope.account.phone}" name="phoneNumber" required="required">
													</div>



												</div>
												<div id="error" style="color: red">${requestScope.error}</div>
												<button type="submit" class="btn btn-primary mr-2">Xác nhận</button>
												<button type="reset" class="btn iq-bg-danger">Hủy</button>
											</form>
										</div>

								</div>



							</div>
								<div class="tab-pane fade" id="chang-pwd" role="tabpanel">
									<div class="iq-card">
										<div class="iq-card-header d-flex justify-content-between">
											<div class="iq-header-title">
												<h4 class="card-title">Đổi mật khẩu</h4>
											</div>
										</div>
										<div class="iq-card-body">
											<form>

												<div class="form-group">
													<label for="passwordConfirm">Mật khẩu mới:</label> <input
														type="Password" class="form-control" value="" id="passwordConfirm" required>
												</div>

												<button type="button" class="btn btn-primary mr-2" onclick="changePassword()">Xác nhận</button>

												<button type="reset" class="btn iq-bg-danger">Hủy</button>
											</form>
										</div>
									</div>
								</div>
								<div class="tab-pane fade" id="chang-role" role="tabpanel">
									<div class="iq-card">
										<div class="iq-card-header d-flex justify-content-between">
											<div class="iq-header-title">
												<h4 class="card-title">Chỉnh sửa vai trò</h4>
											</div>
										</div>
										<div class="iq-card-body">
											<div class="container">
												<div class="row">
													<div class="col-md-6">
														<p>Vai trò đang có</p>
														<table class="table" id="roleHaveTable">
															<thead>
															<tr>
																<th></th>
																<th>Tên</th>
																<th>Tuỳ chọn</th>
															</tr>
															</thead>
															<tbody>
															<c:forEach var="oRole" items="${requestScope.account.roles}">

																<tr>
																	<td></td>
																	<td>${oRole.description}</td>
																	<td>
																		<c:if test="${oRole.id!=1}">
																			<button type="button"
																					class="btn iq-bg-danger btn-rounded btn-sm my-0"><i
																					class="ri-delete-bin-line" onclick="removeRole(this,${requestScope.account.id},${oRole.id},`${oRole.description}`)"></i></button>
																		</c:if>
																	</td>
																</tr>

															</c:forEach>


															</tbody>
														</table>
													</div>
													<div class="col-md-6">
														<p>Vai trò có thể thêm</p>
														<table class="table" id="roleMayHadTable">
															<thead>
															<tr>
																<th></th>
																<th>Tên</th>
																<th>Tùy chỉnh</th>
															</tr>
															</thead>
															<tbody>
															<c:forEach var="mRole" items="${requestScope.listUnableRole}">
																<tr>
																	<td></td>
																	<td>${mRole.description}</td>
																	<td><button class="btn iq-bg-info fa fa-plus-circle" onclick="addRole(this,${requestScope.account.id},${mRole.id},`${mRole.description}`)"></button></td>
																</tr>
															</c:forEach>
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Wrapper END -->
	<!-- Footer -->
	<footer class="iq-footer">
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
		<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css">
		<script src="js/jquery.min.js"></script>
		<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js"></script>
		<script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
		<script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>
		<script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
		<script>
			let tableRole;
			let tableMayHadRole;
			$(document).ready(function () {
				tableRole = $('#roleHaveTable').DataTable({
					rowId: 'row_num',
					columnDefs: [{
						targets: 0,
						data: null,
						defaultContent: '',
						title: 'STT',
						className: 'dt-center',
						orderable: false,
						searchable: false,
						render: function (data, type, row, meta) {

							return meta.row + 1;
						}
					}],
					order: [[0, 'asc']],
					"searching": true,
					"sorting": true,
				});
				tableMayHadRole = $('#roleMayHadTable').DataTable({
					rowId: 'row_num',
					columnDefs: [{
						targets: 0,
						data: null,
						defaultContent: '',
						title: 'STT',
						className: 'dt-center',
						orderable: false,
						searchable: false,
						render: function (data, type, row, meta) {

							return meta.row + 1;
						}
					}],
					order: [[0, 'asc']],
					"searching": true,
					"sorting": true,
				});
			});
			function addRole(button,idUser,idRole,description){
				Swal.fire({
					title: 'Xác nhận?',
					text: "Bạn chắc chắn thực hiện thao tác này!",
					icon: 'info',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: 'Yes, add it!'
				}).then((result) => {
					if (result.isConfirmed) {
						<c:url var="AddUserRole" value="/admin/AddUserRole" />
						$.ajax({
							url: "${AddUserRole}",
							type: "post",
							data: {
								userId:idUser,
								roleId:idRole,
							},
							success: function (data) {
								let isSuccess = (JSON.parse(data)).isSuccess;
								if (isSuccess) {
									Swal.fire({
										icon: 'success',
										title: 'Thành công',
										text: 'Thêm thành công!',

									})
									let appendInsert=`<tr>
																	<td>`+idRole+`</td>
																	<td>`+description+`</td>
																	<td>

																			<button type="button"
																					class="btn iq-bg-danger btn-rounded btn-sm my-0"><i
																					class="ri-delete-bin-line" onclick="removeRole(this,${requestScope.account.id},`+idRole+`,\'`+description+`\')"></i></button>

																	</td>
																</tr>
									`
									tableRole.rows.add($(appendInsert)).draw();
									tableMayHadRole.row($($(button).closest("tr"))).remove().draw(false);
								}else{
									Swal.fire({
										icon: 'error',
										title: 'Oops...',
										text: 'Thêm thất bại!',
									})
								}
							},
							error: function (data) {
								Swal.fire({
									icon: 'error',
									title: 'Oops...',
									text: 'Thêm thất bại!',

								})
							}
						});
					}
				});
			}
			function removeRole(button,idUser,idRole,description){
				Swal.fire({
					title: 'Xác nhận?',
					text: "Bạn chắc chắn thực hiện thao tác này!",
					icon: 'info',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: 'Yes, add it!'
				}).then((result) => {
					if (result.isConfirmed) {
						<c:url var="RemoveUserRole" value="/admin/RemoveUserRole" />
						$.ajax({
							url: "${RemoveUserRole}",
							type: "post",
							data: {
								userId:idUser,
								roleId:idRole,
							},
							success: function (data) {
								let isSuccess = (JSON.parse(data)).isSuccess;
								if (isSuccess) {
									Swal.fire({
										icon: 'success',
										title: 'Thành công',
										text: 'Xóa thành công!',

									})
									let appendInsert=`<tr>
																	<td>`+idRole+`</td>
																	<td>`+description+`</td>

		<td><button class="btn iq-bg-info fa fa-plus-circle" onclick="addRole(this,${requestScope.account.id},`+idRole+`,\'`+description+`\')"></button></td>

																</tr>
									`
									tableMayHadRole.rows.add($(appendInsert)).draw();
									tableRole.row($($(button).closest("tr"))).remove().draw(false);

								}else{
									Swal.fire({
										icon: 'error',
										title: 'Oops...',
										text: 'Xóa thất bại!',
									})
								}
							},
							error: function (data) {
								Swal.fire({
									icon: 'error',
									title: 'Oops...',
									text: 'Xóa thất bại!',

								})
							}
						});
					}
				});
			}
		</script>
	<script>
	function changePassword(){
		Swal.fire({
			title: 'Xác nhận?',
			text: "Bạn chắc chắn thực hiện thao tác này!",
			  icon: 'info',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: 'Yes, update it!'
			}).then((result) => {
			  if (result.isConfirmed) {
				  <c:url var="EditPasswordAccount" value="/admin/EditPasswordAccount" />
				  $.ajax({
						url : "${EditPasswordAccount}",
						type : "post",
						data : {
							password : $("#passwordConfirm").val(),
							idUser : ${requestScope.account.id},
						},
						success : function(data) {
							var getData = JSON.parse(data);
							if(getData==="true"){
								Swal.fire({
									  position: 'center',
									  icon: 'success',
									  title: 'Your work has been saved',
									  showConfirmButton: false,
									  timer: 1500
									})
							}
							if(getData==="false"){
								Swal.fire({
									  position: 'center',
									  icon: 'error',
									  title: 'Có lỗi xảy ra trong quá trình thay đổi',
									  showConfirmButton: false,
									  timer: 1500
									})
							}
							if(getData==="error"){
								Swal.fire({
									  position: 'center',
									  icon: 'error',
									  title: 'Mật khẩu phải bao gồm chữ hoa, chữ thường, ký tự đặc biệt và chữ số',
									  showConfirmButton: false,
									  timer: 1500
									})
							}

						},
						error : function(data) {

						}
					});
			  }
			})
	}
	
	</script>
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