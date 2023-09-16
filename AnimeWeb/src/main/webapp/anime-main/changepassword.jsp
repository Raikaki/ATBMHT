<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link rel="stylesheet" type="text/css" href="css/ds/style.css"/>
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
    <link rel="stylesheet" type="text/css" href="css/ds/style.css"/>
    <script src="https://kit.fontawesome.com/9847adceef.js"></script>
    <script src="https://www.google.com/recaptcha/api.js?hl=vi"></script>
</head>
<body>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app"/>
<c:url var="urlAvatar"
       value="${request.rervletContext.realPath}${sessionScope.user.avatar}"/>
<div id="ah_wrapper">

    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Header Section Begin -->
    <c:import url="/anime-main/header.jsp"/>
    <!-- Header End -->
    <c:url var="ChangePassW" value="/anime-main/ChangePassW"/>
    <!-- Hero Section Begin -->
    <section class="product spad">
        <div class="container">
            <form action="${ChangePassW}" method="post" id="editProfile">
<%--                <div class="row">--%>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Password :</span>
                            <input type="password" required="required" name="password">
                        </div>

                    </div>
                    <%--                    <label class="col-sm-3">Mật khâu mới:</label>--%>


                    <%--                    <input class="col-sm-9" type="password" required="required" name="password">--%>
                    <%--                </div>--%>
                    <div class="input-group mb-3">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Email &emsp;&nbsp;&nbsp; :</span>
                            <input type="email" value="${user.email}" name="email" required="required">
                        </div>

                    </div>
                    <%--                <div class="row">--%>
                    <%--                    <label class="col-sm-3">Email address:</label>--%>
                    <%--                    <input class="col-sm-9" required="required" type="email"--%>
                    <%--                           name="email" value="${user.email}"--%>
                    <%--                           id="mailValue" readonly>--%>
                    <%--                </div>--%>
                    <div class="row">
                        <div class="g-recaptcha"
                             data-sitekey="6Lf2nYwkAAAAADknQvj1Os2Ht92MMORFX3RhbQDo">
                        </div>
                    </div>
                    <div class="row">
                        <button class="col-sm-3" id="SendMailButton" onclick="afterSendmail(this)">Send mail</button>

                        <input class="col-sm-4" required="required" type="text" placeholder="Mã xác nhận"
                               name="emailCode">
                        <div class="col-sm-1"></div>

                    </div>


                    <div id="logInfoEmail"></div>
                    <div style="color: red">${errorSignup}</div>
                    <%--                <div class="row justify-content-end">--%>
                    <div class="justify-content-end row btneditpassword">
                        <button class="btn btn-danger" type="submit">
                            <fmt:message>button.edit</fmt:message>
                        </button>
                    </div>
            </form>



        </div>

    </section>
    <!-- Footer Section Begin -->
    <c:import url="/anime-main/footer.jsp"/>
    <!-- Footer Section End -->

    <!-- Search model Begin -->
    <%--    <div class="search-model">--%>
    <%--        <div class="h-100 d-flex align-items-center justify-content-center">--%>
    <%--            <div class="search-close-switch">--%>
    <%--                <i class="icon_close"></i>--%>
    <%--            </div>--%>
    <%--            <form class="search-model-form">--%>
    <%--                <input type="text" id="search-input" placeholder="Search here.....">--%>
    <%--            </form>--%>
    <%--        </div>--%>
    <%--    </div>--%>
    <!-- Search model end -->
</div>


<!-- Js Plugins -->

<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/player.js"></script>
<script src="js/jquery.nice-select.min.js"></script>
<script src="js/mixitup.min.js"></script>
<script src="js/jquery.slicknav.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>
<script type="text/javascript">

</script>
<script>
    function sendMail() {
        var linkMail = document.getElementById("mailValue").value;
// console.log(linkMail);
        $.ajax({
            url: "ValidateChangePassW",
            type: "get",
            data: {
                email: linkMail,
            },
            success: function (data) {
                $("#logInfoEmail").html(data);

            },
            error: function (data) {
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