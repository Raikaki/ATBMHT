<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 4/30/2023
  Time: 3:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Warning</title>
</head>
<body>
<h1 style="color: red; text-align: center">Đây là chế độ cho nhà phát triển</h1>
<h2 style="text-align: center; color: #0b0b0b">Bạn không được phép xem </h2>
<p id="ip-address" style="text-align: center;font-size: 20px"></p>
<script>
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "https://api.ipify.org/?format=json", true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var response = JSON.parse(xhr.responseText);
            var ipAddress = response.ip;
            document.getElementById("ip-address").innerHTML = "Địa chỉ IP của bạn là: " + ipAddress;
        }
    };
    xhr.send();
</script>
</body>
</html>
