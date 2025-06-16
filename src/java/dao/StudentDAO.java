/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;

/**
 *
 * @author ADMIN
 */
public class StudentDAO {
    public static int getStudentIdByUserId(int userId) {
        try {
            String sql = "SELECT StudentID FROM Students WHERE UserID = ?";
            PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("StudentID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}
