<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isELIgnored="false" %>


<html>
<head>
  <title>Refund Result</title>
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script>
    function performRefund() {
      var captureId = "92C68189G9002500G"; // Thay thế bằng captureId thực tế

      $.ajax({
        type: "POST",
        url: "/refund", // Tên servlet hoặc đường dẫn tương ứng
        data: { captureId: captureId },
        success: function(response) {
          $("#result").html(response);
        },
        error: function(error) {
          $("#result").html("Error in refund process: " + error.responseText);
        }
      });
    }
  </script>
</head>
<body>

<button onclick="performRefund()">Perform Refund</button>

<div id="result"></div>

</body>
</html>
