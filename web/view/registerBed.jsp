<%-- 
    Document   : registerBed
    Created on : Jun 16, 2025, 12:48:15 PM
    Author     : DUY
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
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
                color: #2b6cb0;
            }

            .main .room-info p {
                font-size: 0.95rem;
                color: #4a5568;
                margin-bottom: 8px;
            }

            .main .form-container {
                background-color: #ffffff;
                padding: 24px;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                margin-bottom: 24px;
            }

            .main .form-container p {
                font-size: 0.95rem;
                color: #4a5568;
                margin-bottom: 12px;
            }

            .main .form-container .status-available i,
            .main .form-container .status-occupied i {
                font-size: 0.75rem;
                margin-right: 6px;
            }

            .main .form-container .status-available {
                color: #28a745;
                font-weight: 500;
            }

            .main .form-container .status-occupied {
                color: #e53e3e;
                font-weight: 500;
            }

            .main .form-container label {
                display: block;
                font-size: 0.95rem;
                font-weight: 600;
                color: #2d3748;
                margin-bottom: 8px;
            }

            .main .form-container input[type="date"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #e2e8f0;
                border-radius: 6px;
                font-size: 0.95rem;
                color: #4a5568;
                margin-bottom: 16px;
                transition: border-color 0.2s ease;
            }

            .main .form-container input[type="date"]:focus {
                outline: none;
                border-color: #3182ce;
                box-shadow: 0 0 0 2px rgba(49, 130, 206, 0.1);
            }

            .main .form-container button {
                display: inline-block;
                padding: 12px 24px;
                background-color: #38a169;
                color: #ffffff;
                border: none;
                border-radius: 6px;
                font-size: 0.95rem;
                font-weight: 600;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }

            .main .form-container button:hover {
                background-color: #2f8555;
            }

            .main .form-container button:disabled {
                background-color: #a0aec0;
                cursor: not-allowed;
            }

            .main .no-bed-message {
                font-size: 0.95rem;
                color: #e53e3e;
                margin-top: 24px;
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
                margin-top: 24px;
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

                .main .form-container input[type="date"] {
                    font-size: 0.9rem;
                }
            }
            .main .form-container select {
                width: 100%;
                padding: 10px;
                border: 1px solid #e2e8f0;
                border-radius: 6px;
                font-size: 0.95rem;
                color: #4a5568;
                margin-bottom: 16px;
                transition: border-color 0.2s ease;
                background-color: #fff;
                appearance: none;
                -webkit-appearance: none;
                -moz-appearance: none;
                background-image: url('data:image/svg+xml;utf8,<svg fill="%234a5568" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/></svg>');
                background-repeat: no-repeat;
                background-position: right 10px center;
                background-size: 20px 20px;
            }

            .main .form-container select:focus {
                outline: none;
                border-color: #3182ce;
                box-shadow: 0 0 0 2px rgba(49, 130, 206, 0.1);
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
            <h2>Đăng ký giường ký túc xá</h2>

            <c:if test="${not empty message}">
                <div class="message">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="message error">${error}</div>
            </c:if>

            <div class="room-info">
                <h2>Phòng ${room.roomNumber}</h2>
                <p><strong>Sức chứa:</strong> ${room.capacity} người</p>
                <p><strong>Đang ở:</strong> ${room.currentOccupancy != null ? room.currentOccupancy : 0} người</p>
                <p><strong>Trạng thái:</strong> 
                    <span class="${room.status eq 'Full' ? 'status-occupied' : 'status-available'}">
                        ${room.status}
                    </span>
                </p>
            </div>

            <%
// Format ngày hôm nay yyyy-MM-dd để dùng cho min="..."
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
String today = sdf.format(new Date());
            %>
            <c:choose>
                <c:when test="${not empty bed}">
                    <form action="${pageContext.request.contextPath}/register-bed" method="post" class="form-container" onsubmit="return validateBookingForm()">
                        <input type="hidden" name="bedId" value="${bed.bedID}" />
                        <input type="hidden" name="roomId" value="${room.roomID}" />

                        <p><strong>Giường:</strong> ${bed.bedNumber} - ${bed.position}</p>
                        <p><strong>Giá:</strong> 
                            <fmt:formatNumber value="${bed.price}" type="currency" currencySymbol="₫" />
                        </p>
                        <p><strong>Trạng thái:</strong>
                            <span class="${bed.status eq 'Available' ? 'status-available' : 'status-occupied'}">
                                <i class="fa-solid fa-circle"></i> 
                                ${bed.status eq 'Available' ? 'Còn trống' : 'Đã đặt'}
                            </span>
                        </p>

                        <label for="startDate">Ngày bắt đầu:</label>
                        <!-- Sửa tại đây: gán min="<%= today %>" để ngăn chọn ngày quá khứ -->
                        <input type="date" id="startDate" name="startDate" required onchange="updateEndDate()" min="<%= today %>" />

                        <label for="months">Thời gian thuê (tháng):</label>
                        <select id="months" name="months" onchange="updateEndDate()" required>
                            <option value="1">1 tháng</option>
                            <option value="2">2 tháng</option>
                            <option value="3">3 tháng</option>
                            <option value="6">6 tháng</option>
                        </select>

                        <label for="endDate">Ngày kết thúc:</label>
                        <input type="date" id="endDate" name="endDate" readonly />

                        <button type="submit">Gửi yêu cầu đăng ký</button>
                    </form>

                    <!-- Script xử lý ngày -->
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

                            // Nếu ngày không tồn tại ở tháng sau (VD: 31 -> 30 hoặc 28)
                            if (endDate.getDate() !== startDate.getDate()) {
                                endDate.setDate(0); // lùi về cuối tháng trước
                            }

                            const formatted = endDate.toISOString().split("T")[0];
                            document.getElementById("endDate").value = formatted;
                        }

                        function validateBookingForm() {
                            const start = document.getElementById("startDate").value;
                            const end = document.getElementById("endDate").value;

                            if (!start || !end) {
                                alert("Vui lòng chọn ngày bắt đầu và thời gian thuê.");
                                return false;
                            }

                            const today = new Date().toISOString().split("T")[0];
                            if (start < today) {
                                alert("Ngày bắt đầu không được nhỏ hơn hôm nay.");
                                return false;
                            }

                            return true;
                        }
                    </script>
                </c:when>
                <c:otherwise>
                    <p class="no-bed-message">Không tìm thấy thông tin giường cần đăng ký.</p>
                </c:otherwise>
            </c:choose>


            <a href="${pageContext.request.contextPath}/room" class="back-btn">← Quay lại danh sách phòng</a>
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
