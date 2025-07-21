package controller;

import dao.BedDAO;
import dao.RegistrationDAO;
import dao.RoomDAO;
import model.Bed;
import model.Room;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/roomDetail")
public class RoomDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy roomId từ request
            String roomIdParam = request.getParameter("roomId");
            if (roomIdParam == null || roomIdParam.isEmpty()) {
                response.sendRedirect("bookingBed.jsp");
                return;
            }
            // Gọi cập nhật trước khi load dữ liệu
            RegistrationDAO.updateExpiredRegistrationsAndBeds();

            int roomId = Integer.parseInt(roomIdParam);

            // Lấy thông tin phòng
            Room room = RoomDAO.getRoomByID(roomId);

            // Lấy danh sách giường
            List<Bed> beds = BedDAO.getBedsByRoomID(roomId);

            // Gửi dữ liệu sang JSP
            request.setAttribute("room", room);
            request.setAttribute("beds", beds);

            // Forward đến JSP
            request.getRequestDispatcher("view/roomDetail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
