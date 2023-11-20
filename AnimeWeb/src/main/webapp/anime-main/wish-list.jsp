<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>
<html>
<head>


    <meta charset="UTF-8">
    <meta name="description" content="Anime Template">
    <meta name="keywords" content="Anime, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Anime|Wish-list</title>
    <!-- Google Font -->
    <link
            href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">
    <link
            href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;400;500;600;700;800;900&display=swap"
            rel="stylesheet">
    <link rel="icon" href="${pageContext.request.contextPath}/anime-main/img/logonweb.png" type="image/png">

    <!-- Css Styles -->
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
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
<c:url var="checkoutWishList" value="/anime-main/AddWishList"/>
<div id="preloder">
    <div class="loader"></div>
</div>
<div id="ah_wrapper">

    <c:import url="/anime-main/header.jsp"/>
    <section class="product spad">
        <div class="container" id="container">

            <div class="row">
                <div class="col-lg-8">
                    <div class="trending__product">
                        <div class="row">
                            <div class="col-lg-8 col-md-8 col-sm-8">
                                <div class="section-title">

                                    <h4>
                                        <fmt:message>content.wishlist</fmt:message>
                                    </h4>

                                </div>
                            </div>

                        </div>

                        <div class="row" id="wishlist">

                            <c:if test="${sessionScope.wishlist ==null}">

                            </c:if>
                            <c:forEach var="movieList"
                                       items="${sessionScope.wishlist}">
                                <%--                                ${movieList.value.getWishList()}--%>
                                <c:set var="list" value="${movieList.value}"/>
                                <c:forEach var="movie" items="${list.getWishList()}">
                                    <div class="col-lg-4 col-md-6 col-sm-6" id="movie-${movie.id}">

                                        <div class="chooseFilm" id="chooseFilm">

                                            <div class="product__item">
                                                <c:url var="urlAvatarMovie"
                                                       value="${movie.getFirstAvatar()}"/>


                                                <div class="product__item__pic set-bg"
                                                     data-setbg="${urlAvatarMovie}">
                                                    <div class="choose">
                                                            <%--                                                        <form action="/anime-main/checkout" method="get" id="pay">--%>
                                                        <input type="checkbox" id="${movie.id}" name="selectedMovies"
                                                               onchange="updateSelectedMovies(this)"
                                                               value="${movie.id}" data-id="${movie.id}">

                                                    </div>
                                                    <div class="price_film">
                                                        <fmt:formatNumber value="${movie.renderPrice}"
                                                                          type="number" pattern="#,##0"/>đ
                                                    </div>
                                                </div>


                                                <div class="product__item__text">
                                                    <h5>
                                                        <a href="${MovieDetail}?idMovie=${movie.id}">${movie.name}</a>
                                                    </h5>
                                                    <button class="remove-from-wishlist" data-id="${movie.id}">
                                                        <fmt:message>button.remove</fmt:message>
                                                    </button>


                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:forEach>

                        </div>

                    </div>
                </div>
                <c:set var="order" value="${sessionScope.order}"/>
                <div class="col-lg-4">
                    <div class="payment">
                        <div class="bill">
                            <div>
                                <p><fmt:message>content.selectedMovie</fmt:message> <span
                                        id="selectedMovieNames"></span></p>

                                <p><fmt:message>content.totalOder</fmt:message> <span id="totalPrice"></span>đ</p>
                            </div>


                        </div>

                        <div style="margin-top: -30px;"><a href="${checkoutWishList}?action=checkout">
                            <button class="checkout-button" id="checkout-button">
                                <fmt:message>button.payOder</fmt:message></button>
                        </a></div>
                        <div style="margin-top: -30px;"><a href="${checkoutWishList}?action=checkoutAll">
                            <button class="checkout-button" id="checkoutAll-button">
                                <fmt:message>button.payAllOder</fmt:message></button>
                        </a></div>
                        <div style="margin-top: -30px;">
                            <button class="removeAll"><fmt:message>button.removeAll</fmt:message></button>
                        </div>
                    </div>
                </div>
                <%--                </form>--%>
                <c:if test="${fail}">
                    <script>
                        Swal.fire({
                            title: 'Hãy chọn phim trước khi thanh toán',
                            icon: 'error',
                            confirmButtonText: 'OK'
                        })
                        //     .then((result) => {
                        //     window.location.href = "/anime-main/wishList";
                        // });
                    </script>
                </c:if>

                <div class="col-md-6">


                </div>
            </div>
        </div>
    </section>
    <!-- Product Section End -->

    <!-- Footer Section Begin -->
    <c:import url="/anime-main/footer.jsp"/>


