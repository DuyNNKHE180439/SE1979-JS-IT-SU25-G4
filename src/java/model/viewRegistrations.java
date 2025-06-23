/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class viewRegistrations {
    private int reId;
    private String stuName;
    private String roomName;
    private String bedName;
    private String position;
    private double price;
    private int total;
    private int current;
    private String regiDate;
    private String startDate;
    private String endDate;

    public viewRegistrations() {
    }

    public viewRegistrations(int reId, String stuName, String roomName, String bedName, String position, double price, int total, int current, String regiDate, String startDate, String endDate) {
        this.reId = reId;
        this.stuName = stuName;
        this.roomName = roomName;
        this.bedName = bedName;
        this.position = position;
        this.price = price;
        this.total = total;
        this.current = current;
        this.regiDate = regiDate;
        this.startDate = startDate;
        this.endDate = endDate;
    }

  

    public int getReId() {
        return reId;
    }

    public void setReId(int reId) {
        this.reId = reId;
    }

    public String getStuName() {
        return stuName;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getBedName() {
        return bedName;
    }

    public void setBedName(String bedName) {
        this.bedName = bedName;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

   

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getCurrent() {
        return current;
    }

    public void setCurrent(int current) {
        this.current = current;
    }

    public String getRegiDate() {
        return regiDate;
    }

    public void setRegiDate(String regiDate) {
        this.regiDate = regiDate;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    @Override
    public String toString() {
        return "viewRegistrations{" + "reId=" + reId + ", stuName=" + stuName + ", roomName=" + roomName + ", bedName=" + bedName + ", position=" + position + ", price=" + price + ", total=" + total + ", current=" + current + ", regiDate=" + regiDate + ", startDate=" + startDate + ", endDate=" + endDate + '}';
    }
    
}
