<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <link rel="icon" href="${pageContext.request.contextPath}/anime-main/img/logonweb.png" type="image/png">


    <meta charset="UTF-8">
    <meta name="description" content="Anime Template">
    <meta name="keywords" content="Anime, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Anime|Check-Out</title>
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
    <fmt:setLocale value="${sessionScope.LANG}"/>
    <fmt:setBundle basename="app"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.4/dist/sweetalert2.min.css"/>
    <script src="https://www.paypal.com/sdk/js?client-id=AbenXsywXYlbMw4GpzHDSdiXPx7hKY7adwNFIjsSlY7HfsmSRD6DOzeswhhcBtKiqC46A2kiwzyk_Wf7&currency=USD"></script>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <style>
        .ui-dialog {
            top: 30% !important;
            left: 45% !important;

        }

    </style>
</head>
<body>
<fmt:setLocale value="${sessionScope.LANG}"/>
<c:url var="profileServlet" value="/anime-main/profile.jsp"/>
<c:url var="MovieDetail" value="/anime-main/MovieDetail"/>
<c:url var="Index" value="/anime-main/Index"/>
<c:url var="check" value="/anime-main/checkout"/>
<c:url var="paypal" value="/anime-main/PayPalCheckOut"/>
<c:url var="recharge" value="/anime-main/checkRecharge"/>
<div id="ah_wrapper">
    <header class="checkout__detail">

        <h2>Hóa đơn bán hàng</h2>
        <div>(Hóa đơn điện tử)</div>
        <div>Ngày ${day}, Tháng ${month}, Năm ${year}</div>
        <br>
        <div class="information">
            <div class="header__logo">
                <img src="img/logo.png" alt="">
            </div>
            <br>
            <div>Mã số thuế: 02343253</div>
            <div>Mã hóa đơn: ${number}</div>
            <div>Họ tên khách hàng: ${user.fullName}</div>
        </div>

    </header>
    <section class="product spad">
        <div class="container">

            <div class="row">
                <div class="col-lg-8">
                    <div class="trending__product">
                        <div class="row">
                            <div class="col-lg-8 col-md-8 col-sm-8">
                                <div class="section-title">

                                    <h4>
                                        Check Out | Detail
                                    </h4>

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
                                        <c:forEach var="movie" items="${sessionScope.order.getSelectedMovies()}">
                                            <tr>
                                                <td><img src=${movie.getFirstAvatar()} alt=${movie.getFirstAvatar()}
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
                        <div>Total : ${order.selectedMovies.size()}</div>
                        <div class="name_film_buy">
                            <c:forEach var="movie" items="${sessionScope.order.getSelectedMovies()}">
                                <div>
                                    <p>Name: ${movie.name} <br> Price: ${movie.getRenderPrice()} VND</p>

                                </div>
                            </c:forEach>
                        </div>
                        <div class="price_total">
                            <div>
                                Total Price: ${sessionScope.order.totalPrice} VND
                                <div><input type="hidden" name="denominations" value="${sessionScope.order.totalPrice}">
                                </div>
                                <input type="hidden" name="values" value="0">
                            </div>
                        </div>

                    </div>
                    <%--                    <a href="${check}?action=checkout">--%>
                    <%--                        <button id="buyMovie" >Xác nhận</button>--%>
                    <%--                    </a>--%>
                    <a href="${check}?action=back">
                        <button id="buyMovie2">Quay lại</button>
                    </a>
                    <button id="buyMovie" class="charge" style="display: none;" onclick="handlePayment()">Thanh toán
                        ngay
                    </button>
                    <div id="paypal-button-container" style="display: none;"></div>
                    <button id="verifyOrderButton" style="display: block;" onclick="verifyOrder()">Xác thực đơn hàng
                    </button>

                    <div class="dialog" style="  left: 45%!important; top: 40%!important">
                        <div id="dialog1" title="Xác thực đơn hàng"
                             style=" display: block; width: auto;height: auto;   ">
                            <form>
                                <label for="KeyFile">Choose File</label>
                                <input type="file" id="KeyFile" name="KeyFile">
                            </form>
                            <button onclick="sendFileDataToServer()">Xác thực</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">

                </div>
            </div>
        </div>
    </section>
    <c:if test="${empty sessionScope.done}">

        <c:choose>
            <c:when test="${success ==true}">
                <script>

                    Swal.fire({
                        title: 'Thanh toán thành công',
                        icon: 'success',
                        confirmButtonText: 'OK'
                    }).then((result) => {
                        window.location.href = "${pageContext.request.contextPath}/anime-main/wishList";
                    });
                </script>
            </c:when>
            <c:when test="${success ==false}">
                <script>
                    Swal.fire({
                        title: 'Thanh toán thất bại',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    }).then((result) => {
                        window.location.href = "${pageContext.request.contextPath}/anime-main/wishList";
                    });
                </script>
            </c:when>
        </c:choose>

    </c:if>


    <c:import url="/anime-main/footer.jsp"/>

