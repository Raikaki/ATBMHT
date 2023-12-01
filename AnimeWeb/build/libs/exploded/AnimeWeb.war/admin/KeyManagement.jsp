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
  <title>Danh sách khóa</title>
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
                <h4 class="card-title">Danh sách khóa</h4>
              </div>
            </div>
            <div class="iq-card-body">
              <div class="table-responsive">

                <table id="key-list-table"
                       class="table table-striped table-bordered mt-4" role="grid"
                       aria-describedby="user-list-page-info" style="text-align: center">
                  <thead>
                  <tr>
                    <th>id</th>
                    <th>Public key</th>
                    <th>id người dùng sở hữu</th>
                    <th>userName</th>
                    <th>Ngày tạo</th>
                    <th>Ngày hết hạn</th>
                    <th>Ngày hủy</th>
                    <th>Trạng thái</th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach var="item" items="${requestScope.keyList}">
                    <tr>
                     <td>${item.id}</td>
                      <td>${item.idAccount}</td>
                      <td>${item.userName}</td>
                      <td>${item.key}</td>
                      <td>${item.dayReceive}</td>
                      <td>${item.dayExpired}</td>
                      <td>${item.dayCanceled}</td>
                      <td><div id="renderIsActive${item.id}">
                        <c:if test="${item.status==1}">
                        <span class="badge iq-bg-success">
															</c:if>
															<c:if test="${item.status==0}">
																<span class="badge iq-bg-danger">
															</c:if>
                                                                    ${item.statusDescription}</span>
                      </div></td>
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
    tableSupplier=$('#key-list-table').DataTable({
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
</script>

</body>
</html>