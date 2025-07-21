<%-- 
    Document   : studentHome
    Created on : Jun 11, 2025, 2:59:50 AM
    Author     : Admin
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ký Túc Xá</title>
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
                color: rgb(3, 78, 162);
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
            .main {
                margin-left: 300px;
                padding: 100px 30px 30px;
                background-color: #f9fafb;
                min-height: calc(100vh - 80px);
            }

            .main .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
                padding: 15px 20px;
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            }

            .main .header h1 {
                margin: 0;
                color: rgb(46, 78, 148);
                font-size: 24px;
                font-weight: 600;
            }

            .main .content {
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                overflow: hidden;
            }

            .main .news-bar {
                background-color: rgb(46, 77, 157);
                color: white;
                padding: 15px;
                font-size: 16px;
                font-weight: 600;
                border-top-left-radius: 10px;
                border-top-right-radius: 10px;
            }

            .main table {
                width: 100%;
                border-collapse: collapse;
                font-size: 14px;
            }

            .main table th {
                background-color: rgb(46, 77, 157);
                color: white;
                padding: 15px;
                text-align: left;
                font-weight: 600;
            }

            .main table td {
                padding: 15px;
                border-bottom: 1px solid #edf2f7;
                color: #333;
            }

            .main table tr {
                transition: background-color 0.2s ease;
            }

            .main table tr.news-item:hover {
                background-color: #f7fafc;
                cursor: pointer;
            }

            .main table td:first-child {
                font-weight: 500;
                color: #2b6cb0;
            }

            .main table td:nth-child(2) {
                font-weight: 500;
                color: rgb(3, 78, 162);
            }

            .main table td:nth-child(3) {
                color: #4a5568;
            }

            .main table td:nth-child(4) {
                color: #718096;
                font-size: 13px;
            }

            .main table .payment-btn {
                display: inline-block;
                padding: 10px 10px;
                background: linear-gradient(45deg, #F36F21, #ff8c00);
                color: #fff;
                text-decoration: none;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                text-align: center;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
                cursor: pointer;
            }

            .main table .payment-btn:hover {
                background: linear-gradient(45deg, #e55e1a, #e07b00);
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            }
            .leave-request-form {
                max-width: 600px;
                margin: 20px auto;
            }

            .leave-request-form div {
                margin-bottom: 20px;
            }

            .leave-request-form label {
                display: block;
                font-size: 14px;
                font-weight: 600;
                color: rgb(46, 78, 148);
                margin-bottom: 8px;
            }

            .leave-request-form input[readonly] {
                width: 100%;
                padding: 12px;
                font-size: 14px;
                color: #4a5568;
                background-color: #f7fafc;
                border: 1px solid #e2e8f0;
                border-radius: 8px;
                cursor: not-allowed;
            }

            .leave-request-form textarea {
                width: 100%;
                padding: 12px;
                font-size: 16px;
                color: #333;
                background-color: #fff;
                border: 1px solid #e2e8f0;
                border-radius: 8px;
                resize: vertical;
                min-height: 120px;
            }

            .leave-request-form textarea:focus {
                outline: none;
                border-color: #3182ce;
                box-shadow: 0 0 5px rgba(49, 130, 206, 0.3);
            }

            .leave-request-form button {
                display: inline-block;
                padding: 12px 24px;
                background: linear-gradient(45deg, #F36F21, #ff8c00);
                color: #fff;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
            }

            .leave-request-form button:hover {
                background: linear-gradient(45deg, #e55e1a, #e07b00);
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            }

        </style>
    </head>
    <c:if test="${not empty mess}">
        <script>
            alert("${mess}");
        </script>
    </c:if>
    <body>
        <div class="nav-bar">
            <div class="hamburger" id="hamburger">
                <i class="fa-solid fa-bars"></i>
            </div>
            <div class="logo">
                <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo Ký Túc Xá">
            </div>
            <div class="notification" id="notification">
                <i class="fa-solid fa-bell"></i>
                <div class="popup" id="popup">
                    <div class="popup-item">
                        <h4>Electricity Bill Notice</h4>
                        <p>Electricity bill payment notice issued.</p>
                    </div>
                    <div class="popup-item">
                        <h4>Security Alert</h4>
                        <p>Students, please protect your personal belongings.</p>
                    </div>
                    <div class="popup-item">
                        <h4>New Notification</h4>
                        <p>You have 1 new notification.</p>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="slider.jsp" />

        <div class="main" id="main">
            <div class="header">
                <h1>YÊU CẦU HỦY PHÒNG KTX</h1>
            </div>
            <div class="content">
                <form action="user" method="post" class="leave-request-form">
                    <input type="hidden" name="action" value="editLeaveRequest">
                    <input type="hidden" name="regisId" value="${leave.getRegisId()}">
                    <div>
                        <label for="studentName">Phòng:</label>
                        <input type="text"   value="${leave.getRoomNum()}" readonly>
                    </div>
                    <div>
                        <label for="studentCode">Giường:</label>
                        <input type="text"   value="${leave.getBedNum()}" readonly>
                    </div>
                    <div>
                        <label for="roomNumber">Ngày Bắt Đầu:</label>
                        <input type="text"   value="${leave.getStartDate()}" readonly>
                    </div>
                    <div>
                        <label for="bedNumber">Ngày Kết Thúc:</label>
                        <input type="text"   value="${leave.getEndDate()}" readonly>
                    </div>
                    <div>
                        <label for="reason">Lý Do Hủy Phòng (Không quá 250 ký tự):</label>
                        <textarea  name="reason" required placeholder="Nhập lý do hủy phòng..."></textarea>
                    </div>
                    <button type="submit">Xác Nhận</button>
                </form>
            </div>
        </div>>

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