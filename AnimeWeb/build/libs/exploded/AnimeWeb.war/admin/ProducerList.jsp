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
  <title>Danh sách nhà sản xuất</title>
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
                <h4 class="card-title">Danh sách nhà sản xuất</h4>
              </div>
            </div>
            <div class="iq-card-body">
              <div class="table-responsive">
                                 <span class="addProducer float-right mb-3 mr-2">
                              <button class="btn btn-sm iq-bg-success"><i
                                      class="ri-add-fill"><span class="pl-1">Thêm mới</span></i>
                              </button>
                              </span>
                <table id="tableProducer" class="table table-striped table-bordered">
                  <thead>
                  <tr>
                    <th></th>
                    <th>Mã</th>
                    <th>Tên</th>
                    <th>Mô tả</th>
                    <th>Trạng thái</th>
                    <th>Ngày tạo</th>
                    <th>Tùy chọn</th>
                  </tr>
                  </thead>
                  <tbody>

                  <c:forEach var="producer" items="${requestScope.listProducer}">

                    <tr>
                      <td></td>
                      <td>${producer.id}</td>
                      <td contenteditable="false">${producer.name}</td>
                      <td contenteditable="false">${producer.description}</td>

                      <td>
                        <div id="renderIsActive${producer.id}">
                          <c:if test="${producer.status==1}">
                          <span class="badge iq-bg-success">
															</c:if>
															<c:if test="${producer.status==0}">
																<span class="badge iq-bg-danger">
															</c:if>
                                                                    ${producer.statusString}</span>
                        </div>
                      </td>
                      <td>${producer.createAt}</td>
                      <td>
                        <div id="option_Producer">
                          <c:if test="${producer.status==1}">
                                                <span class="table-remove" id="hideProducer">
                                                    <button type="button"
                                                            class="btn iq-bg-danger btn-rounded btn-sm my-0"
                                                            onclick="hideProducer(${producer.id},this)"><i
                                                            class="fa-solid fa-eye-slash"></i></button></span>
                            <span class="table-remove" id="showProducer"
                                  style="display: none!important;">
                                                         <button type="button"
                                                                 class="btn iq-bg-success btn-rounded btn-sm my-0"
                                                                 onclick="displayProducer(${producer.id},this)"><i
                                                                 class="fa-solid fa-eye"></i></button></span>

                          </c:if>
                          <c:if test="${producer.status==0}">
                                                          <span class="table-remove" id="hideProducer"
                                                                style="display: none!important;">
                                                              <button type="button"
                                                                      class="btn iq-bg-danger btn-rounded btn-sm my-0"
                                                                      onclick="hideProducer(${producer.id},this)"><i
                                                                      class="fa-solid fa-eye-slash"></i></button></span>
                            <span class="table-remove" id="showProducer">
                                                         <button type="button"
                                                                 class="btn iq-bg-success btn-rounded btn-sm my-0"
                                                                 onclick="displayProducer(${producer.id},this)"><i
                                                                 class="fa-solid fa-eye"></i></button></span>

                          </c:if>
                          <span class="table-remove" id="removeProducer">
                                                     <button type="button"
                                                             class="btn iq-bg-danger btn-rounded btn-sm my-0"
                                                             onclick="removeProducer(${producer.id},this)"><i
                                                             class="ri-delete-bin-line"></i></button></span>
                          <span class="table-remove" id="settingProducer">
                                                     <button type="button"
                                                             class="btn iq-bg-info btn-rounded btn-sm my-0"
                                                             onclick="editProducer(${producer.id},this)"><i
                                                             class="ri-pencil-line"></i></button></span>

                        </div>
                        <div id="editProducerArea" style="display: none">
                          <button type="button" class="btn btn-info"
                                  onclick="submitEdit(${producer.id},this)" id="submitEdit"
                                  disabled>Xác nhận chỉnh sửa
                          </button>
                        </div>
                      </td>
                    </tr>
                  </c:forEach>
                  </tbody>

                </table>
                <div id="addArea">

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
    var tableProducer;
    <jsp:useBean id="status" class="model.Status"/>
    $(document).ready(function () {
      tableProducer = $('#tableProducer').DataTable({
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
      let addRow=`<table class="table table-striped table-bordered" >
              <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Description</th>
                                        <th>Action</th>

                                    </tr>
                                    </thead>
                                    <tbody>
                 <tr id="addProducer">


                                            <td contenteditable="true" id="addName"></td>
                                            <td contenteditable="true" id="addDescription"></td>

                                            <td>
                                               <span class="table-remove">
                                               <button type="button" class="btn btn-sm iq-bg-success btn-rounded btn-sm my-0" onclick="submitAdd(this)" id="submitAddButton">Xác nhận</button>
                                                </span>
                                            </td>
                                        </tr>
                                        </tbody>
                                        </table>
            `
      $(".addProducer").on("click",()=>{
        if ($("#addProducer").length) {
          $("#addArea").html(``);
        } else {
          $("#addArea").html(addRow);
          let button = $("#submitAddButton");
          let tr = $(button).closest("tr");
          let tdArray = $(tr).find("td");
          validate(button, tdArray[0], tdArray[1]);
          enableSubmit(button, tdArray[0], tdArray[1]);

        }
      });
    });
    function submitAdd(button){
      let tr = $(button).closest("tr");
      let tdArray = $(tr).find("td");

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
          let addName =  $(tdArray[0]).text();
          let addDescription = $(tdArray[1]).text();

          <c:url var="AddProducer" value="/admin/AddProducer"/>
          $.ajax({
            url: "${AddProducer}",
            type: "post",
            data: {
              addName:addName,
              addDescription:addDescription,

            },
            success: function (data) {
              let newProducer = JSON.parse((JSON.parse(data)).newProducer);

              let createAt = newProducer.createAt;



              let appendInsert=`<tr>
                                            <td></td>
                                            <td>`+newProducer.id+`</td>
                                            <td contenteditable="false">`+newProducer.name+`</td>
                                            <td contenteditable="false">`+newProducer.description+`</td>

                                            <td>
                                                <div id="renderIsActive`+newProducer.id+`">

                                                    <span class="badge iq-bg-success">
                                                                        `+newProducer.statusString+`</span>
                                                </div>
                                            </td>

                                            <td>`+createAt+`</td>
                                            <td>
                                                <div id="option_producer">

                                                <span class="table-remove" id="hideProducer">
                                                    <button type="button"
                                                            class="btn iq-bg-danger btn-rounded btn-sm my-0"
                                                            onclick="hideProducer(`+newProducer.id+`,this)"><i
                                                            class="fa-solid fa-eye-slash"></i></button></span>
                                                        <span class="table-remove" id="showProducer"
                                                              style="display: none!important;">
                                                         <button type="button"
                                                                 class="btn iq-bg-success btn-rounded btn-sm my-0"
                                                                 onclick="displayProducer(`+newProducer.id+`,this)"><i
                                                                 class="fa-solid fa-eye"></i></button></span>



                                                    <span class="table-remove" id="removeProducer">
                                                     <button type="button"
                                                             class="btn iq-bg-danger btn-rounded btn-sm my-0"
                                                             onclick="removeProducer(`+newProducer.id+`,this)"><i
                                                             class="ri-delete-bin-line"></i></button></span>
                                                    <span class="table-remove" id="settingProducer">
                                                     <button type="button"
                                                             class="btn iq-bg-info btn-rounded btn-sm my-0"
                                                             onclick="editProducer(`+newProducer.id+`,this)"><i
                                                             class="ri-pencil-line"></i></button></span>

                                                </div>
                                                <div id="editProducerArea" style="display: none">
                                                    <button type="button" class="btn btn-info"
                                                            onclick="submitEdit(`+newProducer.id+`,this)" id="submitEdit"
                                                            disabled>Xác nhận chỉnh sửa
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>`;
              tableProducer.rows.add($(appendInsert)).draw();
              $("#addProducer").remove();
              Swal.fire({
                icon: 'success',
                title: 'Thành công',
                text: 'Thêm thành công!',

              })
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
      })

    }
    function editProducer(idProducer, button) {
      let tr = $(button).closest("tr");
      let tdArray = $(tr).find("td");
      $(tdArray[2]).attr("contenteditable", "true");
      $(tdArray[3]).attr("contenteditable", "true");
      $(tdArray[2]).addClass("edit-box");
      $(tdArray[3]).addClass("edit-box");

      $($(tdArray[6]).find("#option_Producer")).css("display", "none");
      $($(tdArray[6]).find("#editProducerArea")).css("display", "block");

      let submitEdit = $(tr).find("#submitEdit");
      validate(submitEdit, tdArray[2], tdArray[3]);
      enableSubmit(submitEdit, tdArray[2], tdArray[3]);

    }

    function submitEdit(idProducer, button) {
      Swal.fire({
        title: 'Xác nhận?',
        text: "Bạn chắc chắn thực hiện thao tác này!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, edit it!'
      }).then((result) => {
        if (result.isConfirmed) {
          let tr = $(button).closest("tr");
          let tdArray = $(tr).find("td");

          <c:url var="EditProducer" value="/admin/EditProducer"/>
          $.ajax({
            url: "${EditProducer}",
            type: "post",
            data: {
              idProducer: idProducer,
              name: $(tdArray[2]).text(),
              description: $(tdArray[3]).text(),
              phone: $(tdArray[4]).text(),
              address: $(tdArray[5]).text(),
            },
            success: function (data) {
              let updatedProducer = (JSON.parse(data)).updatedProducer;
              if (updatedProducer) {
                $(tdArray[2]).text(updatedProducer.name);
                $(tdArray[3]).text(updatedProducer.description);
                $(tdArray[2]).attr("contenteditable", "false");
                $(tdArray[3]).attr("contenteditable", "false");
                $(tdArray[2]).removeClass("edit-box");
                $(tdArray[3]).removeClass("edit-box");
                Swal.fire(
                        'Good job!',
                        'Sửa thành công!',
                        'success'
                )
                $($(tdArray[6]).find("#option_Producer")).css("display", "block");
                $($(tdArray[6]).find("#editProducerArea")).css("display", "none");
              } else {
                Swal.fire({
                  icon: 'error',
                  title: 'Oops...',
                  text: 'Sửa thất bại, nhà cung cấp không tồn tại hoặc đã bị xóa trước đó!',

                })
              }
            },
            error: function (data) {
              Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Sửa thất bại, nhà cung cấp không tồn tại hoặc đã bị xóa trước đó!',

              })
            }
          });
        }
      })

    }

    function validate(submit, ...tds) {

      tds.forEach(td => {
        td.addEventListener("input", () => {
          enableSubmit(submit, ...tds);
        });
      })
    }

    function enableSubmit(submit, ...tds) {
      let isNotEmpty = true;
      tds.forEach(td => {
        isNotEmpty &= $(td).text().trim() !== "";
      })
      if (isNotEmpty) {
        $(submit).prop('disabled', false);
      } else {
        $(submit).prop('disabled', true);

      }
    }

    function removeProducer(idProducer, button) {
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
          <c:url var="RemoveProducer" value="/admin/RemoveProducer"/>
          $.ajax({
            url: "${RemoveProducer}",
            type: "post",
            data: {
              idProducer: idProducer,

            },
            success: function (data) {
              let isSuccess = (JSON.parse(data)).isSuccess;

              if (isSuccess) {

                tableProducer.row($($(button).closest("tr"))).remove().draw(false);
                Swal.fire(
                        'Good job!',
                        'Xóa thành công!',
                        'success'
                )
              }
            },
            error: function (data) {
              Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Xóa thất bại, nhà cung cấp không tồn tại hoặc đã bị xóa trước đó!',

              })
            }
          });
        }
      })
    }

    function displayProducer(idProducer, button) {
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
          <c:url var="DisplayProducer" value="/admin/DisplayProducer"/>
          $.ajax({
            url: "${DisplayProducer}",
            type: "post",
            data: {
              idProducer: idProducer,

            },
            success: function (data) {
              let isSuccess = (JSON.parse(data)).isSuccess;

              if (isSuccess) {
                let td = $(button).closest("td");

                $("#renderIsActive" + idProducer).html(`

																<span class="badge iq-bg-success">
                                                                   ${status.display()} </span>
                                `);
                $($(td).find("#showProducer")).css("display", "none");
                $($(td).find("#hideProducer")).css("display", "block");
                Swal.fire(
                        'Good job!',
                        'Hiển thị thành công!',
                        'success'
                )
              }
            },
            error: function (data) {
              Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Hiển thị thất bại!',

              })
            }
          });
        }
      })
    }

    function hideProducer(idProducer, button) {
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
          <c:url var="HideProducer" value="/admin/HideProducer"/>
          $.ajax({
            url: "${HideProducer}",
            type: "post",
            data: {
              idProducer: idProducer,

            },
            success: function (data) {
              let isSuccess = (JSON.parse(data)).isSuccess;

              if (isSuccess) {
                let td = $(button).closest("td");

                $("#renderIsActive" + idProducer).html(`

																<span class="badge iq-bg-danger">
                                                                   ${status.hidden()} </span>
                                `);
                $($(td).find("#showProducer")).css("display", "block");
                $($(td).find("#hideProducer")).css("display", "none");
                Swal.fire(
                        'Good job!',
                        'Ẩn thành công!',
                        'success'
                )
              }
            },
            error: function (data) {
              Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: 'Ẩn thất bại!',

              })
            }
          });
        }
      })
    }
  </script>
</body>
</html>