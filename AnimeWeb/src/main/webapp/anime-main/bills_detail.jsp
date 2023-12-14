<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="Anime Template">
    <meta name="keywords" content="Anime, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Bill Detail</title>
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
    <link rel="stylesheet" type="text/css" href="css/ds/style.css"/>
    <script src="https://kit.fontawesome.com/9847adceef.js"></script>
</head>
<c:url var="movieDetail" value="/anime-main/MovieDetail"/>
<body>

<!-- Page Preloder -->
<div id="preloder">
    <div class="loader"></div>
</div>
<div id="ah_wrapper">
    <!-- Header Section Begin -->
    <c:import url="/anime-main/header.jsp"/>
    <!-- Header End -->

    <!-- Product Section Begin -->
    <section class="product spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="trending__product">
                        <div class="row">
                            <div class="col-lg-8 col-md-8 col-sm-8">
                                <div class="section-title">
                                    <h4>Chi tiết hóa đơn</h4>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="trending__product">
                                    <div class="row">
                                        <div class="col-lg-8 col-md-8 col-sm-8">
                                            <div class="section-title">
                                                <div> Tên khách hàng: ${requestScope.bill_detail.fullName}</div>
                                                <div> Mã số hóa đơn: ${requestScope.bill_detail.bill_num}</div>
                                                <div>Thời gian lập hóa
                                                    đơn: ${requestScope.bill_detail.formattedCreateAt} </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="table_film">
                                            <table>

                                                <tr>
                                                    <th>Avatar</th>
                                                    <th>Name</th>
                                                    <th>Movie genre</th>
                                                    <th>Producer</th>
                                                    <th>Price</th>
                                                </tr>
                                            </table>
                                            <div class="table__film_detail">
                                                <table>
                                                    <c:forEach var="movie"
                                                               items="${requestScope.bill_movies}">
                                                        <tr>
                                                            <td><img
                                                                    src=${movie.getFirstAvatar()} alt=${movie.getFirstAvatar()}
                                                                    width="100"
                                                                    height="150"></td>
                                                            <td>${movie.name}</td>
                                                            <td>

                                                                <c:forEach var="genre" items="${movie.genres}">
                                                                    <div>${genre.description}</div>
                                                                </c:forEach>
                                                            </td>
                                                            <td>
                                                                <c:forEach var="producer" items="${movie.listProducer}">
                                                                    <div>${producer.name}</div>
                                                                </c:forEach>
                                                            </td>
                                                            <td>${movie.getRenderPrice()} VND</td>
                                                        </tr>
                                                    </c:forEach>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="payment">
                                <div class="bill">
                                    <div>Total : ${requestScope.bill_movies.size()}</div>
                                    <div class="price_total">
                                        <div>
                                            Total Price: ${requestScope.bill_detail.totalPrice} VND
                                            <input type="hidden" name="refundValue" id="refundValue"
                                                   value="${requestScope.bill_detail.totalPrice}">
                                            <c:choose>
                                                <c:when test="${verify==true}">
                                                    <div style="color:  #02ff02">Đơn hàng đã được xác thực
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="hidden" name="captureId" id="captureId"
                                                           value="${requestScope.captureId}">
                                                    <div style="color: #ff7070">Đơn hàng không được xác thực</div>
                                                    <button id="refundButton" onclick="performRefund()">Perform Refund</button>

                                                    <div id="result"></div>
                                                </c:otherwise>
                                            </c:choose>
                                            <%--                                            <div><input type="hidden" name="denominations" value="${sessionScope.order.totalPrice}">--%>
                                        </div>
                                        <input type="hidden" name="values" value="0">
                                    </div>
                                </div>

                            </div>
                            <%--                    <a href="${check}?action=checkout">--%>
                            <%--                        <button id="buyMovie" >Xác nhận</button>--%>
                            <%--                    </a>--%>
                            <%--                    <a href="${check}?action=back">--%>
                            <%--                        <button id="buyMovie">Quay lại</button>--%>
                            <%--                    </a>--%>
                            <button id="buyMovie" class="charge" style="display: none;" onclick="handlePayment()">Thanh
                                toán
                                ngay
                            </button>
                            <div id="paypal-button-container" style="display: none;"></div>

                        </div>


                    </div>
                </div>
            </div>
        </div>

    </section>
    <!-- Product Section End -->

    <!-- Footer Section Begin -->
    <c:import url="/anime-main/footer.jsp"/>
</div>
<!-- Footer Section End -->

<!-- Search model Begin -->

<!-- Search model end -->

<!-- Js Plugins -->

<script>
    function showTimePurchased(event) {
        var timePurchased = event.target.closest('.product__item__text').querySelector('.time-purchased');
        if (timePurchased.style.display === 'none') {
            timePurchased.style.display = 'block';
        } else {
            timePurchased.style.display = 'none';
        }
    }
</script>
<script>
    async function convertCurrency() {

        var refundValue = $("#refundValue").val();

        const url = `https://api.apilayer.com/exchangerates_data/convert?to=USD&from=VND&amount=` + refundValue;
        try {
            const response = await fetch(url, {
                headers: {
                    "apikey": "CaL5Dsgtc1FeF8gQFWJMxOrPtvc0euON"
                }
            });
            const data = await response.json();
            const convertedAmount = data.result.toFixed(2);
            console.log(convertedAmount);
            console.log(data);
            currency = convertedAmount;
            return convertedAmount;
        } catch (error) {
            console.error(error);
            throw error;
        }
    }
    async function performRefund() {
        var captureId = $("#captureId").val();
        const refundValue = await convertCurrency();
        $.ajax({
            type: "POST",
            url: "/refund", // Tên servlet hoặc đường dẫn tương ứng
            data: {
                captureId: captureId,
                refundValue: refundValue

            },

            success: function (response) {
                $("#result").html(response);
                $("#refundButton").hide();
            },
            error: function (error) {
                $("#result").html("Error in refund process: " + error.responseText);
            }
        });
    }
</script>
</body>

</html>