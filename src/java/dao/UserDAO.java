/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Address;
import model.User;
import java.sql.Connection;

/**
 *
 * @author Admin
 */
public class UserDAO {

    public static User getUserByLoginIdAndPassword(String loginId, String password) {
        DBContext db = DBContext.getInstance();
        User user = null;

        try {
            String sql = """
                        SELECT * FROM Users WHERE (Email = ? OR Username = ?) AND Password = ?
                        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, loginId);
            statement.setString(2, loginId);
            statement.setString(3, password);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setUserName(rs.getString("Username"));
                user.setPassWord(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setRoleId(rs.getInt("RoleID"));
                user.setStatus(rs.getString("Status"));
                user.setFirstName(rs.getString("FirstName"));
                user.setLastName(rs.getString("LastName"));
                user.setDateOfBirth(rs.getString("DateOfBirth"));
                user.setGender(rs.getString("Gender"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setAddressId(rs.getInt("AddressID"));
                user.setCreatedAt(rs.getString("CreatedAt"));
                user.setUpdatedAt(rs.getString("UpdatedAt"));

            }
            return user;
        } catch (Exception e) {
            return null;
        }
    }

    public static User getUserByEmail(String email) {
        DBContext db = DBContext.getInstance();
        User user = null;

        try {
            String sql = """
                        SELECT * FROM Users WHERE Email = ? 
                        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setUserName(rs.getString("Username"));
                user.setPassWord(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setRoleId(rs.getInt("RoleID"));
                user.setStatus(rs.getString("Status"));
                user.setFirstName(rs.getString("FirstName"));
                user.setLastName(rs.getString("LastName"));
                user.setDateOfBirth(rs.getString("DateOfBirth"));
                user.setGender(rs.getString("Gender"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setAddressId(rs.getInt("AddressID"));
                user.setCreatedAt(rs.getString("CreatedAt"));
                user.setUpdatedAt(rs.getString("UpdatedAt"));

            }
            return user;
        } catch (Exception e) {
            return null;
        }
    }

    public static User getUserById(int id) {
        DBContext db = DBContext.getInstance();
        User user = null;

        try {
            String sql = """
                        SELECT* FROM dbo.Users WHERE UserID=?
                        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setUserName(rs.getString("Username"));
                user.setPassWord(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setRoleId(rs.getInt("RoleID"));
                user.setStatus(rs.getString("Status"));
                user.setFirstName(rs.getString("FirstName"));
                user.setLastName(rs.getString("LastName"));
                user.setDateOfBirth(rs.getString("DateOfBirth"));
                user.setGender(rs.getString("Gender"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setAddressId(rs.getInt("AddressID"));
                user.setCreatedAt(rs.getString("CreatedAt"));
                user.setUpdatedAt(rs.getString("UpdatedAt"));

            }
            return user;
        } catch (Exception e) {
            return null;
        }
    }

    public static User registerUser(User user, Address address) {
        DBContext db = DBContext.getInstance();
        User registeredUser = null;
        Connection conn = null;

        try {
            conn = db.getConnection();
            conn.setAutoCommit(false); // Bắt đầu transaction

            // 1. Insert Address
            String sqlAddress = """
            INSERT INTO dbo.Addresses (Street, Ward, District, Province)
            VALUES (?, ?, ?, ?)
        """;

            int addressId = -1;
            try (PreparedStatement psAddress = conn.prepareStatement(sqlAddress, Statement.RETURN_GENERATED_KEYS)) {
                psAddress.setString(1, address.getStreet());
                psAddress.setString(2, address.getWard());
                psAddress.setString(3, address.getDistrict());
                psAddress.setString(4, address.getProvince());

                psAddress.executeUpdate();

                ResultSet rs = psAddress.getGeneratedKeys();
                if (rs.next()) {
                    addressId = rs.getInt(1);
                } else {
                    conn.rollback();
                    return null;
                }
            }

            // 2. Insert User
            String sqlUser = """
            INSERT INTO dbo.Users (
                Username, Password, Email, RoleID, Status,
                FirstName, LastName, DateOfBirth, Gender,
                PhoneNumber, AddressID, CreatedAt, UpdatedAt
            ) VALUES (?, ?, ?, 2, DEFAULT, ?, ?, ?, ?, ?, ?, DEFAULT, DEFAULT)
        """;

            int userId = -1;
            try (PreparedStatement psUser = conn.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS)) {
                psUser.setString(1, user.getUserName());
                psUser.setString(2, user.getPassWord());
                psUser.setString(3, user.getEmail());
                psUser.setString(4, user.getFirstName());
                psUser.setString(5, user.getLastName());
                psUser.setString(6, user.getDateOfBirth());
                psUser.setString(7, user.getGender());
                psUser.setString(8, user.getPhoneNumber());
                psUser.setInt(9, addressId);

                psUser.executeUpdate();

                ResultSet rsUser = psUser.getGeneratedKeys();
                if (rsUser.next()) {
                    userId = rsUser.getInt(1);
                } else {
                    conn.rollback();
                    return null;
                }
            }

            // Commit transaction
            conn.commit();

            // Gán ID vào object và trả kết quả
            user.setUserId(userId);
            user.setAddressId(addressId);
            registeredUser = user;

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return registeredUser;
    }

    public static User getUserByUserName(String userName) {
        DBContext db = DBContext.getInstance();
        User user = null;

        try {
            String sql = """
                        SELECT * FROM Users WHERE Username = ? 
                        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, userName);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setUserName(rs.getString("Username"));
                user.setPassWord(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setRoleId(rs.getInt("RoleID"));
                user.setStatus(rs.getString("Status"));
                user.setFirstName(rs.getString("FirstName"));
                user.setLastName(rs.getString("LastName"));
                user.setDateOfBirth(rs.getString("DateOfBirth"));
                user.setGender(rs.getString("Gender"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setAddressId(rs.getInt("AddressID"));
                user.setCreatedAt(rs.getString("CreatedAt"));
                user.setUpdatedAt(rs.getString("UpdatedAt"));

            }
            return user;
        } catch (Exception e) {
            return null;
        }
    }

    public static User getUserByPhoneNumber(String phoneNumber) {
        DBContext db = DBContext.getInstance();
        User user = null;

        try {
            String sql = """
                        SELECT * FROM Users WHERE PhoneNumber = ? 
                        """;
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, phoneNumber);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("UserID"));
                user.setUserName(rs.getString("Username"));
                user.setPassWord(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setRoleId(rs.getInt("RoleID"));
                user.setStatus(rs.getString("Status"));
                user.setFirstName(rs.getString("FirstName"));
                user.setLastName(rs.getString("LastName"));
                user.setDateOfBirth(rs.getString("DateOfBirth"));
                user.setGender(rs.getString("Gender"));
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setAddressId(rs.getInt("AddressID"));
                user.setCreatedAt(rs.getString("CreatedAt"));
                user.setUpdatedAt(rs.getString("UpdatedAt"));

            }
            return user;
        } catch (Exception e) {
            return null;
        }
    }

    public static void updatePassword(String email, String password) {
        DBContext db = DBContext.getInstance();
        String sql = "UPDATE dbo.Users SET Password=? WHERE Email=?";
        try {
            PreparedStatement st = db.getConnection().prepareStatement(sql);
            st.setString(1, password);
            st.setString(2, email);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

}
