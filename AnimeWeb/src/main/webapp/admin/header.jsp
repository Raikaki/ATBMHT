<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:url var="Dashboard" value="/admin/dashBoard"/>
<c:url var="UserList" value="/admin/UserList"/>
<c:url var="UserEdit" value="/admin/UserEdit"/>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/console-ban@5.0.0/dist/console-ban.min.js"></script>
<c:url var="urlAvatar" value="${sessionScope.user.avatar}"/>

<script src="https://cdn.jsdelivr.net/npm/console-ban@5.0.0/dist/console-ban.min.js"></script>
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
<div class="iq-top-navbar">
            <div class="iq-navbar-custom">
               <nav class="navbar navbar-expand-lg navbar-light p-0">
                  <div class="iq-menu-bt d-flex align-items-center">
                     <div class="wrapper-menu">
                        <div class="main-circle"><i class="ri-menu-line"></i></div>
                        <div class="hover-circle"><i class="ri-close-fill"></i></div>
                     </div>
                     <div class="iq-navbar-logo d-flex justify-content-between ml-3">
                        <a href="${Dashboard}" class="header-logo">
                        <img src="/anime-main/img/logonweb.png" class="img-fluid rounded" alt="">
                        <div>Admin AnimeWeb</div>
                        </a>
                     </div>
                  </div>
                
                  
                  <ul class="navbar-list">
                     <li class="line-height">
                        <a href="#" class="search-toggle iq-waves-effect d-flex align-items-center">
                           <div class="caption">
                              <img src="${urlAvatar}" class="img-fluid rounded" alt="" style="width: 80px!important;">
                              <p class="mb-0">Manager</p>
                           </div>
                        </a>
                     </li>
                  </ul>
               </nav>
            </div>
         </div>