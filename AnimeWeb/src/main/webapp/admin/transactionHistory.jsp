<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>Transaction History</title>
    <link rel="shortcut icon" href="images/favicon.ico"/>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- Typography CSS -->
    <link rel="stylesheet" href="css/typography.css">
    <!-- Style CSS -->
    <link rel="stylesheet" href="css/style.css">
    <!-- Responsive CSS -->
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css">
    <!-- Import jQuery library -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Import Datatables JavaScript library -->
    <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>

    <!-- Import Datatables CSS stylesheet -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">

    <!-- Import Bootstrap CSS stylesheet -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap.min.css">

</head>
<body>
<div class="wrapper">
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
                                <h4 class="card-title">Bootstrap Datatables</h4>
                            </div>
                        </div>
                        <div class="iq-card-body">
                            <p>Images in Bootstrap are made responsive with <code>.img-fluid</code>. <code>max-width:
                                100%;</code> and <code>height: auto;</code> are applied to the image so that it scales
                                with the parent element.</p>
                            <div class="table-responsive">
                                <table id="transaction" class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th>Tên khách hàng</th>
                                        <th>Biến động số dư</th>
                                        <th>Chi tiết</th>
                                        <th>Thời gian</th>
                                        <th></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="row" items="${requestScope.transactionHistoryList}">
                                        <tr>
                                            <c:choose>
                                                <c:when test="${fn:contains(row.residualRange, '-')}">
                                                    <td>${row.getUserName()}</td>
                                                    <td><span style="color:red">${row.residualRange} VND</span></td>
                                                    <td>${row.description}</td>
                                                    <td>${row.changeFormat()}</td>
                                                    <td>
                                                        <button class="iq-bg-primary" data-toggle="tooltip"
                                                                data-placement="top" title=""
                                                                data-original-title="Delete" type="button" onclick="Remove(${row.id},this)">
                                                            <i class="ri-delete-bin-line"></i>
                                                        </button>
                                                    </td>
                                                </c:when>
                                                <c:otherwise>
                                                    <td>${row.getUserName()}</td>
                                                    <td><span style="color:#00c300">${row.residualRange} VND</span></td>
                                                    <td>${row.description}</td>
                                                    <td>${row.changeFormat()}</td>
                                                    <td>
                                                        <button class="iq-bg-primary" data-toggle="tooltip"
                                                                data-placement="top" title=""
                                                                data-original-title="Delete" type="button" onclick="Remove(${row.id},this)">
                                                            <i class="ri-delete-bin-line"></i>
                                                        </button>
                                                    </td>
                                                </c:otherwise>
                                            </c:choose>
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

<script src="js/jquery.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js"></script>
<script>
    $(document).ready(function () {
        $('#transaction').DataTable({
            "searching": true,
            "sorting": true,
            dom: 'Bfrtip',
            buttons: [
                'copy', 'csv', 'excel', 'pdf', 'print'
            ],
        });

    });
</script>
<script>
    function Remove(id,button) {
        const swalWithBootstrapButtons = Swal.mixin({
            customClass: {
                confirmButton: 'btn btn-success',
                cancelButton: 'btn btn-danger'
            },
            buttonsStyling: false
        })

        swalWithBootstrapButtons.fire({
            title: 'Are you sure?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Yes, delete it!',
            cancelButtonText: 'No, cancel!',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: "/admin/removeTransactionHistory",
                    type: "post",
                    data: {
                        id: id,
                    },
                    success: function (data) {
                        console.log(data);

                        $('#transaction').DataTable().row($($(button).closest('tr'))).remove().draw(false);
                    },
                    error: function (data) {
                        console.log(data.responseText)
                    }
                });
                swalWithBootstrapButtons.fire(
                    'Deleted!',
                    'Your file has been deleted.',
                    'success'
                )
            } else if (
                /* Read more about handling dismissals below */
                result.dismiss === Swal.DismissReason.cancel
            ) {
                swalWithBootstrapButtons.fire(
                    'Cancelled',
                    'Your imaginary file is safe :)',
                    'error'
                )
            }
        })

    }
</script>
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


<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>
