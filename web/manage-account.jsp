<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý tài khoản</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <link href="css/style.css" rel="stylesheet" type="text/css" />
        <link href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap.min.css" rel="stylesheet" />
    </head>
    <body class="skin-black">

        <!-- Phần đầu -->
        <jsp:include page="admin-slider.jsp" />

        <!-- Nội dung chính -->
        <aside class="right-side">
            <section class="content">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="panel">
                            <header class="panel-heading">
                                <div class="text-center"><strong>Quản lý tài khoản sinh viên</strong></div>
                                <div style="margin-top: 10px;">
                                    <a href="create-student" class="btn btn-primary btn-sm">Tạo tài khoản mới</a>
                                </div>
                            </header>

                            <div class="panel-body table-responsive">
                                <style>
                                    .avatar-img {
                                        width: 80px;
                                        height: 80px;
                                        object-fit: cover;
                                        border-radius: 50%;
                                        box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
                                        transition: transform 0.3s ease;
                                    }

                                    .avatar-img:hover {
                                        transform: scale(1.05);
                                    }
                                </style>

                                <table id="accountTable" class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Hình ảnh</th>
                                            <th>Mã sinh viên</th>
                                            <th>Tên đăng nhập</th>
                                            <th>Họ tên</th>
                                            <th>Email</th>
                                            <th>Trạng thái</th>
                                            <th>Ngày tạo</th>
                                            <th>Sửa</th>
                                            <th>Vô hiệu hóa</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="student" items="${studentList}">
                                            <tr>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty student.user.imagePath}">
                                                            <img src="${pageContext.request.contextPath}/${student.user.imagePath}"
                                                                 alt="Ảnh đại diện"
                                                                 title="${student.user.firstName} ${student.user.lastName}"
                                                                 class="avatar-img" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span>Không có ảnh</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${student.studentCode}</td>
                                                <td>${student.user.userName}</td>
                                                <td>${student.user.firstName} ${student.user.lastName}</td>
                                                <td>${student.user.email}</td>
                                                <td>
                                                    <span class="label
                                                          ${student.user.status == 'Active' ? 'label-success' :
                                                            student.user.status == 'Inactive' ? 'label-danger' :
                                                            'label-default'}">
                                                              ${student.user.status}
                                                          </span>
                                                    </td>
                                                    <td>
                                                        <c:out value="${student.user.createdAt}"/>

                                                    </td>
                                                    <td>
                                                        <a href="edit-student?userID=${student.user.userId}" class="btn btn-warning btn-xs">Sửa</a>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${student.user.status == 'Active'}">
                                                                <form action="update-status" method="post" style="display:inline;">
                                                                    <input type="hidden" name="userId" value="${student.user.userId}" />
                                                                    <input type="hidden" name="status" value="Inactive" />
                                                                    <button type="submit" class="btn btn-danger btn-xs"
                                                                            onclick="return confirm('Bạn có chắc muốn vô hiệu hóa tài khoản này không?')">
                                                                        Vô hiệu hóa
                                                                    </button>
                                                                </form>
                                                            </c:when>


                                                            <c:when test="${student.user.status == 'Inactive'}">
                                                                <form action="update-status" method="post" style="display:inline;">
                                                                    <input type="hidden" name="userId" value="${student.user.userId}" />
                                                                    <input type="hidden" name="status" value="Active" />
                                                                    <button type="submit" class="btn btn-success btn-xs"
                                                                            onclick="return confirm('Bạn có chắc muốn khôi phục tài khoản này không?')">
                                                                        Khôi phục
                                                                    </button>
                                                                </form>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                            </div>
                        </div>
                    </div>
                </section>

                <div class="footer-main text-center">
                    Bản quyền © Hệ thống Quản lý Ký túc xá - 2025
                </div>
            </aside>

            <!-- Script -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
            <script src="js/bootstrap.min.js" type="text/javascript"></script>
            <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
            <script src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap.min.js"></script>
            <script src="js/Director/app.js" type="text/javascript"></script>

            <script>
                                                                                $(document).ready(function () {
                                                                                    var table = $('#accountTable').DataTable({
                                                                                        "paging": true,
                                                                                        "searching": true,
                                                                                        "ordering": true,
                                                                                        "info": true,
                                                                                        "pageLength": 5,
                                                                                        "lengthMenu": [5, 10, 25, 50],
                                                                                        "language": {
                                                                                            "lengthMenu": "Hiển thị _MENU_ dòng mỗi trang",
                                                                                            "zeroRecords": "Không tìm thấy bản ghi nào",
                                                                                            "info": "Trang _PAGE_ / _PAGES_",
                                                                                            "infoEmpty": "Không có dữ liệu",
                                                                                            "infoFiltered": "(lọc từ tổng _MAX_ bản ghi)",
                                                                                            "search": "Tìm kiếm:",
                                                                                            "paginate": {
                                                                                                "first": "Đầu",
                                                                                                "last": "Cuối",
                                                                                                "next": "Sau",
                                                                                                "previous": "Trước"
                                                                                            }
                                                                                        }
                                                                                    });

                                                                                    // Custom search
                                                                                    $('input[name="table_search"]').on('keyup', function () {
                                                                                        table.search(this.value).draw();
                                                                                    });
                                                                                });
            </script>
        </body>
    </html>
