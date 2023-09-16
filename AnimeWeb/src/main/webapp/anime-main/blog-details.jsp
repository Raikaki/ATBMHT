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
    <script src="https://kit.fontawesome.com/9847adceef.js"></script>
</head>
<style>
    .container {
        background: #070720 !important;
    }

    .hidden-content {
        display: none;
    }

    .expanded .hidden-content {
        display: block;
    }


</style>
<body>
<fmt:setLocale value="${sessionScope.LANG}"/>
<fmt:setBundle basename="app"/>

<c:url var="renderComment" value="/anime-main/RenderCommentBlog"/>
<c:url var="commentBlog" value="/anime-main/commentBlog"/>

<div id="ah_wrapper">
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Header Section Begin -->
    <c:import url="/anime-main/header.jsp"/>
    <!-- Header End -->

    <!-- Blog Details Section Begin -->
    <section class="blog-details spad">
        <div class="container">
            <div class="row d-flex justify-content-center">
                <div class="col-lg-8">
                    <div class="blog__details__title">
                        <h6>
                            <span> ${requestScope.currentBlog.getReleaseAt()}</span>
                        </h6>
                        <h2>${requestScope.currentBlog.getTitle()}</h2>
                        <div class="blog__details__social">
                            <a href="#" class="facebook"><i class="fa fa-facebook-square"></i>
                                Facebook</a> <a href="#" class="pinterest"><i
                                class="fa fa-pinterest"></i> Pinterest</a> <a href="#"
                                                                              class="linkedin"><i
                                class="fa fa-linkedin-square"></i>
                            Linkedin</a> <a href="#" class="twitter"><i
                                class="fa fa-twitter-square"></i> Twitter</a>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class=" col-8">
                        <div class="blog__details__pic">
                            <img
                                    src="/${requestScope.currentBlog.getAvatar()}"
                                    alt="image">
                        </div>
                    </div>
                    <div class=" col-4 content-col">
                        <div class="blog__details__content">
                            <div class="blog__details__text custom"
                                 id="content">${requestScope.contentBlog.toString()}</div>
                            <%--                        <c:if  test="${requestScope.contentBlog.toString().length>300}">--%>
                            <a onclick="toggleContent()" id="moreButton"
                               style="text-decoration: underline;font-style: italic;">Xem thêm</a>
                            <%--                        </c:if>--%>
                        </div>
                    </div>

                    <div class="blog__details__tags">
                        <a href="#">Healthfood</a> <a href="#">Sport</a> <a href="#">Game</a>
                    </div>
                    <div class="blog__details__btns">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="blog__details__btns__item">
                                    <h5>
                                        <a href="#"><span class="arrow_left"></span> Building a
                                            Better LiA...</a>
                                    </h5>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="blog__details__btns__item next__btn">
                                    <h5>
                                        <a href="#">Mugen no Juunin: Immortal – 21 <span
                                                class="arrow_right"></span></a>
                                    </h5>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-8 col-md-8">
                        <div class="anime__details__review">
                            <div class="section-title">
                                <h5>
                                    <fmt:message>content.reviews</fmt:message>
                                </h5>
                            </div>


                            <div id="commentBase">
                                <c:forEach var="comment" items="${requestScope.currentBlog.listComment}">
                                    <div class="anime__review__item">
                                        <div class="anime__review__item__pic">
                                            <c:url var="avt"
                                                   value="${comment.accountComment.avatar}"/>
                                            <img src="${avt}" alt="">
                                        </div>
                                        <div class="anime__review__item__text">
                                            <h6>
                                                    ${comment.accountComment.fullName} -
                                                <span>${comment.diffTime}</span>
                                            </h6>
                                            <p>${comment.content}</p>
                                        </div>
                                        <div class="replyBase">
                                            <button
                                                    value="${comment.id}"
                                                    class="setValue"
                                                    onclick="showForm(${comment.id},this,${comment.accountComment.id})">
                                                Reply
                                            </button>
                                            <div class="hiddenForm" style="display: none">

                                            </div>
                                        </div>

                                        <div id="commentBase1${comment.id}">


                                        </div>
                                        <c:if test="${comment.availableReply}">
                                            <button id="moreComment${comment.id}" onclick="showMore(this,`root1`)"
                                                    value="0">Xem thêm
                                            </button>

                                        </c:if>
                                    </div>
                                </c:forEach>
                            </div>
                            <c:if test="${requestScope.availableToRender>0}">
                                <button id="moreComment" onclick="showMore(this,`root0`)"
                                        value="${requestScope.rendered}">
                                    Xem thêm 5 bình luận tiếp theo, còn ${requestScope.availableToRender} khả dụng
                                </button>
                            </c:if>
                        </div>


                        <div class="anime__details__form">
                            <div class="section-title">
                                <h5>
                                    <fmt:message>conten.comment</fmt:message>
                                </h5>
                            </div>

                            <form action="${commentBlog}" method="post">
                                <input type="number" value="${requestScope.currentBlog.id}" hidden name="idBlog">
                                <textarea placeholder="Your Comment" name="message"></textarea>
                                <button type="submit" value="${requestScope.currentBlog.id}" name="saveID">
                                    <i class="fa fa-location-arrow"></i>
                                    <fmt:message>content.review</fmt:message>
                                </button>
                            </form>
                        </div>


                    </div>

                </div>
            </div>
        </div>
