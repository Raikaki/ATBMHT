<%@ page language="java" contentType="text/html; charset=UTF-8"
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
  <link rel="icon" href="${pageContext.request.contextPath}/anime-main/img/logonweb.png" type="image/png">

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
  <link rel="stylesheet" type="text/css" href="css/ds/style.css" />
  <script src="https://kit.fontawesome.com/9847adceef.js"></script>
  <script src="https://www.google.com/recaptcha/api.js?hl=vi"></script>

</head>

<body>



<c:url var="urlAvatar"
       value="${request.rervletContext.realPath}/anime-main/storage/avatarUser/${sessionScope.user.avatar}" />
<fmt:setLocale value="${sessionScope.LANG}" />
<fmt:setBundle basename="app" />


<!-- Page Preloder -->
<div id="preloder">
  <div class="loader"></div>
</div>
<div id="ah_wrapper">
  <!-- Header Section Begin -->
  <c:import url="/anime-main/header.jsp" />
  <c:url var="login" value="/anime-main/login.jsp"/>
  <!-- Header End -->
<c:url var="forgotPassword" value="/anime-main/forgotPassword"/>
  <!-- Normal Breadcrumb Begin -->
  <section class="normal-breadcrumb set-bg"
           data-setbg="img/normal-breadcrumb.jpg">
    <div class="container">
      <div class="row">
        <div class="col-lg-12 text-center">
          <div class="normal__breadcrumb__text">
            <h2>
              Forget Password
            </h2>

          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- Normal Breadcrumb End -->

  <!-- Signup Section Begin -->
  <section class="signup spad">
    <div class="container">
      <div class="row">
        <div class="col-lg-6">
          <div class="login__form">
            <h3>
              Forget Password
            </h3>
            <form action="${forgotPassword}?action=verify" method="post">
              <div class="input__item">
                <input required="required" type="email"
                       placeholder="Email address" name="email" value="${mailOld}"
                       id="mailValue"> <span class="icon_mail"></span>
              </div>
              <div class="input__item">
                <input required="required" type="text" placeholder="loginName"
                       name="userName" value="${nameOld}"> <span
                      class="icon_profile"></span>
              </div>
              <div class="g-recaptcha"
                   data-sitekey="6Lf2nYwkAAAAADknQvj1Os2Ht92MMORFX3RhbQDo"></div>
              <div class="input__item">
                <input required="required" type="text" placeholder="Mã xác nhận"
                       name="emailCode">
                <button id="SendMailButton" onclick="afterSendmail(this)"
                        disabled>Send mail</button>
              </div>
              <div id="logInfoEmail"></div>
              <div style="color: red">${requestScope.error}</div>


              <button type="submit" class="site-btn" value="Submit"
                      name="accountBtn">
                Xác nhận
              </button>
            </form>
            <h5>
                Đăng nhập lại
              <a href="${login}"><fmt:message>menu.login</fmt:message>!</a>
            </h5>
          </div>
        </div>

      </div>
    </div>
  </section>
  <!-- Signup Section End -->

  <!-- Footer Section Begin -->
  <c:import url="/anime-main/footer.jsp" />
  <!-- Footer Section End -->
</div>
<!-- Search model Begin -->
<div class="search-model">
  <div class="h-100 d-flex align-items-center justify-content-center">
    <div class="search-close-switch">
      <i class="icon_close"></i>
    </div>
    <form class="search-model-form">
      <input required="required" type="text" id="search-input"
             placeholder="Search here.....">
    </form>
  </div>
</div>
<!-- Search model end -->

<!-- Js Plugins -->

<script type="text/javascript">
  function validateEmail(email) {
    var re = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/;
    return re.test(String(email).toLowerCase());
  }
  var emailInput = document.getElementById('mailValue');
  emailInput.addEventListener('input', function() {
    var isValidEmail = validateEmail(emailInput.value);
    if (isValidEmail) {
      document.getElementById('SendMailButton').removeAttribute(
              'disabled');
    } else {
      document.getElementById('SendMailButton').setAttribute(
              'disabled', 'disabled');
    }
  });
  function sendMail() {
    var linkMail = document.getElementById("mailValue").value;

    $.ajax({
      url : "${forgotPassword}",
      type : "get",
      data : {
        email : linkMail,
      },
      success : function(data) {
        $("#logInfoEmail").html(data);

      },
      error : function(data) {
        $("#logInfoEmail").html("Gửi mail thất bại");
      }
    });
  }
  function afterSendmail(e) {
    var timeLeft = 30;
    e.disabled = true;
    sendMail();
    var timerId = setInterval(countdown, 1000);
    function countdown() {
      if (timeLeft == -1) {
        clearTimeout(timerId);
        e.disabled = false;
        e.textContent = "Send mail";
      } else {
        e.textContent = timeLeft + " s";
        timeLeft--;
      }
    }

  }
</script>
</body>

</html>