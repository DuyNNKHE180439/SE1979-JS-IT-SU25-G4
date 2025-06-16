<%-- 
    Document   : studentHome
    Created on : Jun 11, 2025, 2:59:50 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
            color: #F36F21;
            cursor: pointer;
            margin-right: 20px;
        }

        .nav-bar .logo img {
            height: 60px;
        }

        .nav-bar .notification {
            font-size: 24px;
            color: #007bff;
            cursor: pointer;
            position: relative;
            margin-left: auto;
        }

        .popup {
            position: absolute;
            top: 60px;
            right: 20px;
            width: 250px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 5px 10px rgba(0, 0, 0, 0.15);
            padding: 10px;
            display: none;
            animation: fadeIn 0.3s ease;
        }

        .popup.active {
            display: block;
        }

        .popup p {
            margin: 0;
            font-size: 14px;
            color: #333;
        }

        @keyframes fadeIn {
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
            width: 300px;
            background-color: #fff;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            height: 100vh;
            position: fixed;
            top: 80px;
            left: 0;
            transition: transform 0.3s ease;
            z-index: 900;
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
            max-height: calc(100vh - 220px);
            overflow-y: auto;
        }

        .sidebar .menu a {
            display: flex;
            align-items: center;
            padding: 14px;
            color: #333;
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
        }

        .sidebar .logout {
            margin-top: 20px;
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
            padding: 100px 20px 20px;
            transition: margin-left 0.3s ease;
        }

        .main.expanded {
            margin-left: 0;
        }

        .main .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .main .header h1 {
            margin: 0;
            color: rgb(46, 78, 148);
        }

        .main .news-bar h2 {
            background-color: rgb(46, 77, 157);
            color: white;
            border-radius: 5px;
            padding: 10px;
            margin: 0 0 10px 0;
        }

        .main .news-item {
            background-color: #fff;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            cursor: pointer;
        }

        .main .news-item h3 {
            margin: 0 0 10px;
            font-size: 16px;
        }

        .main .news-item p {
            margin: 0;
            color: #666;
            font-size: 14px;
        }

        .popup .popup-item {
            margin-bottom: 10px;
        }

        .popup .popup-item h4 {
            font-weight: bold;
            margin: 0 0 5px 0;
            color: #1E90FF;
            font-size: 14px;
        }

        .popup .popup-item p {
            margin: 0;
            font-size: 12px;
            color: #333;
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
        <div class="header">
            <h1>STUDENT BOARD</h1>
        </div>
        <div class="news-bar">
            <h2>NEWS</h2>
        </div>
        <div class="news-item">
            <h3>QUY ĐỊNH VỀ SỬ DỤNG THIẾT BỊ ĐIỆN TẠI KTX</h3>
            <p>huongct12 2025-05-28T09:14:28.59</p>
        </div>
        <div class="news-item">
            <h3>TB. VIỆC ĐẢM BẢO AN NINH AN TOÀN TRONG THỜI GIAN NGHỈ LỄ 30/4, 01/5</h3>
            <p>huongct12 2025-04-27T15:00:45.9</p>
        </div>
        <div class="news-item">
            <h3>THÔNG BÁO V/V ĐĂNG KÝ/HUỶ PHÒNG KTX KỲ SUMMER 2025</h3>
            <p>huongct12 2025-04-03T10:12:10.74</p>
        </div>
        <div class="news-item">
            <h3>THÔNG BÁO V/V GIA HẠN GIỮ CHỖ VÀ THAY ĐỔI THỜI GIAN ĐĂNG KÝ MỚI PHÒNG KTX KỲ SP25</h3>
            <p>huongct12 2024-12-13T22:28:20.927</p>
        </div>
        <div class="news-item">
            <h3>THÔNG BÁO V/V ĐĂNG KÝ/HUỶ PHÒNG KTX KỲ SPRING 2025</h3>
            <p>huongct12 2024-11-13T19:34:29.727</p>
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
