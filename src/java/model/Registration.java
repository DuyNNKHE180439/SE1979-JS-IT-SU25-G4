package model;

import java.sql.Timestamp;

public class Registration {

    private int registrationID;
    private int studentID;
    private int roomID;
    private int bedID;
    private String status;
    private int approvedBy;
    private Timestamp approvedAt;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Timestamp startDate;
    private Timestamp endDate;
    private Room room;
    private Bed bed;

    public Registration() {
    }

    public Registration(int registrationID, int studentID, int roomID, int bedID, String status, int approvedBy, Timestamp approvedAt, Timestamp createdAt, Timestamp updatedAt, Timestamp startDate, Timestamp endDate) {
        this.registrationID = registrationID;
        this.studentID = studentID;
        this.roomID = roomID;
        this.bedID = bedID;
        this.status = status;
        this.approvedBy = approvedBy;
        this.approvedAt = approvedAt;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    public Bed getBed() {
        return bed;
    }

    public void setBed(Bed bed) {
        this.bed = bed;
    }

    public int getRegistrationID() {
        return registrationID;
    }

    public void setRegistrationID(int registrationID) {
        this.registrationID = registrationID;
    }

    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public int getBedID() {
        return bedID;
    }

    public void setBedID(int bedID) {
        this.bedID = bedID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(int approvedBy) {
        this.approvedBy = approvedBy;
    }

    public Timestamp getApprovedAt() {
        return approvedAt;
    }

    public void setApprovedAt(Timestamp approvedAt) {
        this.approvedAt = approvedAt;
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

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    @Override
    public String toString() {
        return "Registration{"
                + "registrationID=" + registrationID
                + ", studentID=" + studentID
                + ", roomID=" + roomID
                + ", bedID=" + bedID
                + ", status='" + status + '\''
                + ", approvedBy=" + approvedBy
                + ", approvedAt=" + approvedAt
                + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt
                + ", startDate=" + startDate
                + ", endDate=" + endDate
                + ", room=" + (room != null ? room.getRoomNumber() : "null")
                + ", bed=" + (bed != null ? bed.getBedNumber() : "null")
                + '}';
    }

}
