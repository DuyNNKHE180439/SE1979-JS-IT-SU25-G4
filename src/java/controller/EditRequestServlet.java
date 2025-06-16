package controller;

import dao.RegistrationDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Registration;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet(name = "EditRequestServlet", urlPatterns = {"/edit-request"})
public class EditRequestServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int regId = Integer.parseInt(request.getParameter("requestId"));
        Registration reg = RegistrationDAO.getRegistrationById(regId);
        request.setAttribute("registration", reg);
        request.getRequestDispatcher("view/editRegistration.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int regId = Integer.parseInt(request.getParameter("registrationID"));
        Timestamp startDate = Timestamp.valueOf(request.getParameter("startDate") + " 00:00:00");
        Timestamp endDate = Timestamp.valueOf(request.getParameter("endDate") + " 00:00:00");

        boolean success = RegistrationDAO.updateRegistration(regId, startDate, endDate);
        if (success) {
            request.setAttribute("successMessage", "Cập nhật thành công!");
        } else {
            request.setAttribute("errorMessage", "Cập nhật thất bại!");
        }

        request.getRequestDispatcher("register-list").forward(request, response);
    }
}
