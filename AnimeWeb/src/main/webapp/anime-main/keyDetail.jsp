<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
  <meta charset="UTF-8">
  <meta name="description" content="Anime Template">
  <meta name="keywords" content="Anime, unica, creative, html">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Anime</title>

  <!-- Google Font -->
  <link
          href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;600;700&display=swap"
          rel="stylesheet">
  <link
          href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;400;500;600;700;800;900&display=swap"
          rel="stylesheet">

  <!-- Css Styles -->
  <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
  <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
  <link rel="stylesheet" href="css/plyr.css" type="text/css">
  <link rel="stylesheet" href="css/nice-select.css" type="text/css">
  <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
  <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
  <link rel="stylesheet" type="text/css" href="css/ds/style.css"/>
  <link rel="stylesheet" href="https://kit.fontawesome.com/fe2c9f6253.css"
        crossorigin="anonymous">
  <script src="https://kit.fontawesome.com/9847adceef.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
</head>

<body>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app"/>


<c:url var="urlAvatar"
       value="${request.rervletContext.realPath}${sessionScope.user.avatar}"/>

<div id="ah_wrapper">

  <!-- Page Preloder -->
  <div id="preloder">
    <div class="loader"></div>
  </div>

  <!-- Header Section Begin -->
  <c:import url="/anime-main/header.jsp"/>
  <!-- Header End -->

  <!-- Hero Section Begin -->
  <section class="">

    <div class="container">
      <span class="addKey float-right mb-3 mr-2">
                              <button class="btn btn-sm iq-bg-success" style="background:#ecfff6 !important;color: #65f9b3!important"><i
                                      class="ri-add-fill"><span class="pl-1">Nhập key</span></i>
                              </button>
                              </span>
      <span class="createKey float-right mb-3 mr-2">
                              <button class="btn btn-sm iq-bg-success" style="background:#ecfff6 !important;color: #65f9b3!important"><i
                                      class="ri-add-fill"><span class="pl-1">Tạo key</span></i>
                              </button>
                              </span>
      <div id="addArea">

      </div>
      <table id="key-list-table"
             class="table table-striped table-bordered mt-4" role="grid"
             aria-describedby="user-list-page-info" data-stripe-classes="[]" style="text-align: center">
        <thead>
        <tr>
          <th>id</th>
          <th>Public key</th>
          <th>Ngày tạo</th>
          <th>Ngày hết hạn</th>
          <th>Ngày hủy</th>
          <th>Trạng thái</th>
          <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${requestScope.keyList}">
          <tr style="background-color:rgba(0,0,0,.05)">
            <td>${item.id}</td>
            <td style="
    max-width: 200px;
    word-break: break-all;">${item.key}</td>
            <td>${item.dayReceive}</td>
            <td>${item.dayExpired}</td>
            <td>${item.dayCanceled}</td>
            <td>
              <div id="renderIsActive${item.id}">
              <c:if test="${item.status==1}">
              <span class="badge iq-bg-success">
															</c:if>
															<c:if test="${item.status==0}">
																<span class="badge iq-bg-danger">
															</c:if>
                                                                    ${item.statusDescription}</span>
            </div>
            </td>
            <td>
              <c:if test="${item.status==1}">
                <button class="btn btn-danger" type="button" onclick="lostKey(this)">
                  <fmt:message>button.lost</fmt:message>
                </button>
              </c:if>
            </td>
          </tr>

        </c:forEach>
        </tbody>
      </table>

    </div>
  </section>
  <!-- Footer Section Begin -->
  <c:import url="/anime-main/footer.jsp"/>
  <!-- Footer Section End -->
