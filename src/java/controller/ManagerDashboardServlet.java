package controller;

import dao.ReportDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Revenue;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import model.Room;

@WebServlet(name = "ManagerDashboardServlet", urlPatterns = {"/manager-dashboard"})
public class ManagerDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ReportDAO dao = new ReportDAO();

        // Doanh thu theo tháng
        List<Revenue> revenueList = dao.getMonthlyRevenue();
        request.setAttribute("revenueList", revenueList);

        // Trạng thái yêu cầu
        int completed = dao.getCompletedCount();   // Gồm cả Complete + Expired
        int rejected = dao.getRejectedCount();     // Gồm trạng thái Rejected
        int total = completed + rejected;

        // Tính phần trăm
        double percentCompleted = total == 0 ? 0 : (completed * 100.0) / total;
        double percentRejected = total == 0 ? 0 : (rejected * 100.0) / total;
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

        // Truyền sang JSP
        request.setAttribute("completedCount", completed);
        request.setAttribute("rejectedCount", rejected);
        request.setAttribute("percentCompleted", String.format("%.1f", percentCompleted));
        request.setAttribute("percentRejected", String.format("%.1f", percentRejected));

        // Chuyển tiếp tới dashboard
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for manager dashboard with monthly revenue and request stats.";
    }
}
