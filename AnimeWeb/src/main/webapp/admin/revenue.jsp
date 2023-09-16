
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
  <title>Thống kê doanh thu</title>
  <!-- Thêm thư viện jQuery và Chart.js -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<!-- Tạo một canvas để vẽ biểu đồ -->
<canvas id="revenueChart"></canvas>

<c:url value="/api/revenue-by-month" var="revenue"/>
<script>
  $(document).ready(function() {
    // Gọi API endpoint để lấy dữ liệu thống kê
    $.getJSON('${revenue}', function(data) {
      // Tạo biểu đồ cột
      var ctx = document.getElementById('revenueChart').getContext('2d');
      var chart = new Chart(ctx, {
        type: 'bar',
        data: {
          labels: data.labels,
          datasets: [{
            label: 'Tổng doanh thu (VND)',
            data: data.values,
            backgroundColor: 'rgba(54, 162, 235, 0.2)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 1
          }]
        },
        options: {
          scales: {
            yAxes: [{
              ticks: {
                beginAtZero: true
              }
            }]
          }
        }
      });
    });
  });
</script>


</body>
</html>

