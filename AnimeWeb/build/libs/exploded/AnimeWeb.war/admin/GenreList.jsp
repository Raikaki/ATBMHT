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
  <title>Danh sách thể loại</title>
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
  <link rel="stylesheet"
        href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/flatpickr.min.css">


  <c:url var="MovieList" value="/admin/MovieList"/>
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
                <h4 class="card-title">Danh sách thể loại</h4>
              </div>
            </div>
            <div class="iq-card-body">
              <div id="table" class="table-editable">
                              <span class="genre-add float-right mb-3 mr-2">
                              <button class="btn btn-sm iq-bg-success"><i
                                      class="ri-add-fill"><span class="pl-1">Thêm mới</span></i>
                              </button>
                              </span>
                <table class="table table-bordered table-responsive-md table-striped text-center"
                       id="tableGenre">

                  <thead>
                  <tr>
                    <th>Stt</th>
                    <th>Mã</th>
                    <th>Mô tả</th>
                    <th>Tùy chọn</th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:set var="stt" value="0"/>
                  <c:forEach var="genre" items="${requestScope.genres}">
                    <c:set var="stt" value="${stt + 1}"/>
                    <tr>
                      <td contenteditable="false">${stt}</td>
                      <td contenteditable="false" id="idGenre">${genre.id}</td>
                      <td contenteditable="false" id="descriptionGenre">${genre.description}</td>
                      <td>
                                          <span class="table-remove"><button type="button"
                                                                             class="btn iq-bg-danger btn-rounded btn-sm my-0" onclick="removeGenre(${genre.id},this)">Xóa</button>
                                             <span id="settingChapter"><button type="button" class="btn btn-info"  onclick="settingGenre(${genre.id},this)">Chỉnh sửa</button></span>
                                          </span>
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
  <!-- jQuery -->
  <script>
    var tableGenre;
    $(document).ready(function () {

      tableGenre= $('#tableGenre').DataTable({
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


  $(".genre-add").on("click",function (){
    let data=` <tr id="addGenre">
                      <td contenteditable="false">${stt}</td>
                      <td contenteditable="false" id="idGenre">${genre.id}</td>
                      <td contenteditable="true" id="descriptionGenre">${genre.description}</td>
                      <td>
                                             <span id="insertGenre"><button type="button" class="btn btn-info" value="${genre.id}" onclick="insertGenre(this)">Thêm</button></span>
                                          </span>
                      </td>
                    </tr>`
    if ($("#addGenre").length) {

    } else {
      $('#tableGenre').append(data);
    }
  })
  function removeGenre(idGenre,button){


    Swal.fire({
      title: 'Xác nhận?',
      text: "Bạn chắc chắn thực hiện thao tác này!",
      icon: 'info',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, remove it!'
    }).then((result) => {
      <c:url var="RemoveGenre" value="/admin/RemoveGenre"/>
      if (result.isConfirmed) {
        if(idGenre){
          $.ajax({
            url: "${RemoveGenre}",
            type: "post",
            data: {
              idGenre: idGenre,
            },
            success: function (response) {
              let isSuccess = (JSON.parse(response)).isSuccess;

              if(isSuccess){
                tableGenre.row($($(button).closest("tr"))).remove().draw(false);

                Swal.fire(
                        'Good job!',
                        'Xóa thành công!',
                        'success'
                )
              }
            },
            error: function (data) {
              Swal.fire('Xóa thất bại, hãy kiểm tra và thử lại');
            }
          });
        }else{
          Swal.fire('Dữ liệu không hợp lệ, hãy kiểm tra và thử lại');
        }
      }
    });
  }
  function settingGenre(idGenre,button){
    let tr = $(button).closest("tr");
    let tdArray = $(tr).find("td");
    $(tdArray[2]).attr("contenteditable","true");
    $(tdArray[3]).html(`<span id="submitSetting"><button type="button" class="btn btn-info"  onclick="submitSetting(`+idGenre+`,this)">Xác nhận</button></span>`)
  }
  function submitSetting(idGenre,button){
    let tr = $(button).closest("tr");
    let tdArray = $(tr).find("td");
    let description = $(tdArray[2]).text();
    if(description&& description.trim()!==""){
      Swal.fire({
        title: 'Xác nhận?',
        text: "Bạn chắc chắn thực hiện thao tác này!",
        icon: 'info',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, change it!'
      }).then((result) => {
        if (result.isConfirmed) {
          <c:url var="SettingGenre" value="/admin/SettingGenre"/>
          $.ajax({
            url: "${SettingGenre}",
            type: "post",
            data: {
              idGenre:idGenre,
              genreDescription: description,
            },
            success: function (response) {
              let data = JSON.parse(response);
              let genre = JSON.parse(data.genre);
              if(genre){
              $(description).text(genre.description);
                $(tdArray[2]).attr("contenteditable","false");
                $(tdArray[3]).html(
                        `  <span class="table-remove"><button type="button"
                                                                             class="btn iq-bg-danger btn-rounded btn-sm my-0" onclick="removeGenre(`+genre.id+`,this)">Xóa</button>
                                             <span id="settingChapter"><button type="button" class="btn btn-info"  onclick="settingGenre(`+genre.id+`,this)">Sửa</button></span>
                                          </span>
                        `
                );
                Swal.fire(
                        'Good job!',
                        'Sửa thành công!',
                        'success'
                )
              }
            },
            error: function (data) {
              Swal.fire('Sửa thất bại, hãy kiểm tra và thử lại');
            }
          });
        }
      })

    }else{
      Swal.fire('Mô tả không được để trống');
    }
  }
  function insertGenre(button){
    let tr = $(button).closest("tr");
    let description = $($(tr).find("#descriptionGenre")).text();

   if(description&& description.trim()!==""){
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
         <c:url var="InsertGenre" value="/admin/InsertGenre"/>
         $.ajax({
           url: "${InsertGenre}",
           type: "post",
           data: {
             genreDescription: description,
           },
           success: function (response) {
             let data = JSON.parse(response);
             let genre = JSON.parse(data.genre);
             if(genre){
               let newRow = ` <tr>
                      <td contenteditable="false">${stt}</td>
                      <td contenteditable="false" id="idGenre">`+genre.id+`</td>
                      <td contenteditable="false" id="descriptionGenre">`+genre.description+`</td>
                      <td>
                                          <span class="table-remove"><button type="button"
                                                                             class="btn iq-bg-danger btn-rounded btn-sm my-0" onclick="removeGenre(`+genre.id+`,this)">Xóa</button>
                                             <span id="settingChapter"><button type="button" class="btn btn-info" value="`+genre.id+`" onclick="settingGenre(this)">Chỉnh sửa</button></span>
                                          </span>
                      </td>
                    </tr>`
               $("#addGenre").remove();
               tableGenre.rows.add($(newRow)).draw();
               Swal.fire(
                       'Good job!',
                       'Thêm thành công!',
                       'success'
               )
             }
           },
           error: function (data) {
             Swal.fire('Thêm thất bại, hãy kiểm tra và thử lại');
           }
         });
       }
     })

   }else{
     Swal.fire('Mô tả không được để trống');
   }
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
</body>
</html>