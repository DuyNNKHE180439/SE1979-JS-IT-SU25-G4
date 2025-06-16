package controller;

import dao.RegistrationDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "DeleteRequestServlet", urlPatterns = {"/delete-request"})
public class DeleteRequestServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int regId = Integer.parseInt(request.getParameter("requestId"));
        boolean deleted = RegistrationDAO.deleteRegistrationById(regId);
        if (deleted) {
            request.setAttribute("successMessage", "Xóa yêu cầu thành công!");
        } else {
            request.setAttribute("errorMessage", "Không thể xóa yêu cầu!");
        }

        request.getRequestDispatcher("register-list").forward(request, response);
    }
}
