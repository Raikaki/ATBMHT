<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app"/>

<c:url var="MovieDetail" value="/anime-main/MovieDetail"/>
<c:url var="urlAvatar"
       value="${sessionScope.user.avatar}"/>
<div class="col-lg-4 col-md-6 col-sm-8">
    <div class="product__sidebar">
        <div class="product__sidebar__view">
            <div class="section-title">
                <h5><fmt:message>content.topview</fmt:message></h5>
            </div>
            <ul class="filter__controls">
                <li class="active" data-filter=".day" onclick="loadTopViewMoviesDay()"><fmt:message>day</fmt:message></li>
                <li data-filter=".month" onclick="loadTopViewMovies()"><fmt:message>month</fmt:message></li>
                <li data-filter=".years" onclick="loadTopViewMoviesYear()"><fmt:message>year</fmt:message></li>
            </ul>
            <br>
            <div class="filter__gallery" id="top-view-movies-container">



            </div>
        </div>

    </div>
</div>
<script src="js/jquery-3.3.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/player.js"></script>

<script src="js/mixitup.min.js"></script>
<script src="js/jquery.slicknav.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script>
    window.addEventListener("load", function () {
        // Ch?n ph?n t? HTML t??ng ?ng v?i l?a ch?n "Day"
        const defaultFilter = document.querySelector('.filter__controls li[data-filter=".day"]');

        // Kích ho?t s? ki?n click cho ph?n t? v?a ch?n
        defaultFilter.click();
    });
</script>
<script>
    function loadTopViewMovies() {
        console.log("ok")
        $.ajax({
            url: "topView",
            method: "GET",
            data: {
                "action": "topMonth",

            },
            success: function (data) {
                var container = $("#top-view-movies-container");
                container.empty();
                var movies = JSON.parse(data); // chuy?n chu?i JSON thành m?ng JavaScript
                console.log(movies); // hi?n th? m?ng phim trong console
                for (var i = 0; i < movies.length; i++) {
                    var movie = movies[i];
                    var item = $("<div>", {
                        "class": "product__sidebar__view__item set-bg mix day",
                        "data-setbg": `"`+movie.avatars[0].name+`"`,
                        "style": `background-position: center; background-size: cover;background-image: url(\"`+movie.avatars[0].name+`\");`,
                    })
                        .append($("<div>", { "class": "ep" }).text(movie.currentEpisode + "/" + movie.totalEpisode))
                        .append($("<div>", { "class": "rate" })
                            .text(movie.avgRate)
                            .append($("<i>", { "class": "fa fa-star", "style": "color:#f3da35;" })))
                        .append($("<div>", { "class": "view", "style": "bottom: 10px; right: 10px; top: unset;" })
                            .append($("<i>", { "class": "fa fa-eye" }))
                            .append($("<span>").text(movie.views)))
                        .append($("<h5>").append($("<a>", { "href": "${MovieDetail}?idMovie=" + movie.id }).text(movie.name)));
                    container.append(item);
                }
            }

        });
    }
</script>
<script>
    function loadTopViewMoviesYear() {
        console.log("ok")
        $.ajax({
            url: "topView",
            method: "GET",
            data: {
                "action": "topYear",

            },
            success: function (data) {
                var container = $("#top-view-movies-container");
                container.empty();
                var movies = JSON.parse(data); // chuy?n chu?i JSON thành m?ng JavaScript
                console.log(movies); // hi?n th? m?ng phim trong console
                for (var i = 0; i < movies.length; i++) {
                    var movie = movies[i];
                    var item = $("<div>", {
                        "class": "product__sidebar__view__item set-bg mix day",
                        "data-setbg": `"`+movie.avatars[0].name+`"`,
                        "style": `background-position: center; background-size: cover;background-image: url(\"`+movie.avatars[0].name+`\");`,
                    })
                        .append($("<div>", { "class": "ep" }).text(movie.currentEpisode + "/" + movie.totalEpisode))
                        .append($("<div>", { "class": "rate" })
                            .text(movie.avgRate)
                            .append($("<i>", { "class": "fa fa-star", "style": "color:#f3da35;" })))
                        .append($("<div>", { "class": "view", "style": "bottom: 10px; right: 10px; top: unset;" })
                            .append($("<i>", { "class": "fa fa-eye" }))
                            .append($("<span>").text(movie.views)))
                        .append($("<h5>").append($("<a>", { "href": "${MovieDetail}?idMovie=" + movie.id }).text(movie.name)));
                    container.append(item);
                }
            }

        });
    }
</script>
<script>
    function loadTopViewMoviesDay() {
        console.log("ok")
        $.ajax({
            url: "topView",
            method: "GET",
            data: {
                "action": "topDay",

            },
            success: function (data) {
                var container = $("#top-view-movies-container");
                container.empty();
                var movies = JSON.parse(data); // chuy?n chu?i JSON thành m?ng JavaScript
                console.log(movies); // hi?n th? m?ng phim trong console
                for (var i = 0; i < movies.length; i++) {
                    var movie = movies[i];
                    var item = $("<div>", {
                        "class": "product__sidebar__view__item set-bg mix day",
                        "data-setbg": `"`+movie.avatars[0].name+`"`,
                        "style": `background-position: center; background-size: cover;background-image: url(\"`+movie.avatars[0].name+`\");`,
                    })
                        .append($("<div>", { "class": "ep" }).text(movie.currentEpisode + "/" + movie.totalEpisode))
                        .append($("<div>", { "class": "rate" })
                            .text(movie.avgRate)
                            .append($("<i>", { "class": "fa fa-star", "style": "color:#f3da35;" })))
                        .append($("<div>", { "class": "view", "style": "bottom: 10px; right: 10px; top: unset;" })
                            .append($("<i>", { "class": "fa fa-eye" }))
                            .append($("<span>").text(movie.views)))
                        .append($("<h5>").append($("<a>", { "href": "${MovieDetail}?idMovie=" + movie.id }).text(movie.name)));
                    container.append(item);
                }
            }

        });
    }
</script>

