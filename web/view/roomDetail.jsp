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
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                background-color: #f7fafc;
                color: #2d3748;
                line-height: 1.6;
            }

            .nav-bar {
                background-color: #ffffff;
                height: 64px;
                padding: 0 24px;
                display: flex;
                align-items: center;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 1000;
            }

            .nav-bar .hamburger {
                font-size: 1.5rem;
                color: #ed8936;
                cursor: pointer;
                transition: color 0.2s ease;
            }

            .nav-bar .hamburger:hover {
                color: #dd6b20;
            }

            .nav-bar .logo img {
                height: 48px;
                transition: transform 0.3s ease;
            }

            .nav-bar .logo img:hover {
                transform: scale(1.05);
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
                width: 260px;
                background-color: #ffffff;
                padding: 24px;
                box-shadow: 2px 0 8px rgba(0, 0, 0, 0.05);
                height: calc(100vh - 64px);
                position: fixed;
                top: 64px;
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
                margin-bottom: 24px;
                padding-bottom: 16px;
                border-bottom: 1px solid #edf2f7;
            }

            .sidebar .profile img {
                width: 48px;
                height: 48px;
                border-radius: 50%;
                margin-right: 12px;
                object-fit: cover;
            }

            .sidebar .profile .info {
                flex: 1;
            }

            .sidebar .profile .title {
                font-size: 1rem;
                font-weight: 600;
                color: #2b6cb0;
                margin-bottom: 4px;
            }

            .sidebar .profile p {
                font-size: 0.85rem;
                color: #718096;
                margin: 2px 0;
            }

            .sidebar .menu {
                max-height: calc(100vh - 200px);
                overflow-y: auto;
            }

            .sidebar .menu a {
                display: flex;
                align-items: center;
                padding: 12px 16px;
                color: #4a5568;
                text-decoration: none;
                margin-bottom: 8px;
                border-radius: 6px;
                transition: all 0.2s ease;
                font-size: 0.95rem;
                font-weight: 500;
            }

            .sidebar .menu a i {
                margin-right: 12px;
                font-size: 1.25rem;
                color: #718096;
            }

            .sidebar .menu a:hover,
            .sidebar .menu a.active {
                background-color: #ed8936;
                color: #ffffff;
            }

            .sidebar .menu a:hover i,
            .sidebar .menu a.active i {
                color: #ffffff;
            }

            .sidebar .logout a {
                display: block;
                padding: 12px 16px;
                background-color: #e53e3e;
                color: #ffffff;
                text-align: center;
                text-decoration: none;
                border-radius: 6px;
                font-weight: 500;
                transition: background-color 0.2s ease;
            }

            .sidebar .logout a:hover {
                background-color: #c53030;
            }

            .main {
                margin-left: 260px;
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