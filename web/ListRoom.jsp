<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý phòng KTX</title>
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="css/ionicons.min.css" rel="stylesheet" type="text/css" />
        <link href="css/style.css" rel="stylesheet" type="text/css" />
        <link href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css" />
    </head>
    <body class="skin-black">

        <!-- Phần đầu -->
        <jsp:include page="slider.jsp" />

        <!-- Nội dung chính -->
        <aside class="right-side">
            <section class="content">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="panel">
                            <header class="panel-heading">
                                <div class="text-center"><strong>Danh sách phòng</strong></div>
                                <div style="margin-top: 10px;">
                                    <a href="rooms?action=create" class="btn btn-primary btn-sm">Tạo phòng mới</a>
                                </div>
                            </header>

                            <div class="panel-body table-responsive">
                                <table id="roomTable" class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Hình ảnh</th>
                                            <th>Số phòng</th>
                                            <th>Sức chứa</th>
                                            <th>Đang sử dụng</th>
                                            <th>Trạng thái</th>
                                            <th>Ngày tạo</th>
                                            <th>Ngày cập nhật</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="room" items="${roomList}">
                                            <tr>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty room.roomImagePath}">
                                                            <img src="${pageContext.request.contextPath}/${room.roomImagePath}" alt="Room Image" width="100" height="80"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span>Không có ảnh</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${room.roomNumber}</td>
                                                <td>${room.capacity}</td>
                                                <td>${room.currentOccupancy != null ? room.currentOccupancy : "-"}</td>
                                                <td>
                                                    <span class="label
                                                          ${room.status == 'Available' ? 'label-success' :
                                                            room.status == 'Occupied' ? 'label-warning' :
                                                            'label-default'}">
                                                          <c:choose>
                                                              <c:when test="${room.status == 'Available'}">Còn trống</c:when>
                                                              <c:when test="${room.status == 'Occupied'}">Đã có người</c:when>
                                                              <c:otherwise>Bảo trì</c:otherwise>
                                                          </c:choose>
                                                    </span>
                                                </td>
                                                <td>${room.createdAt}</td>
                                                <td>${room.updatedAt}</td>
                                                <td>
                                                    <a href="rooms?action=edit&roomID=${room.roomID}" class="btn btn-warning btn-xs">Sửa</a>
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

            <!-- Chân trang -->
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
                var table = $('#roomTable').DataTable({
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
