<%-- 
    Document   : slider
    Created on : Jun 16, 2025, 5:54:36 PM
    Author     : ADMIN
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="sidebar" id="sidebar">
    <div class="profile">
        <table>
            <tr>
                <td>
                    <c:choose>
                        <c:when test="${empty user.getImagePath()}">
                            <img src="${pageContext.request.contextPath}/images/FrogSleep.png" alt="Ảnh mặc định" width="150">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/${user.getImagePath()}" alt="Ảnh đại diện" width="150">
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <p><span class="title">${user.firstName} ${user.lastName}</span></p>
                    <p><span class="title">Giới tính: </span>${user.gender}</p>
                    <p><span class="title">Ngày sinh: </span>
                        <fmt:parseDate value="${user.dateOfBirth}" pattern="yyyy-MM-dd HH:mm:ss.S" var="parsedDate" />
                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                    </p>
                    <p><span class="title">SĐT: </span>${user.phoneNumber}</p>
                </td>
            </tr>
        </table>
    </div>
    <div class="menu">
        <a href="${pageContext.request.contextPath}/view/studentHome.jsp"><i class="fa-solid fa-house"></i> Trang Chủ</a>
        <a href="${pageContext.request.contextPath}/user?action=viewProfile"><i class="fa-solid fa-file-alt"></i> Thông Tin Cá Nhân</a>
        <a href="#"><i class="fa-solid fa-bell"></i> Bảng Tin</a>
        <a href="#"><i class="fa-solid fa-clock"></i> Lịch Sử Cư Trú</a>
        <a href="${pageContext.request.contextPath}/room"><i class="fa-solid fa-bed"></i> Đặt Phòng</a>
        <a href="${pageContext.request.contextPath}/register-list"><i class="fa-solid fa-file-alt"></i> Yêu Cầu Của Tôi</a>
        <a href="#"><i class="fa-solid fa-plug"></i> Điện Nước Sử Dụng</a>
        <a href="#"><i class="fa-solid fa-dollar-sign"></i> Thanh Toán</a>
    </div>
    <div class="logout">
        <a href="${pageContext.request.contextPath}/Logout">Đăng Xuất</a>
    </div>
</div>