<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa tài khoản sinh viên</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
</head>
<body class="skin-black">
    <jsp:include page="admin-slider.jsp" />

    <aside class="right-side">
        <section class="content">
            <div class="row">
                <div class="col-xs-12">
                    <h2>Chỉnh sửa tài khoản sinh viên</h2>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="edit-student" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="userId" value="${student.user.userId}" />

                        <!-- Username -->
                        <div class="form-group">
                            <label for="username">Tên đăng nhập *</label>
                            <input type="text" class="form-control" name="username" value="${student.user.userName}" required />
                        </div>

                        <!-- Email -->
                        <div class="form-group">
                            <label for="email">Email *</label>
                            <input type="email" class="form-control" name="email" value="${student.user.email}" required />
                            <c:if test="${not empty emailError}">
                                <small class="text-danger">${emailError}</small>
                            </c:if>
                        </div>

                        <!-- Họ -->
                        <div class="form-group">
                            <label for="firstName">Họ *</label>
                            <input type="text" class="form-control" name="firstName" value="${student.user.firstName}" required />
                        </div>

                        <!-- Tên -->
                        <div class="form-group">
                            <label for="lastName">Tên *</label>
                            <input type="text" class="form-control" name="lastName" value="${student.user.lastName}" required />
                        </div>

                        <!-- Giới tính -->
                        <div class="form-group">
                            <label for="gender">Giới tính</label>
                            <select class="form-control" name="gender">
                                <option value="">-- Chọn giới tính --</option>
                                <option value="Nam" ${student.user.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                                <option value="Nữ" ${student.user.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                <option value="Khác" ${student.user.gender == 'Khác' ? 'selected' : ''}>Khác</option>
                            </select>
                        </div>

                        <!-- SĐT -->
                        <div class="form-group">
                            <label for="phoneNumber">Số điện thoại</label>
                            <input type="text" class="form-control" name="phoneNumber" value="${student.user.phoneNumber}" />
                        </div>

                        <!-- Ngày sinh -->
                        <div class="form-group">
                            <label for="dateOfBirth">Ngày sinh</label>
                            <input type="date" class="form-control" name="dateOfBirth" value="${student.user.dateOfBirth}" />
                            <c:if test="${not empty dateError}">
                                <small class="text-danger">${dateError}</small>
                            </c:if>
                        </div>

                        <!-- Ảnh đại diện -->
                        <div class="form-group">
                            <label for="imagePath">Ảnh đại diện</label>
                            <input type="file" class="form-control" name="imagePath" id="imagePath" accept="image/*" onchange="previewImage(event)" />
                            <img id="preview" src="#" alt="Xem trước ảnh" style="display:none; width: 120px; border: 1px solid #ccc; margin-top: 10px;" />
                        </div>

                        <!-- Ảnh hiện tại -->
                        <c:if test="${student.user.imagePath != null}">
                            <div class="form-group">
                                <label>Ảnh hiện tại:</label><br/>
                                <img src="${pageContext.request.contextPath}/${student.user.imagePath}" id="existingImage" style="width: 120px;" />
                            </div>
                        </c:if>

                        <!-- Mã sinh viên -->
                        <div class="form-group">
                            <label for="studentCode">Mã sinh viên *</label>
                            <input type="text" class="form-control" name="studentCode" value="${student.studentCode}" required />
                            <c:if test="${not empty studentCodeError}">
                                <small class="text-danger">${studentCodeError}</small>
                            </c:if>
                        </div>

                        <!-- Hidden userID -->
                        <c:if test="${student != null}">
                            <input type="hidden" name="userID" value="${student.userID}" />
                        </c:if>

                        <!-- Buttons -->
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                        <a href="manage-account" class="btn btn-default">Hủy</a>
                    </form>
                </div>
            </div>
        </section>
        <div class="footer-main text-center">
            Bản quyền © Hệ thống Quản lý Ký túc xá - 2025
        </div>
    </aside>

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
                    if (existing) {
                        existing.style.opacity = "0.3";
                    }
                };
                reader.readAsDataURL(input.files[0]);
            } else {
                preview.style.display = "none";
                if (existing) {
                    existing.style.opacity = "1";
                }
            }
        }
    </script>
</body>
</html>
