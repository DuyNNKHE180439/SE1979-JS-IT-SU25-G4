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

        // ==== Lấy thông tin người dùng ====
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phoneNumber");
        String dob = request.getParameter("dateOfBirth");
        String roleIdRaw = request.getParameter("roleId");
        String studentCode = request.getParameter("studentCode");
        String existingImagePath = request.getParameter("existingImagePath");

        int roleId = (roleIdRaw != null && !roleIdRaw.isEmpty()) ? Integer.parseInt(roleIdRaw) : 0;

        // ==== Xử lý ảnh (ưu tiên ảnh mới, nếu không có thì giữ ảnh cũ) ====
        String imagePath = null;
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
        } else {
            // Nếu không upload ảnh mới thì giữ ảnh cũ
            imagePath = existingImagePath;
        }

        // ==== Khởi tạo đối tượng User ====
        User user = new User();
        user.setUserName(username);
        user.setPassWord(password);
        user.setEmail(email);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setGender(gender);
        user.setPhoneNumber(phone);
        user.setDateOfBirth(dob);
        user.setRoleId(roleId);
        user.setImagePath(imagePath); // gán ảnh xử lý ở trên

        boolean hasError = false;

        // ==== Validate ====
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("usernameError", "Tên đăng nhập không được để trống.");
            hasError = true;
        } else if (username.length() < 4) {
            request.setAttribute("usernameError", "Tên đăng nhập phải có ít nhất 4 ký tự.");
            hasError = true;
        } else if (dao.checkUsernameExists(username)) {
            request.setAttribute("usernameError", "Tên đăng nhập đã tồn tại.");
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
            request.setAttribute("emailError", "Email đã tồn tại.");
            hasError = true;
        }

        if (phone != null && !phone.trim().isEmpty() && !phone.matches("^0\\d{9}$")) {
            request.setAttribute("phoneError", "Số điện thoại phải gồm 10 chữ số và bắt đầu bằng 0.");
            hasError = true;
        }

        if (roleId == 2) {
            if (studentCode == null || studentCode.trim().isEmpty()) {
                request.setAttribute("studentCodeError", "Mã sinh viên không được để trống.");
                hasError = true;
            } else if (dao.checkStudentCodeExists(studentCode)) {
                request.setAttribute("studentCodeError", "Mã sinh viên đã tồn tại.");
                hasError = true;
            }
        }

        // ==== Nếu có lỗi -> quay lại form + giữ dữ liệu nhập ====
        if (hasError) {
            Student student = new Student(user, studentCode);
            request.setAttribute("student", student);
            request.getRequestDispatcher("create-student.jsp").forward(request, response);
            return;
        }

        // ==== Nếu hợp lệ -> thực hiện tạo user/student ====
        boolean success;
        if (roleId == 2) {
            success = dao.createStudent(user, studentCode);
        } else {
            success = dao.createUserOnly(user);
        }

        if (success) {
            response.sendRedirect("manage-account");
        } else {
            request.setAttribute("error", "Không thể tạo tài khoản. Vui lòng thử lại.");
            Student student = new Student(user, studentCode);
            request.setAttribute("student", student);
            request.getRequestDispatcher("create-student.jsp").forward(request, response);
        }
    }
}
