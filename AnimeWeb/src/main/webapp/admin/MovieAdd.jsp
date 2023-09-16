<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en">
<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Nhập phim mới</title>
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
  <c:url var="submitAddMovie" value="/admin/MovieAdd"/>
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
      <h1>Nhập phim mới</h1>
      <form method="post" action="${submitAddMovie}" id="mainForm" enctype="multipart/form-data" class="needs-validation">
        <div class="row">
          <div class="col-lg-3">
            <div class="iq-card">
              <div class="iq-card-header d-flex justify-content-between">
                <div class="iq-header-title">
                  <h4 class="card-title">Chọn ảnh đại diện</h4>
                </div>
              </div>
              <div class="iq-card-body">

                <div class="form-group">
                  <div class="add-img-user profile-img-edit">

                    <div class="p-image">
                      <div id="image-render-area">
                      </div>
                      <label
                              class="upload-button btn iq-bg-primary">Ảnh đại diện (5 ảnh) <input
                              class="file-upload" type="file" accept="image/*" name="avatar1" id="uploadImage" multiple></label>
                    </div>

                  </div>
                  <div class="img-extension mt-3">
                    <div class="d-inline-block align-items-center">
                      <span>Chấp nhận</span> <label href="javascript:void();">.jpg</label> <label
                    >.png</label> <label>.jpeg</label><span></span>
                    </div>
                  </div>
                </div>

              </div>
            </div>
          </div>
          <div class="col-lg-9">
            <div class="iq-card">
              <div class="iq-card-header d-flex justify-content-between">
                <div class="iq-header-title">
                  <h4 class="card-title">Thông tin phim mới</h4>
                </div>
              </div>
              <div class="iq-card-body">
                <div class="new-user-info">

                  <div class="row">
                    <div class="form-group col-md-6">
                      <label for="name">Tên phim: </label> <input type="text"
                                                              class="form-control" id="name" name="name" placeholder="Name" required>
                    </div>


                    <div class="form-group col-md-6">
                      <label for="totalEpisode">Tổng số tập:</label> <input type="number"
                                                                              class="form-control" id="totalEpisode" name="totalEpisode" placeholder="Total Episode" required>
                    </div>
                    <div class="form-group col-md-6">
                      <label for="descriptionVN">Mô tả tiếng Việt:</label> <input type="text"
                                                                                class="form-control" id="descriptionVN" name="descriptionVN" placeholder="Description VN" required>
                    </div>
                    <div class="form-group col-md-6">
                      <label for="descriptionEN">Mô tả tiếng Anh:</label> <input type="text"
                                                                                class="form-control" id="descriptionEN" name="descriptionEN" placeholder="Description EN" required>
                    </div>
                    <div class="form-group col-md-6">
                      <label for="price">Giá bán:</label> <input type="number"
                                                               class="form-control" id="price" name="price" placeholder="Price">
                    </div>
                    <div class="form-group col-md-6">
                      <label for="priceImport">Giá nhập:</label> <input type="number"
                                                                 class="form-control" id="priceImport" name="priceImport" placeholder="Price">
                    </div>
                  </div>
                  <hr>
                  <h5 class="mb-3">Mở rộng</h5>
                  <div class="row">
                    <div class="form-group col-md-12">
                      <div id="producerPicker">
                        <label>Chọn nhà sản xuất</label><br>
                          <c:forEach var="pd" items="${requestScope.listProducer}">
                            <input type="checkbox" id="myCheckbox${pd.id}" name="producerPicker" value="${pd.id}" readonly>
                            <label for="myCheckbox${pd.id}">${pd.name}</label>
                          </c:forEach>
                      </div>
                      <div >
                        <label for="supplierPicker">Chọn nhà cung cấp</label><br>
                          <select id="supplierPicker" name="supplierPicker">
                                <c:forEach var="sp" items="${requestScope.listSupplier}">
                                  <option value="${sp.id}">${sp.name}</option>
                                </c:forEach>
                          </select>

                      </div>
                      <div id="pickedGenre">

                      </div>
                      <div id="GenresRender">
                        <label>Chọn thể loại</label>
                            <c:forEach var="genre" items="${requestScope.listGenre}">
                              <input type="checkbox" name="genreValue" value="${genre.id}">${genre.description}
                            </c:forEach>

                      </div>
                    </div>
                    <div class="form-group col-md-6">

                      <div id="typeRender">
                        <label>Chọn loại phim
                          <select name="typePicker" id="typePicker">
                            <c:forEach var="type" items="${requestScope.listType}">
                              <option value="${type.id}">${type.description}</option>
                            </c:forEach>
                          </select>
                        </label>

                      </div>
                    </div>
                  </div>

                  <button type="button" class="btn btn-primary" id="addMovieBt">Xác nhận</button>

                </div>
                <p>${requestScope.error}</p>
              </div>
            </div>
           </div>
        </div>
      </form>
    </div>
  </div>
</div>
<!-- Wrapper END -->
<!-- Footer -->
<footer class="bg-white iq-footer">
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
<script src="js/jquery.min.js"></script>
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
  $("#addMovieBt").on("click",()=>{
    let files = $("#uploadImage").prop("files");
    if(files.length===5 && ($("#name").val().trim()!="")){
      $("#mainForm").submit();
    }else{
      Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: 'Vui lòng nhập tên phim!',

      })
    }
  });
</script>
</body>
</html>