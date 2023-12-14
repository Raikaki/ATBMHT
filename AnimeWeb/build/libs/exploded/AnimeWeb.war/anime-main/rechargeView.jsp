<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isELIgnored="false" %>
<html>
<head>


    <meta charset="UTF-8">
    <meta name="description" content="Anime Template">
    <meta name="keywords" content="Anime, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Anime|Wallet</title>
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
    <link rel="icon" href="${pageContext.request.contextPath}/anime-main/img/logonweb.png" type="image/png">

    <link rel="stylesheet" href="css/plyr.css" type="text/css">
    <%--    <link rel="stylesheet" href="css/nice-select.css" type="text/css">--%>
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="css/ds/style.css"/>
    <script src="https://kit.fontawesome.com/9847adceef.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.css"/>
    <fmt:setLocale value="${sessionScope.LANG}"/>
    <fmt:setBundle basename="app"/>
</head>
<body>
<fmt:setLocale value="${sessionScope.LANG}"/>
<c:url var="profileServlet" value="/anime-main/profile.jsp"/>
<c:url var="MovieDetail" value="/anime-main/MovieDetail"/>
<c:url var="Index" value="/anime-main/Index"/>
<c:url var="walletView" value="/anime-main/recharge"/>
<c:url var="urlAvatar" value="${sessionScope.user.avatar}"/>
<div id="preloder">
    <div class="loader"></div>
</div>
<div id="ah_wrapper">
    <c:import url="/anime-main/header.jsp"/>
    <section class="product spad">
        <div class="container" id="container">

            <div class="row">
                <div class="col-lg-6">
                    <h4 style="color: whitesmoke"><fmt:message>content.accountInformation</fmt:message></h4>
                    <div class="walletImg"><img alt="" src="${urlAvatar}" id="avatar_user"></div>
                    <h4 style="color: whitesmoke"> ${user.fullName}</h4>
                    <br>
                    <h4 style="color: whitesmoke"><fmt:message>content.balance</fmt:message></h4>
                    <div class="balance">

                        <div style="font-size: 200%!important;"><fmt:formatNumber value="${sessionScope.user.balance}"
                                                                                  type="number" pattern="#,##0"/>VND
                        </div>

                    </div>
                    <div>
                        <a href="${walletView}">
                            <button><fmt:message>content.recharge</fmt:message></button>
                        </a>
                    </div>


                </div>
                <div class="col-lg-6">
                    <div class="history">
                        <h4 style="color: whitesmoke"><fmt:message>content.history</fmt:message></h4>
                        <div class="historyTransaction">
                            <c:forEach var="wallet" items="${history}">

                                <c:if test="${not empty wallet}">
                                    <c:choose>
                                        <c:when test="${fn:contains(wallet.residualRange, '-')}">
                                            <div style="color: #ff7070">${wallet.changeFormat()}
                                                <fmt:message>content.fluctuations</fmt:message> ${wallet.residualRange}VND
                                                <fmt:message>content.buyMovie</fmt:message></div>
                                        </c:when>
                                        <c:otherwise>
                                            <div style="color: #02ff02">${wallet.changeFormat()}
                                                <fmt:message>content.fluctuations</fmt:message> ${wallet.residualRange}VND
                                                <fmt:message>content.paypaldec</fmt:message></div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">

                </div>
            </div>
        </div>
    </section>
    <!-- Product Section End -->

    <!-- Footer Section Begin -->
    <c:import url="/anime-main/footer.jsp"/>


</div>
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/player.js"></script>
<%--<script src="js/jquery.nice-select.min.js"></script>--%>
<script src="js/mixitup.min.js"></script>
<script src="js/jquery.slicknav.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>
<script>
    $(document).ready(function () {
        let selectElement = $('#filter');
        let optionElements = selectElement.find('option');
        optionElements.each(function () {
            let optionValue = $(this).val();

            if (optionValue == "${requestScope.param}") {
                $(this).prop("selected", true);
            }
        });
    })
</script>

</body>
</html>
