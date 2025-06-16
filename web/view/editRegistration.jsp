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
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                background-color: #f5f7fa;
                color: #1a202c;
                line-height: 1.7;
                font-size: 16px;
            }

            .nav-bar {
                background-color: #ffffff;
                height: 70px;
                padding: 0 32px;
                display: flex;
                align-items: center;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 1000;
            }

            .nav-bar .hamburger {
                font-size: 1.75rem;
                color: #f6ad55;
                cursor: pointer;
                transition: color 0.3s ease, transform 0.3s ease;
            }

            .nav-bar .hamburger:hover {
                color: #dd6b20;
                transform: rotate(90deg);
            }

            .nav-bar .logo img {
                height: 50px;
                transition: transform 0.3s ease;
            }

            .nav-bar .logo img:hover {
                transform: scale(1.1);
            }

            .nav-bar .notification {
                font-size: 1.6rem;
                color: #4299e1;
                cursor: pointer;
                position: relative;
                margin-left: auto;
                transition: color 0.3s ease;
            }

            .nav-bar .notification:hover {
                color: #2b6cb0;
            }

            .nav-bar .notification::after {
                content: '';
                position: absolute;
                top: -4px;
                right: -4px;
                width: 8px;
                height: 8px;
                background-color: #e53e3e;
                border-radius: 50%;
                display: none;
            }

            .popup {
                position: absolute;
                top: 70px;
                right: 32px;
                width: 320px;
                background-color: #ffffff;
                border-radius: 12px;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
                padding: 20px;
                display: none;
                animation: slideIn 0.3s ease;
                z-index: 1000;
            }

            .popup.active {
                display: block;
            }

            .popup .popup-item {
                padding: 16px;
                border-bottom: 1px solid #edf2f7;
                transition: background-color 0.2s ease;
                border-radius: 8px;
            }

            .popup .popup-item:last-child {
                border-bottom: none;
            }

            .popup .popup-item:hover {
                background-color: #f7fafc;
            }

            .popup .popup-item h4 {
                font-size: 1rem;
                font-weight: 600;
                color: #2b6cb0;
                margin-bottom: 6px;
            }

            .popup .popup-item p {
                font-size: 0.9rem;
                color: #4a5568;
                margin: 0;
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .sidebar {
                width: 280px;
                background-color: #ffffff;
                padding: 32px 24px;
                box-shadow: 4px 0 12px rgba(0, 0, 0, 0.08);
                height: calc(100vh - 70px);
                position: fixed;
                top: 70px;
                left: 0;
                transition: transform 0.3s ease;
                z-index: 900;
            }

            .sidebar.hidden {
                transform: translateX(-100%);
            }

            .sidebar .profile {
                display: flex;
                align-items: center;
                margin-bottom: 32px;
                padding-bottom: 20px;
                border-bottom: 1px solid #e2e8f0;
            }

            .sidebar .profile img {
                width: 56px;
                height: 56px;
                border-radius: 50%;
                margin-right: 16px;
                object-fit: cover;
                border: 2px solid #edf2f7;
            }

            .sidebar .profile .info {
                flex: 1;
            }

            .sidebar .profile .title {
                font-size: 1.1rem;
                font-weight: 600;
                color: #2b6cb0;
                margin-bottom: 6px;
            }

            .sidebar .profile p {
                font-size: 0.9rem;
                color: #718096;
                margin: 3px 0;
            }

            .sidebar .menu {
                max-height: calc(100vh - 220px);
                overflow-y: auto;
            }

            .sidebar .menu a {
                display: flex;
                align-items: center;
                padding: 14px 20px;
                color: #4a5568;
                text-decoration: none;
                margin-bottom: 10px;
                border-radius: 8px;
                transition: all 0.3s ease;
                font-size: 1rem;
                font-weight: 500;
            }

            .sidebar .menu a i {
                margin-right: 14px;
                font-size: 1.4rem;
                color: #718096;
                transition: color 0.3s ease;
            }

            .sidebar .menu a:hover,
            .sidebar .menu a.active {
                background-color: #f6ad55;
                color: #ffffff;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            .sidebar .menu a:hover i,
            .sidebar .menu a.active i {
                color: #ffffff;
            }

            .sidebar .logout a {
                display: block;
                padding: 14px 20px;
                background-color: #e53e3e;
                color: #ffffff;
                text-align: center;
                text-decoration: none;
                border-radius: 8px;
                font-weight: 600;
                transition: background-color 0.3s ease;
            }

            .sidebar .logout a:hover {
                background-color: #c53030;
            }

            .main {
                margin-left: 280px;
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
                <form action="edit-request" method="post">
                    <input type="hidden" name="registrationID" value="${registration.registrationID}" />

                    <p><strong>Phòng:</strong> ${registration.room.roomNumber}</p>
                    <p><strong>Giường:</strong> ${registration.bed.bedNumber}</p>

                    <label for="startDate">Ngày bắt đầu:</label>
                    <input type="date" name="startDate" value="<fmt:formatDate value='${registration.startDate}' pattern='yyyy-MM-dd'/>" required>

                    <label for="endDate">Ngày kết thúc:</label>
                    <input type="date" name="endDate" value="<fmt:formatDate value='${registration.endDate}' pattern='yyyy-MM-dd'/>" required>

                    <div style="margin-top: 24px;">
                        <button type="submit">Lưu thay đổi</button>
                        <a href="register-list">Hủy</a>
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
    </body>
</html>