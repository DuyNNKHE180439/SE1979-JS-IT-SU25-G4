<%-- 
    Document   : editProfile
    Created on : Jun 17, 2025, 5:09 PM
    Author     : Admin
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh Sửa Hồ Sơ</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            * {
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                margin: 0;
                background-color: #f4f4f4;
            }

            .nav-bar {
                background-color: #fff;
                height: 80px;
                padding: 0 20px;
                display: flex;
                align-items: center;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 1000;
            }

            .nav-bar .back-btn {
                font-size: 24px;
                color: rgb(3, 78, 162);
                cursor: pointer;
                margin-right: 20px;
            }

            .nav-bar .logo img {
                height: 60px;
            }

            .error-message {
                display: none;
                color: #dc2626;
                font-size: 0.875rem;
                margin-top: 0.25rem;
            }

            .error-message.active {
                display: block;
            }

            .subheading {
                padding: 1px 20px;
                font-size: 38px;
                font-weight: bold;
                color: #034EA2;
                margin-top: 130px;
                text-align: center;
            }

            .profile-pic-container {
                position: relative;
                display: inline-block;
            }

            .profile-pic-container input[type="file"] {
                display: none;
            }

            .profile-pic-label {
                position: absolute;
                bottom: 0;
                right: 0;
                background-color: rgba(0, 0, 0, 0.7);
                color: white;
                padding: 5px;
                border-radius: 50%;
                cursor: pointer;
                font-size: 20px;
            }
        </style>
    </head>
     <c:if test="${not empty success}">
        <script>
            alert("${success}");
        </script>
    </c:if>
    <body class="bg-gray-100 min-h-screen">
        <div class="nav-bar">
            <a href="${pageContext.request.contextPath}/view/profile.jsp" class="back-btn"><i class="fa-solid fa-arrow-left"></i></a>
            <div class="logo">  
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo">
            </div>
        </div>
        <div class="subheading">Chỉnh Sửa Thông Tin Cá Nhân</div>
        <div class="container max-w-4xl mx-auto pt-10 pb-10 px-6 bg-white rounded-2xl shadow-lg" style="margin-top: 100px;">
            <form action="user" method="POST" id="editProfileForm" enctype="multipart/form-data">
                <input type="hidden" name="action" value="editProfile">
                <input type="hidden" name="userId" value="${profile.getUserId()}">
                <input type="hidden" name="addressId" value="${profile.getAddressId()}">
                <input type="hidden" name="originalPhoneNumber" value="${profile.getPhoneNumber()}">
                <div class="flex justify-center mb-6">
                    <div class="profile-pic-container">
                        <img src="${profile.getImage() != null ? profile.getImage() : 'images/FrogSleep.png'}" alt="Ảnh Đại Diện" class="w-32 h-32 rounded-full object-cover border-4 border-indigo-100 hover:scale-105 transition-transform duration-300" id="profilePicPreview">
                        <label for="profilePic" class="profile-pic-label"><i class="fa-solid fa-camera"></i></label>
                        <input type="file" id="profilePic" name="profilePic" accept="image/*">
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Tên Đăng Nhập</label>
                        <input type="text" name="username" value="${profile.getUserName()}" readonly class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Mật Khẩu</label>
                        <input type="password" name="password" value="${profile.getPassword()}" class="w-full p-3 border border-gray-300 rounded-lg" data-validate="Mật khẩu là bắt buộc">
                        <span class="error-message"></span>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                        <input type="email" name="email" value="${profile.getEmail()}" readonly class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Họ</label>
                        <input type="text" name="firstName" value="${profile.getFirstName()}" class="w-full p-3 border border-gray-300 rounded-lg" data-validate="Họ là bắt buộc">
                        <span class="error-message"></span>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Tên</label>
                        <input type="text" name="lastName" value="${profile.getLastName()}" class="w-full p-3 border border-gray-300 rounded-lg" data-validate="Tên là bắt buộc">
                        <span class="error-message"></span>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Ngày Sinh</label>
                        <input type="date" name="dateOfBirth" value="${profile.dateOfBirth.substring(0, 10)}" class="w-full p-3 border border-gray-300 rounded-lg" data-validate="Ngày sinh không hợp lệ">
                        <span class="error-message"></span>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Giới Tính</label>
                        <select name="gender" class="w-full p-3 border border-gray-300 rounded-lg" data-validate="Vui lòng chọn giới tính">
                            <option value="" disabled>Giới tính</option>
                            <option value="Nam" ${"Nam".equals(profile.getGender()) ? "selected" : ""}>Nam</option>
                            <option value="Nữ" ${"Nữ".equals(profile.getGender()) ? "selected" : ""}>Nữ</option>
                            <option value="Khác" ${"Khác".equals(profile.getGender()) ? "selected" : ""}>Khác</option>
                        </select>
                        <span class="error-message"></span>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Số Điện Thoại</label>
                        <input type="tel" name="phoneNumber" value="${profile.getPhoneNumber()}" class="w-full p-3 border border-gray-300 rounded-lg" data-validate="Số điện thoại không hợp lệ">
                        <span class="error-message"></span>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Tỉnh/Thành Phố</label>
                        <select name="province" id="province" class="w-full p-3 border border-gray-300 rounded-lg">
                            <option value="">Chọn Tỉnh/Thành phố</option>
                        </select>
                        <span class="error-message"></span>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Quận/Huyện</label>
                        <select name="district" id="district" class="w-full p-3 border border-gray-300 rounded-lg" disabled>
                            <option value="">Chọn Quận/Huyện</option>
                        </select>
                        <span class="error-message"></span>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Phường/Xã</label>
                        <select name="ward" id="ward" class="w-full p-3 border border-gray-300 rounded-lg" disabled>
                            <option value="">Chọn Phường/Xã</option>
                        </select>
                        <span class="error-message"></span>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">Đường/Phố</label>
                        <input type="text" name="street" value="${profile.getStreet()}" class="w-full p-3 border border-gray-300 rounded-lg">
                        <span class="error-message"></span>
                    </div>
                </div>
                <div class="text-center mt-8">
                    <button type="submit" class="inline-block px-6 py-3 bg-gradient-to-r from-indigo-600 to-blue-500 text-white rounded-full hover:from-indigo-700 hover:to-blue-600 transition-all duration-300 shadow-md mr-4">Cập Nhật</button>
                    <a href="${pageContext.request.contextPath}/view/profile.jsp" class="inline-block px-6 py-3 bg-gray-400 text-white rounded-full hover:bg-gray-500 transition-all duration-300 shadow-md">Huỷ</a>
                </div>
            </form>
        </div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            // Profile picture preview
            document.getElementById('profilePic').addEventListener('change', function (e) {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('profilePicPreview').src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            });

            function validateEditProfileForm(event) {
                const form = event.target;
                let isValid = true;

                const requiredFields = [
                    {field: form.password, message: "Mật khẩu là bắt buộc"},
                    {field: form.firstName, message: "Họ là bắt buộc"},
                    {field: form.lastName, message: "Tên là bắt buộc"}
                ];

                resetErrors(form);

                requiredFields.forEach(item => {
                    if (!item.field.value.trim()) {
                        showError(item.field, item.message);
                        isValid = false;
                    }
                });

                // Validate password
                const pass = form.password;
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

                // Validate phone number
                if (form.phoneNumber.value && !/^\d{9,11}$/.test(form.phoneNumber.value)) {
                    showError(form.phoneNumber, "Số điện thoại không hợp lệ (phải có 9-11 chữ số)");
                    isValid = false;
                }

                // Validate gender
                if (!form.gender.value) {
                    showError(form.gender, "Vui lòng chọn giới tính");
                    isValid = false;
                }

                if (!isValid) {
                    event.preventDefault();
                }
            }

            function showError(input, message) {
                const errorEl = input.nextElementSibling;
                if (errorEl && errorEl.classList.contains('error-message')) {
                    errorEl.textContent = message;
                    errorEl.classList.add('active');
                }
            }

            function resetErrors(form) {
                form.querySelectorAll('.error-message').forEach(el => {
                    el.textContent = '';
                    el.classList.remove('active');
                });
            }

            document.getElementById('editProfileForm').addEventListener('submit', validateEditProfileForm);

            // Address API integration
            document.addEventListener('DOMContentLoaded', function () {
                const provinceSelect = document.getElementById('province');
                const districtSelect = document.getElementById('district');
                const wardSelect = document.getElementById('ward');

                // Load provinces
                fetch('https://provinces.open-api.vn/api/p/')
                        .then(response => response.json())
                        .then(provinces => {
                            provinces.forEach(function (province) {
                                var option = document.createElement('option');
                                option.value = province.name;
                                option.textContent = province.name;
                                option.setAttribute('data-code', province.code);
                                provinceSelect.appendChild(option);
                            });
                            // Set initial province if exists
                            if ("${profile.getProvice()}") {
                                provinceSelect.value = "${profile.getProvice()}";
                                provinceSelect.dispatchEvent(new Event('change'));
                            }
                        });

                // When province changes
                provinceSelect.addEventListener('change', function () {
                    districtSelect.innerHTML = '<option value="">Chọn Quận/Huyện</option>';
                    wardSelect.innerHTML = '<option value="">Chọn Phường/Xã</option>';
                    wardSelect.disabled = true;

                    if (!this.value) {
                        districtSelect.disabled = true;
                        return;
                    }

                    districtSelect.disabled = false;

                    const selectedOption = this.options[this.selectedIndex];
                    const provinceCode = selectedOption.getAttribute('data-code');

                    fetch('https://provinces.open-api.vn/api/p/' + provinceCode + '?depth=2')
                            .then(response => response.json())
                            .then(function (province) {
                                province.districts.forEach(function (district) {
                                    var option = document.createElement('option');
                                    option.value = district.name;
                                    option.textContent = district.name;
                                    option.setAttribute('data-code', district.code);
                                    districtSelect.appendChild(option);
                                });
                                // Set initial district if exists
                                if ("${profile.getDistrict()}") {
                                    districtSelect.value = "${profile.getDistrict()}";
                                    districtSelect.dispatchEvent(new Event('change'));
                                }
                            });
                });

                // When district changes
                districtSelect.addEventListener('change', function () {
                    wardSelect.innerHTML = '<option value="">Chọn Phường/Xã</option>';

                    if (!this.value) {
                        wardSelect.disabled = true;
                        return;
                    }

                    wardSelect.disabled = false;

                    const selectedOption = this.options[this.selectedIndex];
                    const districtCode = selectedOption.getAttribute('data-code');

                    fetch('https://provinces.open-api.vn/api/d/' + districtCode + '?depth=2')
                            .then(response => response.json())
                            .then(function (district) {
                                district.wards.forEach(function (ward) {
                                    var option = document.createElement('option');
                                    option.value = ward.name;
                                    option.textContent = ward.name;
                                    option.setAttribute('data-code', ward.code);
                                    wardSelect.appendChild(option);
                                });
                                // Set initial ward if exists
                                if ("${profile.getWard()}") {
                                    wardSelect.value = "${profile.getWard()}";
                                }
                            });
                });
            });
        </script>
    </body>
</html>