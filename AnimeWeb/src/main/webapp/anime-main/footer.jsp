<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<footer class="footer">
    <script src="js/main.js"></script>
    <fmt:setLocale value="${sessionScope.LANG}"/>
    <fmt:setBundle basename="app"/>
    <div class="page-up">
        <a href="#" id="scrollToTopButton"><span class="arrow_carrot-up"></span></a>
    </div>
    <script>    $("#scrollToTopButton").click(function () {
        $("html, body").animate({scrollTop: 0}, "slow");
        return false;
    });
    </script>

    <div id="fb-root"></div>

    <!-- Your Plugin chat code -->
    <div id="fb-customer-chat" class="fb-customerchat">
    </div>

    <script>
        var chatbox = document.getElementById('fb-customer-chat');
        chatbox.setAttribute("page_id", "101798746296853");
        chatbox.setAttribute("attribution", "biz_inbox");
    </script>

    <!-- Your SDK code -->
    <script>
        window.fbAsyncInit = function () {
            FB.init({
                xfbml: true,
                version: 'v17.0'
            });
        };

        (function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s);
            js.id = id;
            js.src = 'https://connect.facebook.net/vi_VN/sdk/xfbml.customerchat.js';
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
    </script>
    <div class="container">
        <!-- Messenger Plugin chat Code -->

        <div class="ah_footer">

            <div class="row">
                <div class="col-lg-3">
                    <div class="footer__logo">
                        <a href="./index.jsp"><img src="img/logo.png" alt=""></a>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="footer__nav">
                        <ul>
                            <li class="active"><a href="${index}"><fmt:message>menu.hompage</fmt:message></a></li>
                            <li><a href="./categories.jsp"><fmt:message>menu.categories</fmt:message></a></li>
                            <li><a href="./blog.jsp"><fmt:message>menu.ourblog</fmt:message></a></li>
                            <li><a
                                    href="https://www.facebook.com/profile.php?id=100012214729084"><fmt:message>menu.contracts</fmt:message></a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-3">
                    <p>
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        Copyright &copy;
                        <script>
                            document.write(new Date().getFullYear());
                        </script>
                        All rights reserved | 20130012 & 20130305
                        <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    </p>

                </div>
            </div>
        </div>
    </div>
</footer>
<c:import url="/anime-main/socket.jsp"/>
