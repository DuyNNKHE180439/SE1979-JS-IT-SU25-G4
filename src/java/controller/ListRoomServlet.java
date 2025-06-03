package controller;

import dao.RoomDAO;
import model.Room;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/rooms")
public class ListRoomServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listRooms(request, response);
                break;
            case "view":
                viewRoom(request, response);
                break;
            case "create":
                showCreateForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            default:
                listRooms(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "create":
                createRoom(request, response);
                break;
            case "edit":
                updateRoom(request, response);
                break;
            default:
                response.sendRedirect("rooms?action=list");
        }
    }

    private void listRooms(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Room> roomList = RoomDAO.getAllRooms();
        request.setAttribute("roomList", roomList);
        request.getRequestDispatcher("ListRoom.jsp").forward(request, response);
    }

    private void viewRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roomIDStr = request.getParameter("roomID");
        if (roomIDStr == null) {
            response.sendRedirect("rooms?action=list");
            return;
        }

        try {
            int roomID = Integer.parseInt(roomIDStr);
            Room room = RoomDAO.getRoomByID(roomID);
            if (room == null) {
                response.sendRedirect("rooms?action=list");
                return;
            }

            request.setAttribute("room", room);
            request.getRequestDispatcher("/WEB-INF/views/room-view.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("rooms?action=list");
        }
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("roomForm.jsp").forward(request, response);
    }

    private void createRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roomNumber = request.getParameter("roomNumber");
        String capacityStr = request.getParameter("capacity");
        String occupancyStr = request.getParameter("currentOccupancy");
        String status = request.getParameter("status");

        int capacity = 0;
        Integer currentOccupancy = null;

        try {
            capacity = Integer.parseInt(capacityStr);
            if (occupancyStr != null && !occupancyStr.isEmpty()) {
                currentOccupancy = Integer.parseInt(occupancyStr);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Số lượng phải là số hợp lệ");
            request.getRequestDispatcher("roomForm.jsp").forward(request, response);
            return;
        }

        Room room = new Room();
        room.setRoomNumber(roomNumber);
        room.setCapacity(capacity);
        room.setCurrentOccupancy(currentOccupancy);
        room.setStatus(status);

        boolean success = RoomDAO.createRoom(room);
        if (success) {
            response.sendRedirect("rooms?action=list");
        } else {
            request.setAttribute("error", "Tạo phòng thất bại");
            request.getRequestDispatcher("roomForm.jsp").forward(request, response);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roomIDStr = request.getParameter("roomID");
        if (roomIDStr == null) {
            response.sendRedirect("rooms?action=list");
            return;
        }

        try {
            int roomID = Integer.parseInt(roomIDStr);
            Room room = RoomDAO.getRoomByID(roomID);
            if (room == null) {
                response.sendRedirect("rooms?action=list");
                return;
            }

            request.setAttribute("room", room);
            request.getRequestDispatcher("roomForm.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("rooms?action=list");
        }
    }

    private void updateRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String roomIDStr = request.getParameter("roomID");
        String roomNumber = request.getParameter("roomNumber");
        String capacityStr = request.getParameter("capacity");
        String occupancyStr = request.getParameter("currentOccupancy");
        String status = request.getParameter("status");

        int capacity = 0;
        Integer currentOccupancy = null;
        int roomID;

        try {
            roomID = Integer.parseInt(roomIDStr);
            capacity = Integer.parseInt(capacityStr);
            if (occupancyStr != null && !occupancyStr.isEmpty()) {
                currentOccupancy = Integer.parseInt(occupancyStr);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Số lượng phải là số hợp lệ");
            request.getRequestDispatcher("roomForm.jsp").forward(request, response);
            return;
        }

        Room room = new Room();
        room.setRoomID(roomID);
        room.setRoomNumber(roomNumber);
        room.setCapacity(capacity);
        room.setCurrentOccupancy(currentOccupancy);
        room.setStatus(status);

        boolean success = RoomDAO.updateRoom(room);
        if (success) {
            response.sendRedirect("rooms?action=list");
        } else {
            request.setAttribute("error", "Cập nhật phòng thất bại");
            request.getRequestDispatcher("roomForm.jsp").forward(request, response);
        }
    }

}
