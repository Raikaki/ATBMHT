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
    <title>Danh sách khuyến mãi</title>
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
                                <h4 class="card-title">Danh sách các đợt khuyến mãi</h4>
                            </div>
                        </div>
                        <div class="iq-card-body">
                            <div id="table" class="table-editable">
                              <span class="addBonus float-right mb-3 mr-2">
                              <button class="btn btn-sm iq-bg-success"><i
                                      class="ri-add-fill"><span class="pl-1">Tạo mới</span></i>
                              </button>
                              </span>

                                <table id="tableBonus" class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th>Mã</th>
                                        <th>Mô tả</th>
                                        <th>Ngày bắt đầu</th>
                                        <th>Ngày kết thúc</th>
                                        <th>Phần trăm giảm giá</th>
                                        <th>Ngày tạo</th>
                                        <th>Trạng thái</th>
                                        <th>Tùy chọn</th>
                                    </tr>
                                    </thead>
                                    <tbody>

                                    <c:forEach var="bonus" items="${requestScope.listBonus}">
                                        <tr>
                                            <td></td>

                                            <td>${bonus.id}</td>
                                            <td contenteditable="false">${bonus.description}</td>
                                            <td contenteditable="false">${bonus.dayBegin} <input name="dayBegin" id="dayBegin" type="date" style="display:none;"></td>
                                            <td contenteditable="false">${bonus.dayEnd} <input name="dayEnd" id="dayEnd" type="date" style="display:none;"> </td>
                                            <td contenteditable="false">${bonus.percent} </td>
                                            <td contenteditable="false">${bonus.createAt}</td>
                                            <td>
                                                <div id="renderIsActive${bonus.id}">
                                                    <c:if test="${bonus.status==1}">
                                                    <span class="badge iq-bg-success">
															</c:if>
															<c:if test="${bonus.status==0}">
																<span class="badge iq-bg-danger">
															</c:if>
                                                                        ${bonus.statusString}</span>
                                                </div>
                                            </td>
                                            <td>
                                                <div id="option_Bonus">
                                                    <c:if test="${bonus.status==1}">
                                                <span class="table-remove" id="hideBonus">
                                                    <button type="button"
                                                            class="btn iq-bg-danger btn-rounded btn-sm my-0"
                                                            onclick="hideBonus(${bonus.id},this)"><i
                                                            class="fa-solid fa-eye-slash"></i></button></span>
                                                        <span class="table-remove" id="showBonus"
                                                              style="display: none!important;">
                                                         <button type="button"
                                                                 class="btn iq-bg-success btn-rounded btn-sm my-0"
                                                                 onclick="displayBonus(${bonus.id},this)"><i
                                                                 class="fa-solid fa-eye"></i></button></span>

                                                    </c:if>
                                                    <c:if test="${bonus.status==0}">
                                                          <span class="table-remove" id="hideBonus"
                                                                style="display: none!important;">
                                                              <button type="button"
                                                                      class="btn iq-bg-danger btn-rounded btn-sm my-0"
                                                                      onclick="hideBonus(${bonus.id},this)"><i
                                                                      class="fa-solid fa-eye-slash"></i></button></span>
                                                        <span class="table-remove" id="showBonus">
                                                         <button type="button"
                                                                 class="btn iq-bg-success btn-rounded btn-sm my-0"
                                                                 onclick="displayBonus(${bonus.id},this)"><i
                                                                 class="fa-solid fa-eye"></i></button></span>

                                                    </c:if>
                                                    <span class="table-remove" id="removeBonus">
                                                     <button type="button"
                                                             class="btn iq-bg-danger btn-rounded btn-sm my-0"
                                                             onclick="removeBonus(${bonus.id},this)"><i
                                                             class="ri-delete-bin-line"></i></button></span>
                                                    <span class="table-remove" id="settingBonus">
                                                     <button type="button"
                                                             class="btn iq-bg-info btn-rounded btn-sm my-0"
                                                             onclick="editBonus(${bonus.id},this)"><i
                                                             class="ri-pencil-line"></i></button></span>

                                                        <a href="${settingBonusMovie}?idBonus=${bonus.id}"> <button class="btn iq-bg-info fa fa-plus-circle"></button></a>

                                                </div>
                                                <div id="editBonusArea" style="display: none">
                                                    <button type="button" class="btn btn-info"
                                                            onclick="submitEdit(${bonus.id},this)" id="submitEdit"
                                                            disabled>Xác nhận sửa
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
        var tableBonus;
        <jsp:useBean id="status" class="model.Status"/>
        $(document).ready(function () {
            tableBonus = $('#tableBonus').DataTable({
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
            let addRow=`<table class="table table-striped table-bordered" >
              <thead>
                                    <tr>
                                        <th>Description</th>
                                        <th>DayBegin</th>
                                        <th>DayEnd</th>
                                        <th>Percent</th>
                                        <th>Option</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                 <tr id="addBonus">

                                            <td contenteditable="true" id="addDescription"></td>
                                            <td contenteditable="false"><input name="dayBegin" id="dayBegin" type="date"></td>
                                            <td contenteditable="false"><input name="dayEnd" id="dayEnd" type="date" ></td>
                                            <td contenteditable="true" id="percent"></td>
                                            <td>
                                               <span class="table-remove">
                                               <button type="button" class="btn btn-sm iq-bg-success btn-rounded btn-sm my-0" onclick="submitAdd(this)" id="submitAddButton">Xác nhận sửa</button>
                                                </span>
                                            </td>
                                        </tr>
                                        </tbody>
                                        </table>
            `
            $(".addBonus").on("click",()=>{
                if ($("#addBonus").length) {
                    $("#addArea").html(``);
                } else {
                    $("#addArea").html(addRow);
                    let button = $("#submitAddButton");
                    let tr = $(button).closest("tr");
                    let tdArray = $(tr).find("td");

                    validate(tdArray[1],tdArray[2],button, tdArray[0],tdArray[3]);
                    enableSubmit(tdArray[1],tdArray[2],button, tdArray[0], tdArray[3]);

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
                    let addDescription = $(tdArray[0]).text();
                    let addDayBegin = $($(tdArray[1]).find("#dayBegin")).val();
                    let addDayEnd = $($(tdArray[2]).find("#dayEnd")).val();
                    let addPercent = $(tdArray[3]).text();

                    $.ajax({
                        url: "AddBonus",
                        type: "post",
                        data: {
                            addDescription:addDescription,
                            addDayBegin : addDayBegin,
                            addDayEnd : addDayEnd,
                            addPercent : addPercent,
                        },
                        success: function (data) {

                            let newBonus = JSON.parse((JSON.parse(data)).newBonus);

                            let createAt = newBonus.createAt;

                            let appendInsert=`  <tr>
                                            <td></td>

                                            <td>`+newBonus.id+`</td>
                                            <td contenteditable="false">`+newBonus.description+`</td>
                                            <td contenteditable="false">`+newBonus.dayBegin+` <input name="dayBegin" id="dayBegin" type="date" style="display:none;"></td>
                                            <td contenteditable="false">`+newBonus.dayEnd+`<input name="dayEnd" id="dayEnd" type="date" style="display:none;"> </td>
                                            <td contenteditable="false">`+newBonus.percent+` </td>
                                            <td contenteditable="false">`+createAt+`</td>
                                            <td>
                                                <div id="renderIsActive`+newBonus.id+`">

                                                    <span class="badge iq-bg-success">
                                                                        `+newBonus.statusString+`</span>
                                                </div>
                                            </td>
                                            <td>
                                                <div id="option_Bonus">

                                                <span class="table-remove" id="hideBonus">
                                                    <button type="button"
                                                            class="btn iq-bg-danger btn-rounded btn-sm my-0"
                                                            onclick="hideBonus(`+newBonus.id+`,this)"><i
                                                            class="fa-solid fa-eye-slash"></i></button></span>
                                                        <span class="table-remove" id="showBonus"
                                                              style="display: none!important;">
                                                         <button type="button"
                                                                 class="btn iq-bg-success btn-rounded btn-sm my-0"
                                                                 onclick="displayBonus(`+newBonus.id+`,this)"><i
                                                                 class="fa-solid fa-eye"></i></button></span>



                                                    <span class="table-remove" id="removeBonus">
                                                     <button type="button"
                                                             class="btn iq-bg-danger btn-rounded btn-sm my-0"
                                                             onclick="removeBonus(`+newBonus.id+`,this)"><i
                                                             class="ri-delete-bin-line"></i></button></span>
                                                    <span class="table-remove" id="settingBonus">
                                                     <button type="button"
                                                             class="btn iq-bg-info btn-rounded btn-sm my-0"
                                                             onclick="editBonus(`+newBonus.id+`,this)"><i
                                                             class="ri-pencil-line"></i></button></span>

                                                        <a href="${settingBonusMovie}?idBonus=`+newBonus.id+`"> <button class="btn iq-bg-info fa fa-plus-circle"></button></a>

                                                </div>
                                                <div id="editBonusArea" style="display: none">
                                                    <button type="button" class="btn btn-info"
                                                            onclick="submitEdit(`+newBonus.id+`,this)" id="submitEdit"
                                                            disabled>Xác nhận sửa
                                                    </button>
                                                </div>

                                            </td>
                                        </tr>`;
                            tableBonus.rows.add($(appendInsert)).draw();
                            $("#addBonus").remove();
                            Swal.fire(
                                'Good job!',
                                'Thêm thành công!',
                                'success'
                            )

                        },
                        error: function (data) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: 'Thêm thất bại, Thời gian bắt đầu và kết thúc của đợt khuyến mãi đang nằm trong thời gian của đợt khuyến mãi khác!',

                            })

                        }
                    });
                }
            })

        }
        function editBonus(idBonus, button) {
            let tr = $(button).closest("tr");
            let tdArray = $(tr).find("td");
            $(tdArray[2]).attr("contenteditable", "true");
            $(tdArray[2]).addClass("edit-box");
            $(tdArray[3]).addClass("edit-box");
            $(tdArray[5]).attr("contenteditable", "true");
            $(tdArray[4]).addClass("edit-box");
            $(tdArray[5]).addClass("edit-box");

            $($(tdArray[3]).find("#dayBegin")).css("display","block");
            $($(tdArray[4]).find("#dayEnd")).css("display","block");

            $($(tdArray[8]).find("#option_Bonus")).css("display", "none");
            $($(tdArray[8]).find("#editBonusArea")).css("display", "block");

            let submitEdit = $(tr).find("#submitEdit");
            validate(tdArray[3],tdArray[4],submitEdit, tdArray[2], tdArray[5]);
            enableSubmit(tdArray[3],tdArray[4],submitEdit, tdArray[2], tdArray[5]);
        }

        function submitEdit(idBonus, button) {
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


                    $.ajax({
                        url: "EditBonus",
                        type: "post",
                        data: {
                            idBonus: idBonus,
                            description: $(tdArray[2]).text(),
                            dayBegin: $($(tdArray[3]).find("#dayBegin")).val(),
                            dayEnd:$($(tdArray[4]).find("#dayEnd")).val(),
                            percent: $(tdArray[5]).text(),
                        },
                        success: function (data) {
                            let updatedBonus = JSON.parse(JSON.parse(data).updatedBonus);
                            if (updatedBonus) {

                                $(tdArray[2]).text(updatedBonus.description);
                                $(tdArray[3]).text(updatedBonus.dayBegin);
                                $(tdArray[4]).text(updatedBonus.dayEnd);
                                $(tdArray[5]).text(updatedBonus.percent);
                                $(tdArray[2]).attr("contenteditable", "false");
                                $(tdArray[3]).attr("contenteditable", "false");
                                $(tdArray[5]).attr("contenteditable", "false");
                                $(tdArray[2]).removeClass("edit-box");
                                $(tdArray[3]).removeClass("edit-box");
                                $(tdArray[4]).removeClass("edit-box");
                                $(tdArray[5]).removeClass("edit-box");
                                $($(tdArray[3]).find("#dayBegin")).css("display","none");
                                $($(tdArray[4]).find("#dayEnd")).css("display","none");
                                Swal.fire(
                                    'Good job!',
                                    'Sửa thành công!',
                                    'success'
                                )

                                $($(tdArray[8]).find("#option_Bonus")).css("display", "block");
                                $($(tdArray[8]).find("#editBonusArea")).css("display", "none");
                            } else {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Oops...',
                                    text: 'Sửa thất bại, đợt khuyến mãi không tồn tại hoặc đã bị xóa trước đó!',

                                })
                            }
                        },
                        error: function (data) {
                           if(data.status===500){
                               Swal.fire({
                                   icon: 'error',
                                   title: 'Oops...',
                                   text: 'Sửa thất bại, Thời gian bắt đầu và kết thúc của đợt khuyến mãi đang nằm trong thời gian của đợt khuyến mãi khác!',

                               })
                           }else{
                               console.log(data);
                           }
                        }
                    });
                }
            })

        }

        function validate(dayBegin,dayEnd,submit, ...tds) {

            tds.forEach(td => {
                td.addEventListener("input", () => {
                    enableSubmit(dayBegin,dayEnd,submit, ...tds);
                });
            })
            $($(dayBegin).find("#dayBegin")).on("change",()=>{
                enableSubmit(dayBegin,dayEnd,submit, ...tds);
            })
            $($(dayEnd).find("#dayEnd")).on("change",()=>{
                enableSubmit(dayBegin,dayEnd,submit, ...tds);
            })
        }

        function enableSubmit(dayBegin,dayEnd,submit, ...tds) {
            let isNotEmpty = true;
            tds.forEach(td => {
                isNotEmpty &= $(td).text().trim() !== "";
            })
            isNotEmpty&=$($(dayBegin).find("#dayBegin")).val()!=="" && $($(dayEnd).find("#dayEnd")).val()!==""
            if (isNotEmpty) {
                $(submit).prop('disabled', false);
            } else {
                $(submit).prop('disabled', true);

            }
        }

        function removeBonus(idBonus, button) {
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
                    $.ajax({
                        url: "RemoveBonus",
                        type: "post",
                        data: {
                            idBonus: idBonus,

                        },
                        success: function (data) {
                            let isSuccess = (JSON.parse(data)).isSuccess;

                            if (isSuccess) {

                                tableBonus.row($($(button).closest("tr"))).remove().draw(false);
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
                                text: 'Xóa thất bại, đợt khuyến mãi không tồn tại hoặc đã bị xóa trước đó!',

                            })
                        }
                    });
                }
            })
        }

        function displayBonus(idBonus, button) {
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
                    $.ajax({
                        url: "DisplayBonus",
                        type: "post",
                        data: {
                            idBonus: idBonus,

                        },
                        success: function (data) {
                            let isSuccess = (JSON.parse(data)).isSuccess;

                            if (isSuccess) {
                                let td = $(button).closest("td");

                                $("#renderIsActive" + idBonus).html(`

																<span class="badge iq-bg-success">
                                                                   ${status.display()} </span>
                                `);
                                $($(td).find("#showBonus")).css("display", "none");
                                $($(td).find("#hideBonus")).css("display", "block");
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

        function hideBonus(idBonus, button) {
            Swal.fire({
                title: 'Are you sure?',
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, change it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: "HideBonus",
                        type: "post",
                        data: {
                            idBonus: idBonus,

                        },
                        success: function (data) {
                            let isSuccess = (JSON.parse(data)).isSuccess;

                            if (isSuccess) {
                                let td = $(button).closest("td");

                                $("#renderIsActive" + idBonus).html(`

																<span class="badge iq-bg-danger">
                                                                   ${status.hidden()} </span>
                                `);
                                $($(td).find("#showBonus")).css("display", "block");
                                $($(td).find("#hideBonus")).css("display", "none");
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