</section>
<!-- Blog Details Section End -->

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
<script>


    $(".setValue").click(function () {
        var closest = $(this).parent().closest('.commentContainer');
        closest.find(".formComment").css("display", "block");
        var valueForm = closest.find(".formComment").attr('action');
        closest.find(".formComment").attr("action", valueForm + "&&" + $(this).val())

    })


</script>
<script>function showMore(button, type) {
    let rendered = button.value;
    let parentId = button.id.substring("moreComment".length);
    console.log(rendered)
    $.ajax({
        url: "${renderComment}",
        type: "post",
        data: {
            rendered: rendered,
            idBlog:${requestScope.currentBlog.id},
            type: type,
            parentId: parentId,
        },
        success: function (data) {
            console.log(data)
            renderComment(data, button.id, type, parentId);

        },
        error: function (data) {
            console.log(data);
        }
    });
}

function renderComment(json, namebutton, type, parentId) {
    let data = JSON.parse(json);
    let commentList = JSON.parse(data.listComment);
    let rendered = JSON.parse(data.rendered);
    let enableRender = JSON.parse(data.enableRender);
    $("#" + namebutton).val(rendered);

    let reviewItemHTML = `
`;
    if (type == "root0") {
        let moreButton;
        let replyBase;
        for (let i = 0; i < commentList.length; i++) {
            moreButton = commentList[i].availableReply ? `<button id="moreComment` + commentList[i].id + `" onclick="showMore(this,\`root1\`)" value="0">Xem thêm</button>` : ``;
            replyBase = `	<div class="replyBase">
										<button
												value="` + commentList[i].id + `"
												class="setValue" onclick="showForm(` + commentList[i].id + `,this,` + commentList[i].accountComment.id + `)">Reply</button>
										<div class="hiddenForm" style="display: none">

										</div>
									</div>`;
            reviewItemHTML += `
<div class="anime__review__item">
        <div class="anime__review__item__pic">
            <img src="` + "${pageContext.request.contextPath}" + commentList[i].accountComment.avatar + `" alt="">
        </div>
        <div class="anime__review__item__text">
            <h6>` + commentList[i].accountComment.fullName + `
                - <span>` + commentList[i].diffTime + `</span>
            </h6>
            <p>` + commentList[i].content + `</p>
        </div>` + replyBase + `<div id="commentBase1` + commentList[i].id + `">
											</div>` + moreButton + `
  </div>`
        }
        $("#commentBase").append(reviewItemHTML);
    }
    if (type == "root1" || type == "root2") {
        let moreButton;
        let replyBase;
        let parent;
        for (let i = 0; i < commentList.length; i++) {
            if (type == "root2") {
                parent = commentList[i].parentId;
            } else {
                parent = commentList[i].id;
            }
            replyBase = `	<div class="replyBase">
										<button
												value="` + commentList[i].id + `"
												class="setValue" onclick="showForm(` + parent + `,this,` + commentList[i].accountComment.id + `)">Reply</button>
										<div class="hiddenForm" style="display: none">
										</div>
									</div>`;
            moreButton = commentList[i].availableReply ? `<button id="moreComment` + commentList[i].id + `" onclick="showMore(this,\`root2\`)" value="0">Xem thêm</button>` : ``;
            reviewItemHTML += `
		<div
			class="blog__details__comment__item blog__details__comment__item--reply">
													<div class="blog__details__comment__item__pic">
														<img
																src="` + "${pageContext.request.contextPath}" + commentList[i].accountComment.avatar + `"
																style="width: 50px; height: 50px; border-radius: 50%;"
																alt="">
													</div>
													<div class="blog__details__comment__item__text">
														<div class="anime__review__item__text">
															<h6>` + commentList[i].accountComment.fullName + `
																	reply to` + commentList[i].accountReply.fullName + `
																		 - <span>` + commentList[i].diffTime + `</span>
															</h6>
															<p>` + commentList[i].content + `</p></div>` + replyBase + `<div id="commentBase2` + commentList[i].id + `">


											</div>` + moreButton + `
														</div>
													</div>
		</div>

					`
        }

        if (type == "root1") {

            $("#commentBase1" + parentId).append(reviewItemHTML);
        } else {
            $("#commentBase2" + parentId).append(reviewItemHTML);
        }
    }
    if (enableRender == 0) {
        $("#" + namebutton).css("display", "none");
    } else {
        let valueCmt = enableRender >= 5 ? 5 : enableRender;
        $("#" + namebutton).html("Xem thêm" + valueCmt + " bình luận tiếp theo, còn " + enableRender + " bình luận khả dụng");
        $("#" + namebutton).val(rendered);
    }

}

