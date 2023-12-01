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
  <title>Chỉnh sửa khuyến mãi</title>
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
  <script src="https://kit.fontawesome.com/fe2c9f6253.js"
          crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://kit.fontawesome.com/fe2c9f6253.css"
        crossorigin="anonymous">
  <link rel="stylesheet" href="css/flatpickr.min.css">
  <c:url var="settingBonusMovie" value="/admin/SettingBonusMovie" />
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
                <h4 class="card-title">Chỉnh sửa khuyến mãi</h4>
              </div>
            </div>
            <div class="iq-card-body">
                 <h2>${requestScope.bonus.id}</h2>
                <h2>${requestScope.bonus.description}</h2>
              <table class="table table-bordered table-responsive-md table-striped text-center"
                     id="tableBonusMovie">
                <thead>
                    <tr>
                        <th></th>
                        <th>Mã phim</th>
                        <th>Tên phim</th>
                        <th>Tùy chọn</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="bnMovie" items="${requestScope.bonus.bonusMovie}">
                          <tr>
                              <td></td>
                            <td id="idBm">${bnMovie.id}</td>
                            <td id="nameBm">${bnMovie.name}</td>
                            <td>  <span class="table-remove" id="removeMovieBonus">
                              <button type="button" class="btn iq-bg-danger btn-rounded btn-sm my-0"><i
                                                             class="ri-delete-bin-line" onclick="removeMovie(this,${bnMovie.id},${requestScope.bonus.id})"></i></button></span></td>
                          </tr>
                    </c:forEach>
                </tbody>
              </table>
              <table class="table table-bordered table-responsive-md table-striped text-center"
                     id="tableEnableBonusMovie">
                <thead>
                <tr>
                  <th></th>
                  <th>Mã phim</th>
                  <th>Tên phim</th>
                  <th>Tùy chọn</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="bnMovie" items="${requestScope.enableAddMovie}">
                  <tr>
                    <td></td>
                    <td id="idM">${bnMovie.id}</td>
                    <td id="nameM">${bnMovie.name}</td>
                    <td><span class="table-remove"><button class="btn iq-bg-info fa fa-plus-circle" onclick="addMovie(this,${bnMovie.id},${requestScope.bonus.id})"></button> </span></td>
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
    var tableBonus;
    var tableMovie;
    $(document).ready(function () {
      tableBonus = $('#tableBonusMovie').DataTable({
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
        dom: 'Bfrtip',
        buttons: [
          'copy', 'csv', 'excel', 'pdf', 'print'
        ],

      });
      tableMovie = $('#tableEnableBonusMovie').DataTable({
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
    function removeMovie(button,idMovieBonus,idBonus){
      Swal.fire({
        title: 'Xác nhận?',
        text: "Bạn chắc chắn thực hiện thao tác này!",
        icon: 'info',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, remove it!'
      }).then((result) => {
        <c:url var="RemoveBonusMovie" value="/admin/RemoveBonusMovie"/>
        if (result.isConfirmed) {
          $.ajax({
            url: "${RemoveBonusMovie}",
            type: "post",
            data: {
              idBonus: idBonus,
              idMovieBonus:idMovieBonus,
            },
            success: function (data) {
              let isSuccess = (JSON.parse(data)).isSuccess;
              if (isSuccess) {
                let newRow ="";
                let oldRow = $($(button).closest("tr"));
                newRow=` <tr>
                    <td></td>
                    <td>`+$(oldRow).find("#idBm").text()+`</td>
                            <td>`+$(oldRow).find("#nameBm").text()+`</td>
                    <td><span class="table-remove"><button class="btn iq-bg-info fa fa-plus-circle" onclick="addMovie(this,`+$(oldRow).find("#idBm").text()+`,${requestScope.bonus.id})"></button> </span></td>
                  </tr>`
                tableMovie.rows.add($(newRow)).draw();
                tableBonus.row(oldRow).remove().draw(false);
                Swal.fire({
                  icon: 'success',
                  title: 'Thành công',
                  text: 'Xóa thành công!',

                })
              }else{
                Swal.fire({
                  icon: 'error',
                  title: 'Oops...',
                  text: 'Xóa thất bại, Bộ phim trong khuyến mãi không tồn tại hoặc đã bị xóa trước đó!',

                })
              }
            },
            error: function (data) {
              Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Có lỗi không xác định trong quá trình xóa!',

              })
            }
          });
        }
      })
    }
    function addMovie(button,idMovieBonus,idBonus){
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
          <c:url var="AddBonusMovie" value="/admin/AddBonusMovie"/>
          $.ajax({
            url: "${AddBonusMovie}",
            type: "post",
            data: {
              idBonus: idBonus,
              idMovieBonus:idMovieBonus,
            },
            success: function (data) {
              let isSuccess = (JSON.parse(data)).isSuccess;
              if (isSuccess) {
                let newRow ="";
                let oldRow = $($(button).closest("tr"));
                newRow=`   <tr>
                              <td></td>
                              <td>`+$(oldRow).find("#idM").text()+`</td>
                            <td>`+$(oldRow).find("#nameM").text()+`</td>
                            <td>  <span class="table-remove" id="removeMovieBonus">
                              <button type="button" class="btn iq-bg-danger btn-rounded btn-sm my-0"><i
                                                             class="ri-delete-bin-line" onclick="removeMovie(this,`+$(oldRow).find("#idM").text()+`,${requestScope.bonus.id})"></i></button></span></td>
                          </tr>`;
                tableBonus.rows.add($(newRow)).draw();
                tableMovie.row(oldRow).remove().draw(false);
                Swal.fire({
                  icon: 'success',
                  title: 'Thành công',
                  text: 'Thêm thành công!',

                })
              }else{
                Swal.fire({
                  icon: 'error',
                  title: 'Oops...',
                  text: 'Thêm thất bại, Bộ phim trong khuyến mãi không tồn tại hoặc đã tồn tại trong đợt khuyến mãi trùng với đợt khuyến mãi này!',

                })
              }
            },
            error: function (data) {
              Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Có lỗi không xác định trong quá trình thêm!',

              })
            }
          });
        }
      })
    }
  </script>

</body>
</html>