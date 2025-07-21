package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Bed;
import model.LeaveRequest;
import model.Registration;
import model.Room;
import model.viewRegistrations;

public class RegistrationDAO {

    public static boolean registerBed(int studentId, int roomId, int bedId, Timestamp startDate, Timestamp endDate) {
        String sql = "INSERT INTO Registrations (StudentID, RoomID, BedID, StartDate, EndDate, Status) "
                + "VALUES (?, ?, ?, ?, ?, 'Pending')";
        try {
            PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setInt(2, roomId);
            ps.setInt(3, bedId);
            ps.setTimestamp(4, startDate);
            ps.setTimestamp(5, endDate);
            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<Registration> getAllRequestsWithDetails() {
        List<Registration> list = new ArrayList<>();
        String sql = "SELECT r.*, "
                + "rm.RoomNumber, rm.Capacity, rm.CurrentOccupancy, rm.Status AS RoomStatus, "
                + "b.BedNumber, b.Position, b.Price, b.Status AS BedStatus "
                + "FROM Registrations r "
                + "JOIN Rooms rm ON r.RoomID = rm.RoomID "
                + "JOIN Beds b ON r.BedID = b.BedID";

        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Registration reg = new Registration();
                reg.setRegistrationID(rs.getInt("RegistrationID"));
                reg.setStudentID(rs.getInt("StudentID"));
                reg.setRoomID(rs.getInt("RoomID"));
                reg.setBedID(rs.getInt("BedID"));
                reg.setStartDate(rs.getTimestamp("StartDate"));
                reg.setEndDate(rs.getTimestamp("EndDate"));
                reg.setStatus(rs.getString("Status"));
                reg.setApprovedBy(rs.getInt("ApprovedBy"));
                reg.setApprovedAt(rs.getTimestamp("ApprovedAt"));
                reg.setCreatedAt(rs.getTimestamp("CreatedAt"));
                reg.setUpdatedAt(rs.getTimestamp("UpdatedAt"));

                // Room details
                Room room = new Room();
                room.setRoomID(rs.getInt("RoomID"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setCapacity(rs.getInt("Capacity"));
                room.setCurrentOccupancy(rs.getInt("CurrentOccupancy"));
                room.setStatus(rs.getString("RoomStatus"));
                reg.setRoom(room);

                // Bed details
                Bed bed = new Bed();
                bed.setBedID(rs.getInt("BedID"));
                bed.setBedNumber(rs.getString("BedNumber"));
                bed.setPosition(rs.getString("Position"));
                bed.setPrice(rs.getBigDecimal("Price")); // dùng getBigDecimal
                bed.setStatus(rs.getString("BedStatus"));
                reg.setBed(bed);

                list.add(reg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static boolean deleteRegistrationById(int id) {
        String sql = "DELETE FROM Registrations WHERE RegistrationID = ?";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setInt(1, id);
            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean cancelRegistrationById(int id) {
        String sql = "UPDATE Registrations SET Status = 'Cancelled' WHERE RegistrationID = ?";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setInt(1, id);
            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<Registration> getRegistrationsByStudentId(int studentId) {
        List<Registration> list = new ArrayList<>();
        String sql = "SELECT r.*, "
                + "rm.RoomNumber, rm.Capacity, rm.CurrentOccupancy, rm.Status AS RoomStatus, "
                + "b.BedNumber, b.Position, b.Price, b.Status AS BedStatus "
                + "FROM Registrations r "
                + "JOIN Rooms rm ON r.RoomID = rm.RoomID "
                + "JOIN Beds b ON r.BedID = b.BedID "
                + "WHERE r.StudentID = ?";

        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Registration reg = new Registration();
                reg.setRegistrationID(rs.getInt("RegistrationID"));
                reg.setStudentID(rs.getInt("StudentID"));
                reg.setRoomID(rs.getInt("RoomID"));
                reg.setBedID(rs.getInt("BedID"));
                reg.setStartDate(rs.getTimestamp("StartDate"));
                reg.setEndDate(rs.getTimestamp("EndDate"));
                reg.setStatus(rs.getString("Status"));
                reg.setApprovedBy(rs.getInt("ApprovedBy"));
                reg.setApprovedAt(rs.getTimestamp("ApprovedAt"));
                reg.setCreatedAt(rs.getTimestamp("CreatedAt"));
                reg.setUpdatedAt(rs.getTimestamp("UpdatedAt"));

                // room
                Room room = new Room();
                room.setRoomID(rs.getInt("RoomID"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setCapacity(rs.getInt("Capacity"));
                room.setCurrentOccupancy(rs.getInt("CurrentOccupancy"));
                room.setStatus(rs.getString("RoomStatus"));
                reg.setRoom(room);

                // bed
                Bed bed = new Bed();
                bed.setBedID(rs.getInt("BedID"));
                bed.setBedNumber(rs.getString("BedNumber"));
                bed.setPosition(rs.getString("Position"));
                bed.setPrice(rs.getBigDecimal("Price"));
                bed.setStatus(rs.getString("BedStatus"));
                reg.setBed(bed);

                list.add(reg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static Registration getRegistrationById(int id) {
        String sql = "SELECT r.*, "
                + "       rm.RoomNumber, rm.Capacity, rm.CurrentOccupancy, rm.Status AS RoomStatus, "
                + "       b.BedNumber, b.Position, b.Price, b.Status AS BedStatus "
                + "FROM Registrations r "
                + "JOIN Rooms rm ON r.RoomID = rm.RoomID "
                + "JOIN Beds b ON r.BedID = b.BedID "
                + "WHERE r.RegistrationID = ?";

        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Registration reg = new Registration();
                reg.setRegistrationID(rs.getInt("RegistrationID"));
                reg.setStudentID(rs.getInt("StudentID"));
                reg.setRoomID(rs.getInt("RoomID"));
                reg.setBedID(rs.getInt("BedID"));
                reg.setStartDate(rs.getTimestamp("StartDate"));
                reg.setEndDate(rs.getTimestamp("EndDate"));
                reg.setStatus(rs.getString("Status"));

                Room room = new Room();
                room.setRoomID(rs.getInt("RoomID"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setCapacity(rs.getInt("Capacity"));
                room.setCurrentOccupancy(rs.getInt("CurrentOccupancy"));
                room.setStatus(rs.getString("RoomStatus"));
                reg.setRoom(room);

                Bed bed = new Bed();
                bed.setBedID(rs.getInt("BedID"));
                bed.setBedNumber(rs.getString("BedNumber"));
                bed.setPosition(rs.getString("Position"));
                bed.setPrice(rs.getBigDecimal("Price"));
                bed.setStatus(rs.getString("BedStatus"));
                reg.setBed(bed);

                return reg;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean updateRegistration(int id, Timestamp start, Timestamp end) {
        String sql = "UPDATE Registrations SET StartDate = ?, EndDate = ?, UpdatedAt = CURRENT_TIMESTAMP WHERE RegistrationID = ?";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql)) {
            ps.setTimestamp(1, start);
            ps.setTimestamp(2, end);
            ps.setInt(3, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<viewRegistrations> getAllPendingRegistration() {
        List<viewRegistrations> list = new ArrayList<>();
        String sql = """
                     SELECT * FROM dbo.Registrations JOIN dbo.Rooms ON Rooms.RoomID = Registrations.RoomID 
                     JOIN dbo.Beds ON Beds.BedID = Registrations.BedID 
                     JOIN dbo.Students ON Students.StudentID = Registrations.StudentID 
                     JOIN dbo.Users ON Users.UserID = Students.UserID
                     WHERE Registrations.Status='Pending'
                     """;

        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                viewRegistrations reg = new viewRegistrations();
                reg.setReId(rs.getInt("RegistrationID"));
                reg.setStuName(rs.getString("FirstName") + " " + rs.getString("LastName"));
                reg.setRoomName(rs.getString("RoomNumber"));
                reg.setBedName(rs.getString("BedNumber"));
                reg.setPosition(rs.getString("Position"));
                reg.setPrice(rs.getDouble("Price"));
                reg.setTotal(rs.getInt("Capacity"));
                reg.setCurrent(rs.getInt("CurrentOccupancy"));
                reg.setRegiDate(rs.getString("RegistrationDate").substring(0, 10));
                reg.setStartDate(rs.getString("StartDate").substring(0, 10));
                reg.setEndDate(rs.getString("EndDate").substring(0, 10));
                list.add(reg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void updateRegistrationByApprove(int regeId,int userId ,String status) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "UPDATE dbo.Registrations \n"
                    + "SET Status = ?, \n"
                    + "    ApprovedBy = ?, \n"
                    + "    ApprovedAt = GETDATE() \n"
                    + "WHERE RegistrationID = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, userId);
            statement.setInt(3, regeId);
            statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static boolean addLeaveRequest(LeaveRequest leave) {
        String sql = """
                     INSERT dbo.LeaveRequests
                     (
                         StudentID,
                         Reason,
                         RegistrationID
                     )
                     VALUES
                     (?,?,?)
                     """;
        try {
            PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql);
            ps.setInt(1, leave.getStuId());
            ps.setString(2, leave.getReason());
            ps.setInt(3, leave.getRegisId());
            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
