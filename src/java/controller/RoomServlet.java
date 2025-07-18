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

    private static final int ROOMS_PER_PAGE = 8;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String pageParam = request.getParameter("page");
            String searchQuery = request.getParameter("search");
            int currentPage = pageParam != null ? Integer.parseInt(pageParam) : 1;
            if (currentPage < 1) {
                currentPage = 1;
            }

            List<Room> allRooms = RoomDAO.getAllRooms();

            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String query = searchQuery.trim();
                allRooms = allRooms.stream()
                        .filter(room -> String.valueOf(room.getRoomNumber()).contains(query))
                        .collect(Collectors.toList());
            }
            int totalRooms = allRooms.size();
            int totalPages = (int) Math.ceil((double) totalRooms / ROOMS_PER_PAGE);

            int startIndex = (currentPage - 1) * ROOMS_PER_PAGE;
            int endIndex = Math.min(startIndex + ROOMS_PER_PAGE, totalRooms);
            List<Room> rooms = allRooms.subList(startIndex, endIndex);

            request.setAttribute("rooms", rooms);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search", searchQuery);

            request.getRequestDispatcher("view/room.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load room list.");
            request.getRequestDispatcher("view/roomList.jsp").forward(request, response);
        }
    }
}