</div>

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

<script>
    $(document).ready(function () {
        // Thêm phim vào danh sách mong muốn


        $(".remove-from-wishlist").click(function (event) {
            event.preventDefault();
            var idMovie = $(this).data("id");
            var $movieElement = $("#movie-" + idMovie);
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/anime-main/removeWishlist",
                success: function (respone) {
                    console.log(respone);
                    const swalWithBootstrapButtons = Swal.mixin({
                        customClass: {
                            confirmButton: 'btn btn-success',
                            cancelButton: 'btn btn-danger'
                        },
                        buttonsStyling: false
                    })

                    swalWithBootstrapButtons.fire({
                        title: 'Are you sure?',
                        text: "You won't be able to revert this!",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonText: 'Yes, delete it!',
                        cancelButtonText: 'No, cancel!',
                        reverseButtons: true
                    }).then((result) => {
                        if (result.isConfirmed) {
                            $.ajax({
                                type: "GET",
                                url: "${pageContext.request.contextPath}/anime-main/removeWishlist",
                                data: {
                                    "action": "remove",
                                    "idm": idMovie
                                }, success: function (response) {
                                    $.ajax({
                                        type: "GET",
                                        url: "${pageContext.request.contextPath}/anime-main/RenderWishlist?t=" + new Date().getTime(),
                                        success: function (data) {
                                            console.log(data)
                                            $movieElement.remove();
                                            $movieElement.replaceWith(data);
                                            $('#totalPrice').text(response.totalPrice);
                                            $('#selectedMovieNames').text(response.selectedMovieNames);
                                            swalWithBootstrapButtons.fire(
                                                'Deleted!',
                                                'Your file has been deleted.',
                                                'success'
                                            )
                                        },
                                        error: function (xhr) {
                                            console.log(xhr.responseText);
                                        }
                                    });
                                }, error: function (xhr) {
                                    console.log(xhr.responseText);
                                }
                            });

                        } else if (result.dismiss === Swal.DismissReason.cancel) {
                            swalWithBootstrapButtons.fire(
                                'Cancelled',
                                'Your imaginary file is safe :)',
                                'error'
                            )
                        }
                    })
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                }
            });
        });
        $(".removeAll").click(function (event) {
            event.preventDefault();
            var idMovie = $(this).data("id");
            var $movieElement = $("#movie-" + idMovie);
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/anime-main/removeWishlist",
                success: function (respone) {
                    console.log(respone);
                    const swalWithBootstrapButtons = Swal.mixin({
                        customClass: {
                            confirmButton: 'btn btn-success',
                            cancelButton: 'btn btn-danger'
                        },
                        buttonsStyling: false
                    })

                    swalWithBootstrapButtons.fire({
                        title: 'Are you sure?',
                        text: "You won't be able to revert this!",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonText: 'Yes, delete it!',
                        cancelButtonText: 'No, cancel!',
                        reverseButtons: true
                    }).then((result) => {
                        if (result.isConfirmed) {
                            $.ajax({
                                type: "GET",
                                url: "${pageContext.request.contextPath}/anime-main/removeWishlist",
                                data: {
                                    "action": "removeAll",

                                }, success: function (response) {
                                    $.ajax({
                                        type: "GET",
                                        url: "${pageContext.request.contextPath}/anime-main/RenderWishlist?t=" + new Date().getTime(),
                                        success: function (data) {
                                            console.log(data)
                                            $("#wishlist").remove();
                                            swalWithBootstrapButtons.fire(
                                                'Deleted!',
                                                'Your file has been deleted.',
                                                'success'
                                            )
                                        },
                                        error: function (xhr) {
                                            console.log(xhr.responseText);
                                        }
                                    });
                                }, error: function (xhr) {
                                    console.log(xhr.responseText);
                                }
                            });

                        } else if (result.dismiss === Swal.DismissReason.cancel) {
                            swalWithBootstrapButtons.fire(
                                'Cancelled',
                                'Your imaginary file is safe :)',
                                'error'
                            )
                        }
                    })
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                }
            });
        });
    });

</script>

<script>

    function updateSelectedMovies(checkbox) {
        console.log(checkbox.value);


        $.ajax({
            url: "${pageContext.request.contextPath}/anime-main/updateSelectedMovies",
            method: "POST",
            data: {
                selectedMovies: checkbox.value,
            },
            success: function (response) {
                // Update total price and selected movie names
                $('#totalPrice').text(response.totalPrice);
                $('#selectedMovieNames').text(response.selectedMovieNames);
            },
            error: function (xhr, status, error) {
                console.log(error);
            }
        });
    }
</script>

</body>
</html>
