package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.Revenue;
import model.Room;

public class ReportDAO {

    public List<Revenue> getMonthlyRevenue() {
        List<Revenue> list = new ArrayList<>();
        String sql = """
                SELECT 
                    FORMAT(r.StartDate, 'yyyy-MM') AS Month,
                    SUM(b.Price) AS Revenue
                FROM 
                    Registrations r
                JOIN 
                    Beds b ON r.BedID = b.BedID
                WHERE 
                    r.Status IN ('Complete', 'Expired') AND r.StartDate IS NOT NULL
                GROUP BY 
                    FORMAT(r.StartDate, 'yyyy-MM')
                ORDER BY 
                    Month;
                """;

        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String month = rs.getString("Month");
                java.math.BigDecimal revenue = rs.getBigDecimal("Revenue");
                list.add(new Revenue(month, revenue));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int getCompletedCount() {
        String sql = "SELECT COUNT(*) FROM Registrations WHERE Status IN ('Complete', 'Expired')";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getRejectedCount() {
        String sql = "SELECT COUNT(*) FROM Registrations WHERE Status = 'Reject'";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Room> getAllRooms() {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT RoomID, RoomNumber, Capacity, CurrentOccupancy FROM Rooms";

        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getInt("RoomID"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setCapacity(rs.getInt("Capacity"));
                room.setCurrentOccupancy(rs.getInt("CurrentOccupancy"));
                list.add(room);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalRegistrations() {
        String sql = "SELECT COUNT(*) AS TotalRegistrations FROM Registrations";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            return rs.next() ? rs.getInt("TotalRegistrations") : 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTotalRooms() {
        String sql = "SELECT COUNT(*) AS TotalRooms FROM Rooms";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("TotalRooms");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public java.math.BigDecimal getTotalRevenue() {
        String sql = """
        SELECT SUM(b.Price) AS TotalRevenue
        FROM Registrations r
        JOIN Beds b ON r.BedID = b.BedID
        WHERE r.Status IN ('Complete', 'Expired') AND r.StartDate IS NOT NULL
    """;

        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getBigDecimal("TotalRevenue") != null ? rs.getBigDecimal("TotalRevenue") : java.math.BigDecimal.ZERO;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return java.math.BigDecimal.ZERO;
    }

    public int getTotalOccupants() {
        String sql = "SELECT SUM(CurrentOccupancy) AS TotalOccupants FROM Rooms";
        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("TotalOccupants");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Map<String, Integer> getUserCountByRole() {
        Map<String, Integer> roleCounts = new LinkedHashMap<>();
        String sql = """
        SELECT r.RoleName, COUNT(u.UserID) AS UserCount
        FROM Users u
        JOIN Roles r ON u.RoleID = r.RoleID
        GROUP BY r.RoleName
        ORDER BY r.RoleName
    """;

        try (PreparedStatement ps = DBContext.getInstance().getConnection().prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                roleCounts.put(rs.getString("RoleName"), rs.getInt("UserCount"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return roleCounts;
    }

    public Map<String, Integer> getUserCountByStatus() {
        Map<String, Integer> statusCounts = new LinkedHashMap<>();
        String sql = "SELECT Status, COUNT(*) AS Count FROM Users GROUP BY Status";

        try (Connection conn = DBContext.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                statusCounts.put(rs.getString("Status"), rs.getInt("Count"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return statusCounts;
    }

}
