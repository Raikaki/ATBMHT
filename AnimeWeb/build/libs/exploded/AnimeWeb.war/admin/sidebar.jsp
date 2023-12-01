<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<c:url var="MovieAdd" value="/admin/MovieAdd"/>
<c:url var="MovieList" value="/admin/MovieList"/>
<c:url var="WishList" value="/admin/PurchasedHistory"/>
<c:url var="GenreList" value="/admin/GenreList"/>
<c:url var="SupplierList" value="/admin/SupplierList"/>



<c:url var="WishList" value="/admin/PurchasedHistory"/>
<c:url var="ProducerList" value="/admin/ProducerList"/>
<c:url var="bonusList"  value="/admin/BonusList"/>
<c:url var="rolePage"  value="/admin/RolePage"/>
<c:url var="Dashboard" value="/admin/dashBoard"/>
<c:url var="ProducerList" value="/admin/ProducerList"/>
<c:url var="bonusList" value="/admin/BonusList"/>
<c:url var="addRole" value="/admin/AddRole"/>
<c:url var="transactionHistory" value="/admin/TransactionHistory"/>
<c:url var="userAdd" value="/admin/UserAdd"/>
<c:url var="userList" value="/admin/UserList"/>
<c:url var="logList" value="/admin/LogList"/>
<c:url var="ViewListKey" value="/admin/ViewListKey"/>
<script src="js/jquery.min.js"></script>
<div class="iq-sidebar">
    <div class="iq-navbar-logo d-flex justify-content-between">
        <a href="${Dashboard}" class="header-logo"> <img src="/anime-main/img/logonweb.png" class="img-fluid rounded"
                                                         alt=""> <span>AnimeWeb</span>
        </a>
        <div class="iq-menu-bt align-self-center">
            <div class="wrapper-menu">
                <div class="main-circle">
                    <i class="ri-menu-line"></i>
                </div>
                <div class="hover-circle">
                    <i class="ri-close-fill"></i>
                </div>
            </div>
        </div>
    </div>
    <div id="sidebar-scrollbar">
        <nav class="iq-sidebar-menu">
            <ul id="iq-sidebar-toggle" class="iq-menu">
                <li class="parentActive"><a href="#dashboard" class="iq-waves-effect "
                                      data-toggle="collapse" aria-expanded="true"><span
                        class="ripple rippleEffect"></span><i
                        class="las la-home iq-arrow-left"></i><span>Bảng điều khiển</span><i
                        class="ri-arrow-right-s-line iq-arrow-right"></i></a>
                    <ul id="dashboard" class="iq-submenu collapse show"
                        data-parent="#iq-sidebar-toggle">
                        <li class="childActive"><a href="${Dashboard}"><i

                                class="las la-laptop-code"></i>Thống kê</a></li>

                    </ul>
                </li>


                <li class="parentActive" ><a href="#userinfo" class="iq-waves-effect"
                       data-toggle="collapse" aria-expanded="false"><span
                        class="ripple rippleEffect"></span><i
                        class="las la-user-tie iq-arrow-left"></i><span>Quản lý người dùng</span><i
                        class="ri-arrow-right-s-line iq-arrow-right"></i></a>
                    <ul id="userinfo" class="iq-submenu collapse"
                        data-parent="#iq-sidebar-toggle" style="">
                        <li class="childActive"><a href="${userAdd}"><i class="las la-plus-circle"></i>Thêm người dùng</a></li>
                        <li class="childActive"><a href="${userList}"><i class="las la-th-list"></i>Danh sách người dùng</a></li>
                    </ul>
                </li>
                <li class="parentActive">
                    <a href="https://analytics.google.com/analytics/web/#/p380852987/reports/reportinghub?params=_u..nav%3Dmaui%26_r.14..selmet%3D%5B%22conversions%22%5D"
                       target="_blank" class="iq-waves-effect"><span
                            class="ripple rippleEffect"></span><i
                            class="las la-user-tie iq-arrow-left"></i><span>Google Analytics</span></a>

                </li>


                <li class="parentActive"><a href="#movie" class="iq-waves-effect collapsed"
                       data-toggle="collapse" aria-expanded="false"><i
                        class="ri-pie-chart-box-line iq-arrow-left"></i><span>Quản lý phim</span><i
                        class="ri-arrow-right-s-line iq-arrow-right"></i></a>
                    <ul id="movie" class="iq-submenu collapse"
                        data-parent="#iq-sidebar-toggle">
                        <li class="childActive"><a href="${MovieList}"><i
                                class="ri-folder-chart-2-line"></i>Danh sách phim</a></li>
                        <li class="childActive"><a href="${MovieAdd}"><i
                                class="ri-folder-chart-2-line"></i>Nhập phim mới</a></li>
                        <li class="childActive"><a href="${GenreList}"><i
                                class="ri-folder-chart-2-line"></i>Danh sách thể loại</a></li>
                    </ul>
                </li>

                <li class="parentActive"><a href="#supplier" class="iq-waves-effect collapsed"
                       data-toggle="collapse" aria-expanded="false"><i
                        class="ri-pages-line iq-arrow-left"></i><span>Quản lý nhà cung cấp</span><i
                        class="ri-arrow-right-s-line iq-arrow-right"></i></a>
                    <ul id="supplier" class="iq-submenu collapse"
                        data-parent="#iq-sidebar-toggle">
                        <li class="childActive"><a href="${SupplierList}"><i
                                class="ri-folder-chart-2-line"></i>Danh sách nhà cung cấp</a></li>

                    </ul>
                </li>


                <li class="parentActive"><a href="#producer" class="iq-waves-effect collapsed"
                    data-toggle="collapse" aria-expanded="false"><i
                     class="ri-pages-line iq-arrow-left"></i><span>Quản lý nhà sản xuất</span><i
                     class="ri-arrow-right-s-line iq-arrow-right"></i></a>
                 <ul id="producer" class="iq-submenu collapse"
                     data-parent="#iq-sidebar-toggle">
                     <li class="childActive"><a href="${ProducerList}"><i
                             class="ri-folder-chart-2-line"></i>Danh sách nhà sản xuất</a></li>

                 </ul>
             </li>



                <li class="parentActive">
                    <a href="#tables" class="iq-waves-effect collapsed" data-toggle="collapse" aria-expanded="false"><i
                            class="ri-table-line iq-arrow-left"></i><span>Lịch sử</span><i
                            class="ri-arrow-right-s-line iq-arrow-right"></i></a>
                    <ul id="tables" class="iq-submenu collapse" data-parent="#iq-sidebar-toggle">
                        <li class="childActive"><a href="${WishList}"><i class="ri-table-line"></i>Lịch sử mua phim</a></li>
                        <li class="childActive"><a href="${transactionHistory}"><i class="ri-database-line"></i>Lịch sử giao dịch</a>
                        </li>
                        <li class="childActive">
                            <c:url value="/admin/ImportCoupons" var="importCoupons"/>
                            <a href="${importCoupons}"><i class="ri-folder-chart-2-line"></i>
                                Lịch sử nhập phim</a>
                        </li>

                    </ul>
                </li>
                <li class="parentActive">
                    <a href="#bonus" class="iq-waves-effect collapsed" data-toggle="collapse" aria-expanded="false"><i
                            class="ri-table-line iq-arrow-left"></i><span>Quản lý khuyến mãi</span><i
                            class="ri-arrow-right-s-line iq-arrow-right"></i></a>
                    <ul id="bonus" class="iq-submenu collapse" data-parent="#iq-sidebar-toggle">
                        <li class="childActive"><a href="${bonusList}"><i class="ri-table-line"></i>Danh sách khuyến mãi</a></li>

                    </ul>
                </li>
                <li class="parentActive">
                    <a href="#role" class="iq-waves-effect collapsed" data-toggle="collapse" aria-expanded="false"><i
                            class="ri-table-line iq-arrow-left"></i><span>Quản lý vai trò</span><i
                            class="ri-arrow-right-s-line iq-arrow-right"></i></a>
                    <ul id="role" class="iq-submenu collapse" data-parent="#iq-sidebar-toggle">
                        <li class="childActive"><a href="${rolePage}"><i class="ri-table-line"></i>Quản lý tổng</a></li>
                        <li class="childActive"><a href="${addRole}"><i class="ri-table-line"></i>Tạo vai trò mới</a></li>

                    </ul>
                </li >
                <li class="parentActive">
                    <a href="#log" class="iq-waves-effect collapsed" data-toggle="collapse" aria-expanded="false"><i
                            class="ri-table-line iq-arrow-left"></i><span>Quản lý Log</span><i
                            class="ri-arrow-right-s-line iq-arrow-right"></i></a>
                    <ul id="log" class="iq-submenu collapse" data-parent="#iq-sidebar-toggle">
                        <li class="childActive"><a href="${logList}"><i class="ri-table-line"></i>Quản lý tổng</a></li>

                    </ul>
                </li>
                <li class="parentActive">
                    <a href="#keys" class="iq-waves-effect collapsed" data-toggle="collapse" aria-expanded="false"><i
                            class="ri-table-line iq-arrow-left"></i><span>Quản lý chữ ký</span><i
                            class="ri-arrow-right-s-line iq-arrow-right"></i></a>
                    <ul id="keys" class="iq-submenu collapse" data-parent="#iq-sidebar-toggle">
                        <li class="childActive"><a href="${ViewListKey}"><i class="ri-table-line"></i>Danh sách khóa</a></li>

                    </ul>
                </li>

            </ul>
        </nav>
        <div class="p-3"></div>
    </div>
</div>
<c:import url="/anime-main/socket.jsp"/>
<script>
    function activeNav(){
        $('.childActive').each(function () {
            let path = window.location.href;
            let current = path.substring(path.lastIndexOf('/') + 1);
            let url = $($(this).find('a')).attr('href');
            if (url.includes(current)) {
               $(this).addClass('active');
                $($(this).closest(".parentActive")).addClass('active');
            }
        });
    }
    activeNav();
</script>