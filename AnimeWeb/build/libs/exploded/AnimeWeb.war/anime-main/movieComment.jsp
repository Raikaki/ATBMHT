<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false" %>
<c:url var="renderComment" value="/anime-main/RenderCommentMovie"/>
<c:url var="commentMovie" value="/anime-main/CommentMovie"/>
<fmt:setLocale value="${sessionScope.LANG}" />
<fmt:setBundle basename="app" />
<link rel="stylesheet" type="text/css" href="css/comment.css"/>
<div class="col-lg-8 col-md-8">
  <div class="anime__details__review">
    <div class="section-title">
      <h5>
        <fmt:message>content.reviews</fmt:message>
      </h5>
    </div>


    <div id="commentBase">
      <c:forEach var="comment" items="${requestScope.movie.listComment}">
        <div class="anime__review__item root0" >
          <div class="anime__review__item__pic">
            <c:url var="avt"
                   value="${comment.accountComment.avatar}"/>
            <img src="${avt}" alt="">
          </div>
          <div class="anime__review__item__text commentDisplay">
            <h6>
                ${comment.accountComment.fullName}  <span>- ${comment.diffTime} </span>
            </h6>
            <c:if test="${comment.userComment == sessionScope.user.id}">
              <button onclick="removeComment(${comment.id})" class="btn btn-outline-danger rmButton"><i class="fa fa-trash" aria-hidden="true"></i></button>
            </c:if>
            <p>${comment.content}</p>
          </div>
          <div class="replyBase">
            <button
                    value="${comment.id}"
                    class="setValue btn btn-outline-info"
                    onclick="showForm(${comment.id},this,${comment.accountComment.id})">
              Reply
            </button>
            <div class="hiddenForm" style="display: none">

            </div>
          </div>

          <div id="commentBase1${comment.id}">


          </div>
          <c:if test="${comment.availableReply}">
            <button id="moreComment${comment.id}" class="btn btn-outline-success moreCmt" onclick="showMore(this,`root1`)"
                    value="0">Xem thêm
            </button>

          </c:if>
        </div>
      </c:forEach>
    </div>
    <c:if test="${requestScope.availableToRender>0}">
      <button id="moreComment" class="btn btn-outline-success" onclick="showMore(this,`root0`)" value="${requestScope.rendered}">
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

    <form action="${commentMovie}" method="post" class="needs-validation">
      <input type="number" value="${requestScope.movie.id}" hidden name="idMovie">
      <textarea placeholder="Your Comment" name="message" wrap="hard" maxlength="1000" required></textarea>
      <button type="submit" value="${requestScope.movie.id}" name="saveID">
        <i class="fa fa-location-arrow"></i>
        <fmt:message>content.review</fmt:message>
      </button>
    </form>
  </div>


