package controller;

import dao.StudentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Student;
import java.io.IOException;
import java.util.List;

@WebServlet("/manage-account")
public class ManageAccount extends HttpServlet {

    private final StudentDAO dao = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Student> list = dao.getAllStudents();
        System.out.println("Size = " + list.size());
        request.setAttribute("studentList", list);
        request.getRequestDispatcher("manage-account.jsp").forward(request, response);
    }
}
