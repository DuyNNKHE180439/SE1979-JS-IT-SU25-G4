<%-- 
    Document   : registrationList
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
        <!-- DataTables CSS -->
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" />

        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <!-- DataTables JS -->
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
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

            .main .registrations-table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                background-color: #ffffff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                margin-bottom: 24px;
            }

            .main .registrations-table th,
            .main .registrations-table td {
                padding: 14px 16px;
                text-align: left;
                font-size: 0.9rem;
                color: #4a5568;
                border-right: 1px solid #edf2f7;
                border-bottom: 1px solid #edf2f7;
                transition: background-color 0.2s ease;
            }

            .main .registrations-table th:last-child,
            .main .registrations-table td:last-child {
                border-right: none;
            }

            .main .registrations-table tr:last-child td {
                border-bottom: none;
            }

            .main .registrations-table th {
                background-color: #2b6cb0;
                color: #ffffff;
                font-weight: 600;
                position: sticky;
                top: 0;
                z-index: 10;
            }

            .main .registrations-table tr:nth-child(even) {
                background-color: #f9fafb;
            }

            .main .registrations-table tr:hover {
                background-color: #e6f0fa;
                transform: scale(1.01);
                transition: transform 0.2s ease, background-color 0.2s ease;
            }

            .main .registrations-table td:hover {
                background-color: #d1e7ff;
            }

            .main .registrations-table .action-btn {
                padding: 8px 16px;
                border: none;
                border-radius: 6px;
                font-size: 0.85rem;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.2s ease, transform 0.2s ease;
            }

            .main .registrations-table .action-btn:hover {
                transform: translateY(-2px);
            }

            .main .registrations-table .edit-btn {
                background-color: #3182ce;
                color: #ffffff;
                margin-right: 8px;
            }

            .main .registrations-table .edit-btn:hover {
                background-color: #2b6cb0;
            }

            .main .registrations-table .delete-btn {
                background-color: #e53e3e;
                color: #ffffff;
            }

            .main .registrations-table .delete-btn:hover {
                background-color: #c53030;
            }

            .main .no-registrations {
                font-size: 0.95rem;
                color: #718096;
                margin-top: 24px;
                text-align: center;
                padding: 16px;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
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

                .main .registrations-table {
                    font-size: 0.85rem;
                }

                .main .registrations-table th,
                .main .registrations-table td {
                    padding: 10px 12px;
                }

                .main .registrations-table .action-btn {
                    padding: 6px 12px;
                    font-size: 0.8rem;
                }
            }

            @media (max-width: 600px) {
                .main .registrations-table {
                    display: block;
                    overflow-x: auto;
                    white-space: nowrap;
                }

                .main .registrations-table th,
                .main .registrations-table td {
                    min-width: 120px;
                }

                .main .registrations-table tr:hover {
                    transform: none;
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
            <h2>Danh sách yêu cầu đăng ký giường</h2>

            <c:if test="${not empty successMessage}">
                <div class="message">${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="message error">${errorMessage}</div>
            </c:if>

            <c:choose>
                <c:when test="${not empty registrations}">
                    <table id="registrationTable" class="registrations-table">
                        <thead>
                            <tr>
                                <th>Phòng</th>
                                <th>Giường</th>
                                <th>Ngày bắt đầu</th>
                                <th>Ngày kết thúc</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="reg" items="${registrations}">
                                <tr>
                                    <td>${reg.room.roomNumber}</td>
                                    <td>${reg.bed.bedNumber}</td>
                                    <td><fmt:formatDate value="${reg.startDate}" pattern="dd/MM/yyyy"/></td>
                                    <td><fmt:formatDate value="${reg.endDate}" pattern="dd/MM/yyyy"/></td>
                                    <td>
                                        <form action="edit-request" method="get" style="display:inline;">
                                            <input type="hidden" name="requestId" value="${reg.registrationID}" />
                                            <button class="action-btn edit-btn" type="submit">Sửa</button>
                                        </form>
                                        <form action="delete-request" method="post" style="display:inline;" onsubmit="return confirm('Bạn có chắc muốn xóa yêu cầu này?');">
                                            <input type="hidden" name="requestId" value="${reg.registrationID}" />
                                            <button class="action-btn delete-btn" type="submit">Xóa</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <p class="no-registrations">Không có yêu cầu nào được tạo.</p>
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
        <script>
            $(document).ready(function () {
                $('#registrationTable').DataTable({
                    "language": {
                        "search": "Search Room:",
                        "lengthMenu": "Show _MENU_ entries per page",
                        "zeroRecords": "No matching records found",
                        "info": "Showing _START_ to _END_ of _TOTAL_ entries",
                        "infoEmpty": "No entries available",
                        "infoFiltered": "(filtered from _MAX_ total entries)",
                        "paginate": {
                            "first": "First",
                            "last": "Last",
                            "next": "Next",
                            "previous": "Previous"
                        }
                    },
                    "pagingType": "full_numbers",
                    "pageLength": 10,
                    "lengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
                });
            });
        </script>
    </body>
</html>