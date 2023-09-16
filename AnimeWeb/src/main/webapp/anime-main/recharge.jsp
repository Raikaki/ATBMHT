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
    <%--    <link rel="stylesheet" href="css/nice-select.css" type="text/css">--%>
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="css/ds/style.css"/>
    <script src="https://kit.fontawesome.com/9847adceef.js"></script>
    <script src="https://www.paypal.com/sdk/js?client-id=AbenXsywXYlbMw4GpzHDSdiXPx7hKY7adwNFIjsSlY7HfsmSRD6DOzeswhhcBtKiqC46A2kiwzyk_Wf7&currency=USD"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.css"/>

    <fmt:setLocale value="${sessionScope.LANG}"/>
    <fmt:setBundle basename="app"/>
</head>
<body>
<c:url var="urlAvatar" value="${sessionScope.user.avatar}"/>
<fmt:setLocale value="${sessionScope.LANG}"/>
<c:url var="profileServlet" value="/anime-main/profile.jsp"/>
<c:url var="MovieDetail" value="/anime-main/MovieDetail"/>
<c:url var="Index" value="/anime-main/Index"/>
<c:url var="paypal" value="/anime-main/PayPalCheckOut"/>
<c:url var="recharge" value="/anime-main/checkRecharge"/>
<div id="preloder">
    <div class="loader"></div>
</div>
<div id="ah_wrapper">
    <c:import url="/anime-main/header.jsp"/>
    <section class="product spad">
        <div class="container" id="container">
            <div class="row">
                <div class="col-lg-5">
                    <h4 style="color: whitesmoke"><fmt:message>content.accountInformation</fmt:message></h4>
                    <div class="walletImg"><img alt="" src="${urlAvatar}" id="avatar_user"></div>
                    <h4 style="color: whitesmoke"> ${user.fullName}</h4>
                    <br>
                    <h4 style="color: whitesmoke"><fmt:message>content.balance</fmt:message></h4>
                    <div class="balance">
                        <div style="font-size: 200%!important;"> ${sessionScope.user.balance}đ</div>
                    </div>
                    <div>
                        <c:url var="walletView" value="/anime-main/walletView"/>
                        <a href="${walletView}">
                            <button><fmt:message>content.seedetail</fmt:message></button>
                        </a></div>
                </div>
                <div class="col-lg-2"></div>
                <div class="col-lg-5">
                    <div>
                        <fmt:message>content.deposit</fmt:message>
                    </div>
                    <div class="denominations">
                        <div><input type="radio" name="denominations" value="10000" checked><label>10000 VND</label></div>
                        <div><input type="radio" name="denominations" value="20000"><label>20000 VND</label></div>
                        <div><input type="radio" name="denominations" value="50000"><label>50000 VND</label></div>
                        <div><input type="radio" name="denominations" value="100000"><label>100000 VND</label></div>
                        <div><input type="radio" name="denominations" value="200000"><label>200000 VND</label></div>
                        <div><input type="radio" name="denominations" value="500000"><label>500000 VND</label></div>
                        <input type="hidden" name="values" value="0">
                    </div>
                    <div id="paypal-button-container"></div>
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
<script src="js/jquery.nice-select.min.js"></script>
<script src="js/mixitup.min.js"></script>
<script src="js/jquery.slicknav.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/main.js"></script>
<script src="js/paypal-api.js"></script>
<script src="js/sever.js"></script>
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
<%--<script>--%>

<%--    $(document).ready(function() {--%>
<%--        var selectedValue = $("input[name='denominations']:checked").val();--%>
<%--        var values = $("input[name='values']").val(selectedValue);--%>
<%--        convertCurrency();--%>

<%--        $("input[name='denominations']").change(function() {--%>
<%--            convertCurrency();--%>
<%--        });--%>
<%--    });--%>

<%--    function convertCurrency() {--%>

<%--        var selectedValue = $("input[name='denominations']:checked").val();--%>
<%--        var values = $("input[name='values']").val(selectedValue);--%>
<%--        const url = `https://api.apilayer.com/exchangerates_data/convert?to=USD&from=VND&amount=`+selectedValue;--%>
<%--        $.ajax({--%>
<%--            url: url,--%>
<%--            headers: {--%>
<%--                "apikey": "CaL5Dsgtc1FeF8gQFWJMxOrPtvc0euON"--%>
<%--            },--%>
<%--            dataType: "json",--%>
<%--            success: function (data) {--%>
<%--                const convertedAmount = data.result.toFixed(2);--%>
<%--                console.log(convertedAmount);--%>
<%--                $("input[name='denominations']:checked").val(convertedAmount);--%>

<%--            },--%>
<%--            error: function (error) {--%>
<%--                console.error(error);--%>
<%--            }--%>
<%--        });--%>
<%--    }--%>
<%--</script>--%>
<script>

    let currency = 0;

    async function convertCurrency() {

        var selectedValue = $("input[name='denominations']:checked").val();

        const url = `https://api.apilayer.com/exchangerates_data/convert?to=USD&from=VND&amount=` + selectedValue;
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

    async function createPaypalOrder() {
        try {
            const selectedValue = await convertCurrency();
            console.log(selectedValue);
            return fetch("${paypal}", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({
                    denominations: selectedValue,
                }),
            })
                .then((response) => response.json())
                .then((order) => order.id);
        } catch (error) {
            console.error(error);
        }
    }

    paypal.Buttons({
        async createOrder() {
            return createPaypalOrder();
        },
        onApprove(data) {
            var values = $("input[name='values']").val();
            var selectedValue = $("input[name='denominations']:checked").val();

            console.log(values);
            console.log(selectedValue);
            return fetch("${recharge}", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({
                    balance: selectedValue,
                    orderID: data.orderID
                })
            })
                .then((response) => response.json())
                .then((orderData) => {
                    console.log(orderData);
                    console.log(orderData.purchaseUnits[0].payments.captures[0]);
                    console.log('Capture result', orderData, JSON.stringify(orderData, null, 2));
                    const transaction = orderData.purchaseUnits[0].payments.captures[0];
                    Swal.fire({
                        title: 'Thanh toán thành công',
                        icon: 'success',
                        confirmButtonText: 'OK'
                    }).then((result) => {
                        location.reload();
                    });

                });
        }
    }).render('#paypal-button-container')
</script>


</body>
</html>
