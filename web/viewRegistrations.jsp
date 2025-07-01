<%-- 
    Document   : viewRegistrations
    Created on : Jun 23, 2025, 10:52:17 PM
    Author     : Admin
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Xem danh sách đăng kí phòng</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta name="description" content="Developed By M Abdur Rokib Promy">
        <meta name="keywords" content="Admin, Bootstrap 3, Template, Theme, Responsive">
        <!-- Bootstrap 3.0.2 -->
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Font Awesome -->
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <!-- Ionicons -->
        <link href="css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <!-- Google Font -->
        <link href='http://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
        <!-- Theme style -->
        <link href="css/style.css" rel="stylesheet" type="text/css" />
        <!-- DataTables CSS -->
        <link href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- HTML5 Shim and Respond.js for IE8 support -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
    </head>
    <c:if test="${not empty mess}">
        <script>
            alert("${mess}");
        </script>
    </c:if>
    <body class="skin-black">
        <!-- Header logo: style can be found in header.less -->
        <jsp:include page="slider.jsp" />


        <!-- Right side column: contains the navbar and content of the page -->
        <aside class="right-side">
            <!-- Main content -->
            <section class="content">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="panel">
                            <header class="panel-heading">
                                <div class="text-center">Danh Sách Yêu Cầu Chờ Duyệt</div>
                            </header>
                            <form method="post" action="Manager">
                                <div class="panel-body table-responsive">
                                    <table id="registrationTable" class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Sinh Viên</th>
                                                <th>Phòng</th>
                                                <th>Giường</th>
                                                <th>Vị Trí</th>
                                                <th>Đơn Giá</th>
                                                <th>Tối Đa (người)</th>
                                                <th>Hiện Có (người)</th>
                                                <th>Ngày Đăng Ký</th>
                                                <th>Ngày Bắt Đầu</th>
                                                <th>Ngày Kết Thúc</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="reg" items="${list}">
                                                <tr>
                                                    <td>${reg.getReId()}</td>
                                                    <td>${reg.getStuName()}</td>
                                                    <td>${reg.getRoomName()}</td>
                                                    <td>${reg.getBedName()}</td>
                                                    <td>${reg.getPosition()}</td>
                                                    <td>${reg.getPrice()}</td>
                                                    <td>${reg.getTotal()}</td>
                                                    <td>${reg.getCurrent()}</td>
                                                    <td>${reg.getRegiDate()}</td>
                                                    <td>${reg.getStartDate()}</td>
                                                    <td>${reg.getEndDate()}</td>

                                                    <td>
                                                        <form method="post" action="Manager" style="display:inline;">
                                                            <input type="hidden" name="id" value="${reg.getReId()}" />
                                                            <input type="hidden" name="userId" value="${user.getUserId()}" />
                                                            <button type="submit" name="action" value="approve" class="btn btn-warning btn-xs">Chấp Nhận</button>
                                                        </form>
                                                        <form method="post" action="Manager" style="display:inline;">
                                                            <input type="hidden" name="id" value="${reg.getReId()}" />
                                                            <input type="hidden" name="userId" value="${user.getUserId()}" />
                                                            <button type="submit" name="action" value="reject" class="btn btn-danger btn-xs">Từ Chối</button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </form>
                        </div>
                        <!-- /.panel -->
                    </div>
                </div>
            </section>
            <!-- /.content -->

        </aside>
        <!-- /.right-side -->
    </div>
    <!-- ./wrapper -->

    <!-- jQuery 2.0.2 -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap.min.js"></script>
    <!-- Director App -->
    <script src="js/Director/app.js" type="text/javascript"></script>
    <script>
            $(document).ready(function () {
                $('#registrationTable').DataTable({
                    "paging": false,
                    "searching": false,
                    "ordering": true,
                    "info": false
                });
            });
    </script>
</body>
</html>
