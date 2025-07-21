/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class LeaveRequest {

    private int leaveId;
    private int stuId;
    private int regisId;
    private String reason;
    private String status;
    private int approveBy;
    private String approveAt;
    private String createAt;
    private String UpdateAt;
    private String roomNum;
    private String bedNum;
    private String startDate;
    private String endDate;
    private String fullName;

    public LeaveRequest() {
    }

    public LeaveRequest(int leaveId, int stuId, int regisId, String reason, String status, int approveBy, String approveAt, String createAt, String UpdateAt, String roomNum, String bedNum, String startDate, String endDate, String fullName) {
        this.leaveId = leaveId;
        this.stuId = stuId;
        this.regisId = regisId;
        this.reason = reason;
        this.status = status;
        this.approveBy = approveBy;
        this.approveAt = approveAt;
        this.createAt = createAt;
        this.UpdateAt = UpdateAt;
        this.roomNum = roomNum;
        this.bedNum = bedNum;
        this.startDate = startDate;
        this.endDate = endDate;
        this.fullName = fullName;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

   
    public int getLeaveId() {
        return leaveId;
    }

    public void setLeaveId(int leaveId) {
        this.leaveId = leaveId;
    }

    public int getStuId() {
        return stuId;
    }

    public void setStuId(int stuId) {
        this.stuId = stuId;
    }

    public int getRegisId() {
        return regisId;
    }

    public void setRegisId(int regisId) {
        this.regisId = regisId;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getApproveBy() {
        return approveBy;
    }

    public void setApproveBy(int approveBy) {
        this.approveBy = approveBy;
    }

    public String getApproveAt() {
        return approveAt;
    }

    public void setApproveAt(String approveAt) {
        this.approveAt = approveAt;
    }

    public String getCreateAt() {
        return createAt;
    }

    public void setCreateAt(String createAt) {
        this.createAt = createAt;
    }

    public String getUpdateAt() {
        return UpdateAt;
    }

    public void setUpdateAt(String UpdateAt) {
        this.UpdateAt = UpdateAt;
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
        return "LeaveRequest{" + "leaveId=" + leaveId + ", stuId=" + stuId + ", regisId=" + regisId + ", reason=" + reason + ", status=" + status + ", approveBy=" + approveBy + ", approveAt=" + approveAt + ", createAt=" + createAt + ", UpdateAt=" + UpdateAt + ", roomNum=" + roomNum + ", bedNum=" + bedNum + ", startDate=" + startDate + ", endDate=" + endDate + '}';
    }

}
