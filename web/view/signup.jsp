<%-- 
    Document   : login
    Created on : May 20, 2025, 11:37:23 PM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng ký</title>
        <!--===============================================================================================-->	
        <link rel="icon" type="image/png" href="images/icons/FrogFind.png"/>
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
        <!--===============================================================================================-->	
        <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="css/util.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <style>
            .form-toggle {
                display: none;
            }
            .form-toggle.active {
                display: block;
            }
            .login100-form {
                transition: all 0.5s ease;
            }
        </style>
    </head>
    <c:if test="${not empty usernameError}">
        <script>
      alert("${usernameError}");
        </script>
    </c:if>

    <body>
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100">
                    <div class="login-logo-container">
                        <img src="images/logo.png" alt="Logo">
                    </div>

                    <form class="login100-form  form-toggle" id="register-form" action="Register" method="POST">
                        <div class="wrap-input100 validate-input" data-validate="Tên người dùng là bắt buộc">
                            <input class="input100" type="text" name="username" placeholder="Tên tài khoản">
                            <span class="error-message text-danger" style="font-size: 14px;"></span>
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-user" aria-hidden="true"></i>
                            </span>
                        </div>

                        <div class="wrap-input100 " data-validate="Email là bắt buộc">
                            <input class="input100" type="text" name="email" placeholder="Email">
                            <span class="error-message text-danger" style="font-size: 14px;"></span>
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-envelope" aria-hidden="true"></i>
                            </span>
                        </div>

                        <div class="wrap-input100 " data-validate="Mật khẩu là bắt buộc">
                            <input class="input100" type="password" name="pass" placeholder="Mật khẩu">
                            <span class="error-message text-danger" style="font-size: 14px;"></span>
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-lock" aria-hidden="true"></i>
                            </span>
                        </div>

                        <div class="wrap-input100 " data-validate="Họ là bắt buộc">
                            <input class="input100" type="text" name="firstName" placeholder="Họ">
                            <span class="error-message text-danger" style="font-size: 14px;"></span>
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-user" aria-hidden="true"></i>
                            </span>
                        </div>

                        <div class="wrap-input100 " data-validate="Tên là bắt buộc">
                            <input class="input100" type="text" name="lastName" placeholder="Tên">
                            <span class="error-message text-danger" style="font-size: 14px;"></span>
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-user" aria-hidden="true"></i>
                            </span>
                        </div>

                        <div class="wrap-input100" data-validate="Ngày sinh không hợp lệ">
                            <input class="input100" type="date" name="dateOfBirth" placeholder="Ngày sinh">
                            <span class="error-message text-danger" style="font-size: 14px;"></span>
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-calendar" aria-hidden="true"></i>
                            </span>
                        </div>

                        <div class="wrap-input100">
                            <select class="input100" name="gender">
                                <option value="" disabled selected>Giới tính</option>
                                <option value="Nam">Nam</option>
                                <option value="Nữ">Nữ</option>
                                <option value="Khác">Khác</option>
                            </select>
                            <span class="error-message text-danger" style="font-size: 14px;"></span>
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-venus-mars" aria-hidden="true"></i>
                            </span>
                        </div>

                        <div class="wrap-input100" data-validate="Số điện thoại không hợp lệ">
                            <input class="input100" type="text" name="phoneNumber" placeholder="Số điện thoại">
                            <span class="error-message text-danger" style="font-size: 14px;"></span>
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-phone" aria-hidden="true"></i>
                            </span>
                        </div>

                        <div class="wrap-input100">
                            <select class="input100" id="province" name="province">
                                <option value="">Chọn Tỉnh/Thành phố</option>
                            </select>
                        </div>

                        <div class="wrap-input100">
                            <select class="input100" id="district" name="district" >
                                <option value="">Chọn Quận/Huyện</option>
                            </select>
                        </div>

                        <div class="wrap-input100">
                            <select class="input100" id="ward" name="ward" >
                                <option value="">Chọn Phường/Xã</option>
                            </select>
                        </div>
                        <div class="wrap-input100 ">
                            <input class="input100" type="text" name="street" placeholder="Đường (nếu có)">
                        </div>

                        <div class="container-login100-form-btn">
                            <button class="login100-form-btn" type="submit">
                                Đăng Ký
                            </button>
                        </div>

                        <div class="text-center p-t-136">
                            <a class="txt2" href="view/login.jsp" id="to-login">
                                Đã có tài khoản? Đăng nhập
                                <i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/bootstrap/js/popper.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/tilt/tilt.jquery.min.js"></script>
        <script>
            function validateRegisterForm(event) {
                const form = event.target;
                let isValid = true;

                const requiredFields = [
                    {field: form.username, message: "Tên người dùng là bắt buộc"},
                    {field: form.email, message: "Email là bắt buộc"},
                    {field: form.pass, message: "Mật khẩu là bắt buộc"},
                    {field: form.firstName, message: "Họ là bắt buộc"},
                    {field: form.lastName, message: "Tên là bắt buộc"},
                ];

                resetErrors(form);

                requiredFields.forEach(item => {
                    if (!item.field.value.trim()) {
                        showError(item.field, item.message);
                        isValid = false;
                    }
                });

                if (form.phoneNumber.value && !/^\d{9,11}$/.test(form.phoneNumber.value)) {
                    showError(form.phoneNumber, "Số điện thoại không hợp lệ (phải có 9-11 chữ số)");
                    isValid = false;
                }

                if (!form.gender.value) {
                    showError(form.gender, "Vui lòng chọn giới tính");
                    isValid = false;
                }

                if (!isValid)
                    event.preventDefault();
            }

            function showError(input, message) {
                const errorEl = input.parentElement.querySelector(".error-message");
                if (errorEl)
                    errorEl.textContent = message;
            }

            function resetErrors(form) {
                form.querySelectorAll(".error-message").forEach(el => el.textContent = "");
            }

            document.querySelector('form[action="Login"]').addEventListener('submit', validateLoginForm);
            document.querySelector('form[action="Register"]').addEventListener('submit', validateRegisterForm);
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const provinceSelect = document.getElementById('province');
                const districtSelect = document.getElementById('district');
                const wardSelect = document.getElementById('ward');

                // Load tỉnh/thành phố
                fetch('https://provinces.open-api.vn/api/p/')
                        .then(response => response.json())
                        .then(provinces => {
                            provinces.forEach(function (province) {
                                var option = document.createElement('option');
                                option.value = province.name; // Lưu tên tỉnh vào value
                                option.textContent = province.name;
                                option.setAttribute('data-code', province.code); // Lưu code vào data-code
                                provinceSelect.appendChild(option);
                            });
                        });

                // Khi chọn tỉnh
                provinceSelect.addEventListener('change', function () {
                    districtSelect.innerHTML = '<option value="">-- Chọn quận --</option>';
                    wardSelect.innerHTML = '<option value="">-- Chọn phường --</option>';
                    wardSelect.disabled = true;

                    if (!this.value) {
                        districtSelect.disabled = true;
                        return;
                    }

                    districtSelect.disabled = false;

                    // Lấy code từ data-code của option được chọn
                    const selectedOption = this.options[this.selectedIndex];
                    const provinceCode = selectedOption.getAttribute('data-code');

                    fetch('https://provinces.open-api.vn/api/p/' + provinceCode + '?depth=2')
                            .then(response => response.json())
                            .then(function (province) {
                                province.districts.forEach(function (district) {
                                    var option = document.createElement('option');
                                    option.value = district.name; // Lưu tên quận vào value
                                    option.textContent = district.name;
                                    option.setAttribute('data-code', district.code); // Lưu code vào data-code
                                    districtSelect.appendChild(option);
                                });
                            });
                });

                // Khi chọn quận
                districtSelect.addEventListener('change', function () {
                    wardSelect.innerHTML = '<option value="">-- Chọn phường --</option>';

                    if (!this.value) {
                        wardSelect.disabled = true;
                        return;
                    }

                    wardSelect.disabled = false;

                    // Lấy code từ data-code của option được chọn
                    const selectedOption = this.options[this.selectedIndex];
                    const districtCode = selectedOption.getAttribute('data-code');

                    fetch('https://provinces.open-api.vn/api/d/' + districtCode + '?depth=2')
                            .then(response => response.json())
                            .then(function (district) {
                                district.wards.forEach(function (ward) {
                                    var option = document.createElement('option');
                                    option.value = ward.name; // Lưu tên phường vào value
                                    option.textContent = ward.name;
                                    option.setAttribute('data-code', ward.code); // Lưu code nếu cần
                                    wardSelect.appendChild(option);
                                });
                            });
                });
            });
        </script>


        <!--===============================================================================================-->
        <script src="js/main.js"></script>

    </body>
</html>