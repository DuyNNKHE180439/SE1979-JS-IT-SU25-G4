package model;

import java.math.BigDecimal;

public class Bed {
    private int bedID;
    private int roomID;
    private String bedNumber;
    private String position;
    private BigDecimal price;
    private String status;

    public Bed() {
    }

    public Bed(int bedID, int roomID, String bedNumber, String position, BigDecimal price, String status) {
        this.bedID = bedID;
        this.roomID = roomID;
        this.bedNumber = bedNumber;
        this.position = position;
        this.price = price;
        this.status = status;
    }

    // Getter và Setter
    public int getBedID() {
        return bedID;
    }

    public void setBedID(int bedID) {
        this.bedID = bedID;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public String getBedNumber() {
        return bedNumber;
    }

    public void setBedNumber(String bedNumber) {
        this.bedNumber = bedNumber;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
