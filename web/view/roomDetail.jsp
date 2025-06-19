<%-- 
    Document   : bookingBed
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
                padding: 80px 24px 24px;
                transition: margin-left 0.3s ease;
                min-height: calc(100vh - 64px);
            }

            .main.expanded {
                margin-left: 0;
            }

            .main h2 {
                font-size: 1.75rem;
                font-weight: 700;
                color: #2d3748;
                margin-bottom: 24px;
            }

            .main .room-info {
                background-color: #ffffff;
                padding: 24px;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                margin-bottom: 24px;
            }

            .main .room-info h2 {
                font-size: 1.5rem;
                margin-bottom: 16px;
            }

            .main .room-info p {
                font-size: 0.95rem;
                color: #4a5568;
                margin-bottom: 8px;
            }

            .main .room-image {
                width: 100%;
                max-height: 400px;
                object-fit: cover;
                border-radius: 8px;
                margin-bottom: 24px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            }

            .main .no-image {
                width: 100%;
                height: 300px;
                background-color: #e2e8f0;
                display: flex;
                justify-content: center;
                align-items: center;
                border-radius: 8px;
                margin-bottom: 24px;
            }

            .main .no-image span {
                font-size: 1rem;
                color: #718096;
                font-weight: 500;
            }

            .main h3 {
                font-size: 1.25rem;
                font-weight: 600;
                color: #2d3748;
                margin-bottom: 16px;
            }

            .main .beds-table {
                width: 100%;
                border-collapse: collapse;
                background-color: #ffffff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            }

            .main .beds-table th,
            .main .beds-table td {
                padding: 12px 16px;
                text-align: left;
                font-size: 0.9rem;
            }

            .main .beds-table th {
                background-color: #2b6cb0;
                color: #ffffff;
                font-weight: 600;
            }

            .main .beds-table tr {
                border-bottom: 1px solid #edf2f7;
            }

            .main .beds-table tr:last-child {
                border-bottom: none;
            }

            .main .beds-table tr:hover {
                background-color: #f7fafc;
            }

            .main .status-available i,
            .main .status-occupied i {
                font-size: 0.75rem;
                margin-right: 6px;
            }

            .main .status-available {
                color: #28a745;
                font-weight: 500;
            }

            .main .status-occupied {
                color: #e53e3e;
                font-weight: 500;
            }

            .main .back-btn {
                display: inline-block;
                padding: 10px 20px;
                background-color: #3182ce;
                color: #ffffff;
                text-decoration: none;
                border-radius: 6px;
                font-weight: 500;
                transition: background-color 0.2s ease;
                margin-top: 16px;
            }

            .main .back-btn:hover {
                background-color: #2b6cb0;
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
                    padding: 80px 16px 16px;
                }

                .main.expanded {
                    margin-left: 0;
                }

                .popup {
                    width: 90%;
                    right: 16px;
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
            <h2>Dormitory Room Detail</h2>
            <c:choose>
                <c:when test="${not empty room}">
                    <c:choose>
                        <c:when test="${not empty room.roomImagePath}">
                            <img src="${pageContext.request.contextPath}/${room.roomImagePath}" alt="Room Image" class="room-image">
                        </c:when>
                        <c:otherwise>
                            <div class="no-image">
                                <span>No Room Image</span>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="room-info">
                        <h2>Room ${room.roomNumber}</h2>
                        <p><strong>Capacity:</strong> ${room.capacity} people</p>
                        <p><strong>Current Occupancy:</strong> ${room.currentOccupancy != null ? room.currentOccupancy : 0} people</p>
                        <p><strong>Status:</strong> 
                            <span style="color: ${room.status eq 'Full' ? '#e53e3e' : '#28a745'}; font-weight: 500;">
                                ${room.status}
                            </span>
                        </p>
                    </div>

                    <h3>Bed List</h3>
                    <c:choose>
                        <c:when test="${not empty beds}">
                            <table class="beds-table">
                                <thead>
                                    <tr>
                                        <th>Bed Number</th>
                                        <th>Position</th>
                                        <th>Price (VND)</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="bed" items="${beds}">
                                        <tr>
                                            <td>${bed.bedNumber}</td>
                                            <td>${bed.position}</td>
                                            <td><fmt:formatNumber value="${bed.price}" type="currency" currencySymbol="₫"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${bed.status eq 'Available'}">
                                                        <span class="status-available"><i class="fa-solid fa-circle"></i> Available</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-occupied"><i class="fa-solid fa-circle"></i> Occupied</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:if test="${bed.status eq 'Available'}">
                                                    <form action="${pageContext.request.contextPath}/register-bed" method="get" style="margin: 0;">
                                                        <input type="hidden" name="bedId" value="${bed.bedID}" />
                                                        <button type="submit" style="padding: 6px 12px; background-color: #f97316; border: none; color: white; border-radius: 4px; cursor: pointer;">
                                                            Book Bed
                                                        </button>
                                                    </form>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p>No beds are registered for this room.</p>
                        </c:otherwise>
                    </c:choose>

                    <a href="${pageContext.request.contextPath}/room" class="back-btn">← Back to Room List</a>
                </c:when>
                <c:otherwise>
                    <p>Room information not found.</p>
                </c:otherwise>
            </c:choose>
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