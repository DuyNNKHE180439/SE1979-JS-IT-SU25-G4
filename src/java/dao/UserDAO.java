/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

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
}
