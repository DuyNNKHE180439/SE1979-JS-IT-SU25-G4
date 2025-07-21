<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Tạo tài khoản sinh viên</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
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
                        <h2>Tạo tài khoản mới</h2>

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

                                <!-- Passwords -->
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

                            <!-- Role -->
                            <div class="form-group">
                                <label for="roleId">Vai trò *</label>
                                <select class="form-control" name="roleId" id="roleId" required onchange="toggleStudentFields()">
                                    <option value="1" <c:if test="${student.user.roleId == 1}">selected</c:if>>Admin</option>
                                    <option value="3" <c:if test="${student.user.roleId == 3}">selected</c:if>>Manager</option>
                                    <option value="2" <c:if test="${student.user.roleId == 2}">selected</c:if>>Student</option>
                                    </select>
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
                                <input type="hidden" name="existingImagePath" value="${student.user.imagePath}" />
                                <img id="preview" style="display: none; width: 120px; border: 1px solid #ccc; margin-top: 10px;" />
                            </div>

                            <!-- Student Code -->
                            <div class="form-group" id="studentCodeGroup" style="display: none;">
                                <label for="studentCode">Mã sinh viên *</label>
                                <input type="text" class="form-control" name="studentCode" id="studentCode" value="${student.studentCode}" />
                                <div id="studentCodeError" class="text-danger small">
                                    <c:if test="${not empty studentCodeError}">${studentCodeError}</c:if>
                                </div>
                            </div>

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

        <!-- Script -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap.min.js"></script>
        <script src="js/Director/app.js" type="text/javascript"></script>

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
                                            preview.src = "";
                                            preview.style.display = "none";
                                        }
                                    }

                                    function toggleStudentFields() {
                                        const role = document.getElementById("roleId").value;
                                        const studentCodeGroup = document.getElementById("studentCodeGroup");
                                        studentCodeGroup.style.display = role === "2" ? "block" : "none";
                                    }

                                    function validateForm() {
                                        let valid = true;
                                        const email = document.getElementById("email").value.trim();
                                        const phone = document.getElementById("phoneNumber").value.trim();
                                        const dob = document.getElementById("dateOfBirth").value;
                                        const now = new Date().toISOString().split("T")[0];

                                        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                                        const phoneRegex = /^0\d{9}$/;

                                        if (!emailRegex.test(email)) {
                                            document.getElementById("emailError").textContent = "Email không hợp lệ.";
                                            valid = false;
                                        } else {
                                            document.getElementById("emailError").textContent = "";
                                        }

                                        if (phone && !phoneRegex.test(phone)) {
                                            document.getElementById("phoneError").textContent = "Số điện thoại phải bắt đầu bằng 0 và có 10 chữ số.";
                                            valid = false;
                                        } else {
                                            document.getElementById("phoneError").textContent = "";
                                        }

                                        if (dob && dob > now) {
                                            document.getElementById("dobError").textContent = "Ngày sinh không hợp lệ.";
                                            valid = false;
                                        } else {
                                            document.getElementById("dobError").textContent = "";
                                        }

                                        const role = document.getElementById("roleId").value;
                                        if (role === "2") {
                                            const studentCode = document.getElementById("studentCode").value.trim();
                                            if (studentCode === "") {
                                                document.getElementById("studentCodeError").textContent = "Mã sinh viên là bắt buộc.";
                                                valid = false;
                                            } else {
                                                document.getElementById("studentCodeError").textContent = "";
                                            }
                                        }

                                        return valid;
                                    }

                                    document.addEventListener("DOMContentLoaded", toggleStudentFields);
        </script>

    </body>
</html>
