<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Danh sách phim</title>
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
    <!-- Full calendar -->
    <link href='fullcalendar/core/main.css' rel='stylesheet'/>
    <link href='fullcalendar/daygrid/main.css' rel='stylesheet'/>
    <link href='fullcalendar/timegrid/main.css' rel='stylesheet'/>
    <link href='fullcalendar/list/main.css' rel='stylesheet'/>

    <link rel="stylesheet" href="css/flatpickr.min.css">
    <c:url var="MovieList" value="/admin/MovieList"/>
    <c:url var="chapterSetting" value="/admin/ChapterSetting"/>
    <c:url var="MovieEdit" value="/admin/MovieEdit"/>
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
    <div id="content-page" class="content-page">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <div class="iq-card">
                        <div class="iq-card-header d-flex justify-content-between">
                            <div class="iq-header-title">
                                <h4 class="card-title">Danh sách phim</h4>
                            </div>
                        </div>
                        <div class="iq-card-body">

                            <div class="table-responsive">
                                <table id="tableMovie" class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th>Mã</th>
                                        <th>Tên phim</th>
                                        <th>Tập hiện có</th>
                                        <th>Tổng số tập</th>
                                        <th>Loại phim</th>
                                        <th>Giá niêm yết</th>
                                        <th>Giá bán thực tế</th>
                                        <th>Lượt xem</th>
                                        <th>Ngày tạo</th>
                                        <th>Tùy chọn</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="movie" items="${requestScope.listMovie}">
                                        <tr>
                                            <td></td>
                                            <td>${movie.id}</td>
                                            <td>${movie.name}</td>
                                            <td>${movie.currentEpisode}</td>
                                            <td>${movie.totalEpisode}</td>
                                            <td>${movie.type.description}</td>
                                            <td>${movie.price}</td>
                                            <td>${movie.renderPrice}</td>
                                            <td>${movie.views}</td>
                                            <td>${movie.createAt}</td>
                                            <td>
                                                <div class="flex align-items-center list-user-action" style="float: left!important;">
                                                <button class="btn btn-outline-success" onclick="location.href='${chapterSetting}?idMovie=${movie.id}'"><i class="ion-upload"></i>
                                                </button>

                                                <button class="btn btn-outline-primary" data-toggle="tooltip"
                                                        data-placement="top" title=""
                                                        data-original-title="Edit" type="submit" onclick="location.href='${MovieEdit}?idMovie=${movie.id}'">
                                                    <i class="ri-pencil-line"></i>
                                                </button>

                                                <button class="btn btn-outline-danger" data-toggle="tooltip"
                                                        data-placement="top" title=""
                                                        data-original-title="Delete" type="button"
                                                        onclick="removeMovie(${movie.id},this)">
                                                    <i class="ri-delete-bin-line"></i>
                                                </button>
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
    <!-- Raphael-min JavaScript -->
    <script src="js/raphael-min.js"></script>
    <!-- Morris JavaScript -->
    <script src="js/morris.js"></script>
    <!-- Morris min JavaScript -->
    <script src="js/morris.min.js"></script>
    <!-- Flatpicker Js -->
    <script src="js/flatpickr.js"></script>
    <!-- Style Customizer -->
    <script src="js/style-customizer.js"></script>
    <!-- Chart Custom JavaScript -->
    <script src="js/chart-custom.js"></script>
    <!-- Custom JavaScript -->
    <script src="js/custom.js"></script>
    <script>

            $(document).ready(function () {
            $('#tableMovie').DataTable({
                rowId: 'row_num',
                columnDefs: [ {
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
                } ],
                order: [[ 0, 'asc' ]],
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


        function removeMovie(idMovie,button){
            Swal.fire({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'info',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    <c:url var="RemoveMovie" value="/admin/RemoveMovie"/>
                    $.ajax({
                        url: "${RemoveMovie}",
                        type: "post",
                        data: {
                            idMovie: idMovie,
                        },
                        success: function (data) {
                            let isSuccess = (JSON.parse(data)).isSuccess;
                            if(isSuccess){

                                $('#tableMovie').DataTable().row($($(button).closest('tr'))).remove().draw(false);
                            }
                        },
                        error: function (data) {
                            console.log(data)
                        }
                    });
                }
            })

        }
    </script>
</body>
</html>