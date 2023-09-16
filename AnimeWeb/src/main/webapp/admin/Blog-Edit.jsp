
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>FinDash - Responsive Bootstrap 4 Admin Dashboard Template</title>
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
    <c:url var="BlogEdit" value="/admin/BlogEdit"></c:url>

    <!-- TOP Nav Bar END -->
    <!-- Page Content  -->
    <div id="content-page" class="content-page">
        <div class="container-fluid">
            <form method="post" action="${BlogEdit}?action=edit" enctype="multipart/form-data">
                <div class="row">
                    <div class="col-lg-3">
                        <div class="iq-card">
                            <div class="iq-card-header d-flex justify-content-between">
                                <div class="iq-header-title">
                                    <h4 class="card-title"> Blog Information</h4>
                                </div>
                            </div>
                            <div class="iq-card-body">

                                <div class="form-group">
                                    <div class="add-img-user profile-img-edit">




                                        <div class="p-image">

                                            <label
                                                    class="upload-button btn iq-bg-primary" for="files" id="renderAvatar">
                                                <img alt="" src="/${requestScope.Blog.avatar}" style="width: 50px!important;height: 50px!important;" id="avatarUser" class="upload">

                                            </label>

                                            <input
                                                    class="file-upload" type="file" id="files" accept="image/*" name="avatar" onchange="demoImage()">



<%--                                            <img class="profile-pic img-fluid" style="width: 50px!important;height: 50px!important;" src="/${requestScope.Blog.avatar}"--%>
<%--                                                 alt="profile-pic">--%>
<%--                                            <label--%>
<%--                                                    class="upload-button btn iq-bg-primary">Image Upload --%>
<%--                                                <input--%>
<%--                                                    class="file-upload" type="file" accept="image/*" name="avatar"></label>--%>
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
                                    <h4 class="card-title">Blog Information</h4>
                                </div>
                            </div>
                            <div class="iq-card-body">
                                <div class="new-user-info">

                                    <div class="row">
                                        <div class="form-group col-md-6">
                                            <label for="name">ID: </label> <input type="text"
                                                                                  class="form-control" id="name" name="idBlog" value="${requestScope.Blog.getId()}" placeholder="ID" readonly >
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="name">Title: </label> <input type="text"
                                                                                     class="form-control" id="title" name="title" placeholder="Title" value="${requestScope.Blog.getTitle()}">
                                        </div>

                                        <div class="form-group col-md-6">
                                            <label for="descriptionVN">Ngày ra mắt</label> <input type="datetime-local"
                                                                                                  class="" id="descriptionVN" name="datetime" placeholder="Description VN" value="${requestScope.Blog.releaseAt}">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="descriptionVN">Status</label>
                                            <select id="status" name="status">
                                                <option value="1" ${requestScope.Blog.status == '1' ? 'selected' : ''}>1</option>
                                                <option value="0" ${requestScope.Blog.status == '0' ? 'selected' : ''}>0</option>
                                            </select>

                                            </select>
                                        </div>


                                    </div>
                                    <hr>
                                    <button   type="submit" class="btn btn-primary">Edit
                                        Blog</button>

                                </div>
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
<script>
    function demoImage() {

        var fileSelected = document.getElementById("files").files;
        if (fileSelected.length > 0) {
            var fileToLoad = fileSelected[0];
            var fileReader = new FileReader();
            fileReader.onload = function (fileLoaderEvent) {
                var srcData = fileLoaderEvent.target.result;
                var newImage = document.createElement('img');
                newImage.src = srcData;
                document.getElementById("renderAvatar").innerHTML = newImage.outerHTML;
            }
            fileReader.readAsDataURL(fileToLoad);
        }
    }
    function chooseGenre(){
        let pickedValue = $("#genrePicker").val();
        let pickedText =$('#genrePicker option[value="' + $("#genrePicker").val() + '"]').text();
        $("#pickedGenre").append(
            `<div><label style="border: 1px solid red" onclick="reverseSelect(this)">
`+pickedText+`<input style="display: none;" type="number" name="genreValue" value="`+pickedValue+`">`+`
</label></div>`
        );
        $('#genrePicker option').filter(function() {
            return this.value === pickedValue;
        }).remove();
        if($('#genrePicker option').length===0){
            $('#GenresRender').css('display','none');
        }

    }
    function reverseSelect(button){
        if($("#GenresRender").is(":hidden")){
            $('#GenresRender').css('display','block');
        }
        $('#genrePicker').append(
            ` <option value="`+$(button).val()+`">`+$(button).text()+`</option>
              `
        )
        $($(button).closest("div")).remove();
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
<!-- Style Customizer -->
<script src="js/style-customizer.js"></script>
<!-- Chart Custom JavaScript -->
<script src="js/chart-custom.js"></script>
<!-- Custom JavaScript -->
<script src="js/custom.js"></script>
</body>
</html>