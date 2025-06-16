package controller;

import dao.RegistrationDAO;
import dao.StudentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Registration;
import model.User;

@WebServlet(name = "RegisterListServlet", urlPatterns = {"/register-list"})
public class RegisterListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login");
            return;
        }

        try {
            int studentId = StudentDAO.getStudentIdByUserId(user.getUserId());

            List<Registration> registrations = RegistrationDAO.getRegistrationsByStudentId(studentId);
            request.setAttribute("registrations", registrations);

            // Trả về view để hiển thị danh sách đăng ký
            request.getRequestDispatcher("view/registerRequests.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải danh sách đăng ký.");
            request.getRequestDispatcher("view/registerRequests.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Có thể xử lý POST giống GET nếu cần
    }

    @Override
    public String getServletInfo() {
        return "Hiển thị danh sách đăng ký của người dùng hiện tại";
    }
}
