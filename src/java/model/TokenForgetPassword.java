/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;

/**
 *
 * @author Admin
 */
public class TokenForgetPassword {

    private int tokenId;
    private int userId;
    private String token;
    private LocalDateTime expiryDate;
    private boolean isUsed;

    public TokenForgetPassword() {
    }

    public TokenForgetPassword(int tokenId, int userId, String token, LocalDateTime expiryDate, boolean isUsed) {
        this.tokenId = tokenId;
        this.userId = userId;
        this.token = token;
        this.expiryDate = expiryDate;
        this.isUsed = isUsed;
    }
     public TokenForgetPassword(int userId, String token, LocalDateTime expiryDate, boolean isUsed) {
        this.userId = userId;
        this.token = token;
        this.expiryDate = expiryDate;
        this.isUsed = isUsed;
    }

    public int getTokenId() {
        return tokenId;
    }

    public void setTokenId(int tokenId) {
        this.tokenId = tokenId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public LocalDateTime getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(LocalDateTime expiryDate) {
        this.expiryDate = expiryDate;
    }

    public boolean isIsUsed() {
        return isUsed;
    }

    public void setIsUsed(boolean isUsed) {
        this.isUsed = isUsed;
    }

    @Override
    public String toString() {
        return "TokenResetPassword{" + "tokenId=" + tokenId + ", userId=" + userId + ", token=" + token + ", expiryDate=" + expiryDate + ", isUsed=" + isUsed + '}';
    }

}
