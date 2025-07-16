package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import model.Bed;
import model.Order;
import model.ResidentHistory;

/**
 *
 * @author ADMIN
 */
public class BedDAO {

    public static List<Bed> getBedsByRoomID(int roomID) {
        DBContext db = DBContext.getInstance();
        List<Bed> bedList = new ArrayList<>();

        try {
            String sql = "SELECT * FROM Beds WHERE RoomID = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, roomID);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Bed bed = new Bed();
                bed.setBedID(rs.getInt("BedID"));
                bed.setRoomID(rs.getInt("RoomID"));
                bed.setBedNumber(rs.getString("BedNumber"));
                bed.setPosition(rs.getString("Position"));
                bed.setPrice(rs.getBigDecimal("Price"));
                bed.setStatus(rs.getString("Status"));

                bedList.add(bed);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return bedList;
    }

    public static Bed getBedById(int bedId) {
        Bed bed = null;
        try {
            DBContext db = DBContext.getInstance();
            String sql = "SELECT BedID, RoomID, BedNumber, Position, Price, Status FROM Beds WHERE BedID = ?";
            PreparedStatement ps = db.getConnection().prepareStatement(sql);
            ps.setInt(1, bedId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                bed = new Bed();
                bed.setBedID(rs.getInt("BedID"));
                bed.setRoomID(rs.getInt("RoomID"));
                bed.setBedNumber(rs.getString("BedNumber"));
                bed.setPosition(rs.getString("Position"));
                bed.setPrice(rs.getBigDecimal("Price"));
                bed.setStatus(rs.getString("Status"));
            }

            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return bed;
    }
// hàm dao lấy tất cả những request status là approve

    public static List<Order> getAllOrder() {
        List<Order> list = new ArrayList<>();
        String sql = """
                     SELECT * FROM dbo.Registrations 
                     JOIN dbo.Rooms ON Rooms.RoomID = Registrations.RoomID 
                     JOIN dbo.Beds ON Beds.BedID = Registrations.BedID 
                     WHERE Registrations.Status ='Approve'
                     """;

        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order or = new Order();
                or.setStuNum(rs.getInt("StudentID"));
                or.setRegisId(rs.getInt("RegistrationID"));
                or.setRoomNum(rs.getString("RoomNumber"));
                or.setBedNum(rs.getString("BedNumber"));
                or.setPosition(rs.getString("Position"));
                or.setRegisDate(rs.getString("RegistrationDate").substring(0, 10));
                or.setStartDate(rs.getString("StartDate").substring(0, 10));
                or.setEndDate(rs.getString("EndDate").substring(0, 10));
                or.setPrice(rs.getDouble("Price"));

                LocalDate startDate = LocalDate.parse(rs.getString("StartDate").substring(0, 10));
                LocalDate endDate = LocalDate.parse(rs.getString("EndDate").substring(0, 10));
                long months = ChronoUnit.MONTHS.between(startDate, endDate);
                double total = months * rs.getDouble("Price");
                or.setTotal(total);
                list.add(or);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static List<Order> getResidentHistory(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = """
                     SELECT * FROM dbo.Registrations 
                                          JOIN dbo.Rooms ON Rooms.RoomID = Registrations.RoomID 
                                          JOIN dbo.Beds ON Beds.BedID = Registrations.BedID 
                                          JOIN dbo.Students ON Students.StudentID = Registrations.StudentID
                     			  JOIN dbo.Users ON Users.UserID = Students.UserID
                     			 WHERE Registrations.Status='Complete' AND Students.UserID=?
                     """;

        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order or = new Order();
                or.setStuNum(rs.getInt("StudentID"));
                or.setRegisId(rs.getInt("RegistrationID"));
                or.setRoomNum(rs.getString("RoomNumber"));
                or.setBedNum(rs.getString("BedNumber"));
                or.setPosition(rs.getString("Position"));
                or.setRegisDate(rs.getString("RegistrationDate").substring(0, 10));
                or.setStartDate(rs.getString("StartDate").substring(0, 10));
                or.setEndDate(rs.getString("EndDate").substring(0, 10));
                or.setPrice(rs.getDouble("Price"));

                LocalDate startDate = LocalDate.parse(rs.getString("StartDate").substring(0, 10));
                LocalDate endDate = LocalDate.parse(rs.getString("EndDate").substring(0, 10));
                long months = ChronoUnit.MONTHS.between(startDate, endDate);
                double total = months * rs.getDouble("Price");
                or.setTotal(total);
                list.add(or);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
  

}
