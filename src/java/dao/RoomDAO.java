package dao;

import java.util.ArrayList;
import java.util.List;
import model.Room;
import java.sql.*;
import model.Bed;

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
                room.setCurrentOccupancy(occupancy != null ? (Integer) occupancy : 0);

                room.setStatus(rs.getString("Status"));
                room.setCreatedAt(rs.getTimestamp("CreatedAt"));
                room.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
                room.setRoomImagePath(rs.getString("RoomImagePath"));

                roomList.add(room);
            }

            return roomList;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

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
                room.setRoomImagePath(rs.getString("RoomImagePath")); // ADD image

                return room;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean createRoom(Room room) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "INSERT INTO Rooms (RoomNumber, Capacity, CurrentOccupancy, Status, RoomImagePath, CreatedAt, UpdatedAt) "
                    + "VALUES (?, ?, ?, ?, ?, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, room.getRoomNumber());
            statement.setInt(2, room.getCapacity());

            if (room.getCurrentOccupancy() != null) {
                statement.setInt(3, room.getCurrentOccupancy());
            } else {
                statement.setNull(3, java.sql.Types.INTEGER);
            }

            statement.setString(4, room.getStatus());
            statement.setString(5, room.getRoomImagePath()); // ADD image

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updateRoom(Room room) {
        DBContext db = DBContext.getInstance();
        try {
            String sql = "UPDATE Rooms SET RoomNumber = ?, Capacity = ?, CurrentOccupancy = ?, Status = ?, RoomImagePath = ?, UpdatedAt = CURRENT_TIMESTAMP "
                    + "WHERE RoomID = ?";
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setString(1, room.getRoomNumber());
            statement.setInt(2, room.getCapacity());

            if (room.getCurrentOccupancy() != null) {
                statement.setInt(3, room.getCurrentOccupancy());
            } else {
                statement.setNull(3, java.sql.Types.INTEGER);
            }

            statement.setString(4, room.getStatus());
            statement.setString(5, room.getRoomImagePath()); // ADD image
            statement.setInt(6, room.getRoomID());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

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
        // Test delete or create room with image
        Room room = new Room();
        room.setRoomNumber("A888");
        room.setCapacity(4);
        room.setCurrentOccupancy(1);
        room.setStatus("Available");
        room.setRoomImagePath("../images/sample.jpg");

        boolean created = createRoom(room);
        System.out.println("Create result: " + created);
    }
}
