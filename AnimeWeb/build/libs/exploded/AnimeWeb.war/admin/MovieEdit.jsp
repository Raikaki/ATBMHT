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
    <title>Chỉnh sửa thông tin phim</title>
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
    <c:url var="submitEdit" value="/admin/MovieEdit" />
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
            <h1>Sửa thông tin phim</h1>
            <form method="post" action="${submitEdit}?idMovie=${requestScope.movieTarget.id}" id="mainForm" enctype="multipart/form-data" class="needs-validation">
                <div class="row">
                    <div class="col-lg-3">
                        <div class="iq-card">
                            <div class="iq-card-header d-flex justify-content-between">
                                <div class="iq-header-title">
                                    <h4 class="card-title">Sửa ảnh đại diện</h4>
                                </div>
                            </div>
                            <div class="iq-card-body">
                                <div class="form-group">
                                    <div class="add-img-user profile-img-edit">

                                        <div class="p-image">
                                            <div id="image-render-area">
                                            </div>
                                            <label
                                                    class="upload-button btn iq-bg-primary">Ảnh đại diện (5 ảnh)<input
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
                                    <h4 class="card-title">Sửa thông tin phim</h4>
                                </div>
                            </div>
                            <div class="iq-card-body">
                                <div class="new-user-info">

                                    <div class="row">
                                        <div class="form-group col-md-6">
                                            <label for="name">Tên phim: </label> <input type="text"
                                                                                    class="form-control" id="name" name="name" placeholder="Name" value="${requestScope.movieTarget.name}" required>
                                        </div>


                                        <div class="form-group col-md-6">
                                            <label for="totalEpisode">Tổng số tập:</label> <input type="number"
                                                                                                    class="form-control" id="totalEpisode" name="totalEpisode" placeholder="Total Episode" value="${requestScope.movieTarget.totalEpisode}" required>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="descriptionVN">Mô tả tiếng Việt:</label> <input type="text"
                                                                                                      class="form-control" id="descriptionVN" name="descriptionVN" placeholder="Description VN" value="${requestScope.movieTarget.descriptionVN}" required>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="descriptionEN">Mô tả tiếng Anh:</label> <input type="text"
                                                                                                      class="form-control" id="descriptionEN" name="descriptionEN" placeholder="Description EN" value="${requestScope.movieTarget.descriptionEN}" required>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="price">Giá bán:</label> <input type="number"
                                                                                       class="form-control" id="price" name="price" placeholder="Price" value="${requestScope.movieTarget.price}">
                                        </div>

                                    </div>
                                    <hr>
                                    <h5 class="mb-3">Mở rộng</h5>
                                    <div class="row">
                                        <div class="form-group col-md-12">
                                            <div id="producerPicker">
                                                <label>Chọn nhà sản xuất</label><br>
                                                <c:forEach var="pd" items="${requestScope.listProducer}">
                                                    <input type="checkbox" id="myCheckbox${pd.id}" name="producerPicker" value="${pd.id}" readonly checked>
                                                    <label for="myCheckbox${pd.id}">${pd.name}</label>
                                                </c:forEach>
                                                <c:forEach var="p" items="${requestScope.producerNotHave}">
                                                    <input type="checkbox" id="myCheckbox${p.id}" name="producerPicker" value="${p.id}" readonly>
                                                    <label for="myCheckbox${p.id}">${p.name}</label>
                                                </c:forEach>
                                            </div>

                                            <div id="pickedGenre">
                                                    <c:forEach var="gr" items="${requestScope.movieTarget.genres}">
                                                        <input type="checkbox" name="genreValue" checked value="${gr.id}">${gr.description}
                                                    </c:forEach>
                                                    <c:forEach var="ngr" items="${requestScope.genreNotHave}">
                                                        <input type="checkbox" name="genreValue"  value="${ngr.id}">${ngr.description}

                                                    </c:forEach>
                                            </div>

                                        </div>
                                        <div class="form-group col-md-6">

                                            <div id="typeRender">
                                                <label>Chọn loại phim
                                                    <select name="typePicker"  id="typePicker">
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