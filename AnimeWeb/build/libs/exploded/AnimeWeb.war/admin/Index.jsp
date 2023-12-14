<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>Danh sách nhân viên | Quản trị Admin</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Main CSS-->
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
    <!-- or -->
    <link rel="stylesheet" href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
    <link rel="stylesheet" href="css/style.css">

    <link rel="shortcut icon" href="images/favicon.ico"/>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- Typography CSS -->
    <link rel="stylesheet" href="css/typography.css">
    <!-- Style CSS -->
    <link rel="stylesheet" href="css/style.css">
    <!-- Responsive CSS -->
    <link rel="stylesheet" href="css/responsive.css">
    <script src="https://kit.fontawesome.com/fe2c9f6253.js"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://kit.fontawesome.com/fe2c9f6253.css"
          crossorigin="anonymous">
    <!-- Font-icon css-->
    <link rel="stylesheet" type="text/css"
          href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <!-- Google tag (gtag.js) -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<div id="loading">
    <div id="loading-center"></div>
</div>
<body onload="time()" class="app sidebar-mini rtl">
<!-- Navbar-->

<div class="wrapper">
    <!-- Sidebar menu-->
    <c:import url="sidebar.jsp"/>
    <c:import url="/admin/header.jsp"/>
    <c:url var="chartMovie" value="/admin/chartMovie"/>
    <!-- Google tag (gtag.js) -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-Q5H83WY80P"></script>
    <script>
        window.dataLayer = window.dataLayer || [];

        function gtag() {
            dataLayer.push(arguments);
        }

        gtag('js', new Date());

        gtag('config', 'G-Q5H83WY80P');
    </script>
    <div class="content-page" id="content-page">
        <div class="row">
            <div class="col-md-12">
                <div class="app-title">

                    <div id="clock"></div>
                </div>
            </div>
        </div>
        <div class="row">
            <!--Left-->
            <div class="col-md-12 col-lg-6">
                <div class="row">
                    <!-- col-6 -->
                    <div class="col-md-6">
                        <div class="widget-small primary coloured-icon"><i class='icon bx bxs-user-account fa-3x'></i>
                            <div class="info">
                                <h4>Tổng khách hàng</h4>
                                <p><b>${requestScope.totalAccount}</b></p>
                                <p class="info-tong">Tổng số khách hàng được quản lý.</p>

                            </div>
                        </div>
                    </div>
                    <!-- col-6 -->
                    <div class="col-md-6">
                        <div class="widget-small info coloured-icon"><i class='icon bx bxs-data fa-3x'></i>
                            <div class="info">
                                <h4>Tổng số phim</h4>
                                <p><b>${requestScope.totalMovie} phim</b></p>
                                <p class="info-tong">Tổng số phim được quản lý.</p>
                            </div>
                        </div>
                    </div>
                    <!-- col-6 -->
                    <div class="col-md-6">
                        <div class="widget-small warning coloured-icon"><i class='icon bx bxs-shopping-bags fa-3x'></i>
                            <div class="info">
                                <h4>Tổng lượt mua phim </h4>
                                <p><b>${requestScope.totalMoviePurchase} lượt mua</b></p>
                                <p class="info-tong">Tổng số lượt mua phim.</p>


                            </div>
                        </div>
                    </div>
                    <!-- col-6 -->
                    <div class="col-md-6">
                        <div class="widget-small danger coloured-icon"><i class='icon bx bxs-error-alt fa-3x'></i>
                            <div class="info">
                                <h4>Tài khoản bị khóa</h4>
                                <p><b>${requestScope.blockAccount}</b></p>
                                <p class="info-tong">Tổng số tài khoản hiện tại đang bị khóa.</p>
                            </div>
                        </div>
                    </div>
                    <!-- col-12 -->
                    <div class="col-md-12">
                        <div class="tile">
                            <h3 class="tile-title">Các bộ phim được mua nhiều nhất trong tháng</h3>
                            <div>
                                <table class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th>ID Phim</th>
                                        <th>Tên Phim</th>
                                        <th>Thể loại</th>
                                        <th>Số lượng</th>
                                        <th>Giá</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="movie" items="${requestScope.topPurchasedList}">
                                        <tr>
                                            <td>${movie.id}</td>
                                            <td>${movie.name}</td>
                                            <td><c:forEach var="genre" items="${movie.genres}">
                                                <div>${genre.description}</div>
                                            </c:forEach></td>
                                            <td><fmt:formatNumber
                                                    value="${movie.totalPurchased}"
                                                    type="number"
                                                    pattern="#,##0"/></td>
                                            <td><fmt:formatNumber
                                                    value="${movie.price}"
                                                    type="number"
                                                    pattern="#,##0"/> VND</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!-- / div trống-->
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="tile">
                            <h3 class="tile-title">Các bộ phim được mua nhiều nhất trong trong năm</h3>
                            <div>
                                <table class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th>ID Phim</th>
                                        <th>Tên Phim</th>
                                        <th>Thể loại</th>
                                        <th>Số lượng</th>
                                        <th>Giá</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="movie" items="${requestScope.topPurchasedListYear}">
                                        <tr>
                                            <td>${movie.id}</td>
                                            <td>${movie.name}</td>
                                            <td><c:forEach var="genre" items="${movie.genres}">
                                                <div>${genre.description}</div>
                                            </c:forEach></td>
                                            <td><fmt:formatNumber
                                                    value="${movie.totalPurchased}"
                                                    type="number"
                                                    pattern="#,##0"/></td>
                                            <td><fmt:formatNumber
                                                    value="${movie.price}"
                                                    type="number"
                                                    pattern="#,##0"/> VND</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!-- / div trống-->
                        </div>
                    </div>

                    <div class="col-md-12">
                        <div class="tile">
                            <h3 class="tile-title">Các bộ phim được mua ít nhất trong tháng</h3>
                            <div>
                                <table class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th>ID Phim</th>
                                        <th>Tên Phim</th>
                                        <th>Thể loại</th>
                                        <th>Số lượng</th>
                                        <th>Giá</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="movie" items="${requestScope.topNotPurchasedList}">
                                        <tr>
                                            <td>${movie.id}</td>
                                            <td>${movie.name}</td>
                                            <td><c:forEach var="genre" items="${movie.genres}">
                                                <div>${genre.description}</div>
                                            </c:forEach></td>
                                            <td><fmt:formatNumber
                                                    value="${movie.totalPurchased}"
                                                    type="number"
                                                    pattern="#,##0"/></td>
                                            <td><fmt:formatNumber
                                                    value="${movie.price}"
                                                    type="number"
                                                    pattern="#,##0"/> VND</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!-- / div trống-->
                        </div>
                    </div>
                    <!-- / col-12 -->
                    <!-- col-12 -->
                    <div class="col-md-12">
                        <div class="tile">
                            <h3 class="tile-title">Thống kê thu chi của năm</h3>
                            <iframe src="costChart.jsp" width="100%" height="500"></iframe>
                            <div>
                                Lợi nhuận thu được trong năm :<h5><fmt:formatNumber value="${requestScope.profit}"  type="number" pattern="#,##0"/> VND</h5>
                            </div>
                        </div>

                    </div>
                    <!-- / col-12 -->
                </div>
            </div>
            <!--END left-->
            <!--Right-->
            <div class="col-md-12 col-lg-6">
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile">


                            <h3 class="tile-title">Top 5 các bộ phim được xem nhiều nhất</h3>

                            <iframe src="chartMovie.jsp" width="100%" height="500"></iframe>


                        </div>
                        <div class="col-md-12">
                            <div class="tile">
                                <h3 class="tile-title">Thống kê doanh thu </h3>
                                <div class="embed-responsive embed-responsive-16by9">
                                    <iframe src="revenue.jsp" width="100%" height="600"></iframe>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!--END right-->
            </div>


            <div class="text-center" style="font-size: 13px">
                <p><b>Copyright
                    <script type="text/javascript">
                        document.write(new Date().getFullYear());
                    </script>

                </b></p>
            </div>
        </div>
    </div>
