<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:useBean id="now" class="java.util.Date" scope="request"/>
<c:url var="urlAvatar" value="${sessionScope.user.avatar}"/>
<c:url var="listFollow" value="/anime-main/ListFollow"/>
<%--<c:url var="ManagerAccount" value="/anime-main/ManagerAccount"/>--%>

<c:url var="movieDetail" value="/anime-main/MovieDetail"/>
<c:url var="listPurchased" value="/anime-main/ListPurchased"/>
<c:url var="wishList" value="/anime-main/wishList"/>
<c:url var="index" value="/anime-main/Index"/>
<c:url var="logOut" value="/anime-main/logOut"/>
<fmt:setBundle basename="app"/>
<link rel="icon" href="/anime-main/img/logonweb.png" type="image/png">
<script src="https://cdn.jsdelivr.net/npm/console-ban@5.0.0/dist/console-ban.min.js"></script>
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-Q5H83WY80P"></script>


<script>
    window.dataLayer = window.dataLayer || [];

    function gtag() {
        dataLayer.push(arguments);
    }

    gtag('js', new Date());

    gtag('config', 'G-Q5H83WY80P');
</script>
<script>
    // default options
    ConsoleBan.init()
    // custom options
    ConsoleBan.init({
        redirect: '../cook.jsp'
    })

    let isCtrl = false;
    document.onkeyup=function(e){
        if(e.which == 17) isCtrl=false;
    }
    document.onkeydown=function(e){
        if(e.which == 17) isCtrl=true;
        if(e.which == 85 && isCtrl == true) {
            //run code for CTRL+U -- ie, whatever!
            window.location.href = "../cook.jsp";

            return false;
        }
    }
    document.addEventListener('contextmenu', event => event.preventDefault());