</div>
<script src="js/jquery-3.3.1.min.js"></script>

<script src="https://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css"/>
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

    let currency = 0;

    async function convertCurrency() {

        var selectedValue = $("input[name='denominations']").val();

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

    function handlePayment() {
        // Ẩn nút "Thanh toán ngay"
        document.getElementById("buyMovie").style.display = "none";

        // Hiển thị nút "Xác thực đơn hàng"
        document.getElementById("buyMovie2").style.display = "none";

        // Hiển thị phần tử chứa nút PayPal
        document.getElementById("paypal-button-container").style.display = "block";
    }

    var uploadedFileContent;

    $(function () {
        $("#dialog1").dialog({
            autoOpen: false,
            position: {
                my: 'center',
                at: 'center',
                of: window
            }
        });

        $("#KeyFile").on("change", function () {
            var file = this.files[0];
            if (file) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    uploadedFileContent = e.target.result;
                };
                reader.readAsText(file);
                console.log(file);
                console.log(uploadedFileContent);
            }
        });
    });

    function verifyOrder() {
        $("#dialog1").dialog('open');
    }

    function sendFileDataToServer() {
        if (uploadedFileContent) {
            $.ajax({
                url: "/anime-main/signature",
                type: "post",
                data: {
                    fileContent: uploadedFileContent
                },
                success: function (data) {
                    let dataParse = JSON.parse(data);
                    let isSuccess = dataParse.isSuccess;
                    if(isSuccess){
                        Swal.fire({
                            position: 'center',
                            icon: 'success',
                            title: 'SIGN',
                            showConfirmButton: false,
                            timer: 1500
                        });
                        document.getElementById("verifyOrderButton").style.display = "none";
                        document.getElementById("buyMovie2").style.display = "none";
                        // Hiển thị nút "Thanh toán ngay"
                        document.getElementById("buyMovie").style.display = "block";

                        // Hiển thị phần tử chứa nút PayPal


                        $("#dialog1").dialog('close');
                    }else{
                        Swal.fire({
                            position: 'center',
                            icon: 'error',
                            title: dataParse.message,

                            showConfirmButton: true

                        });
                    }

                },
                error: function (data) {
                    // Handle error
                    console.log("Error:", data);
                }
            });
        } else {
            console.log("No file content to send.");
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
            console.log(data);

            return fetch("checkRecharge", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({
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
                        window.location.href = "${pageContext.request.contextPath}/anime-main/wishList";
                    });

                })
                .catch((error) => {
                    console.error('Error during payment:', error);
                    Swal.fire({
                        title: 'Thanh toán thất bại',
                        icon: 'error',
                        confirmButtonText: 'OK'
                    }).then((result) => {
                        window.location.href = "${pageContext.request.contextPath}/anime-main/wishList";
                    });
                });
        }
    }).render('#paypal-button-container');


</script>

<script>

</script>
</body>

</html>
