package com.ehotels.model;

import jakarta.persistence.*;

@Entity
@Table(name = "hotel")
public class Hotel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "hotel_id")
    private Integer hotelId;

    @Column(name = "chain_id", nullable = false)
    private Integer chainId;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private Integer category;

    @Column(nullable = false)
    private String address;

    @Column(nullable = false)
    private String area;

    @Column(name = "contact_email", nullable = false)
    private String contactEmail;

    @Column(name = "contact_phone", nullable = false)
    private String contactPhone;

    @Column(name = "manager_employee_id")
    private Integer managerEmployeeId;

    // Getters
    public Integer getHotelId() { return hotelId; }
    public Integer getChainId() { return chainId; }
    public String getName() { return name; }
    public Integer getCategory() { return category; }
    public String getAddress() { return address; }
    public String getArea() { return area; }
    public String getContactEmail() { return contactEmail; }
    public String getContactPhone() { return contactPhone; }
    public Integer getManagerEmployeeId() { return managerEmployeeId; }

    // Setters
    public void setHotelId(Integer hotelId) { this.hotelId = hotelId; }
    public void setChainId(Integer chainId) { this.chainId = chainId; }
    public void setName(String name) { this.name = name; }
    public void setCategory(Integer category) { this.category = category; }
    public void setAddress(String address) { this.address = address; }
    public void setArea(String area) { this.area = area; }
    public void setContactEmail(String contactEmail) { this.contactEmail = contactEmail; }
    public void setContactPhone(String contactPhone) { this.contactPhone = contactPhone; }
    public void setManagerEmployeeId(Integer managerEmployeeId) { this.managerEmployeeId = managerEmployeeId; }
}
