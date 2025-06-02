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
        <title>Đăng nhập</title>
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
    <c:if test="${not empty success}">
        <script>
            alert("${success}");
        </script>
    </c:if>
    <c:if test="${not empty emailError}">
        <script>
            alert("${emailError}");
        </script>
    </c:if>
    <c:if test="${not empty phoneError}">
        <script>
            alert("${phoneError}");
        </script>
    </c:if>
    <body>
        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100">
                    <div class="login-logo-container">
                        <img src="images/logo.png" alt="Logo">
                    </div>

                    <form class="login100-form " action="Login" method="POST">


                        <div class="wrap-input100 " data-validate = "Vui lòng nhập tên tài khoản hoặc Email">
                            <input class="input100" type="text" name="email" placeholder="Email hoặc tên tài khoản">
                            <span class="error-message text-danger" style="font-size: 14px;"></span>
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-envelope" aria-hidden="true"></i>
                            </span>
                        </div>

                        <div class="wrap-input100 " data-validate = "Vui lòng nhập mật khẩu">
                            <input class="input100" type="password" name="pass" placeholder="Mật khẩu">
                            <span class="error-message text-danger" style="font-size: 14px;"></span>
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-lock" aria-hidden="true"></i>
                            </span>
                        </div>

                        <div class="container-login100-form-btn">
                            <button class="login100-form-btn" type="submit">
                                Đăng nhập
                            </button>
                        </div>

                        <div class="text-center p-t-12">
                            <span class="txt1">
                                Quên
                            </span>
                            <a class="txt2" href="requestPassword">
                                Tài khoản / Mật khẩu?
                            </a>
                        </div>
                        <div class="container-login100-form-btn">
                            <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:8080/SWP391-SU25-SE1979-G4/Login&response_type=code&client_id=611569971681-vi5nck1d72bu9r3hh6mukep2rmhth9pd.apps.googleusercontent.com&approval_prompt=force
                               " class="login100-form-btn" style="background-color: #db4437; color: white; display: flex; align-items: center; justify-content: center;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-google" viewBox="0 0 16 16" style="margin-right: 8px;">
                                <path d="M15.545 6.558a9.42 9.42 0 0 1 .139 1.626c0 2.434-.87 4.492-2.384 5.885h.002C11.978 15.292 10.158 16 8 16A8 8 0 1 1 8 0a7.689 7.689 0 0 1 5.352 2.082l-2.284 2.284A4.347 4.347 0 0 0 8 3.166c-2.087 0-3.86 1.408-4.492 3.304a4.792 4.792 0 0 0 0 3.063h.003c.635 1.893 2.405 3.301 4.492 3.301 1.078 0 2.004-.276 2.722-.764h-.003a3.702 3.702 0 0 0 1.599-2.431H8v-3.08h7.545z"/>
                                </svg>
                                <span>Đăng nhập với Google</span>
                            </a>
                        </div>
                        <br>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>
                        <div class="text-center p-t-136">
                            <a class="txt2" href="#" id="to-register">
                                Chưa có tài khoản? Đăng ký tại đây
                                <i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
                            </a>
                        </div>

                    </form>

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
                            <a class="txt2" href="#" id="to-login">
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
            $('.js-tilt').tilt({
                scale: 1.1
            })

            // Chuyển đổi giữa form đăng nhập và đăng ký
            $(document).ready(function () {
                // Ẩn form đăng ký ban đầu
                $('#register-form').hide();

                $('#to-register').click(function (e) {
                    e.preventDefault();
                    $('.login100-form').first().fadeOut(300, function () {
                        $('#register-form').fadeIn(300);
                    });
                });

                $('#to-login').click(function (e) {
                    e.preventDefault();
                    $('#register-form').fadeOut(300, function () {
                        $('.login100-form').first().fadeIn(300);
                    });
                });
            });
        </script>
        <script>
            function validateLoginForm(event) {
                const form = event.target;
                let isValid = true;

                const email = form.email;
                const pass = form.pass;

                resetErrors(form);

                if (!email.value.trim()) {
                    showError(email, "Vui lòng nhập email hoặc tên tài khoản");
                    isValid = false;
                }
                if (!pass.value.trim()) {
                    showError(pass, "Vui lòng nhập mật khẩu");
                    isValid = false;
                }

                if (!isValid)
                    event.preventDefault();
            }

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
                // Validate password
                const pass = form.pass;
                if (pass.value) {
                    if (pass.value.length < 6) {
                        showError(pass, "Mật khẩu phải có ít nhất 6 ký tự");
                        isValid = false;
                    } else if (!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+$/.test(pass.value)) {
                        showError(pass, "Mật khẩu phải chứa cả chữ và số");
                        isValid = false;
                    } else if (/\s/.test(pass.value)) {
                        showError(pass, "Mật khẩu không được chứa dấu cách");
                        isValid = false;
                    }
                }
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