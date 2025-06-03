package model;

import java.sql.Timestamp;

public class Room {

    private int roomID;  // thêm trường id
    private String roomNumber;
    private int capacity;
    private Integer currentOccupancy;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Constructor có id
    public Room(int roomID, String roomNumber, int capacity, Integer currentOccupancy, String status) {
        this.roomID = roomID;
        this.roomNumber = roomNumber;
        this.capacity = capacity;
        this.currentOccupancy = currentOccupancy;
        this.status = status;
    }

    // Constructor có id và thời gian tạo, cập nhật
    public Room(int roomID, String roomNumber, int capacity, Integer currentOccupancy, String status, Timestamp createdAt, Timestamp updatedAt) {
        this.roomID = roomID;
        this.roomNumber = roomNumber;
        this.capacity = capacity;
        this.currentOccupancy = currentOccupancy;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Constructor không có id (vd dùng khi tạo mới, id do DB tạo)
    public Room(String roomNumber, int capacity, Integer currentOccupancy, String status) {
        this.roomNumber = roomNumber;
        this.capacity = capacity;
        this.currentOccupancy = currentOccupancy;
        this.status = status;
    }

    // Default constructor
    public Room() {
    }

    // Getter/setter cho id
    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    // Các getter/setter còn lại
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

    @Override
    public String toString() {
        return "Room{"
                + "id=" + roomID
                + ", roomNumber='" + roomNumber + '\''
                + ", capacity=" + capacity
                + ", currentOccupancy=" + currentOccupancy
                + ", status='" + status + '\''
                + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt
                + '}';
    }
}
