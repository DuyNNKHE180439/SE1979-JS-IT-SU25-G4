package model;

import java.sql.Timestamp;
import java.util.List;

public class Room {

    private int roomID;
    private String roomNumber;
    private int capacity;
    private Integer currentOccupancy;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String roomImagePath;
    private List<Bed> beds;

    public List<Bed> getBeds() {
        return beds;
    }

    public void setBeds(List<Bed> beds) {
        this.beds = beds;
    }

    // === Constructors ===
    // Constructor có ID + đầy đủ thời gian + ảnh
    public Room(int roomID, String roomNumber, int capacity, Integer currentOccupancy, String status, Timestamp createdAt, Timestamp updatedAt, String roomImagePath) {
        this.roomID = roomID;
        this.roomNumber = roomNumber;
        this.capacity = capacity;
        this.currentOccupancy = currentOccupancy;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.roomImagePath = roomImagePath;
    }

    // Constructor có ID không thời gian nhưng có ảnh
    public Room(int roomID, String roomNumber, int capacity, Integer currentOccupancy, String status, String roomImagePath) {
        this.roomID = roomID;
        this.roomNumber = roomNumber;
        this.capacity = capacity;
        this.currentOccupancy = currentOccupancy;
        this.status = status;
        this.roomImagePath = roomImagePath;
    }

    // Constructor không có ID (tạo mới) có ảnh
    public Room(String roomNumber, int capacity, Integer currentOccupancy, String status, String roomImagePath) {
        this.roomNumber = roomNumber;
        this.capacity = capacity;
        this.currentOccupancy = currentOccupancy;
        this.status = status;
        this.roomImagePath = roomImagePath;
    }

    // Default constructor
    public Room() {
    }

    // === Getters and Setters ===
    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public Integer getCurrentOccupancy() {
        return currentOccupancy;
    }

    public void setCurrentOccupancy(Integer currentOccupancy) {
        this.currentOccupancy = currentOccupancy;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getRoomImagePath() {
        return roomImagePath;
    }

    public void setRoomImagePath(String roomImagePath) {
        this.roomImagePath = roomImagePath;
    }

    // === toString ===
    @Override
    public String toString() {
        return "Room{"
                + "roomID=" + roomID
                + ", roomNumber='" + roomNumber + '\''
                + ", capacity=" + capacity
                + ", currentOccupancy=" + currentOccupancy
                + ", status='" + status + '\''
                + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt
                + ", roomImagePath='" + roomImagePath + '\''
                + '}';
    }
}
