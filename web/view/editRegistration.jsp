<%-- 
    Document   : registerBed
    Created on : Jun 16, 2025, 12:48:15 PM
    Author     : ADMIN
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>On Campus Dormitory</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
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

            .nav-bar .hamburger {
                font-size: 24px;
                color: rgb(3, 78, 162);
                cursor: pointer;
                margin-right: 20px;
            }

            .nav-bar .logo img {
                height: 60px;
            }

            .nav-bar .notification {
                font-size: 1.5rem;
                color: #3182ce;
                cursor: pointer;
                position: relative;
                margin-left: auto;
                transition: color 0.2s ease;
            }

            .nav-bar .notification:hover {
                color: #2b6cb0;
            }

            .popup {
                position: absolute;
                top: 60px;
                right: 24px;
                width: 280px;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                padding: 16px;
                display: none;
                animation: slideIn 0.3s ease;
                z-index: 1000;
            }

            .popup.active {
                display: block;
            }

            .popup .popup-item {
                padding: 12px;
                border-bottom: 1px solid #edf2f7;
                transition: background-color 0.2s ease;
            }

            .popup .popup-item:last-child {
                border-bottom: none;
            }

            .popup .popup-item:hover {
                background-color: #f7fafc;
            }

            .popup .popup-item h4 {
                font-size: 0.95rem;
                font-weight: 600;
                color: #2b6cb0;
                margin-bottom: 4px;
            }

            .popup .popup-item p {
                font-size: 0.85rem;
                color: #4a5568;
                margin: 0;
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(-8px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .sidebar {
                width: 300px;
                background-color: #fff;
                padding: 20px;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
                height: calc(100vh - 80px);
                position: fixed;
                top: 80px;
                left: 0;
                transition: transform 0.3s ease;
                z-index: 900;
                display: flex;
                flex-direction: column;
            }

            .sidebar.hidden {
                transform: translateX(-100%);
            }

            .sidebar .profile {
                text-align: left;
                margin-bottom: 10px;
            }

            .sidebar .profile table {
                width: 100%;
            }

            .sidebar .profile td:first-child img {
                width: 60px;
                border-radius: 50%;
                vertical-align: middle;
                margin-right: 10px;
            }

            .sidebar .profile td:last-child {
                vertical-align: middle;
            }

            .sidebar .profile .title {
                font-weight: bold;
                color: #1E90FF;
                margin-right: 5px;
            }

            .sidebar .profile p {
                margin: 2px 0;
            }

            .sidebar .profile p:first-child {
                font-size: 16px;
                margin-bottom: 12px;
            }

            .sidebar .profile p:not(:first-child) {
                font-size: 12px;
            }

            .sidebar .menu {
                flex: 1;
                overflow-y: auto;
                margin-bottom: 20px;
            }

            .sidebar .menu a {
                display: flex;
                align-items: center;
                padding: 14px;
                color: rgb(3, 78, 162);
                text-decoration: none;
                margin-bottom: 10px;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .sidebar .menu a.active,
            .sidebar .menu a:hover {
                background-color: #F36F21;
                color: #fff;
            }

            .sidebar .menu a i {
                margin-right: 12px;
                font-size: 20px;
                color: rgb(3, 78, 162);
            }

            .sidebar .logout {
                margin-top: auto;
            }

            .sidebar .logout a {
                display: block;
                padding: 14px;
                background-color: #F36F21;
                color: #fff;
                text-align: center;
                text-decoration: none;
                border-radius: 8px;
                transition: background-color 0.3s ease;
            }

            .main {
                margin-left: 300px;
                padding: 90px 32px 32px;
                transition: margin-left 0.3s ease;
                min-height: calc(100vh - 70px);
                background-color: #f5f7fa;
            }

            .main.expanded {
                margin-left: 0;
            }

            .main h2 {
                font-size: 2rem;
                font-weight: 700;
                color: #1a202c;
                margin-bottom: 32px;
                letter-spacing: -0.02em;
            }

            .main .message {
                padding: 14px 20px;
                border-radius: 8px;
                margin-bottom: 20px;
                font-size: 1rem;
                font-weight: 500;
                background-color: #48bb78;
                color: #ffffff;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            .main .message.error {
                background-color: #e53e3e;
            }

            .main .form-container {
                background-color: #ffffff;
                padding: 32px;
                border-radius: 12px;
                box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
                margin-bottom: 32px;
                max-width: 600px;
            }

            .main .form-container p {
                font-size: 1rem;
                color: #4a5568;
                margin-bottom: 16px;
                font-weight: 500;
            }

            .main .form-container label {
                display: block;
                font-size: 1rem;
                font-weight: 600;
                color: #1a202c;
                margin-bottom: 10px;
            }

            .main .form-container input[type="date"] {
                width: 100%;
                padding: 12px;
                border: 1px solid #e2e8f0;
                border-radius: 8px;
                font-size: 1rem;
                color: #1a202c;
                margin-bottom: 20px;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
                background-color: #f7fafc;
            }

            .main .form-container input[type="date"]:focus {
                outline: none;
                border-color: #4299e1;
                box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.15);
            }

            .main .form-container button {
                display: inline-block;
                padding: 12px 32px;
                background-color: #38a169;
                color: #ffffff;
                border: none;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            .main .form-container button:hover {
                background-color: #2f8555;
                transform: translateY(-2px);
            }

            .main .form-container button:disabled {
                background-color: #a0aec0;
                cursor: not-allowed;
                transform: none;
            }

            .main .form-container a {
                display: inline-block;
                padding: 12px 32px;
                background-color: #edf2f7;
                color: #4a5568;
                text-decoration: none;
                border-radius: 8px;
                font-weight: 600;
                margin-left: 16px;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }

            .main .form-container a:hover {
                background-color: #e2e8f0;
                transform: translateY(-2px);
            }

            .main .no-bed-message {
                font-size: 1rem;
                color: #e53e3e;
                margin-top: 32px;
                font-weight: 500;
            }

            .main .back-btn {
                display: inline-block;
                padding: 12px 24px;
                background-color: #4299e1;
                color: #ffffff;
                text-decoration: none;
                border-radius: 8px;
                font-weight: 600;
                transition: background-color 0.3s ease, transform 0.2s ease;
                margin-top: 32px;
            }

            .main .back-btn:hover {
                background-color: #2b6cb0;
                transform: translateY(-2px);
            }

            @media (max-width: 768px) {
                .sidebar {
                    width: 100%;
                    transform: translateX(-100%);
                }

                .sidebar.hidden {
                    transform: translateX(-100%);
                }

                .main {
                    margin-left: 0;
                    padding: 90px 20px 20px;
                }

                .main.expanded {
                    margin-left: 0;
                }

                .popup {
                    width: 90%;
                    right: 20px;
                }

                .main .form-container {
                    padding: 24px;
                }

                .main .form-container input[type="date"] {
                    font-size: 0.95rem;
                }

                .main .form-container button,
                .main .form-container a {
                    width: 100%;
                    text-align: center;
                    margin-bottom: 12px;
                    margin-left: 0;
                }
            }

            @media (max-width: 480px) {
                .nav-bar {
                    padding: 0 16px;
                }

                .popup {
                    width: 95%;
                    right: 10px;
                }

                .main h2 {
                    font-size: 1.75rem;
                }
            }
        </style>
        <style>
            label {
                font-weight: bold;
                display: block;
                margin-top: 12px;
                margin-bottom: 6px;
                font-size: 16px;
            }

            #months {
                width: 100%;
                max-width: 300px;
                padding: 10px;
                font-size: 15px;
                border-radius: 8px;
                border: 1px solid #ccc;
                box-shadow: inset 0 1px 3px rgba(0,0,0,0.1);
                transition: border-color 0.3s, box-shadow 0.3s;
            }

            #months:focus {
                outline: none;
                border-color: #4285f4;
                box-shadow: 0 0 8px rgba(66, 133, 244, 0.4);
            }

            #months:hover {
                border-color: #4285f4;
            }

            /* Optional - hover highlight for options (browser dependent) */
            #months option:hover {
                background-color: #f1f1f1;
            }
        </style>
    </head>

    <body>
        <div class="nav-bar">
            <div class="hamburger" id="hamburger">
                <i class="fa-solid fa-bars"></i>
            </div>
            <div class="logo">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="On Campus Dormitory Logo" />
            </div>
            <div class="notification" id="notification">
                <i class="fa-solid fa-bell"></i>
                <div class="popup" id="popup">
                    <div class="popup-item">
                        <h4>Thông báo đóng tiền điện</h4>
                        <p>Đã có thông báo đóng tiền điện.</p>
                    </div>
                    <div class="popup-item">
                        <h4>Cảnh báo an ninh</h4>
                        <p>Sinh viên chú ý bảo vệ đồ đạc tư trang cá nhân.</p>
                    </div>
                    <div class="popup-item">
                        <h4>Thông báo mới</h4>
                        <p>Bạn có 1 thông báo mới.</p>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="slider.jsp" />

        <div class="main" id="main">
            <h2>Chỉnh sửa yêu cầu đăng ký giường</h2>

            <div class="form-container">
                <form action="${pageContext.request.contextPath}/edit-request" method="post" onsubmit="return validateEditForm()">
                    <input type="hidden" name="registrationID" value="${registration.registrationID}" />

                    <p><strong>Phòng:</strong> ${registration.room.roomNumber}</p>
                    <p><strong>Giường:</strong> ${registration.bed.bedNumber}</p>

                    <%
                        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                        String today = sdf.format(new java.util.Date());
                    %>

                    <label for="startDate">Ngày bắt đầu:</label>
                    <input type="date" id="startDate" name="startDate"
                           value="<fmt:formatDate value='${registration.startDate}' pattern='yyyy-MM-dd'/>"
                           min="<%= today %>" required onchange="updateEndDate()" />

                    <label for="months">Thời gian thuê (tháng):</label>
                    <select id="months" name="months" onchange="updateEndDate()" required>
                        <option value="1">1 tháng</option>
                        <option value="2">2 tháng</option>
                        <option value="3">3 tháng</option>
                        <option value="6">6 tháng</option>
                        <option value="12">12 tháng</option>
                    </select>

                    <label for="endDate">Ngày kết thúc:</label>
                    <input type="date" id="endDate" name="endDate"
                           value="<fmt:formatDate value='${registration.endDate}' pattern='yyyy-MM-dd'/>"
                           readonly required />

                    <div style="margin-top: 24px;">
                        <button type="submit">Lưu thay đổi</button>
                        <a href="${pageContext.request.contextPath}/register-list" class="back-btn">Hủy</a>
                    </div>
                </form>
            </div>
        </div>

        <script>
            const hamburger = document.getElementById('hamburger');
            const sidebar = document.getElementById('sidebar');
            const main = document.getElementById('main');

            hamburger.addEventListener('click', () => {
                sidebar.classList.toggle('hidden');
                main.classList.toggle('expanded');
            });

            const notification = document.getElementById('notification');
            const popup = document.getElementById('popup');

            notification.addEventListener('click', () => {
                popup.classList.toggle('active');
            });

            document.addEventListener('click', (e) => {
                if (!notification.contains(e.target)) {
                    popup.classList.remove('active');
                }
            });
        </script>
        <script>
            function updateEndDate() {
                const startInput = document.getElementById("startDate").value;
                const months = parseInt(document.getElementById("months").value || "1");

                if (!startInput) {
                    document.getElementById("endDate").value = "";
                    return;
                }

                const startDate = new Date(startInput);
                const endDate = new Date(startDate);
                endDate.setMonth(endDate.getMonth() + months);

                // Xử lý ngày kết thúc nếu ngày đầu tháng không tồn tại (ví dụ 31/1 + 1 tháng)
                if (endDate.getDate() !== startDate.getDate()) {
                    endDate.setDate(0);
                }

                const formatted = endDate.toISOString().split("T")[0];
                document.getElementById("endDate").value = formatted;
            }

            function validateEditForm() {
                const start = document.getElementById("startDate").value;
                const end = document.getElementById("endDate").value;
                const today = new Date().toISOString().split("T")[0];

                if (!start || !end) {
                    alert("Vui lòng chọn ngày bắt đầu và thời gian thuê.");
                    return false;
                }

                if (start < today) {
                    alert("Ngày bắt đầu không được nhỏ hơn ngày hôm nay.");
                    return false;
                }

                return true;
            }

            function calculateInitialMonths() {
                const startInput = document.getElementById("startDate").value;
                const endInput = document.getElementById("endDate").value;

                if (startInput && endInput) {
                    const startDate = new Date(startInput);
                    const endDate = new Date(endInput);

                    let months = (endDate.getFullYear() - startDate.getFullYear()) * 12 +
                            (endDate.getMonth() - startDate.getMonth());

                    if (endDate.getDate() < startDate.getDate())
                        months--;

                    months = Math.max(1, months); // ít nhất là 1 tháng

                    // Gán giá trị tháng vào select
                    document.getElementById("months").value = months;
                }
            }

            document.addEventListener("DOMContentLoaded", function () {
                calculateInitialMonths();
                updateEndDate();
            });
        </script>
    </body>
</html>