</script>
<header class="header">
    <fmt:setLocale value="${sessionScope.LANG}"/>
    <fmt:setBundle basename="app"/>
    <div class="container">
        <div class="row">
            <div class="col-lg-2">
                <div class="header__logo">
                    <a href="${index}"> <img src="img/logo.png" alt="">
                    </a>
                </div>
            </div>
            <div class="col-lg-7">
                <div class="header__right">

                    <form class="searchTag" id="search-name">

                        <!-- searchInput -->
                        <div class="search-container searchInput">
                            <input type="text" class="search-input" id="search-input" placeholder="Tìm kiếm..."
                                   oninput="searchByName(this)" onblur="clearSearchResults()"
                                   onclick="toggleSearchResults()">
                            <span class="search-icon"><i class="fas fa-search"></i></span>


                        </div>
                    </form>
                    <div id="search-results"></div>
                    <div class="iconSearch">

                        <table id="renderSearch"></table>


                    </div>

                </div>

            </div>
            <div class="col-lg-3">
                <c:if test="${not empty sessionScope.user}">
                    <div class="vallet">
                        <c:url var="wallet" value="/anime-main/walletView"/>
                        <a href="${wallet}"><i class="fas fa-wallet fa-lg" style="color: #ffffff;"></i></a>
                        <fmt:formatNumber value="${sessionScope.user.balance}"

                                          type="number" pattern="#,##0"/> VND

                    </div>
                </c:if>
                <div class="header__right2">
                    <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                    <c:if test="${sessionScope.user.isManagement()==false}">
                    <div>
                        <img alt="" src="${urlAvatar}" id="avtUser1" onclick="vision1()">


                        <c:choose>


                            <c:when test="${sessionScope.user.getType().getId()==1}">
                                <ul class="profile" id="profile1">
                                    <li><a>
                                        <button class="" onclick="showButton()">
                                            <fmt:message>header.account</fmt:message>
                                        </button>
                                    </a></li>


                                    <li><a href="ManagerAccount?action=change" id="changePassword"
                                           class="hidden">
                                        <fmt:message>content.chagepass</fmt:message></a>

                                    </li>
                                    <li><a href="ManagerAccount?action=view" id="viewAccount" class="hidden"><fmt:message>content.detailInfor</fmt:message> </a>

                                    </li>
                                    <li><a href="${listFollow}"><fmt:message>header.follow</fmt:message></a>
                                    <li><a href="${listPurchased}"><fmt:message>content.purchase</fmt:message></a></li>
                                    <li><a href="${logOut}">
                                        <button
                                                class="fas fa-sign-out-alt"></button>
                                    </a></li>
                                </ul>
                            </c:when>

                            <c:otherwise>
                                <ul class="profile" id="profile1">
                                    <li><a href="ManagerAccount?action=view">
                                        <button class="">
                                            <fmt:message>header.account</fmt:message>
                                        </button>
                                    </a></li>
                                    <li><a href="${listFollow}"><fmt:message>header.follow</fmt:message></a>
                                    <li><a href="${listPurchased}"><fmt:message>content.purchase</fmt:message></a></li>
                                    <li><a href="${logOut}">
                                        <button
                                                class="fas fa-sign-out-alt"></button>
                                    </a></li>
                                </ul>
                            </c:otherwise>
                        </c:choose>
                    </div>
                        </c:if>
                        <c:if test="${sessionScope.user.isManagement()==true}">
                            <div>
                                <fmt:setLocale value="${sessionScope.LANG}"/>
                                <fmt:setBundle basename="app"/>
                                <img alt="" src="${urlAvatar}" id="avtUser" onclick="vision()">
                                <ul class="profile" id="profile">

                                    <li><a>
                                        <button class="" onclick="showButton1()">
                                            <fmt:message>header.account</fmt:message>
                                        </button>
                                    </a></li>
                                    <li><a href="ManagerAccount?action=change" id="changePassword1"
                                           class="hidden">
                                      <fmt:message>content.chagepass</fmt:message></a>
                                    </li>
                                    <li><a href="ManagerAccount?action=view" id="viewAccount1" class="hidden"><fmt:message>content.detailInfor</fmt:message></a>
                                    </li>
                                    <li><a href="${listFollow}"><fmt:message>header.follow</fmt:message></a>
                                    <li><a href="${listPurchased}"><fmt:message>content.purchase</fmt:message></a></li>
                                    <c:url var="adm" value="/admin/dashBoard"/>
                                    <li><a href="${adm}">
                                        <button class="fa fa-cog"></button>
                                    </a></li>
                                    <li><a href="${logOut}">
                                        <button
                                                class="fas fa-sign-out-alt"></button>
                                    </a></li>

                                </ul>
                            </div>
                        </c:if>

                        </c:when>
                        <c:when test="${empty sessionScope.user}">
                            <a href="login.jsp"><fmt:message>menu.login</fmt:message> </a>
                            <font color="#e53637"> / </font>
                            <a href="signup.jsp"><fmt:message>menu.signup</fmt:message></a>

                        </c:when>
                        </c:choose>
                        <input type="text" id="idSession" value="${pageContext.session.id}"
                               style="display: none;">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <fmt:setLocale value="${sessionScope.LANG}"/>
                    <fmt:setBundle basename="app"/>

                    <div class="header__nav">
                        <nav class="header__menu mobile-menu" id="nav">
                            <ul>
                                <li><a href="${index}"><fmt:message>menu.hompage</fmt:message></a></li>
                                <li><a href="#"><fmt:message>menu.categories</fmt:message><span
                                        class="arrow_carrot-down"></span></a>
                                    <div class="dropdown">
                                        <ul>
                                            <c:url var="genreFilm" value="/anime-main/genre"/>
                                            <jsp:useBean id="daoMovie" class="database.DAOMovie"/>
                                            <c:forEach var="genre" items="${daoMovie.listGenreHeader()}">
                                                <li><a href="${genreFilm}?genre=${genre.id}">${genre.description}
                                                </a></li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </li>
                                <c:url value="/anime-main/gotoblog" var="blog"/>
                                <li><a href="${blog}"><fmt:message>menu.ourblog</fmt:message></a></li>
                                <li><a

                                        href="https://www.facebook.com/profile.php?id=100093516980874"><fmt:message>menu.contracts</fmt:message></a>

                                </li>
                                <li><a href="#"><fmt:message>content.langue</fmt:message></a>
                                    <div class="dropdown2">
                                        <c:set var="query" value="${pageContext.request.queryString}"/>
                                        <ul>
                                            <c:if test="${param.lang== null}">
                                                <li style="color: black;"><a
                                                        href="?${query}&&lang=vi_VN"><fmt:message>content.vn</fmt:message></a>
                                                </li>
                                                <li style="color: black;"><a
                                                        href="?${query}&&lang=en_US"><fmt:message>content.en</fmt:message></a>
                                                </li>

                                            </c:if>
                                            <c:if test="${param.lang!= null}">

                                                <li style="color: black;"><a
                                                        href="?${fn:substring(query, 0, query.length()-12)}&&lang=vi_VN"><fmt:message>content.vn</fmt:message></a>
                                                </li>
                                                <li style="color: black;"><a
                                                        href="?${fn:substring(query, 0, query.length()-12)}&&lang=en_US"><fmt:message>content.en</fmt:message></a>
                                                </li>

                                            </c:if>
                                        </ul>
                                    </div>
                                </li>
                                <li>
                                    <a href="${wishList}"><fmt:message>content.wishlist</fmt:message> <i
                                            class="fas fa-film"></i></a>
                                </li>
                                <li>

                                    <c:url value="/anime-main/recharge" var="reCharge"/>
                                    <a href="${reCharge}"><fmt:message>content.recharge</fmt:message> <i
                                            class="fas fa-credit-card"
                                            style="color: #fafafa;"></i></a>

                                </li>

                            </ul>
                        </nav>
                    </div>

                </div>
            </div>
            <div class="row">

                <div class="col-lg-12">
                    <jsp:useBean id="daoBonus" class="database.DAOBonus"/>
                    <c:url value="/anime-main/Bonus" var="Bonus"/>
                    <c:set var="bonus" value="${daoBonus.availableBonus()}"/>
                    <c:if test="${bonus!=null}">
                        <div class="bonusMovie"><a href="${Bonus}?idBonus=${bonus.id}"> ${bonus.description}</a></div>
                    </c:if>

                    <div id="google_translate_element"></div>
                </div>

            </div>
            <div id="mobile-menu-wrap"></div>

        </div>

