package controller;

import dao.StudentDAO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Student;
import model.User;

@WebServlet(name = "EditStudentServlet", urlPatterns = {"/edit-student"})
@MultipartConfig
public class EditStudentServlet extends HttpServlet {

    private final StudentDAO dao = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("userID"));
            Student student = dao.getStudentByUserId(userId);

            if (student != null) {
                request.setAttribute("student", student);
                request.getRequestDispatcher("edit-student.jsp").forward(request, response);
            } else {
                response.sendRedirect("manage-account");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("manage-account");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        int userId = Integer.parseInt(request.getParameter("userID"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phoneNumber");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String studentCode = request.getParameter("studentCode");

        Student existingStudent = dao.getStudentByUserId(userId);
        String imagePath = existingStudent.getUser().getImagePath();

        
        Part imagePart = request.getPart("imagePath");
        if (imagePart != null && imagePart.getSize() > 0) {
            String fileName = UUID.randomUUID().toString() + "_" + Paths.get(imagePart.getSubmittedFileName()).getFileName();
            String uploadPath = getServletContext().getRealPath("/") + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            imagePart.write(uploadPath + File.separator + fileName);
            imagePath = "uploads/" + fileName;
        }

        // Tạo user object
        User user = new User();
        user.setUserId(userId);
        user.setUserName(username);
        user.setEmail(email);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setGender(gender);
        user.setPhoneNumber(phoneNumber);
        user.setDateOfBirth(dateOfBirth);
        user.setImagePath(imagePath);

        // Validate
        boolean hasError = false;

        if (dao.isEmailExistForOtherUser(email, userId)) {
            request.setAttribute("emailError", "Email đã tồn tại.");
            hasError = true;
        }

        if (dao.isStudentCodeExistForOtherUser(studentCode, userId)) {
            request.setAttribute("studentCodeError", "Mã sinh viên đã tồn tại.");
            hasError = true;
        }

        // Kiểm tra định dạng ngày
        try {
            if (dateOfBirth != null && !dateOfBirth.isEmpty()) {
                java.sql.Date.valueOf(dateOfBirth); // Sẽ lỗi nếu sai định dạng yyyy-MM-dd
            }
        } catch (Exception e) {
            request.setAttribute("dateError", "Ngày sinh không hợp lệ. Định dạng đúng: yyyy-MM-dd");
            hasError = true;
        }

        if (hasError) {
            request.setAttribute("student", existingStudent); // giữ lại dữ liệu cũ
            request.getRequestDispatcher("edit-student.jsp").forward(request, response);
            return;
        }

        // Cập nhật
        boolean updated = dao.updateStudent(user, studentCode);
        if (updated) {
            response.sendRedirect("manage-account");
        } else {
            request.setAttribute("error", "Cập nhật thất bại. Vui lòng thử lại.");
            request.setAttribute("student", existingStudent);
            request.getRequestDispatcher("edit-student.jsp").forward(request, response);
        }
    }

}
