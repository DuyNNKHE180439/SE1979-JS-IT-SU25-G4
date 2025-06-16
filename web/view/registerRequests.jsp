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
                    "lengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]] // 👈 Dropdown option
                });
            });
        </script>
    </body>
</html>