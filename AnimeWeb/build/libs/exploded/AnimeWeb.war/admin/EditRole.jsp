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
    <title>Chỉnh sửa vai trò</title>
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
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css">
    <c:url var="editRole" value="/admin/EditRole" />
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
                    <div class="col-lg-9">
                        <div class="iq-card">
                            <div class="iq-card-header d-flex justify-content-between">
                                <div class="iq-header-title">
                                    <h4 class="card-title">Chỉnh sửa quyền hạn</h4>
                                </div>
                            </div>
                            <div class="iq-card-body">
                                <form>
                                <div class="new-user-info">
                                    <div class="row">

                                        <div class="form-group col-md-6">
                                            <h3>Vai trò đang sửa : ${requestScope.role.description} </h3>
                                        </div>
                                        <div class="container">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <p>Quyền hạn đang có</p>
                                                    <table class="table" id="permissionHaveTable">
                                                        <thead>
                                                        <tr>
                                                            <th></th>
                                                            <th>Tên</th>
                                                            <th>Tùy chọn</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <c:forEach var="pms" items="${requestScope.role.permissions}">
                                                           <tr><td></td>
                                                            <td>${pms.name}</td>
                                                            <td><button type="button" class="btn iq-bg-danger btn-rounded btn-sm my-0"><i class="ri-delete-bin-line"
                                                                                                                                          onclick="removeRole(this,${pms.id},`${pms.name}`)"></i></button>
                                                                <input type="text" name="idPermission" value="${pms.id}" style="display: none">
                                                            </td>
                                                           </tr>
                                                        </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                <div class="col-md-6">
                                                    <p>Quyền hạn có thể có</p>
                                                    <table class="table" id="permissionMayHadTable">
                                                        <thead>
                                                        <tr>
                                                            <th></th>
                                                            <th>Tên</th>
                                                            <th>Tùy chọn</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        <c:forEach var="permission" items="${requestScope.enablePermission}">
                                                            <tr>
                                                                <td></td>
                                                                <td>${permission.name}</td>
                                                                <td><button class="btn iq-bg-info fa fa-plus-circle" type="button" onclick="addToRole(this,${permission.id},`${permission.name}`)"></button></td>
                                                            </tr>
                                                        </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <p style="color: red">${requestScope.error}</p>
                                    <button type="button" class="btn btn-primary" onclick="submitEdit(this)">Chỉnh sửa vai trò</button>

                                </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

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
    var permissionHave;
    var permissionMayHad;
    $(document).ready(function () {
        permissionHave = $('#permissionHaveTable').DataTable({
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
        permissionMayHad = $('#permissionMayHadTable').DataTable({
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
    function addToRole(button,idPermission,name){
        let trAppend=`
    <tr>
        <td></td>
        <td>`+name+`</td>
        <td><button type="button" class="btn iq-bg-danger btn-rounded btn-sm my-0"><i class="ri-delete-bin-line"
         onclick="removeRole(this,`+idPermission+`,\``+name+`\`)"></i></button>
        <input type="text" name="idPermission" value="`+idPermission+`" style="display: none">
		</td>

</tr>
    `;
        permissionHave.rows.add($(trAppend)).draw();
        permissionMayHad.row($($(button).closest("tr"))).remove().draw(false);
    }
    function removeRole(button,idPermission,name){
        let trAppend=`
    <tr>
        <td></td>
        <td>`+name+`</td>
        <td><button class="btn iq-bg-info fa fa-plus-circle" type="button" onclick="addToRole(this,`+idPermission+`,\``+name+`\`)"></button>
		</td>

</tr>
    `;
        permissionMayHad.rows.add($(trAppend)).draw();
        permissionHave.row($($(button).closest("tr"))).remove().draw(false);
    }
    function submitEdit(button){
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
                let formData = new FormData($(button).closest("form")[0]);
                let formObject = {};

                for (let [key, value] of formData.entries()) {
                    if (!formObject[key]) {
                        formObject[key] = [value];
                    } else {
                        formObject[key].push(value);
                    }
                }
                formObject["idRole"]=(${requestScope.role.id});
                <c:url var="EditRole" value="/admin/EditRole"/>
                $.ajax({
                    url: "${EditRole}",
                    type: "post",
                    data:formObject,
                    success: function (data) {
                        let isSuccess = (JSON.parse(data)).isSuccess;

                        if (isSuccess) {

                                 Swal.fire(
                                'Good job!',
                                'Sửa thành công!',
                                'success'
                            )
                        }
                    },
                    error: function (data) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: 'Sửa thất bại!',

                        })
                    }
                });
            }
        })
    }
</script>
</body>
</html>