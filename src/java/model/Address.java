/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Address {
    private int addressId;
    private String street ;
    private String ward;
    private String district;
    private String province;

    public Address() {
    }

    public Address(int addressId, String street, String ward, String district, String province) {
        this.addressId = addressId;
        this.street = street;
        this.ward = ward;
        this.district = district;
        this.province = province;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    @Override
    public String toString() {
        return "Address{" + "addressId=" + addressId + ", street=" + street + ", ward=" + ward + ", district=" + district + ", province=" + province + '}';
    }
    
}
