<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Tạo tài khoản sinh viên</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <link href="css/ionicons.min.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <link href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap.min.css" rel="stylesheet" />
</head>
<body class="skin-black">

<jsp:include page="admin-slider.jsp" />

<aside class="right-side">
    <section class="content">
        <div class="row">
            <div class="col-xs-12">
                <h2>Tạo tài khoản sinh viên mới</h2>

                <form action="create-student" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <!-- Username -->
                    <div class="form-group">
                        <label for="username">Tên đăng nhập *</label>
                        <input type="text" class="form-control" name="username" id="username" value="${student.user.userName}" required />
                        <div id="usernameError" class="text-danger small">
                            <c:if test="${not empty usernameError}">${usernameError}</c:if>
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="form-group">
                        <label for="password">Mật khẩu *</label>
                        <input type="password" class="form-control" name="password" id="password" required />
                        <div id="passwordError" class="text-danger small">
                            <c:if test="${not empty passwordError}">${passwordError}</c:if>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="form-group">
                        <label for="email">Email *</label>
                        <input type="email" class="form-control" name="email" id="email" value="${student.user.email}" required />
                        <div id="emailError" class="text-danger small">
                            <c:if test="${not empty emailError}">${emailError}</c:if>
                        </div>
                    </div>

                    <!-- First Name -->
                    <div class="form-group">
                        <label for="firstName">Họ *</label>
                        <input type="text" class="form-control" name="firstName" id="firstName" value="${student.user.firstName}" required />
                    </div>

                    <!-- Last Name -->
                    <div class="form-group">
                        <label for="lastName">Tên *</label>
                        <input type="text" class="form-control" name="lastName" id="lastName" value="${student.user.lastName}" required />
                    </div>

                    <!-- Gender -->
                    <div class="form-group">
                        <label for="gender">Giới tính</label>
                        <select class="form-control" name="gender" id="gender">
                            <option value="">-- Chọn giới tính --</option>
                            <option value="Nam" ${student.user.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                            <option value="Nữ" ${student.user.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                            <option value="Khác" ${student.user.gender == 'Khác' ? 'selected' : ''}>Khác</option>
                        </select>
                    </div>

                    <!-- Phone -->
                    <div class="form-group">
                        <label for="phoneNumber">Số điện thoại</label>
                        <input type="text" class="form-control" name="phoneNumber" id="phoneNumber" value="${student.user.phoneNumber}" />
                        <div id="phoneError" class="text-danger small">
                            <c:if test="${not empty phoneError}">${phoneError}</c:if>
                        </div>
                    </div>

                    <!-- Date of Birth -->
                    <div class="form-group">
                        <label for="dateOfBirth">Ngày sinh</label>
                        <input type="date" class="form-control" name="dateOfBirth" id="dateOfBirth" value="${student.user.dateOfBirth}" />
                        <div id="dobError" class="text-danger small"></div>
                    </div>

                    <!-- Image Upload -->
                    <div class="form-group">
                        <label for="imagePath">Ảnh đại diện</label>
                        <input type="file" class="form-control" name="imagePath" id="imagePath" accept="image/*" onchange="previewImage(event)" />
                        <img id="preview"
                             src="<c:out value='${student.user.imagePath}'/>"
                             alt="Xem trước ảnh"
                             style="${not empty student.user.imagePath ? 'display:block;' : 'display:none;'} width: 120px; border: 1px solid #ccc; margin-top: 10px;" />
                    </div>

                    <!-- Student Code -->
                    <div class="form-group">
                        <label for="studentCode">Mã sinh viên *</label>
                        <input type="text" class="form-control" name="studentCode" id="studentCode" value="${student.studentCode}" required />
                        <div id="studentCodeError" class="text-danger small">
                            <c:if test="${not empty studentCodeError}">${studentCodeError}</c:if>
                        </div>
                    </div>

                    <!-- Submit -->
                    <button type="submit" class="btn btn-primary">Tạo tài khoản</button>
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

        if (input.files && input.files[0]) {
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = "block";
            };
            reader.readAsDataURL(input.files[0]);
        } else {
            preview.style.display = "none";
        }
    }

    function validateForm() {
        let valid = true;

        const email = document.getElementById("email").value.trim();
        const phone = document.getElementById("phoneNumber").value.trim();
        const dob = document.getElementById("dateOfBirth").value;
        const now = new Date().toISOString().split("T")[0];

        ["username", "password", "firstName", "lastName", "studentCode"].forEach(id => {
            const input = document.getElementById(id);
            const error = document.getElementById(id + "Error");
            if (input && input.value.trim() === "") {
                if (error) error.textContent = "Trường này là bắt buộc.";
                valid = false;
            } else {
                if (error) error.textContent = "";
            }
        });

        const emailError = document.getElementById("emailError");
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            emailError.textContent = "Email không hợp lệ.";
            valid = false;
        } else {
            emailError.textContent = "";
        }

        const phoneError = document.getElementById("phoneError");
        if (phone !== "" && !/^0\d{9}$/.test(phone)) {
            phoneError.textContent = "Số điện thoại phải bắt đầu bằng 0 và có 10 chữ số.";
            valid = false;
        } else {
            phoneError.textContent = "";
        }

        const dobError = document.getElementById("dobError");
        if (dob !== "" && dob > now) {
            dobError.textContent = "Ngày sinh không hợp lệ.";
            valid = false;
        } else {
            dobError.textContent = "";
        }

        return valid;
    }
</script>

</body>
</html>
