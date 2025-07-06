package controller;

import dao.StudentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.UUID;
import model.User;
import model.Student;

@WebServlet("/create-student")
@MultipartConfig
public class CreateStudentServlet extends HttpServlet {

    private final StudentDAO dao = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("create-student.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phoneNumber");
        String dob = request.getParameter("dateOfBirth");
        String studentCode = request.getParameter("studentCode");

        boolean hasError = false;

        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("usernameError", "Tên đăng nhập không được để trống.");
            hasError = true;
        } else if (username.length() < 4) {
            request.setAttribute("usernameError", "Tên đăng nhập phải có ít nhất 4 ký tự.");
            hasError = true;
        } else if (dao.checkUsernameExists(username)) {
            request.setAttribute("usernameError", "Tên đăng nhập đã tồn tại, vui lòng chọn tên khác.");
            hasError = true;
        }

        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("passwordError", "Mật khẩu không được để trống.");
            hasError = true;
        } else if (password.length() < 6) {
            request.setAttribute("passwordError", "Mật khẩu phải có ít nhất 6 ký tự.");
            hasError = true;
        }

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("emailError", "Email không được để trống.");
            hasError = true;
        } else if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            request.setAttribute("emailError", "Email không đúng định dạng.");
            hasError = true;
        } else if (dao.checkEmailExists(email)) {
            request.setAttribute("emailError", "Email đã tồn tại, vui lòng chọn email khác.");
            hasError = true;
        }

        if (phone != null && !phone.trim().isEmpty() && !phone.matches("^0\\d{9}$")) {
            request.setAttribute("phoneError", "Số điện thoại phải gồm 10 chữ số và bắt đầu bằng 0.");
            hasError = true;
        }

        if (studentCode == null || studentCode.trim().isEmpty()) {
            request.setAttribute("studentCodeError", "Mã sinh viên không được để trống.");
            hasError = true;
        } else if (dao.checkStudentCodeExists(studentCode)) {
            request.setAttribute("studentCodeError", "Mã sinh viên đã tồn tại.");
            hasError = true;
        }

        User user = new User();
        user.setUserName(username);
        user.setPassWord(password);
        user.setEmail(email);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setGender(gender);
        user.setPhoneNumber(phone);
        user.setDateOfBirth(dob);
        user.setImagePath(null);

        Student student = new Student(user, studentCode);

        if (hasError) {
            request.setAttribute("student", student);
            request.getRequestDispatcher("create-student.jsp").forward(request, response);
            return;
        }

        Part imagePart = request.getPart("imagePath");
        if (imagePart != null && imagePart.getSize() > 0) {
            String fileName = UUID.randomUUID().toString() + "_" + Paths.get(imagePart.getSubmittedFileName()).getFileName();
            String uploadPath = getServletContext().getRealPath("/") + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            imagePart.write(uploadPath + File.separator + fileName);
            user.setImagePath("uploads/" + fileName);
        }

        boolean success = dao.createStudent(user, studentCode);
        if (success) {
            response.sendRedirect("manage-account");
        } else {
            request.setAttribute("error", "Không thể tạo tài khoản. Vui lòng thử lại.");
            request.setAttribute("student", student);
            request.getRequestDispatcher("create-student.jsp").forward(request, response);
        }
    }
}
