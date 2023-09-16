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
    <title>Danh sách nhà cung cấp</title>
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
                                <h4 class="card-title">Danh sách nhà cung cấp</h4>
                            </div>
                        </div>
                        <div class="iq-card-body">
                            <div class="table-responsive">
                                 <span class="addSupplier float-right mb-3 mr-2">
                              <button class="btn btn-sm iq-bg-success"><i
                                      class="ri-add-fill"><span class="pl-1">Tạo mới</span></i>
                              </button>
                              </span>
                                <table id="tableSupplier" class="table table-striped table-bordered">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th>Mã</th>
                                        <th>Tên</th>
                                        <th>Mô tả</th>
                                        <th>Số điện thoại</th>
                                        <th>Địa chỉ</th>
                                        <th>Trạng thái</th>
                                        <th>Ngày tạo</th>
                                        <th>Tùy chọn</th>
                                    </tr>
                                    </thead>
                                    <tbody>

                                    <c:forEach var="supplier" items="${requestScope.listSupplier}">

                                        <tr>
                                            <td></td>
                                            <td>${supplier.id}</td>
                                            <td contenteditable="false">${supplier.name}</td>
                                            <td contenteditable="false">${supplier.description}</td>
                                            <td contenteditable="false">${supplier.phone}</td>
                                            <td contenteditable="false">${supplier.address}</td>
                                            <td>
                                                <div id="renderIsActive${supplier.id}">
                                                    <c:if test="${supplier.status==1}">
                                                    <span class="badge iq-bg-success">
															</c:if>
															<c:if test="${supplier.status==0}">
																<span class="badge iq-bg-danger">
															</c:if>
                                                                        ${supplier.statusString}</span>
                                                </div>
                                            </td>
                                            <td>${supplier.createAt}</td>
                                            <td>
                                                <div id="option_supplier">
                                                    <c:if test="${supplier.status==1}">
                                                <span class="table-remove" id="hideSupplier">
                                                    <button type="button"
                                                            class="btn iq-bg-danger btn-rounded btn-sm my-0"
                                                            onclick="hideSupplier(${supplier.id},this)"><i
                                                            class="fa-solid fa-eye-slash"></i></button></span>
                                                        <span class="table-remove" id="showSupplier"
                                                              style="display: none!important;">
                                                         <button type="button"
                                                                 class="btn iq-bg-success btn-rounded btn-sm my-0"
                                                                 onclick="displaySupplier(${supplier.id},this)"><i
                                                                 class="fa-solid fa-eye"></i></button></span>

                                                    </c:if>
                                                    <c:if test="${supplier.status==0}">
                                                          <span class="table-remove" id="hideSupplier"
                                                                style="display: none!important;">
                                                              <button type="button"
                                                                      class="btn iq-bg-danger btn-rounded btn-sm my-0"
                                                                      onclick="hideSupplier(${supplier.id},this)"><i
                                                                      class="fa-solid fa-eye-slash"></i></button></span>
                                                        <span class="table-remove" id="showSupplier">
                                                         <button type="button"
                                                                 class="btn iq-bg-success btn-rounded btn-sm my-0"
                                                                 onclick="displaySupplier(${supplier.id},this)"><i
                                                                 class="fa-solid fa-eye"></i></button></span>

                                                    </c:if>
                                                    <span class="table-remove" id="removeSupplier">
                                                     <button type="button"
                                                             class="btn iq-bg-danger btn-rounded btn-sm my-0"
                                                             onclick="removeSupplier(${supplier.id},this)"><i
                                                             class="ri-delete-bin-line"></i></button></span>
                                                    <span class="table-remove" id="settingSupplier">
                                                     <button type="button"
                                                             class="btn iq-bg-info btn-rounded btn-sm my-0"
                                                             onclick="editSupplier(${supplier.id},this)"><i
                                                             class="ri-pencil-line"></i></button></span>

                                                </div>
                                                <div id="editSupplierArea" style="display: none">
                                                    <button type="button" class="btn btn-info"
                                                            onclick="submitEdit(${supplier.id},this)" id="submitEdit"
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
        var tableSupplier;
        <jsp:useBean id="status" class="model.Status"/>
        $(document).ready(function () {
            tableSupplier = $('#tableSupplier').DataTable({
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
                                        <th>Phone</th>
                                        <th>Address</th>
                                        <th>Option</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                 <tr id="addSupplier">


                                            <td contenteditable="true" id="addName"></td>
                                            <td contenteditable="true" id="addDescription"></td>
                                            <td contenteditable="true" id="addPhone"></td>
                                            <td contenteditable="true" id="addAddress"></td>
                                            <td>
                                               <span class="table-remove">
                                               <button type="button" class="btn btn-sm iq-bg-success btn-rounded btn-sm my-0" onclick="submitAdd(this)" id="submitAddButton">Submit</button>
                                                </span>
                                            </td>
                                        </tr>
                                        </tbody>
                                        </table>
            `
            $(".addSupplier").on("click",()=>{
                if ($("#addSupplier").length) {
                    $("#addArea").html(``);
                } else {
                    $("#addArea").html(addRow);
                    let button = $("#submitAddButton");
                    let tr = $(button).closest("tr");
                    let tdArray = $(tr).find("td");
                    console.log(tdArray)
                    validate(button, tdArray[0], tdArray[1], tdArray[2], tdArray[3]);
                    enableSubmit(button, tdArray[0], tdArray[1], tdArray[2], tdArray[3]);

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
                    let addPhone = $(tdArray[2]).text();
                    let addAddress = $(tdArray[3]).text();
                    <c:url var="AddSupplier" value="/admin/AddSupplier"/>
                    $.ajax({
                        url: "${AddSupplier}",
                        type: "post",
                        data: {
                            addName:addName,
                            addDescription:addDescription,
                            addPhone:addPhone,
                            addAddress:addAddress,
                        },
                        success: function (data) {
                            let newSupplier = JSON.parse((JSON.parse(data)).newSupplier);

                            let createAt = newSupplier.createAt;

                            let appendInsert=`<tr>
                                            <td></td>
                                            <td>`+newSupplier.id+`</td>
                                            <td contenteditable="false">`+newSupplier.name+`</td>
                                            <td contenteditable="false">`+newSupplier.description+`</td>
                                            <td contenteditable="false">`+newSupplier.phone+`</td>
                                            <td contenteditable="false">`+newSupplier.address+`</td>
                                            <td>
                                                <div id="renderIsActive`+newSupplier.id+`">

                                                    <span class="badge iq-bg-success">
                                                                        `+newSupplier.statusString+`</span>
                                                </div>
                                            </td>

                                            <td>`+createAt+`</td>
                                            <td>
                                                <div id="option_supplier">

                                                <span class="table-remove" id="hideSupplier">
                                                    <button type="button"
                                                            class="btn iq-bg-danger btn-rounded btn-sm my-0"
                                                            onclick="hideSupplier(`+newSupplier.id+`,this)"><i
                                                            class="fa-solid fa-eye-slash"></i></button></span>
                                                        <span class="table-remove" id="showSupplier"
                                                              style="display: none!important;">
                                                         <button type="button"
                                                                 class="btn iq-bg-success btn-rounded btn-sm my-0"
                                                                 onclick="displaySupplier(`+newSupplier.id+`,this)"><i
                                                                 class="fa-solid fa-eye"></i></button></span>



                                                    <span class="table-remove" id="removeSupplier">
                                                     <button type="button"
                                                             class="btn iq-bg-danger btn-rounded btn-sm my-0"
                                                             onclick="removeSupplier(`+newSupplier.id+`,this)"><i
                                                             class="ri-delete-bin-line"></i></button></span>
                                                    <span class="table-remove" id="settingSupplier">
                                                     <button type="button"
                                                             class="btn iq-bg-info btn-rounded btn-sm my-0"
                                                             onclick="editSupplier(`+newSupplier.id+`,this)"><i
                                                             class="ri-pencil-line"></i></button></span>

                                                </div>
                                                <div id="editSupplierArea" style="display: none">
                                                    <button type="button" class="btn btn-info"
                                                            onclick="submitEdit(`+newSupplier.id+`,this)" id="submitEdit"
                                                            disabled>Submit Edit
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>`;
                            tableSupplier.rows.add($(appendInsert)).draw();
                            $("#addSupplier").remove();
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
        function editSupplier(idSupplier, button) {
            let tr = $(button).closest("tr");
            let tdArray = $(tr).find("td");
            $(tdArray[2]).attr("contenteditable", "true");
            $(tdArray[3]).attr("contenteditable", "true");
            $(tdArray[4]).attr("contenteditable", "true");
            $(tdArray[5]).attr("contenteditable", "true");
            $(tdArray[2]).addClass("edit-box");
            $(tdArray[3]).addClass("edit-box");
            $(tdArray[4]).addClass("edit-box");
            $(tdArray[5]).addClass("edit-box");

            $($(tdArray[8]).find("#option_supplier")).css("display", "none");
            $($(tdArray[8]).find("#editSupplierArea")).css("display", "block");

            let submitEdit = $(tr).find("#submitEdit");
            validate(submitEdit, tdArray[2], tdArray[3], tdArray[4], tdArray[5]);
            enableSubmit(submitEdit, tdArray[2], tdArray[3], tdArray[4], tdArray[5]);

        }

        function submitEdit(idSupplier, button) {
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

                    <c:url var="EditSupplier" value="/admin/EditSupplier"/>
                    $.ajax({
                        url: "${EditSupplier}",
                        type: "post",
                        data: {
                            idSupplier: idSupplier,
                            name: $(tdArray[2]).text(),
                            description: $(tdArray[3]).text(),
                            phone: $(tdArray[4]).text(),
                            address: $(tdArray[5]).text(),
                        },
                        success: function (data) {
                            let updatedSupplier = JSON.parse(JSON.parse(data).updatedSupplier);

                            if (updatedSupplier) {

                                $(tdArray[2]).text(updatedSupplier.name);
                                $(tdArray[3]).text(updatedSupplier.description);
                                $(tdArray[4]).text(updatedSupplier.phone);
                                $(tdArray[5]).text(updatedSupplier.address);
                                $(tdArray[2]).attr("contenteditable", "false");
                                $(tdArray[3]).attr("contenteditable", "false");
                                $(tdArray[4]).attr("contenteditable", "false");
                                $(tdArray[5]).attr("contenteditable", "false");
                                $(tdArray[2]).removeClass("edit-box");
                                $(tdArray[3]).removeClass("edit-box");
                                $(tdArray[4]).removeClass("edit-box");
                                $(tdArray[5]).removeClass("edit-box");
                                Swal.fire(
                                    'Good job!',
                                    'Sửa thành công!',
                                    'success'
                                )
                                $($(tdArray[8]).find("#option_supplier")).css("display", "block");
                                $($(tdArray[8]).find("#editSupplierArea")).css("display", "none");
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

        function removeSupplier(idSupplier, button) {
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
                    <c:url var="RemoveSupplier" value="/admin/RemoveSupplier"/>
                    $.ajax({
                        url: "${RemoveSupplier}",
                        type: "post",
                        data: {
                            idSupplier: idSupplier,

                        },
                        success: function (data) {
                            let isSuccess = (JSON.parse(data)).isSuccess;

                            if (isSuccess) {

                                tableSupplier.row($($(button).closest("tr"))).remove().draw(false);
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

        function displaySupplier(idSupplier, button) {
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
                    <c:url var="DisplaySupplier" value="/admin/DisplaySupplier"/>
                    $.ajax({
                        url: "${DisplaySupplier}",
                        type: "post",
                        data: {
                            idSupplier: idSupplier,

                        },
                        success: function (data) {
                            let isSuccess = (JSON.parse(data)).isSuccess;

                            if (isSuccess) {
                                let td = $(button).closest("td");

                                $("#renderIsActive" + idSupplier).html(`

																<span class="badge iq-bg-success">
                                                                   ${status.display()} </span>
                                `);
                                $($(td).find("#showSupplier")).css("display", "none");
                                $($(td).find("#hideSupplier")).css("display", "block");
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

        function hideSupplier(idSupplier, button) {
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
                    <c:url var="HideSupplier" value="/admin/HideSupplier"/>
                    $.ajax({
                        url: "${HideSupplier}",
                        type: "post",
                        data: {
                            idSupplier: idSupplier,

                        },
                        success: function (data) {
                            let isSuccess = (JSON.parse(data)).isSuccess;

                            if (isSuccess) {
                                let td = $(button).closest("td");

                                $("#renderIsActive" + idSupplier).html(`

																<span class="badge iq-bg-danger">
                                                                   ${status.hidden()} </span>
                                `);
                                $($(td).find("#showSupplier")).css("display", "block");
                                $($(td).find("#hideSupplier")).css("display", "none");
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