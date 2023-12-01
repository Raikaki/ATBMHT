<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
</head>
<body>
<c:url var="chartMovie" value="/admin/chartMovie"/>
<div style="display: flex; justify-content: space-between;">
    <div>
        <div id="chartMonth" style="width: 300px!important; height: 300px!important;"></div>
    </div>
    <div>
        <div id="chartYear" style="width: 300px!important; height: 300px!important;"></div>

    </div>
</div>


<script>
    $(document).ready(function () {
        var topViewMoviesMonth;
        var topViewMoviesYear;

        // Hàm vẽ biểu đồ cho top view tháng
        function drawMonthChart(data) {
            var seriesData = [];

            // Tạo dữ liệu cho series
            for (var i = 0; i < data.length; i++) {
                seriesData.push({
                    name: data[i].name,
                    y: data[i].views
                });
            }

            // Vẽ biểu đồ tròn
            Highcharts.chart('chartMonth', {
                chart: {
                    type: 'pie'
                },
                title: {
                    text: 'Các bộ phim được xem nhiều nhất trong tháng'
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.y}</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b>: {point.y}',
                            distance: -30
                        }
                    }
                },
                series: [{
                    name: 'Top view this month',
                    data: seriesData,
                    colors: [
                        'rgba(255, 99, 132, 0.7)',
                        'rgba(54, 162, 235, 0.7)',
                        'rgba(255, 206, 86, 0.7)',
                        'rgba(75, 192, 192, 0.7)',
                        'rgba(153, 102, 255, 0.7)'
                    ]
                }]
            });
        }

// Hàm vẽ biểu đồ cho top view năm
        function drawYearChart(data) {
            var seriesData = [];

            // Tạo dữ liệu cho series
            for (var i = 0; i < data.length; i++) {
                seriesData.push({
                    name: data[i].name,
                    y: data[i].views
                });
            }

            // Vẽ biểu đồ tròn
            Highcharts.chart('chartYear', {
                chart: {
                    type: 'pie'
                },
                title: {
                    text: 'Các bộ phim được xem nhiều nhất trong năm'
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.y}</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b>: {point.y}',
                            distance: -30
                        }
                    }
                },
                series: [{
                    name: 'Top view this year',
                    data: seriesData,
                    colors: [
                        'rgba(255, 99, 132, 0.7)',
                        'rgba(54, 162, 235, 0.7)',
                        'rgba(255, 206, 86, 0.7)',
                        'rgba(75, 192, 192, 0.7)',
                        'rgba(153, 102, 255, 0.7)'
                    ]
                }]
            });

        }

        // Gửi yêu cầu AJAX để lấy dữ liệu biểu đồ năm mặc định
        $.ajax({
            url: "${chartMovie}",
            method: "GET",
            success: function (response) {
                topViewMoviesYear = response;
                console.log(response);
                drawYearChart(response);
            },
            error: function (xhr, status, error) {
                console.error(error);
            }
        });

        // Gửi yêu cầu AJAX để lấy dữ liệu biểu đồ tháng mặc định
        $.ajax({
            url: "${chartMovie}",
            method: "GET",
            data: { action: "month" },
            success: function (response) {
                topViewMoviesMonth = response;
                console.log(response);
                drawMonthChart(response);
            },
            error: function (xhr, status, error) {
                console.error(error);
            }
        });
    });
</script>
</body>
</html>
