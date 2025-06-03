/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.ArrayList;
import java.util.List;
import model.Room;
import java.sql.*;

/**
 *
 * @author ADMIN
 */
public class RoomDAO {

    public static List<Room> getAllRooms() {
        DBContext db = DBContext.getInstance();
        List<Room> roomList = new ArrayList<>();

        try {
            String sql = "SELECT * FROM Rooms";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getInt("RoomID"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setCapacity(rs.getInt("Capacity"));

                Object occupancy = rs.getObject("CurrentOccupancy");
                room.setCurrentOccupancy(occupancy != null ? (Integer) occupancy : null);

                room.setStatus(rs.getString("Status"));
                room.setCreatedAt(rs.getTimestamp("CreatedAt"));
                room.setUpdatedAt(rs.getTimestamp("UpdatedAt"));

                roomList.add(room);
            }

            return roomList;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

// Lấy phòng theo RoomID
    public static Room getRoomByID(int roomID) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "SELECT * FROM Rooms WHERE RoomID = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, roomID);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getInt("RoomID"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setCapacity(rs.getInt("Capacity"));

                Object occupancy = rs.getObject("CurrentOccupancy");
                room.setCurrentOccupancy(occupancy != null ? (Integer) occupancy : null);

                room.setStatus(rs.getString("Status"));
                room.setCreatedAt(rs.getTimestamp("CreatedAt"));
                room.setUpdatedAt(rs.getTimestamp("UpdatedAt"));

                return room;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

// Tạo mới phòng (RoomID tự tăng nên không cần set)
    public static boolean createRoom(Room room) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "INSERT INTO Rooms (RoomNumber, Capacity, CurrentOccupancy, Status, CreatedAt, UpdatedAt) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, room.getRoomNumber());
            statement.setInt(2, room.getCapacity());
            if (room.getCurrentOccupancy() != null) {
                statement.setInt(3, room.getCurrentOccupancy());
            } else {
                statement.setNull(3, java.sql.Types.INTEGER);
            }
            statement.setString(4, room.getStatus());

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

// Cập nhật phòng theo RoomID
    public static boolean updateRoom(Room room) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "UPDATE Rooms SET RoomNumber = ?, Capacity = ?, CurrentOccupancy = ?, Status = ?, UpdatedAt = CURRENT_TIMESTAMP WHERE RoomID = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, room.getRoomNumber());
            statement.setInt(2, room.getCapacity());
            if (room.getCurrentOccupancy() != null) {
                statement.setInt(3, room.getCurrentOccupancy());
            } else {
                statement.setNull(3, java.sql.Types.INTEGER);
            }
            statement.setString(4, room.getStatus());
            statement.setInt(5, room.getRoomID());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

// Xóa phòng theo RoomID
    public static boolean deleteRoom(int roomID) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "DELETE FROM Rooms WHERE RoomID = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, roomID);

            int rowsDeleted = statement.executeUpdate();
            return rowsDeleted > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
//        Room room1 = new Room("123123", 123123, 123123, "Occupied");
//
//        boolean result1 = createRoom(room1);
//        System.out.println("Test 1 - Create room 101 with occupancy: " + (result1 ? "Success" : "Failed"));
        
        
         int roomIDToDelete = 1; // Thay bằng ID bạn muốn xóa

        boolean deleted = RoomDAO.deleteRoom(roomIDToDelete);

        if (deleted) {
            System.out.println("Room with ID " + roomIDToDelete + " was deleted successfully.");
        } else {
            System.out.println("Failed to delete room with ID " + roomIDToDelete + ".");
        }
    }

}
