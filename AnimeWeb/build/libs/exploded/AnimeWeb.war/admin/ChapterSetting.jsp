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
    <title>Danh sách tập phim</title>
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
                                <h4 class="card-title">Danh sách tập phim</h4>
                            </div>
                        </div>
                        <div class="iq-card-body">
                            <div id="table" class="table-editable">
                              <span class="table-add float-right mb-3 mr-2">
                              <button class="btn btn-sm iq-bg-success"><i
                                      class="ri-add-fill"><span class="pl-1">Thêm tập phim mới</span></i>
                              </button>
                              </span>


                                <table class="table table-bordered table-responsive-md table-striped text-center"
                                       id="tableChapter">

                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th>Tập</th>
                                        <th>Thời gian kết thúc OST</th>
                                        <th>Địa chỉ lưu</th>
                                        <th>Tùy chọn</th>
                                    </tr>
                                    </thead>
                                    <tbody>

                                    <c:forEach var="chapter" items="${requestScope.listChapter}">

                                        <tr>
                                            <td contenteditable="false"></td>
                                            <td contenteditable="false" id="indexChapter">${chapter.index}</td>
                                            <td contenteditable="false" id="opening">${chapter.opening}</td>

                                            <td id>
                                                    ${chapter.name}
                                            </td>
                                            <td>
                                          <span class="table-remove"><button type="button"
                                                                             class="btn iq-bg-danger btn-rounded btn-sm my-0"
                                                                             onclick="removeChapter(${chapter.id},this)">Xóa</button>  </span>
                                             <span id="settingChapter"><button type="button" class="btn btn-info"
                                                                               value="${chapter.id}"
                                                                               onclick="settingChapter(this)">Sửa</button></span>

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
        var tableChapter;
        $(document).ready(function () {
            tableChapter = $('#tableChapter').DataTable({
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
            let newTr = '\n  <tr id="addChapter"> \n' +
                '                                            <td contenteditable="false"></td>\n' +
                '                                            <td contenteditable="true" id="indexChapter"></td>\n' +
                '                                            <td contenteditable="true" id="opening"></td>\n' +
                '\n' +
                '                                            <td>\n' +
                '                                     <input type="file" multiple id="video-upload" name="video-upload" accept="video/*"> <div id="upload-status-container">\n ' +
                ' <div id="upload-header">\n           ' +
                ' <span id="upload-header-text"></span>\n        ' +
                '   \n    ' +
                '    </div>\n       ' +
                ' <div id="progress-bar-container">\n            ' +
                '<table class="table">\n               ' +
                ' <tbody></tbody>\n           ' +
                ' </table>\n       ' +
                ' </div>\n    ' +
                '</div>       \n' +
                '                                            </td>\n' +
                '                                            <td>\n' +
                '                                          <span class="table-remove"><button type="button" class="btn btn-sm iq-bg-success btn-rounded btn-sm my-0" onclick="startUploading(this,`insert`)" id="submitUploadButton">Xác nhận</button>\n' +

                '                                            </td>\n' +
                '                                        </tr>';
            $(".table-add").on("click", "i", () => {

                if ($("#addChapter").length) {

                } else {
                    $("tbody").append(newTr);
                }

            })
        });


        function removeChapter(idChapter, button) {
            Swal.fire({
                title: 'Xác nhận?',
                text: "Bạn chắc chắn thực hiện thao tác này!",
                icon: 'info',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {

                    <c:url var="RemoveChapter" value="/admin/RemoveChapter"/>
                    $.ajax({
                        url: "${RemoveChapter}",
                        type: "post",
                        data: {
                            idChapter: idChapter,
                            idMovie:${requestScope.idMovie},
                        },
                        success: function (data) {
                            let isSuccess = (JSON.parse(data)).isSuccess;
                            if (isSuccess) {
                                tableChapter.row($($(button).closest("tr"))).remove().draw(false);
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Thành công',
                                    text: 'Xóa thành công!',

                                })
                            }
                        },
                        error: function (data) {
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: 'Xóa thất bại, tập phim không tồn tại hoặc đã bị xóa trước đó!',

                            })
                        }
                    });
                }
            })

        }

        let totalFileCount, fileUploadCount, fileSize;

        function startUploading(button, type) {
            let tr = $(button).closest("tr");
            let tdArray = $(tr).find("td");
            let files = $($(tdArray[3]).find("#video-upload")).prop('files')[0];
            let totalFile = $($(tdArray[3]).find("#video-upload")).prop('files')
            if (type === "insert" && files.length === 0) {
                alert("Please choose at least one file and try.");
                return;
            }
            fileUploadCount = 0;
            $("#submitUploadButton").prop('disabled', true);
            prepareProgressBarUI(files, tdArray, totalFile);
            uploadFile(tr, type, button);
        }

        function prepareProgressBarUI(files, tdArray, totalFile) {

            totalFileCount = totalFile.length;

            let $tbody = $($(tdArray[3]).find("#progress-bar-container")).find("tbody");
            $tbody.empty();
            $($(tdArray[3]).find("#upload-header-text")).html("uploading");
            for (let i = 0; i < totalFileCount; i++) {
                let fsize = parseFileSize(totalFile[i].size);
                let fname = totalFile[i].name;

                let bar = '<tr id="progress-bar-' + i + '"><td style="width:75%"><div class="filename">' + fname + '</div>'
                    + '<div class="progress"><div class="progress-bar progress-bar-striped active" style="width:0%"></div></div></td>'
                    + '<td  style="width:25%"><span class="size-loaded"></span> ' + fsize + ' <span class="percent-loaded"></span></td></tr>';

                $tbody.append(bar);
            }

            $($(tdArray[3]).find("#upload-status-container")).show();
        }

        function parseFileSize(size) {
            let precision = 1;
            let factor = Math.pow(10, precision);
            size = Math.round(size / 1024); //size in KB
            if (size < 1000) {
                return size + " KB";
            } else {
                size = Number.parseFloat(size / 1024); //size in MB
                if (size < 1000) {
                    return (Math.round(size * factor) / factor) + " MB";
                } else {
                    size = Number.parseFloat(size / 1024); //size in GB
                    return (Math.round(size * factor) / factor) + " GB";
                }
            }
            return 0;
        }

        function uploadFile(tr, type, button) {
            let tdArray = $(tr).find("td");
            let file = $($(tdArray[3]).find("#video-upload")).prop('files')[fileUploadCount];

            let fd = new FormData();

            let index = $(tr).find("#indexChapter").text();
            let opening = $(tr).find("#opening").text();

            fd.append('index', index);
            fd.append('opening', opening);
            fd.append('type', type);
            if (type === "edit") {
                fd.append("idChapter", $(button).val());
                if (file) {
                    fd.append("video-upload", file);
                    fileSize = file.size;
                }
            } else {
                fd.append("video-upload", file);
                fileSize = file.size;
            }
            fd.append('idMovie', ${requestScope.idMovie});
            <c:url var="ChapterSetting" value="/admin/ChapterSetting"/>
            $.ajax({
                url: '${ChapterSetting}',
                type: 'POST',
                data: fd,
                processData: false,
                contentType: false,
                xhr: function () {
                    let myXhr =  new XMLHttpRequest();
                    if (myXhr.upload && file) {
                        myXhr.upload.addEventListener('progress', onUploadProgress.bind(null, tdArray), false);
                    }
                    return myXhr;
                },
                success: function (response) {

                    onUploadComplete(response, false, response.responseText, tr, type, button)

                },
                error: function (xhr, status, error) {
                    var parser = new DOMParser();
                    var htmlDoc = parser.parseFromString(xhr.responseText, "text/html");
                    var errorMessage = htmlDoc.querySelector("p:nth-of-type(2)").textContent;
                    onUploadComplete(xhr, true, errorMessage, tr, type, button);


                },

            });


        }

        function onUploadProgress(tdArray, e) {
            if (e.lengthComputable) {
                let percentComplete = parseInt((e.loaded) * 100 / fileSize);
                let pbar = $($(tdArray[3]).find('#progress-bar-' + fileUploadCount))
                let bar = pbar.find(".progress-bar");
                let sLoaded = pbar.find(".size-loaded");
                let pLoaded = pbar.find(".percent-loaded");
                bar.css("width", percentComplete + '%');
                sLoaded.html(parseFileSize(e.loaded) + " / ");
                pLoaded.html("(" + percentComplete + "%)");
            } else {
                alert('unable to compute');
            }
        }

        function onUploadComplete(e, error, mess, tr, type, button) {
            let tdArray = $(tr).find("td");

            let pbar = $($(tdArray[3]).find('#progress-bar-' + fileUploadCount));

            if (error || e.status === 500) {
                pbar.find(".progress-bar").removeClass("active").addClass("progress-bar-danger");

            } else {
                pbar.find(".progress-bar").removeClass("active");
                pbar.find(".size-loaded").html('<i class="fa fa-check text-success"></i> ');
            }
            fileUploadCount++;
            if (fileUploadCount < totalFileCount) {

                uploadFile(tr, type, button);
                $($(tdArray[3]).find("#upload-header-text")).html("Đang tải lên");
            } else {
                if (!error) {
                    let data = JSON.parse(e);
                    let chapter = JSON.parse(data.chapter);


                    $($(tdArray[3]).find("#upload-header-text")).html("Tải lên thành công!");
                    let appendInsert = `  <tr>
                                            <td contenteditable="false"></td>
                                            <td contenteditable="false" id="indexChapter">` + chapter.index + `</td>
                                            <td contenteditable="false" id="opening">` + chapter.opening + `</td>

                                            <td>
                                                        ` + chapter.name + `
                                            </td>
                                            <td>
                                          <span class="table-remove"><button type="button" class="btn iq-bg-danger btn-rounded btn-sm my-0" onclick="removeChapter(` + chapter.id + `,this)">Xóa</button>
        <span id="settingChapter"><button type="button" class="btn btn-info" value="` + chapter.id + `" onclick="settingChapter(this)">Chỉnh sửa</button></span>

</span>
                                            </td>
                                        </tr>`


                    let appendEdit = `
                                            <td contenteditable="false"></td>
                                            <td contenteditable="false" id="indexChapter">` + chapter.index + `</td>
                                            <td contenteditable="false" id="opening">` + chapter.opening + `</td>

                                            <td>
                                                        ` + chapter.name + `
                                            </td>
                                            <td>
                                          <span class="table-remove"><button type="button" class="btn iq-bg-danger btn-rounded btn-sm my-0" onclick="removeChapter(` + chapter.id + `,this)">Xóa</button>
        <span id="settingChapter"><button type="button" class="btn btn-info" value="` + chapter.id + `" onclick="settingChapter(this)">Chỉnh sửa</button></span>

</span>
                                            </td>
                                       `;
                    if (type === "insert") {

                        $("#addChapter").remove();

                        tableChapter.rows.add($(appendInsert)).draw();
                        Swal.fire(
                            'Success!',
                            `Thêm thành công`,
                            'success'
                        )

                    }
                    if (type === "edit") {
                        $(tr).html(appendEdit);
                        Swal.fire(
                            'Success!',
                            `Sửa thành công`,
                            'success'
                        )
                    }


                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: mess,
                    })
                }
            }
            $("#submitUploadButton").prop('disabled', false);
        }


        function showHide(ele) {
            if ($(ele).hasClass('fa-window-minimize')) {
                $(ele).removeClass('fa-window-minimize').addClass('fa-window-restore').attr("title", "restore");
                $("#progress-bar-container").slideUp();
            } else {
                $(ele).addClass('fa-window-minimize').removeClass('fa-window-restore').attr("title", "minimize");
                $("#progress-bar-container").slideDown();
            }
        }

        function settingChapter(button) {
            let idChapter = $(button).val();
            let parent = $(button).closest("tr");
            let tdArray = $(parent).find("td");
            $(tdArray[1]).attr("contenteditable", "true");
            $(tdArray[2]).attr("contenteditable", "true");
            $(tdArray[1]).addClass("edit-box");
            $(tdArray[2]).addClass("edit-box");

            $(tdArray[3]).html(' <input type="file" multiple id="video-upload" name="video-upload" accept="video/*"> <div id="upload-status-container">\n ' +
                ' <div id="upload-header">\n           ' +
                ' <span id="upload-header-text"></span>\n        ' +
                '   \n    ' +
                '    </div>\n       ' +
                ' <div id="progress-bar-container">\n            ' +
                '<table class="table">\n               ' +
                ' <tbody></tbody>\n           ' +
                ' </table>\n       ' +
                ' </div>\n    ' +
                '</div>       \n');
            $(tdArray[3]).addClass("edit-box");
            $(button).css("display", "none");
            $($(tdArray[4]).find("#settingChapter")).html(`<button type="button" class="btn btn-info" value="` + idChapter + `" onclick="startUploading(this,'edit')">Xác nhận chỉnh sửa</button>`)

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
    <script src="js/chart-custom.js"></script>
    <script src="js/custom.js"></script>
</body>
</html>