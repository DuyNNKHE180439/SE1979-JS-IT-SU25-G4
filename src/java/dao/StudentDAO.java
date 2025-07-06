package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Student;
import model.User;

public class StudentDAO {

    public Student getStudentByUserId(int userId) {
        String sql = "SELECT s.StudentID, s.UserID, s.StudentCode, u.UserName, u.Email, u.FirstName, u.LastName, u.RoomImagePath, u.Gender, u.PhoneNumber, u.Status, u.CreatedAt "
                + "FROM Students s JOIN Users u ON s.UserID = u.UserID WHERE u.UserID = ?";
        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Student student = new Student();
                    student.setStudentID(rs.getInt("StudentID"));
                    student.setUserID(rs.getInt("UserID"));
                    student.setStudentCode(rs.getString("StudentCode"));

                    User user = new User();
                    user.setUserId(rs.getInt("UserID"));
                    user.setUserName(rs.getString("UserName"));
                    user.setEmail(rs.getString("Email"));
                    user.setFirstName(rs.getString("FirstName"));
                    user.setLastName(rs.getString("LastName"));
                    user.setImagePath(rs.getString("RoomImagePath"));
                    user.setGender(rs.getString("Gender"));
                    user.setPhoneNumber(rs.getString("PhoneNumber"));
                    user.setStatus(rs.getString("Status"));
                    user.setCreatedAt(rs.getString("CreatedAt"));

                    student.setUser(user);
                    return student;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Student> getAllStudents() {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT s.StudentID, s.UserID, s.StudentCode, "
                + "u.UserName, u.Email, u.FirstName, u.LastName, u.RoomImagePath, "
                + "u.Gender, u.PhoneNumber, u.Status, u.CreatedAt "
                + "FROM Students s "
                + "JOIN Users u ON s.UserID = u.UserID "
                + "WHERE u.RoleID = 2";

        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Student student = new Student();
                student.setStudentID(rs.getInt("StudentID"));
                student.setUserID(rs.getInt("UserID"));
                student.setStudentCode(rs.getString("StudentCode"));

                User user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setUserName(rs.getString("UserName"));
                user.setEmail(rs.getString("Email"));
                user.setFirstName(rs.getString("FirstName"));
                user.setLastName(rs.getString("LastName"));
                user.setImagePath(rs.getString("RoomImagePath"));
                user.setGender(rs.getString("Gender"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setStatus(rs.getString("Status"));
                user.setCreatedAt(rs.getString("CreatedAt"));

                student.setUser(user);
                list.add(student);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static int getStudentIdByUserId(int userId) {
        String sql = "SELECT StudentID FROM Students WHERE UserID = ?";
        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("StudentID");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean createStudent(User user, String studentCode) {
        String userSql = "INSERT INTO Users (Username, Password, Email, RoleID, Status, FirstName, LastName, Gender, PhoneNumber, DateOfBirth, CreatedAt, UpdatedAt, RoomImagePath) "
                + "VALUES (?, ?, ?, 2, 'Active', ?, ?, ?, ?, ?, GETDATE(), GETDATE(), ?)";

        String studentSql = "INSERT INTO Students (UserID, StudentCode) VALUES (?, ?)";

        try (Connection conn = DBContext.getInstance().getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement userPs = conn.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS)) {
                userPs.setString(1, user.getUserName());
                userPs.setString(2, user.getPassWord());
                userPs.setString(3, user.getEmail());
                userPs.setString(4, user.getFirstName());
                userPs.setString(5, user.getLastName());
                userPs.setString(6, user.getGender());
                userPs.setString(7, user.getPhoneNumber());
                userPs.setString(8, user.getDateOfBirth());
                userPs.setString(9, user.getImagePath());

                int affected = userPs.executeUpdate();
                if (affected == 0) {
                    throw new SQLException("Không thể thêm user.");
                }

                try (ResultSet keys = userPs.getGeneratedKeys()) {
                    if (keys.next()) {
                        int userId = keys.getInt(1);

                        try (PreparedStatement studentPs = conn.prepareStatement(studentSql)) {
                            studentPs.setInt(1, userId);
                            studentPs.setString(2, studentCode);
                            studentPs.executeUpdate();
                        }
                    }
                }

                conn.commit();
                return true;

            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStudent(User user, String studentCode) {
        String userSql = "UPDATE Users SET Username = ?, Email = ?, FirstName = ?, LastName = ?, "
                + "Gender = ?, PhoneNumber = ?, DateOfBirth = ?, UpdatedAt = GETDATE(), RoomImagePath = ? "
                + "WHERE UserID = ?";

        String studentSql = "UPDATE Students SET StudentCode = ? WHERE UserID = ?";

        try (Connection conn = DBContext.getInstance().getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement userPs = conn.prepareStatement(userSql)) {
                userPs.setString(1, user.getUserName());
                userPs.setString(2, user.getEmail());
                userPs.setString(3, user.getFirstName());
                userPs.setString(4, user.getLastName());
                userPs.setString(5, user.getGender());
                userPs.setString(6, user.getPhoneNumber());
                userPs.setString(7, user.getDateOfBirth());
                userPs.setString(8, user.getImagePath());
                userPs.setInt(9, user.getUserId());
                userPs.executeUpdate();
            }

            try (PreparedStatement studentPs = conn.prepareStatement(studentSql)) {
                studentPs.setString(1, studentCode);
                studentPs.setInt(2, user.getUserId());
                studentPs.executeUpdate();
            }

            conn.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteStudent(int userId) {
        String studentSql = "DELETE FROM Students WHERE UserID = ?";
        String userSql = "DELETE FROM Users WHERE UserID = ?";

        try (Connection conn = DBContext.getInstance().getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement ps1 = conn.prepareStatement(studentSql); PreparedStatement ps2 = conn.prepareStatement(userSql)) {
                ps1.setInt(1, userId);
                ps1.executeUpdate();

                ps2.setInt(1, userId);
                ps2.executeUpdate();

                conn.commit();
                return true;

            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isStudentCodeExist(String studentCode) {
        String sql = "SELECT 1 FROM Students WHERE studentCode = ?";
        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, studentCode);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEmailExistForOtherUser(String email, int userId) {
        String sql = "SELECT 1 FROM Users WHERE Email = ? AND UserID != ?";
        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isStudentCodeExistForOtherUser(String studentCode, int userId) {
        String sql = "SELECT 1 FROM Students WHERE StudentCode = ? AND UserID != ?";
        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, studentCode);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateUserStatus(int userId, String status) {
        String sql = "UPDATE Users SET Status = ?, UpdatedAt = GETDATE() WHERE UserID = ?";
        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkUsernameExists(String username) {
        String sql = "SELECT 1 FROM Users WHERE userName = ?";
        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean checkEmailExists(String email) {
        String sql = "SELECT 1 FROM Users WHERE email = ?";
        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean checkStudentCodeExists(String studentCode) {
        String sql = "SELECT 1 FROM Students WHERE studentCode = ?";
        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, studentCode);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
