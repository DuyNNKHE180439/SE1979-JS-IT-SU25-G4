package controller;

import dao.RoomDAO;
import model.Room;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "RoomServlet", urlPatterns = {"/room"})
public class RoomServlet extends HttpServlet {

    private static final int ROOMS_PER_PAGE = 6;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Get page and search parameters
            String pageParam = request.getParameter("page");
            String searchQuery = request.getParameter("search");
            int currentPage = pageParam != null ? Integer.parseInt(pageParam) : 1;
            if (currentPage < 1) currentPage = 1;

            // Get all rooms
            List<Room> allRooms = RoomDAO.getAllRooms();

            // Filter rooms based on search query
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String query = searchQuery.trim().toLowerCase();
                allRooms = allRooms.stream()
                        .filter(room -> 
                            String.valueOf(room.getRoomNumber()).toLowerCase().contains(query) ||
                            (room.getCurrentOccupancy() >= room.getCapacity() ? "full" : room.getStatus().toLowerCase()).contains(query))
                        .collect(Collectors.toList());
            }

            // Calculate pagination
            int totalRooms = allRooms.size();
            int totalPages = (int) Math.ceil((double) totalRooms / ROOMS_PER_PAGE);

            // Get rooms for current page
            int startIndex = (currentPage - 1) * ROOMS_PER_PAGE;
            int endIndex = Math.min(startIndex + ROOMS_PER_PAGE, totalRooms);
            List<Room> rooms = allRooms.subList(startIndex, endIndex);

            // Set attributes
            request.setAttribute("rooms", rooms);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);

            // Forward to JSP
            request.getRequestDispatcher("view/room.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load room list.");
            request.getRequestDispatcher("view/roomList.jsp").forward(request, response);
        }
    }
}