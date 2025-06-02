/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.TokenForgetPassword;
import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author Admin
 */
public class TokenForgetDAO {

    public String getFormatDate(LocalDateTime myDateObj) {
        DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedDate = myDateObj.format(myFormatObj);
        return formattedDate;
    }

    public boolean insertTokenForget(TokenForgetPassword tokenForget) {
        DBContext db = DBContext.getInstance();
        String sql = """
                     INSERT INTO dbo.PasswordResetTokens
                     (
                         UserID,
                         Token,
                         ExpiryDate,
                         IsUsed
                     )
                     VALUES
                     ( ?, ?, ?, ? )
                     """;
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setString(2, tokenForget.getToken());
            ps.setTimestamp(3, Timestamp.valueOf(getFormatDate(tokenForget.getExpiryDate())));
            ps.setBoolean(4, tokenForget.isIsUsed());
            ps.setInt(1, tokenForget.getUserId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public static TokenForgetPassword getTokenPassword(String token) {
        DBContext db = DBContext.getInstance();
        String sql = """
                     SELECT * FROM dbo.PasswordResetTokens WHERE Token=?
                     """;
        try {
            PreparedStatement st = db.getConnection().prepareStatement(sql);
            st.setString(1, token);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return new TokenForgetPassword(rs.getInt("TokenID"),
                        rs.getInt("UserID"),
                        rs.getString("Token"),
                        rs.getTimestamp("ExpiryDate").toLocalDateTime(),
                        rs.getBoolean("IsUsed"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public static void updateStatus(TokenForgetPassword token) {
        DBContext db = DBContext.getInstance();
        System.out.println("token = "+token);
        String sql = "UPDATE dbo.PasswordResetTokens SET IsUsed=? WHERE Token =?";
        try {
            PreparedStatement st = db.getConnection().prepareStatement(sql);
            st.setBoolean(1, token.isIsUsed());
            st.setString(2, token.getToken());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
