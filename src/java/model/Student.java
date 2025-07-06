/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class Student {
    private int studentID;
    private int userID;
    private String studentCode;
    private User user; // liên kết user

    public Student() {
    }

    public Student(User user, String studentCode) {       
        this.user = user;
        this.studentCode = studentCode;
    }
    

    public Student(int studentID, int userID, String studentCode, User user) {
        this.studentID = studentID;
        this.userID = userID;
        this.studentCode = studentCode;
        this.user = user;
    }

    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getStudentCode() {
        return studentCode;
    }

    public void setStudentCode(String studentCode) {
        this.studentCode = studentCode;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Student{" + "studentID=" + studentID + ", userID=" + userID + ", studentCode=" + studentCode + ", user=" + user + '}';
    }
    
    
}
