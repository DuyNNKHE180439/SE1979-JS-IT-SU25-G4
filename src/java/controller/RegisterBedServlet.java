package controller;

import dao.BedDAO;
import dao.RoomDAO;
import dao.RegistrationDAO;
import dao.StudentDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;
import model.Bed;
import model.Room;
import model.User;

@WebServlet(name = "RegisterBedServlet", urlPatterns = {"/register-bed"})
public class RegisterBedServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int bedId = Integer.parseInt(req.getParameter("bedId"));
            Bed bed = BedDAO.getBedById(bedId);
            Room room = RoomDAO.getRoomByID(bed.getRoomID());

            req.setAttribute("bed", bed);
            req.setAttribute("room", room);
            RequestDispatcher rd = req.getRequestDispatcher("view/registerBed.jsp");
            rd.forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("room");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect("Login");
            return;
        }

        try {
            int userId = user.getUserId();
            int studentId = StudentDAO.getStudentIdByUserId(userId);

            int bedId = Integer.parseInt(req.getParameter("bedId"));
            int roomId = Integer.parseInt(req.getParameter("roomId"));
            Timestamp startDate = Timestamp.valueOf(req.getParameter("startDate") + " 00:00:00");
            Timestamp endDate = Timestamp.valueOf(req.getParameter("endDate") + " 00:00:00");

            boolean success = RegistrationDAO.registerBed(studentId, roomId, bedId, startDate, endDate);

            if (success) {
                req.setAttribute("message", "Đăng ký giường thành công!");
            } else {
                req.setAttribute("error", "Đăng ký thất bại. Giường đã được đăng ký hoặc có lỗi xảy ra.");
            }

            // Refresh lại dữ liệu phòng và giường
            Bed bed = BedDAO.getBedById(bedId);
            Room room = RoomDAO.getRoomByID(roomId);
            req.setAttribute("bed", bed);
            req.setAttribute("room", room);

            req.getRequestDispatcher("view/registerBed.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi trong quá trình đăng ký.");
            req.getRequestDispatcher("room").forward(req, resp);
        }
    }
}
