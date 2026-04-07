package com.ehotels.model;

import jakarta.persistence.*;

@Entity
@Table(name = "employee")
public class Employee {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "employee_id")
    private Integer employeeId;

    @Column(name = "hotel_id", nullable = false)
    private Integer hotelId;

    @Column(name = "full_name", nullable = false)
    private String fullName;

    private String address;

    @Column(name = "ssn_sin", nullable = false, unique = true)
    private String ssnSin;

    public Integer getEmployeeId() { return employeeId; }
    public Integer getHotelId() { return hotelId; }
    public String getFullName() { return fullName; }
    public String getAddress() { return address; }
    public String getSsnSin() { return ssnSin; }

    public void setEmployeeId(Integer employeeId) { this.employeeId = employeeId; }
    public void setHotelId(Integer hotelId) { this.hotelId = hotelId; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public void setAddress(String address) { this.address = address; }
    public void setSsnSin(String ssnSin) { this.ssnSin = ssnSin; }
}
