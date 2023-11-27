<%@ page contentType="text/html; charset=UTF-8"
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
    <script src="https://kit.fontawesome.com/9847adceef.js"></script>
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

    <!-- Hero Section Begin -->
    <section class="product spad">

        <div class="container">
            <c:url value="/anime-main/ViewProfile" var="ViewProfile"></c:url>
            <form action="${ViewProfile}" method="post"
                  id="editProfile" enctype="multipart/form-data">
                <div class="changeAvatar">
                    <label for="files" id="renderAvatar">
                        <img alt="" src="${user.avatar}" id="avatarUser" class="upload">
                    </label>
                    <input type="file" name="files" accept="image/*" id="files" hidden="" onchange="demoImage()">

                </div>
                <div class="row">

                    <label class="col-sm-3">Full name:</label>
                    <input type="text" name="name" id="name"value="${user.fullName}">
                </div>
                <div class="row">
                    <label class="col-sm-3">Email:</label>
                    <input type="text" value="${user.email}" name="email" readonly>
                </div>
                <div class="row">
                    <label class="col-sm-3">Số điện thoại:</label>
                    <input type="text" value="${user.phone}" name="phone">

                </div>
                <div class="row justify-content-end">
                    <div class="col-auto">
                        <button class="btn btn-danger" type="submit">
                            <fmt:message>button.edit</fmt:message>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </section>
    <!-- Footer Section Begin -->
    <c:import url="/anime-main/footer.jsp"/>
    <!-- Footer Section End -->

    <!-- Search model Begin -->
    <div class="search-model">
        <div class="h-100 d-flex align-items-center justify-content-center">
            <div class="search-close-switch">
                <i class="icon_close"></i>
            </div>
            <form class="search-model-form">
                <input type="text" id="search-input" placeholder="Search here.....">
            </form>
        </div>
    </div>
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
<script type="text/javascript">
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
</script>
</body>

</html>