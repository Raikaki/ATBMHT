<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<canvas id="costchart"></canvas>
<c:url value="/api/revenue-by-month" var="revenue"/>
<script>
    $(document).ready(function () {
// Gọi API endpoint để lấy dữ liệu thống kê
        $.getJSON('${revenue}', function (data) {
// Tạo biểu đồ cột
            var ctx = document.getElementById('costchart').getContext('2d');
            console.log(data)
            var chart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: data.labels,
                    datasets: [{
                        label: 'Số tiền thu được (VND)',
                        data: data.values,
                        borderColor: 'green',
                        backgroundColor: 'rgba(0, 128, 0, 0.2)',
                        fill: true,
                        tension: 0.5,
                    }, {
                        label: 'Số tiền nhập phim (VND)',
                        data: data.cost,
                        borderColor: 'red',
                        backgroundColor: 'rgba(255, 0, 0, 0.2)',
                        fill: true,
                        tension: 0.5,
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        });
    });
</script>
</body>
</html>
