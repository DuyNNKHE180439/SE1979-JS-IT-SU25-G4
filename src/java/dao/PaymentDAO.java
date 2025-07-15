/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import model.Payment;

/**
 *
 * @author Admin
 */
public class PaymentDAO {

    public static int insertPayment(Payment payment) {

        String sql = "INSERT INTO dbo.Payments\n"
                + "(\n"
                + "    UserID,\n"
                + "    Amount,\n"
                + "    RegistrationID\n"
                + ")\n"
                + "VALUES\n"
                + "(?, ?,?)";
        try {
            PreparedStatement st = DBContext.getInstance().getConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setInt(1, payment.getUserId());
            st.setDouble(2, payment.getAmount());
            st.setInt(3, payment.getRegisId());
            int affectedRows = st.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating payment failed, no rows affected.");
            }
            try (ResultSet generatedKeys = st.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating payment failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
            return -1;
        }
    }

    public static boolean updatePaymentAndRegistrationStatus(String status, int regisId, int paymentId) {
        String updatePaymentSQL = "UPDATE dbo.Payments SET Status=? WHERE PaymentID=?";
        String updateRegistrationSQL = "UPDATE dbo.Registrations SET Status=? WHERE RegistrationID=?";

        PreparedStatement psPayment = null;
        PreparedStatement psRegistration = null;

        try {

            DBContext.getInstance().getConnection().setAutoCommit(false); // Bắt đầu transaction

            // UPDATE bảng Payments
            psPayment = DBContext.getInstance().getConnection().prepareStatement(updatePaymentSQL);
            psPayment.setString(1, status);
            psPayment.setInt(2, paymentId);
            psPayment.executeUpdate();

            // UPDATE bảng Registrations
            psRegistration = DBContext.getInstance().getConnection().prepareStatement(updateRegistrationSQL);
            psRegistration.setString(1, status);
            psRegistration.setInt(2, regisId);
            psRegistration.executeUpdate();

            DBContext.getInstance().getConnection().commit(); // Nếu không lỗi → commit
            return true;

        } catch (SQLException ex) {
            System.out.println("Lỗi khi update payment hoặc registration: " + ex);  // In lỗi ra console
            try {
                if (DBContext.getInstance().getConnection() != null) {
                    DBContext.getInstance().getConnection().rollback(); // Rollback khi có lỗi
                }
            } catch (SQLException rollbackEx) {
                System.out.println("Rollback thất bại: " + rollbackEx);
            }
        } finally {
            try {
                if (psPayment != null) {
                    psPayment.close();
                }
                if (psRegistration != null) {
                    psRegistration.close();
                }
                if (DBContext.getInstance().getConnection() != null) {
                    DBContext.getInstance().getConnection().setAutoCommit(true); // Đặt lại trạng thái
                    DBContext.getInstance().getConnection().close();
                }
            } catch (SQLException closeEx) {
                System.out.println("Lỗi khi đóng tài nguyên: " + closeEx);
            }
        }

        return false;
    }
}
