<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý phòng</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <meta name="description" content="Trang quản lý phòng">
    <meta name="keywords" content="Admin, Bootstrap, Template, Theme, Responsive">
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css" />
    <style>
        #preview {
            margin-top: 10px;
            width: 120px;
            height: auto;
            border: 1px solid #ccc;
        }
        #existingImage {
            width: 120px;
            height: auto;
            margin-top: 10px;
            transition: opacity 0.3s ease;
        }
    </style>
</head>
<body class="skin-black">
    <jsp:include page="slider.jsp" />

    <aside class="right-side">
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <h2>${room != null ? 'Chỉnh sửa phòng' : 'Tạo phòng mới'}</h2>
                    <form action="rooms" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="${room != null ? 'edit' : 'create'}" />

                        <c:if test="${room != null}">
                            <input type="hidden" name="roomID" value="${room.roomID}" />
                        </c:if>

                        <div class="form-group">
                            <label for="roomNumber">Số phòng</label>
                            <input type="text" class="form-control" name="roomNumber" id="roomNumber"
                                   value="${room != null ? room.roomNumber : ''}" required />
                        </div>

                        <div class="form-group">
                            <label for="capacity">Sức chứa</label>
                            <input type="number" class="form-control" name="capacity" id="capacity"
                                   value="${room != null ? room.capacity : ''}" required />
                        </div>

                        <div class="form-group">
                            <label for="currentOccupancy">Đang sử dụng</label>
                            <input type="number" class="form-control" name="currentOccupancy" id="currentOccupancy"
                                   value="${room != null ? room.currentOccupancy : ''}" />
                        </div>

                        <div class="form-group">
                            <label for="status">Trạng thái</label>
                            <select class="form-control" name="status" id="status" required>
                                <option value="Available" ${room != null && room.status == 'Available' ? 'selected' : ''}>Còn trống</option>
                                <option value="Occupied" ${room != null && room.status == 'Occupied' ? 'selected' : ''}>Đã có người</option>
                                <option value="Maintenance" ${room != null && room.status == 'Maintenance' ? 'selected' : ''}>Bảo trì</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="roomImage">Hình ảnh phòng</label>
                            <input type="file" class="form-control" name="roomImage" id="roomImage" accept="image/*" onchange="previewImage(event)" />
                            <img id="preview" src="#" alt="Xem trước" style="display:none;" />
                        </div>

                        <c:if test="${room != null && room.roomImagePath != null}">
                            <div class="form-group">
                                <label>Ảnh hiện tại:</label><br/>
                                <img src="${pageContext.request.contextPath}/${room.roomImagePath}" id="existingImage" alt="Hình phòng" />
                            </div>
                        </c:if>

                        <button type="submit" class="btn btn-primary">${room != null ? 'Cập nhật' : 'Tạo mới'}</button>
                        <a href="rooms?action=list" class="btn btn-default">Hủy</a>
                    </form>
                </div>
            </div>
        </section>

        <div class="footer-main">
            Bản quyền © Hệ thống Quản lý Phòng - 2025
        </div>
    </aside>

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
    <script src="js/bootstrap.min.js" type="text/javascript"></script>
    <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap.min.js"></script>
    <script src="js/Director/app.js" type="text/javascript"></script>
    <script>
        function previewImage(event) {
            const input = event.target;
            const preview = document.getElementById("preview");
            const existing = document.getElementById("existingImage");

            if (input.files && input.files[0]) {
                const reader = new FileReader();

                reader.onload = function (e) {
                    preview.src = e.target.result;
                    preview.style.display = "block";
                    if (existing)
                        existing.style.opacity = "0.3";
                };

                reader.readAsDataURL(input.files[0]);
            } else {
                preview.style.display = "none";
                if (existing)
                    existing.style.opacity = "1";
            }
        }
    </script>
</body>
</html>