</div>
<c:url value="/api/revenue-by-month" var="revenue"/>
<script src="js/jquery-3.3.1.min.js"></script>

<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<!--===============================================================================================-->
<script src="js/popper.min.js"></script>
<script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script>
<!--===============================================================================================-->
<script src="js/bootstrap.min.js"></script>
<!--===============================================================================================-->
<script src="js/main.js"></script>
<!--===============================================================================================-->
<script src="js/plugins/pace.min.js"></script>
<!--===============================================================================================-->
<script type="text/javascript" src="js/plugins/chart.js"></script>

<!--===============================================================================================-->
<
<script type="text/javascript">
    var data = {
        labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6"],
        datasets: [{
            label: "Dữ liệu đầu tiên",
            fillColor: "rgba(255, 213, 59, 0.767), 212, 59)",
            strokeColor: "rgb(255, 212, 59)",
            pointColor: "rgb(255, 212, 59)",
            pointStrokeColor: "rgb(255, 212, 59)",
            pointHighlightFill: "rgb(255, 212, 59)",
            pointHighlightStroke: "rgb(255, 212, 59)",
            data: [20, 59, 90, 51, 56, 100]
        },
            {
                label: "Dữ liệu kế tiếp",
                fillColor: "rgba(9, 109, 239, 0.651)  ",
                pointColor: "rgb(9, 109, 239)",
                strokeColor: "rgb(9, 109, 239)",
                pointStrokeColor: "rgb(9, 109, 239)",
                pointHighlightFill: "rgb(9, 109, 239)",
                pointHighlightStroke: "rgb(9, 109, 239)",
                data: [48, 48, 49, 39, 86, 10]
            }
        ]
    };
    var ctxl = $("#lineChartDemo").get(0).getContext("2d");
    var lineChart = new Chart(ctxl).Line(data);

    var ctxb = $("#barChartDemo").get(0).getContext("2d");
    var barChart = new Chart(ctxb).Bar(data);
</script>
<script type="text/javascript">
    //Thời Gian
    function time() {
        var today = new Date();
        var weekday = new Array(7);
        weekday[0] = "Chủ Nhật";
        weekday[1] = "Thứ Hai";
        weekday[2] = "Thứ Ba";
        weekday[3] = "Thứ Tư";
        weekday[4] = "Thứ Năm";
        weekday[5] = "Thứ Sáu";
        weekday[6] = "Thứ Bảy";
        var day = weekday[today.getDay()];
        var dd = today.getDate();
        var mm = today.getMonth() + 1;
        var yyyy = today.getFullYear();
        var h = today.getHours();
        var m = today.getMinutes();
        var s = today.getSeconds();
        m = checkTime(m);
        s = checkTime(s);
        nowTime = h + " giờ " + m + " phút " + s + " giây";
        if (dd < 10) {
            dd = '0' + dd
        }
        if (mm < 10) {
            mm = '0' + mm
        }
        today = day + ', ' + dd + '/' + mm + '/' + yyyy;
        tmp = '<span class="date"> ' + today + ' - ' + nowTime +
            '</span>';
        document.getElementById("clock").innerHTML = tmp;
        clocktime = setTimeout("time()", "1000", "Javascript");

        function checkTime(i) {
            if (i < 10) {
                i = "0" + i;
            }
            return i;
        }
    }
</script>
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


<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>

</html>