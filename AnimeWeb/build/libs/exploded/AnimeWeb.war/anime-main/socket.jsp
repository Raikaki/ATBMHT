<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 4/11/2023
  Time: 1:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false" %>
<c:url var="updateRole" value="/anime-main/UpdateRoleUser"/>
<c:url var="socket" value="/observer"/>
<c:url var="logOut" value="/anime-main/logOut" />
<script>
    const socket = new WebSocket("wss://animeweb.site/${socket}");
    socket.addEventListener("message", (event) => {
        let data = JSON.parse(event.data);
        let type=data.type;
        if(type=="update"){
            console.log(data.idUser)
            if(data.idUser=="${sessionScope.user.id}"){
                $.ajax({
                    url: "${updateRole}",
                    type: "post",
                    data: {
                    },
                    success: function (data) {

                    },
                    error: function (data) {
                    }
                });
            }
        }else if(type=="logOut"){
            if(data.idUser=="${sessionScope.user.id}"){
                window.location.href = "${logOut}";
            }
        }
        else{
            let array = JSON.parse(data.listId);
            console.log(array)
            for(let i=0;i<array.length;i++){
                if(array[i]=="${sessionScope.user.id}"){
                    $.ajax({
                        url: "${updateRole}",
                        type: "post",
                        data: {
                        },
                        success: function (data) {

                        },
                        error: function (data) {
                        }
                    });
                    return;
                }

            }
        }




    });
</script>