</div>
<!-- Js Plugins -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css">
<script src="js/jquery-3.3.1.min.js"></script>
<script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/player.js"></script>
<script src="js/jquery.nice-select.min.js"></script>
<script src="js/mixitup.min.js"></script>
<script src="js/jquery.slicknav.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>
<script type="text/javascript">
</script>
<script>
  var tableKey;

  $(document).ready(function () {
    tableKey=$('#key-list-table').DataTable({
      "stripeClasses": [],
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
  let addRow=`<table class="table table-striped table-bordered" >
              <thead>
                                    <tr>
                                        <th>Public Key</th>
                                        <th>Ngày hết hạn</th>
                                        <th>Option</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                 <tr id="addKey">


                                            <td contenteditable="true" id="addPublicKey" style="
    max-width: 200px;
    word-break: break-all;"></td>
                                            <td contenteditable="true"><input name="addDayExpired" id="addDayExpired" type="date"></td>
                                            <td>
                                               <span class="table-remove">
                                               <button type="button" class="btn btn-sm iq-bg-success btn-rounded btn-sm my-0" style="background:#ecfff6 !important;color: #65f9b3!important" onclick="submitAdd(this)" id="submitAddButton">Submit</button>
                                                </span>
                                            </td>
                                        </tr>
                                        </tbody>
                                        </table>
            `
  $(".addKey").on("click",()=>{
    if ($("#addKey").length) {
      $("#addArea").html(``);
    } else {
      $("#addArea").html(addRow);
      let button = $("#submitAddButton");
      let tr = $(button).closest("tr");
      let tdArray = $(tr).find("td");
      validate(tdArray[1],button, tdArray[0]);
      enableSubmit(tdArray[1],button, tdArray[0]);

    }
  });

  function validate(dayExpired,submit, ...tds) {

    tds.forEach(td => {
      td.addEventListener("input", () => {
        enableSubmit(dayExpired,submit, ...tds);
      });
    })
    $($(dayExpired).find("#addDayExpired")).on("change",()=>{
      enableSubmit(dayExpired,submit, ...tds);
    })
  }

  function enableSubmit(dayExpired,submit, ...tds) {
    let isNotEmpty = true;
    tds.forEach(td => {
      isNotEmpty &= $(td).text().trim() !== "";
    })
    isNotEmpty&=$($(dayExpired).find("#addDayExpired")).val()!==""
    if (isNotEmpty) {
      $(submit).prop('disabled', false);
    } else {
      $(submit).prop('disabled', true);

    }
  }
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
        let addPublicKey = $(tdArray[0]).text();
        let addDayExpired = $($(tdArray[1]).find("#addDayExpired")).val();
        $.ajax({
          url: "AddPublicKey",
          type: "post",
          data: {
            addPublicKey:addPublicKey,
            addDayExpired : addDayExpired,
          },
          success: function (data) {
            if (data.status === 400) {
              Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: data.responseText,
              });
              return;
            }

              let newBonus = JSON.parse((JSON.parse(data)).newKey);
            let status = newBonus.status;
            let statusString = newBonus.status==1?`<span class="badge iq-bg-success">`:`<span class="badge iq-bg-danger">`;
            let bt = newBonus.status==1?`<button class="btn btn-danger" type="submit">
                      <fmt:message>button.lost</fmt:message>
                    </button>`:"";
              let appendInsert=`<tr style="background-color:rgba(0,0,0,.05)">`
            +`<td>`+newBonus.id+`</td>
            <td style="
    max-width: 200px;
    word-break: break-all;">`+newBonus.key+`</td>
            <td>`+newBonus.dayReceive+`</td>
            <td>`+newBonus.dayExpired+`</td>
            <td>`+newBonus.dayCanceled+`</td>
            <td>
              <div id="renderIsActive`+newBonus.id+`">`+statusString+
                                                                    newBonus.statusDescription+`</span>
            </div>
            </td>
            <td>
             `+bt+`
            </td>
          </tr>`;
              tableKey.rows.add($(appendInsert)).draw();
              $("#addKey").remove();
              Swal.fire(
                      'Good job!',
                      'Thêm thành công!',
                      'success'
              )
          },
          error: function (xhr) {

              Swal.fire({
                icon: 'error',
                title: 'Oops...',
                text: xhr.responseText,
              });

          }
        });
      }
    })

  }
  function lostKey(button){
    Swal.fire({
      title: 'Xác nhận?',
      text: "Bạn đã lộ hoặc mất private key và chắc chắn vô hiệu hóa chữ kí hiện tại ?!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Xác nhận!'
    }).then((result) => {
      if (result.isConfirmed) {

      }
    })

  }
</script>
</body>

</html>