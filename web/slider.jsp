<%-- 
    Document   : slider
    Created on : Jun 24, 2025, 6:12:05 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Font hỗ trợ tiếng Việt -->
        <link href="https://fonts.googleapis.com/css2?family=Roboto&family=Noto+Sans&display=swap" rel="stylesheet">

        <style>
            body, html {
                font-family: 'Roboto', 'Noto Sans', sans-serif;
            }
            .user-panel .image img {
                width: 70px;
                height: 70px;
                object-fit: cover;
                border-radius: 50%;
                border: 2px solid #fff;
                box-shadow: 0 0 4px rgba(0, 0, 0, 0.2);
            }

            .user-panel .info p {
                font-weight: bold;
                margin: 5px 0;
            }
        </style>

    </head>
    <body>
        <header class="header">
            <a href="manager-dashboard" class="logo">
                Manager Dashboard
            </a>
            <!-- Header Navbar: style can be found in header.less -->
            <nav class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
                <div class="navbar-right">
                    <ul class="nav navbar-nav">
                        <!-- Messages: style can be found in dropdown.less-->
                        
                        
                        <!-- User Account: style can be found in dropdown.less -->
                        <li class="dropdown user user-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-user"></i>
                                <span>${sessionScope.user.firstName} ${sessionScope.user.lastName}<i class="caret"></i></span>
                            </a>
                            <ul class="dropdown-menu dropdown-custom dropdown-menu-right">
                                <li class="divider"></li>

                                <li>
                                    <a href="#">
                                        <i class="fa fa-user fa-fw pull-right"></i>
                                        Profile
                                    </a>
                                </li>

                                <li class="divider"></li>

                                <li>
                                    <a href="Logout"><i class="fa fa-ban fa-fw pull-right"></i>Đăng xuất</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        <div class="wrapper row-offcanvas row-offcanvas-left">
            <!-- Left side column. contains the logo and sidebar -->
            <aside class="left-side sidebar-offcanvas">
                <!-- sidebar: style can be found in sidebar.less -->
                <section class="sidebar">
                    <!-- Sidebar user panel -->
                    <div class="user-panel">
                        <div class="pull-left image">
                            <img src="${pageContext.request.contextPath}/${sessionScope.user.imagePath}" class="img-circle" alt="User Image" />
                        </div>
                        <div class="pull-left info">
                            <p>Xin chào, ${sessionScope.user.lastName}</p>

                            <a href="#"><i class="fa fa-circle text-success"></i> Trực tuyến</a>
                        </div>
                    </div>
                    <!-- search form -->
                    <!-- /.search form -->
                    <!-- sidebar menu: : style can be found in sidebar.less -->
                    <ul class="sidebar-menu">
                        <li>
                            <a href="manager-dashboard">
                                <i class="fa fa-dashboard"></i> <span>Quản Lí Chung</span>
                            </a>
                        </li>

                        <li>
                            <a href="rooms">
                                <i class="fa fa-glass"></i> <span>Quản lí phòng</span>
                            </a>
                        </li>

                        <li>
                            <a href="Manager?action=view">
                                <i class="fa fa-globe"></i>Quản lí yêu cầu phòng<span></span>
                            </a>
                        </li>
                        
                        <li>
                            <a href="Manager?action=viewLeave">
                                <i class="fa fa-globe"></i><span>Quản lí yêu cầu huỷ phòng</span>
                            </a>
                        </li>

                    </ul>
                </section>
                <!-- /.sidebar -->
            </aside>
    </body>
</html>
