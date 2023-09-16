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
  <title>Quản lý vai trò</title>
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
  <link rel="stylesheet" href="css/flatpickr.min.css">
  <c:url var="settingBonusMovie" value="/admin/SettingBonusMovie" />

  <c:url var="editRole" value="/admin/EditRole"/>
  <c:url var="removeRole" value="/admin/RemoveRole"/>
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
                <h4 class="card-title">Danh sách vai trò</h4>
              </div>
            </div>
            <div class="iq-card-body">
              <jsp:useBean id="daoRole" class="database.DAORoleAccount"/>
              <jsp:useBean id="daoPermission" class="database.DAOPermission"/>
              <c:forEach var="roleItem" items="${requestScope.listRole}">
                <div class="table-responsive">
                  <h2>${roleItem.description}</h2>
                <c:if test="${roleItem.id!=1}">
                  <form method="post" action="${removeRole}?idRole=${roleItem.id}"><span><button type="button" onclick="confirmRemove(this)"  class="btn iq-bg-warning btn-rounded btn-sm my-0" ><i class="ri-delete-bin-line"></i></button></span></form>
                  <a href="${editRole}?idRole=${roleItem.id}" ><span> <button type="submit" class="btn iq-bg-warning btn-rounded btn-sm my-0" ><i class="ri-pencil-line"></i></button></span></a>
                </c:if>
                <table class="table table-bordered table-responsive-md table-striped text-center" id="roleTable${roleItem.id}">
                  <thead>
                  <tr>
                    <th></th>
                    <th>Mã người dùng</th>
                    <th>User name</th>
                    <th>Tùy chọn</th>
                  </tr>
                  </thead>
                  <tbody>
                      <c:forEach var="user" items="${daoRole.getUserHasRole(roleItem.id)}">
                        <tr>
                          <td></td>
                          <td>${user.id}</td>
                          <td>${user.userName}</td>
                          <td id="settingRole">
                            <form method="post">
                              <div style="text-align: left;">
                                <c:forEach var="pms" items="${daoPermission.getRolePermission(user.id,roleItem.id)}">
                                  <input type="checkbox" name="perms" id="pms${user.id}${roleItem.id}" value="${pms.id}" checked><label for="pms${user.id}${roleItem.id}">${pms.name}</label><br>
                                </c:forEach>
                                <c:forEach var="npms" items="${daoPermission.getRolePermissionNotHave(user.id,roleItem.id)}">
                                  <input type="checkbox" name="perms" id="npms${user.id}${roleItem.id}" value="${npms.id}"><label for="npms${user.id}${roleItem.id}">${npms.name}</label><br>
                                </c:forEach>
                              </div>
                              <div style="text-align: center">
                              <c:if test="${roleItem.id!=1}">
                                <span class="table-remove">
                                <button type="button" class="btn iq-bg-success btn-rounded btn-sm my-0" onclick="settingRole(this,${user.id},${roleItem.id})">
                                Xác nhận</button>
                                <button type="button" class="btn iq-bg-warning btn-rounded btn-sm my-0" onclick="removeUserRole(this,${user.id},${roleItem.id})">
                                  Xóa Quyền</button></span>
                              </c:if>
                              </div>
                            </form>
                          </td>
                        </tr>
                      </c:forEach>
                  </tbody>
                </table>
                </div>
                <script>
                  $(document).ready(function () {
                  $('#roleTable${roleItem.id}').DataTable({
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
              </c:forEach>

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
  <script src="js/custom.js"></script>
<script>
  function removeUserRole(button,userId,roleId){
    Swal.fire({
      title: 'Xác nhận?',
      text: "Bạn chắc chắn thực hiện thao tác này!",
      icon: 'info',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, remove it!'
    }).then((result) => {
      if (result.isConfirmed) {
        <c:url var="RemoveUserRole" value="/admin/RemoveUserRole"/>
        $.ajax({
          url: "${RemoveUserRole}",
          type: "post",
          data: {
            userId:userId,
            roleId:roleId,
          },
          success: function (data) {
            let isSuccess = (JSON.parse(data)).isSuccess;
            if (isSuccess) {
              Swal.fire({
                icon: 'success',
                title: 'Thành công',
                text: 'Xóa thành công!',

              })
              $("#roleTable"+roleId).DataTable().row($($(button).closest("tr"))).remove().draw(false);
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
              text: 'Sửa thất bại!',

            })
          }
        });
      }
    });

  }
  function settingRole(button, userId, roleId) {
    let formData = new FormData($(button).closest("form")[0]);
    let formObject = {};

    for (let [key, value] of formData.entries()) {
      if (!formObject[key]) {
        formObject[key] = [value];
      } else {
        formObject[key].push(value);
      }
    }
    formObject["userId"]=(userId);
    formObject["roleId"]=(roleId);
    <c:url var="SettingUserPermission" value="/admin/SettingUserPermission"/>
    $.ajax({

      url: "${SettingUserPermission}",
      type: "post",
      data: formObject,
      success: function (data) {
        let isSuccess = (JSON.parse(data)).isSuccess;
        if (isSuccess) {
          Swal.fire({
            icon: 'success',
            title: 'Thành công',
            text: 'Sửa thành công!',

          })
        }else{
          Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Sửa thất bại!',

          })
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
 function confirmRemove(button){
   Swal.fire({
     title: 'Xác nhận?',
     text: "Bạn chắc chắn thực hiện thao tác này!",
     icon: 'info',
     showCancelButton: true,
     confirmButtonColor: '#3085d6',
     cancelButtonColor: '#d33',
     confirmButtonText: 'Yes, remove it!'
   }).then((result) => {
     if (result.isConfirmed) {
       $(button).closest("form")[0].submit();
     }
     });

 }
</script>

</body>
</html>