</div>
<script>
  function removeComment(idComment){

    $.ajax({
      url: "removeComment",
      type: "post",
      data: {
      idComment : idComment,
      },
      success: function (data) {
        let isSuccess = (JSON.parse(data)).isSuccess;
        if(isSuccess){
          location.reload();
        }

      },
      error: function (data) {
        console.log(data);
      }
    });
  }
  function showForm(idComment, button, userReply) {


    const form = button.closest(".replyBase").querySelector(".hiddenForm");
    let innerForm;
    // Hiển thị hoặc ẩn form tùy thuộc vào trạng thái hiện tại của form
    if (form.style.display === "none") {
      form.style.display = "block";
      innerForm = `<form
										action="${commentMovie}?idParent=` + idComment + `&idUserReply=` + userReply + `&idMovie=${requestScope.movie.id}"
										 method="post" class="formComment needs-validation">
										<textarea placeholder="Your Comment" name="message"
											style="display: block;" wrap="hard" maxlength="1000" required></textarea>
										<button type="submit" value="" name="" class="btn btn-outline-success">
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

  function showMore(button, type) {
    let rendered = button.value;
    let parentId = button.id.substring("moreComment".length);

    $.ajax({
      url: "${renderComment}",
      type: "post",
      data: {
        rendered: rendered,
        idMovie:${requestScope.movie.id},
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
    if (type === "root0") {
      let moreButton;
      let replyBase;
      for (let i = 0; i < commentList.length; i++) {
        moreButton = commentList[i].availableReply ? `<button id="moreComment` + commentList[i].id + `" onclick="showMore(this,\`root1\`)" class="btn btn-outline-success moreCmt" value="0">Xem thêm</button>` : ``;
        replyBase = `	<div class="replyBase">
										<button
												value="` + commentList[i].id + `"
												class="setValue btn btn-outline-info" onclick="showForm(` + commentList[i].id + `,this,` + commentList[i].accountComment.id + `)">Reply</button>
										<div class="hiddenForm" style="display: none">

										</div>
									</div>`;
        let deleteButton ="";
        if(commentList[i].userComment=="${sessionScope.user.id}"){
          deleteButton=  `<button onclick="removeComment(`+commentList[i].id+`)" class="btn btn-outline-danger rmButton"><i class="fa fa-trash" aria-hidden="true"></i></button>`;
        }
        reviewItemHTML += `
<div class="anime__review__item root0">
        <div class="anime__review__item__pic">
            <img src="` + "${pageContext.request.contextPath}" + commentList[i].accountComment.avatar + `" alt="">
        </div>
        <div class="anime__review__item__text commentDisplay">
            <h6>` + commentList[i].accountComment.fullName + `
                 <span> -` + commentList[i].diffTime + `</span>
            </h6>

             `+deleteButton+`

            <p>` + commentList[i].content + `</p>
        </div>` + replyBase + `<div id="commentBase1` + commentList[i].id + `">
											</div>` + moreButton + `
  </div>`
      }
      $("#commentBase").append(reviewItemHTML);
    }
    if (type === "root1" || type === "root2") {
      let moreButton;
      let replyBase;
      let parent;
      let classRender;
      for (let i = 0; i < commentList.length; i++) {
        if (type === "root2") {
          parent = commentList[i].parentId;
          classRender="notPadding";
        } else {
          parent = commentList[i].id;
          classRender="";
        }
        let deleteButton ="";
        if(commentList[i].userComment=="${sessionScope.user.id}"){
          deleteButton=  `<button onclick="removeComment(`+commentList[i].id+`)" class="btn btn-outline-success rmButton"><i class="fa fa-trash" aria-hidden="true"></i></button>`;
        }
        replyBase = `	<div class="replyBase">
										<button
												value="` + commentList[i].id + `"
												class="setValue btn btn-outline-info" onclick="showForm(` + parent + `,this,` + commentList[i].accountComment.id + `)">Reply</button>
										<div class="hiddenForm" style="display: none">
										</div>
									</div>`;
        moreButton = commentList[i].availableReply ? `<button class="btn btn-outline-success moreCmt" id="moreComment` + commentList[i].id + `" onclick="showMore(this,\`root2\`)" value="0">Xem thêm</button>` : ``;
        reviewItemHTML += `
		<div
			class="blog__details__comment__item blog__details__comment__item--reply `+classRender+`">
													<div class="anime__review__item__pic">
														<img
																src="` + "${pageContext.request.contextPath}" + commentList[i].accountComment.avatar + `"
																style="width: 50px; height: 50px; border-radius: 50%;"
																alt="">
													</div>
													<div class="blog__details__comment__item__text">
														<div class="anime__review__item__text commentDisplay">
															<h6>` + commentList[i].accountComment.fullName + `
																	reply to ` + commentList[i].accountReply.fullName + `
																		  <span>- ` + commentList[i].diffTime + `</span>
															</h6>
														`+deleteButton+`
															<p>` + commentList[i].content + `</p></div>` + replyBase + `<div id="commentBase2` + commentList[i].id + `">


											</div>` + moreButton + `
														</div>
													</div>
		</div>

					`
      }

      if (type === "root1") {

        $("#commentBase1" + parentId).append(reviewItemHTML);
      } else {
        $("#commentBase2" + parentId).append(reviewItemHTML);
      }
    }
    if (enableRender === 0) {
      $("#" + namebutton).css("display", "none");
    } else {
      let valueCmt = enableRender >= 5 ? 5 : enableRender;
      $("#" + namebutton).html("Xem thêm" + valueCmt + " bình luận tiếp theo, còn " + enableRender + " bình luận khả dụng");
      $("#" + namebutton).val(rendered);
    }

  }

</script>