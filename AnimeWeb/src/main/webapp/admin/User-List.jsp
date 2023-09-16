<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Danh sách người dùng</title>
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
<script src="https://kit.fontawesome.com/fe2c9f6253.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://kit.fontawesome.com/fe2c9f6253.css"
	crossorigin="anonymous">
<c:url var="UserEdit" value="/admin/UserEdit" />
<c:url var="RemoveUser" value="/admin/RemoveUser" />
<c:url var="UnlockUser" value="/admin/UnlockUser" />
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
				<div class="row">
					<div class="col-sm-12">
						<div class="iq-card">
							<div class="iq-card-header d-flex justify-content-between">
								<div class="iq-header-title">
									<h4 class="card-title">Danh sách người dùng</h4>
								</div>
							</div>
							<div class="iq-card-body">
								<div class="table-responsive">

									<table id="user-list-table"
										class="table table-striped table-bordered mt-4" role="grid"
										aria-describedby="user-list-page-info" style="text-align: center">
										<thead>
											<tr>
												<th>Ảnh đại diện</th>
												<th>Tên người dùng</th>
												<th>Tên tài khoản</th>
												<th>Số điện thoại</th>
												<th>Email</th>
												<th>Loại tài khoản</th>
												<th>Vai trò</th>
												<th>Trạng thái</th>
												<th>Ngày đăng ký</th>
												<th>Tùy chỉnh</th>
											</tr>
										</thead>
										<tbody>

											<c:forEach var="item" items="${requestScope.listAccount}">
												<tr>
													<c:url var="itemAvatar" value="${item.avatar}" />
													<td class="text-center"><img
														class="rounded img-fluid avatar-40" src="${itemAvatar}"
														alt="profile"></td>
													<td>${item.fullName}</td>
													<td>${item.userName}</td>
													<td>${item.phone}</td>
													<td>${item.email}</td>
													<td>${item.getTypeAccount()}</td>
													<td><c:forEach var="role" items="${item.roles}">
															<div>
																<p>${role.description}</p>

															</div>
														</c:forEach></td>
													<td>
														<div id="renderIsActive${item.id}">
															<c:if test="${item.isActive==1}">
																<span class="badge iq-bg-success">
															</c:if>
															<c:if test="${item.isActive==0}">
																<span class="badge iq-bg-danger">
															</c:if>
															${item.getIsActiveDescription()}</span>
														</div>
													</td>

													<td>${item.getFullJoinDate()}</td>
													<td>

														<div class="flex align-items-center list-user-action" style="float: left!important;">
															<c:if test="${item.isActive==0}">

																<button class="btn btn-outline-success" type="submit"
																	id="unlockButton${item.id}"
																	onclick="unlockUser(${item.id})">
																	<i class="fa-solid fa-lock-open"></i>
																</button>
																<button class="btn btn-outline-danger" type="submit"
																	id="lockButton${item.id}"
																	onclick="lockUser(${item.id})" style="display: none;">
																	<i class="fa-solid fa-lock" ></i>
																</button>
															</c:if>
															<c:if test="${item.isActive==1}">

																<button class="btn btn-outline-success" type="submit"
																	id="unlockButton${item.id}"
																	onclick="unlockUser(${item.id})"
																	style="display: none;">
																	<i class="fa-solid fa-lock-open"></i>
																</button>
																<button class="btn btn-outline-danger" type="submit"
																	id="lockButton${item.id}"
																	onclick="lockUser(${item.id})">
																	<i class="fa-solid fa-lock"></i>
																</button>

															</c:if>
															<form method="get" action="${UserEdit}">
																<input name="idUser" type="hidden"
																	value="${item.id}">
																<button class="btn btn-outline-primary" data-toggle="tooltip"
																	data-placement="top" title=""
																	data-original-title="Edit" type="submit">
																	<i class="ri-pencil-line"></i>
																</button>
															</form>

															<form method="post"
																action="${RemoveUser}?idUser=${item.id}"
																id="removeForm${item.id}">
																<button class="btn btn-outline-danger" data-toggle="tooltip"
																	data-placement="top" title=""
																	data-original-title="Delete" type="button"
																	onclick="submitRemove(${item.id})">
																	<i class="ri-delete-bin-line"></i>
																</button>
															</form>
														</div>
													</td>
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
	<!-- Wrapper END -->
	<!-- Footer -->
	<c:import url="footer.jsp"/>
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

	<script>
		var tableAccount;

		$(document).ready(function () {
			tableSupplier=$('#user-list-table').DataTable({
				"searching": true,
				"sorting": true,
				dom: 'Bfrtip',
				buttons: [
					{
						extend: 'copy',
						className: 'btn btn-outline-primary'
					},
					{
						extend: 'csv',
						className: 'btn btn-outline-info'
					},
					{
						extend: 'excel',
						className: 'btn btn-outline-success'
					},
					{
						extend: 'pdf',
						className: 'btn btn-outline-warning'
					},
					{
						extend: 'print',
						className: 'btn btn-outline-danger'
					}
				],
			});

		});
		function submitRemove(idUser){
			let formName ="removeForm"+idUser;
			Swal.fire({
				title: 'Xác nhận?',
				text: "Bạn chắc chắn thực hiện thao tác này!",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: 'Yes, delete it!'
				}).then((result) => {
				  if (result.isConfirmed) {
					$("#"+formName).submit();
				  }
				})
		}
		function unlockUser(idUser){
			Swal.fire({
				title: 'Xác nhận?',
				text: "Bạn chắc chắn thực hiện thao tác này!",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: 'Yes, change it!'
				}).then((result) => {
				  if (result.isConfirmed) {
						ajaxUnlock(idUser);
				  }
				})
	
		}
		function lockUser(idUser){
			Swal.fire({
				title: 'Xác nhận?',
				text: "Bạn chắc chắn thực hiện thao tác này!",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: 'Yes, change it!'
				}).then((result) => {
				  if (result.isConfirmed) {
				
					ajaxLock(idUser)
				  }
				})
		}
		function ajaxLock(idUser){
			<c:url var="LockUser" value="/admin/LockUser" />
			$.ajax({
				url : "${LockUser}",
				type : "get",
				data : {
					idUser : idUser,
				},
				success : function(data) {
					let result="";
					let parseData = JSON.parse(data);
					let isSuccess = JSON.parse(parseData.isSuccess);
					let newData = JSON.parse(parseData.newData);
					if(isSuccess){
					
						let namebutton ="#lockButton"+idUser;
						$(namebutton).css("display","none");
						let namebutton1 ="#unlockButton"+idUser;
						$(namebutton1).css("display","block");
						let nameRow = "#renderIsActive"+idUser;
						result=`<span class="badge iq-bg-danger">`+newData+`</span>`;
						$(nameRow).html(result);
						Swal.fire({
							  position: 'center',
							  icon: 'success',
							  title: 'Thành công',
							  showConfirmButton: false,
							  timer: 1500
							})
					}else{
						Swal.fire({
							  position: 'center',
							  icon: 'error',
							  title: 'Thất bại',
							  showConfirmButton: false,
							  timer: 1500
							})
					}
		
				},
				error : function(data) {
					console.log(false);
				}
			});
		}
		function ajaxUnlock(idUser){
			<c:url var="UnlockUser" value="/admin/UnlockUser" />
			$.ajax({
				url : "${UnlockUser}",
				type : "get",
				data : {
					idUser : idUser,
				},
				success : function(data) {
					let result="";
					let parseData = JSON.parse(data);
					let isSuccess = JSON.parse(parseData.isSuccess);
					let newData = JSON.parse(parseData.newData);
					if(isSuccess){

						let namebutton ="#lockButton"+idUser;
						$(namebutton).css("display","block");
						let namebutton1 ="#unlockButton"+idUser;
						$(namebutton1).css("display","none");
						let nameRow = "#renderIsActive"+idUser;
						result=`<span class="badge iq-bg-success">`+newData+`</span>`;
						$(nameRow).html(result);
						Swal.fire({
							  position: 'center',
							  icon: 'success',
							  title: 'Thành công',
							  showConfirmButton: false,
							  timer: 1500
							})
					}else{
						Swal.fire({
							  position: 'center',
							  icon: 'error',
							  title: 'Thất bại',
							  showConfirmButton: false,
							  timer: 1500
							})
					}
		
				},
				error : function(data) {
					console.log(false);
				}
			});
		}
	</script>

</body>
</html>