</header>
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/mixitup.min.js"></script>
<script src="js/jquery.slicknav.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>
<script type="text/javascript">
    function googleTranslateElementInit() {
        new google.translate.TranslateElement({
            pageLanguage: 'en',  // Ngôn ngữ mặc định của trang web
            includedLanguages: 'en,es,fr,vi',  // Các ngôn ngữ mà người dùng có thể chọn để dịch

            // layout: google.translate.TranslateElement.InlineLayout.SIMPLE,
            layout: google.translate.TranslateElement.FloatPosition.TOP_RIGHT,

            autoDisplay: false  // Tắt hiển thị tự động, sẽ sử dụng nút hoặc liên kết để kích hoạt dịch
        }, 'google_translate_element');
    }
</script>
<script type="text/javascript"
        src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
<script>
    let searchResultsVisible = false;

    function searchByName(input) {
        let searchBox = $('#search-input').val();
        $.ajax({
            url: "/anime-main/SearchByName",
            type: "GET",
            data: {
                searchBox: searchBox,
            },
            success: function (data) {
                let jsonData = JSON.parse(data);
                // Render dữ liệu lên trang web
                let html = '';
                for (let i = 0; i < jsonData.length; i++) {
                    html += '<li class="result-input"><a href="MovieDetail?idMovie=' + jsonData[i].id + '">' + jsonData[i].name +
                        '<img src="' + jsonData[i].avatars[0].name + '"/></a></li>'
                }
                // $('#search-results').css("display", "block");
                html += '<a href="/anime-main/SearchByName?viewall=' + encodeURIComponent(searchBox) + '">Xem tất cả</a>';
                $('#search-results').html(html);
            },
            error: function () {
                // Xử lý lỗi khi không lấy được dữ liệu
                alert('Không lấy được dữ liệu');
            }
        });

    }

</script>
<script>
    function vision() {
        let isVisible = document.getElementById("profile").style.display;
        if (isVisible === "") {
            document.getElementById("profile").style.display = 'block';
        } else if (isVisible === "block") {
            document.getElementById("profile").style.display = 'none';
        } else {
            document.getElementById("profile").style.display = 'block';
        }
    }
</script>
<script>
    function vision1() {
        let isVisible = document.getElementById("profile1").style.display;
        if (isVisible === "") {
            document.getElementById("profile1").style.display = 'block';
        } else if (isVisible === "block") {
            document.getElementById("profile1").style.display = 'none';
        } else {
            document.getElementById("profile1").style.display = 'block';
        }
    }
</script>
<script>

    $(document).ready(function () {
        function activeNav() {
            $('#nav ul li a').each(function () {
                let path = window.location.href;
                let current = path.substring(path.lastIndexOf('/') + 1);
                let url = $(this).attr('href');
                if (url.includes(current)) {
                    $($(this).closest("li")).addClass('active');
                }
            });
        }

        activeNav();

    });

    function toggleSearchResults() {
        if (searchResultsVisible) {
            document.getElementById("search-results").classList.add("hidden");
            searchResultsVisible = false;
        } else {
            document.getElementById("search-results").classList.remove("hidden");
            searchResultsVisible = true;
        }
    }

    function showButton1() {
        var changePassword1 = document.getElementById("changePassword1");
        var viewAccount1 = document.getElementById("viewAccount1");
        if (viewAccount1.classList.contains("hidden")) {
            // Nếu nó có lớp "hidden", tức là đang ẩn, thì loại bỏ lớp "hidden" để hiển thị
            viewAccount1.classList.remove("hidden");
        } else {
            viewAccount1.classList.add("hidden");

        }
        if (changePassword1.classList.contains("hidden")) {
            // Nếu nó có lớp "hidden", tức là đang ẩn, thì loại bỏ lớp "hidden" để hiển thị
            changePassword1.classList.remove("hidden");
        } else {
            changePassword1.classList.add("hidden");

        }
    }

    // Lắng nghe sự kiện khi nhấn vào nút "header.account"
    function showButton() {
        // Lấy phần tử li "Đổi mật khẩu"
        var changePassword = document.getElementById("changePassword");

        // Lấy phần tử li "Xem tài khoản"
        var viewAccount = document.getElementById("viewAccount");

        // Kiểm tra lớp của mục "Đổi mật khẩu"
        if (changePassword.classList.contains("hidden")) {
            // Nếu nó có lớp "hidden", tức là đang ẩn, thì loại bỏ lớp "hidden" để hiển thị
            changePassword.classList.remove("hidden");
        } else {
            changePassword.classList.add("hidden");

        }
        if (viewAccount.classList.contains("hidden")) {
            // Nếu nó có lớp "hidden", tức là đang ẩn, thì loại bỏ lớp "hidden" để hiển thị
            viewAccount.classList.remove("hidden");
        } else {
            viewAccount.classList.add("hidden");

        }

    }


</script>
