<%-- 
    Document   : profile
    Created on : Jun 17, 2025, 1:15:11 AM
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
        <title>Hồ Sơ Người Dùng</title>
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

            .nav-bar .notification {
                font-size: 24px;
                color: rgb(3, 78, 162);
                cursor: pointer;
                position: relative;
                margin-left: auto;
            }

            .subheading {
                padding: 1px 20px;
                font-size: 38px;
                font-weight: bold;
                color: #034EA2;
                margin-top: 130px; /* Reduced from 130px to 100px */
                text-align: center;
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
            <a href="${pageContext.request.contextPath}/view/studentHome.jsp" class="back-btn"><i class="fa-solid fa-arrow-left"></i></a>
            <div class="logo">  
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo">
            </div>
        </div>
        <div class="subheading">Thông Tin Cá Nhân</div>
        <div class="container max-w-4xl mx-auto pt-10 pb-10 px-6 bg-white rounded-2xl shadow-lg" style="margin-top: 100px;">
            <div class="flex justify-center mb-6">
                <c:choose>
                    <c:when test="${not empty profile.image}">
                        <img src="${pageContext.request.contextPath}/${profile.image}"
                             alt="Ảnh Đại Diện"
                             class="w-32 h-32 rounded-full object-cover border-4 border-indigo-100 hover:scale-105 transition-transform duration-300">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/images/FrogSleep.png"
                             alt="Ảnh Đại Diện"
                             class="w-32 h-32 rounded-full object-cover border-4 border-indigo-100 hover:scale-105 transition-transform duration-300">
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Tên Đăng Nhập</label>
                    <input type="text" value="${profile.getUserName()}" disabled class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Mật Khẩu</label>
                    <input type="password" value="${profile.getPassword()}" disabled class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                    <input type="email" value="${profile.getEmail()}" disabled class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Họ</label>
                    <input type="text" value="${profile.getFirstName()}" disabled class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Tên</label>
                    <input type="text" value="${profile.getLastName()}" disabled class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Ngày Sinh</label>
                    <input type="date" value="${profile.dateOfBirth.substring(0, 10)}" disabled class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Giới Tính</label>
                    <select disabled class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600">
                        <option value="Nam" ${"Nam".equals(profile.getGender()) ? "selected" : ""}>Nam</option>
                        <option value="Nữ" ${"Nữ".equals(profile.getGender()) ? "selected" : ""}>Nữ</option>
                        <option value="Khác" ${"Khác".equals(profile.getGender()) ? "selected" : ""}>Khác</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Số Điện Thoại</label>
                    <input type="tel" value="${profile.getPhoneNumber()}" disabled class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Tỉnh/Thành Phố</label>
                    <input type="text" value="${profile.getProvice()}" disabled class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Quận/Huyện</label>
                    <input type="text" value="${profile.getDistrict()}" disabled class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Phường/Xã</label>
                    <input type="text" value="${profile.getWard()}" disabled class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600">
                </div>
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Đường/Phố</label>
                    <input type="text" value="${profile.getStreet()}" disabled class="w-full p-3 border border-gray-300 rounded-lg bg-gray-50 text-gray-600">
                </div>
            </div>
            <div class="text-center mt-8">
                <a href="user?action=editProfile" class="inline-block px-6 py-3 bg-gradient-to-r from-indigo-600 to-blue-500 text-white rounded-full hover:from-indigo-700 hover:to-blue-600 transition-all duration-300 shadow-md">Chỉnh Sửa</a>
            </div>
        </div>
    </body>
</html>