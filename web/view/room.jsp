<%-- 
    Document   : roomList
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

            .main .message {
                padding: 12px 16px;
                border-radius: 6px;
                margin-bottom: 16px;
                font-size: 0.95rem;
                font-weight: 500;
                background-color: #48bb78;
                color: #ffffff;
            }

            .main .message.error {
                background-color: #e53e3e;
            }

            .main .room-list {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 24px;
            }

            .main .room-card {
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                overflow: hidden;
                transition: transform 0.2s ease, box-shadow 0.2s ease;
            }

            .main .room-card:hover {
                transform: translateY(-4px);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            .main .room-card img {
                width: 100%;
                height: 180px;
                object-fit: cover;
            }

            .main .room-card .no-image {
                width: 100%;
                height: 180px;
                background-color: #e2e8f0;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .main .room-card .no-image span {
                font-size: 0.95rem;
                color: #718096;
                font-weight: 500;
            }

            .main .room-card .content {
                padding: 16px;
            }

            .main .room-card h3 {
                font-size: 1.25rem;
                font-weight: 600;
                color: #2b6cb0;
                margin-bottom: 12px;
            }

            .main .room-card p {
                font-size: 0.9rem;
                color: #4a5568;
                margin-bottom: 8px;
            }

            .main .room-card .status {
                display: flex;
                align-items: center;
                font-weight: 500;
                font-size: 0.9rem;
            }

            .main .room-card .status i {
                font-size: 0.75rem;
                margin-right: 6px;
            }

            .main .room-card .status.full {
                color: #e53e3e;
            }

            .main .room-card .status.available {
                color: #28a745;
            }

            .main .room-card .detail-btn {
                display: inline-block;
                padding: 8px 16px;
                background-color: #3182ce;
                color: #ffffff;
                text-decoration: none;
                border-radius: 6px;
                font-weight: 500;
                transition: background-color 0.2s ease;
                text-align: center;
            }

            .main .room-card .detail-btn:hover {
                background-color: #2b6cb0;
            }

            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 24px;
            }

            .pagination a {
                padding: 8px 16px;
                margin: 0 4px;
                border: 1px solid #e2e8f0;
                border-radius: 6px;
                text-decoration: none;
                color: #4a5568;
                transition: all 0.2s ease;
            }

            .pagination a:hover {
                background-color: #ed8936;
                color: #ffffff;
                border-color: #ed8936;
            }

            .pagination a.active {
                background-color: #3182ce;
                color: #ffffff;
                border-color: #3182ce;
            }

            .pagination a.disabled {
                color: #a0aec0;
                pointer-events: none;
                border-color: #e2e8f0;
            }

            .search-form {
                margin-bottom: 24px;
                display: flex;
                gap: 12px;
                align-items: center;
            }

            .search-form input[type="text"] {
                padding: 8px 12px;
                border: 1px solid #e2e8f0;
                border-radius: 6px;
                font-size: 0.95rem;
                width: 300px;
            }

            .search-form button {
                padding: 8px 16px;
                background-color: #3182ce;
                color: #ffffff;
                border: none;
                border-radius: 6px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }

            .search-form button:hover {
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

                .main .room-list {
                    grid-template-columns: 1fr;
                }

                .search-form {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .search-form input[type="text"] {
                    width: 100%;
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
            <h2>Dormitory Room List</h2>

            <!-- Search form -->
            <form class="search-form" action="${pageContext.request.contextPath}/room" method="get">
                <input type="text" name="search" placeholder="Search by room number or status..." value="${param.search}"/>
                <button type="submit">Search</button>
            </form>

            <!-- Notification after booking -->
            <c:if test="${not empty message}">
                <div class="message">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="message error">${error}</div>
            </c:if>

            <!-- Room list -->
            <div class="room-list">
                <c:forEach var="room" items="${rooms}">
                    <div class="room-card">
                        <c:choose>
                            <c:when test="${not empty room.roomImagePath}">
                                <img src="${pageContext.request.contextPath}/${room.roomImagePath}" alt="Room Image">
                            </c:when>
                            <c:otherwise>
                                <div class="no-image">
                                    <span>No Image</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="content">
                            <h3>Room ${room.roomNumber}</h3>
                            <p><strong>Capacity:</strong> ${room.capacity} people</p>
                            <p><strong>Current Occupancy:</strong> <c:out value="${room.currentOccupancy != null ? room.currentOccupancy : 0}"/> people</p>
                            <p><strong>Status:</strong>
                                <span class="status ${room.currentOccupancy >= room.capacity ? 'full' : 'available'}">
                                    <i class="fa-solid fa-circle"></i>
                                    ${room.currentOccupancy >= room.capacity ? 'Full' : room.status}
                                </span>
                            </p>
                            <a href="${pageContext.request.contextPath}/roomDetail?roomId=${room.roomID}" class="detail-btn">
                                View Details
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Pagination -->
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/room?page=${currentPage - 1}&search=${param.search}">Previous</a>
                </c:if>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <a href="${pageContext.request.contextPath}/room?page=${i}&search=${param.search}" class="${currentPage == i ? 'active' : ''}">${i}</a>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <a href="${pageContext.request.contextPath}/room?page=${currentPage + 1}&search=${param.search}">Next</a>
                </c:if>
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