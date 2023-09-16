<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>User List</title>
    <!-- Favicon -->
    <link rel="shortcut icon" href="images/favicon.ico"/>
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

    <c:url var="BlogEdit" value="/admin/BlogEdit"/>
    <c:url var="RemoveBlog" value="/admin/RemoveBlog"/>


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
    <c:import url="/admin/sidebar.jsp"/>
    <!-- TOP Nav Bar -->
    <c:import url="/admin/header.jsp"/>
    <!-- TOP Nav Bar END -->
    <!-- Page Content  -->
    <div id="content-page" class="content-page">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <div class="iq-card">
                        <div class="iq-card-header d-flex justify-content-between">
                            <div class="iq-header-title">
                                <h4 class="card-title">Blog List</h4>
                            </div>
                        </div>
                        <div class="iq-card-body">
                            <div class="table-responsive">
                                <div class="row justify-content-between">
                                    <div class="col-sm-12 col-md-6">
                                        <div id="user_list_datatable_info" class="dataTables_filter">
                                            <form class="mr-3 position-relative">
                                                <div class="form-group mb-0">
                                                    <input type="search" class="form-control"
                                                           id="exampleInputSearch" placeholder="Search"
                                                           aria-controls="user-list-table">
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                    <div class="col-sm-12 col-md-6">
                                        <div class="user-list-files d-flex float-right">
                                            <a class="iq-bg-primary" href="javascript:void();">
                                                Print </a> <a class="iq-bg-primary" href="javascript:void();">
                                            Excel </a> <a class="iq-bg-primary" href="javascript:void();">
                                            Pdf </a>
                                        </div>
                                    </div>
                                </div>
                                <table id="user-list-table"
                                       class="table table-striped table-bordered mt-4" role="grid"
                                       aria-describedby="user-list-page-info">
                                    <thead>
                                    <tr>
                                        <th>Avatar</th>
                                        <th>Title</th>
                                        <th>Folder</th>
                                        <th>CreateAt</th>
                                        <th>releaseAt</th>
                                        <th>UpdateAt</th>
                                        <th>Status</th>

                                        <th>Action</th>


                                    </tr>
                                    </thead>
                                    <tbody>

                                    <c:forEach var="item" items="${requestScope.listBlog}">
                                        <tr>
                                            <td class="text-center"><img
                                                    class="rounded img-fluid avatar-40" src="/${item.avatar}"
                                                    alt="profile"></td>
                                            <td>${item.title}</td>
                                            <td>${item.folder}</td>
                                            <td>${item.createAt}</td>
                                            <td>${item.releaseAt}</td>
                                            <td>${item.updateAt}</td>
                                            <td>${item.status}</td>

                                            <td>

                                                <div class="flex align-items-center list-user-action">

                                                    <form method="post" action="${BlogEdit}?idBlog=${item.id}">
                                                        <input name="idUser" type="hidden" value="22">
                                                        <button class="iq-bg-primary" data-toggle="tooltip"
                                                                data-placement="top" title="" data-original-title="Edit"
                                                                type="submit">
                                                            <i class="ri-pencil-line"></i>
                                                        </button>
                                                    </form>
                                                    <c:if test="${item.status==1}">

                                                    <form method="post" action="${RemoveBlog}?idBlog=${item.id}"
                                                          id="removeForm${item.id}">
                                                        <button class="iq-bg-primary" data-toggle="tooltip"
                                                                data-placement="top" title=""
                                                                data-original-title="Delete" type="button"
                                                                onclick="submitRemove(${item.id})">
                                                            <i class="ri-delete-bin-line"></i>
                                                        </button>
                                                    </form>
                                                    </c:if>
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
<script src="js/jquery.min.js"></script>
<script src="js/popper.min.js"></script>
<script>
    function submitRemove(idBlog) {
        var formName = "removeForm" + idBlog;
        Swal.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                console.log($("#" + formName).serialize()); // In ra dữ liệu gửi đến POST bằng jQuery
                $("#" + formName).submit(); // Gửi yêu cầu POST bằng jQuery
            }
        })
    }

</script>
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