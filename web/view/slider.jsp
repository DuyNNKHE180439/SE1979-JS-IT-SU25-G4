<%-- 
    Document   : slider
    Created on : Jun 16, 2025, 5:54:36 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="sidebar" id="sidebar">
            <div class="profile">
                <table>
                    <tr>
                        <td><img src="${pageContext.request.contextPath}/images/FrogSleep.png" alt="User Avatar" /></td>
                        <td>
                            <p><span class="title">Hoang Van Dai </span></p>
                            <p><span class="title">Gender:</span> Male</p>
                            <p><span class="title">RollName:</span> HE180375</p>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="menu">
                <a href="#"><i class="fa-solid fa-house"></i> Home</a>
                <a href="#"><i class="fa-solid fa-bell"></i> News</a>
                <a href="#"><i class="fa-solid fa-clock"></i> Resident History</a>
                <a href="${pageContext.request.contextPath}/room"><i class="fa-solid fa-bed"></i> Rooms</a>
                <a href="${pageContext.request.contextPath}/register-list"><i class="fa-solid fa-file-alt"></i> Bed Request</a>
                <a href="#"><i class="fa-solid fa-plug"></i> Electricity Water Usage</a>
                <a href="#"><i class="fa-solid fa-dollar-sign"></i> Payment</a>
                <a href="#"><i class="fa-solid fa-ticket-alt"></i> Parking Ticket</a>
            </div>
            <div class="logout">
                <a href="${pageContext.request.contextPath}/Logout">Đăng xuất</a>
            </div>
        </div>
    </body>
</html>
