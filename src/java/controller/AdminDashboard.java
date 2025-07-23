/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.ReportDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import model.Room;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "AdminDashboard", urlPatterns = {"/admin-dashboard"})
public class AdminDashboard extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ReportDAO dao = new ReportDAO();
        List<Room> roomList = dao.getAllRooms();
        request.setAttribute("roomList", roomList);
        int totalRegistrations = dao.getTotalRegistrations();
        request.setAttribute("totalRegistrations", totalRegistrations);
        int totalRooms = dao.getTotalRooms();
        request.setAttribute("totalRooms", totalRooms);
        BigDecimal totalRevenue = dao.getTotalRevenue();
        request.setAttribute("totalRevenue", totalRevenue);
        int totalOccupants = dao.getTotalOccupants();
        request.setAttribute("totalOccupants", totalOccupants);

        Map<String, Integer> roleCountMap = dao.getUserCountByRole();

        request.setAttribute("roleCountMap", roleCountMap);
        Map<String, Integer> statusCounts = dao.getUserCountByStatus();
        request.setAttribute("statusCounts", statusCounts);
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
