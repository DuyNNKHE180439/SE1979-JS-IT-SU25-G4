/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Order {
    private int stuNum;
    private int regisId;
    private String roomNum;
    private String bedNum;
    private String position;
    private String regisDate;
    private String startDate;
    private String endDate;
    private double price;
    private double total;

    public Order() {
    }

    public Order(int stuNum, int regisId, String roomNum, String bedNum, String position, String regisDate, String startDate, String endDate, double price, double total) {
        this.stuNum = stuNum;
        this.regisId = regisId;
        this.roomNum = roomNum;
        this.bedNum = bedNum;
        this.position = position;
        this.regisDate = regisDate;
        this.startDate = startDate;
        this.endDate = endDate;
        this.price = price;
        this.total = total;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

   

    public int getStuNum() {
        return stuNum;
    }

    public void setStuNum(int stuNum) {
        this.stuNum = stuNum;
    }

    public int getRegisId() {
        return regisId;
    }

    public void setRegisId(int regisId) {
        this.regisId = regisId;
    }

    public String getRoomNum() {
        return roomNum;
    }

    public void setRoomNum(String roomNum) {
        this.roomNum = roomNum;
    }

    public String getBedNum() {
        return bedNum;
    }

    public void setBedNum(String bedNum) {
        this.bedNum = bedNum;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getRegisDate() {
        return regisDate;
    }

    public void setRegisDate(String regisDate) {
        this.regisDate = regisDate;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Order{" + "stuNum=" + stuNum + ", regisId=" + regisId + ", roomNum=" + roomNum + ", bedNum=" + bedNum + ", position=" + position + ", regisDate=" + regisDate + ", startDate=" + startDate + ", endDate=" + endDate + ", price=" + price + ", total=" + total + '}';
    }

   
    
}