function showForm(idComment, button, userReply) {


    const form = button.closest(".replyBase").querySelector(".hiddenForm");
    let innerForm;
    // Hiển thị hoặc ẩn form tùy thuộc vào trạng thái hiện tại của form
    if (form.style.display === "none") {
        form.style.display = "block";
        innerForm = `<form
										action="${commentBlog}?idParent=` + idComment + `&idUserReply=` + userReply + `&idBlog=${requestScope.currentBlog.id}"
										 method="post" class="formComment">
										<textarea placeholder="Your Comment" name="message"
											style="display: block;"></textarea>
										<button type="submit" value="" name="" class="site-btn">
											<i class="fa fa-location-arrow"></i> Submit
										</button>
									</form>`
        form.innerHTML = innerForm;
    } else {
        form.style.display = "none";
    }


}
</script>

<script>


    function toggleContent() {
        var contentElement = document.getElementById("content");
        var moreButton = document.getElementById("moreButton");

        if (contentElement.classList.contains("expanded")) {
            contentElement.classList.remove("expanded");
            contentElement.innerHTML = contentElement.dataset.truncatedContent;
            moreButton.textContent = "Xem thêm";
        } else {
            contentElement.classList.add("expanded");
            contentElement.innerHTML = contentElement.dataset.fullContent;
            moreButton.textContent = "Thu gọn";
        }
    }

    document.addEventListener("DOMContentLoaded", function () {
        var contentElement = document.getElementById("content");
        var moreButton = document.getElementById("moreButton");
        var content = contentElement.innerHTML.trim();

        if (content.length > 300) {
            var truncatedContent = content.substring(0, 300);
            var remainingContent = content.substring(300);
            contentElement.dataset.truncatedContent = truncatedContent;
            contentElement.dataset.fullContent = truncatedContent + '<span class="hidden-content">' + remainingContent + '</span>';
            contentElement.innerHTML = contentElement.dataset.truncatedContent;
            moreButton.style.display = "inline-block";
        } else {
            moreButton.style.display = "none";
        }
    });

</script>

</body>

</html>