package com.ehotels.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "customer")
public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "customer_id")
    private Integer customerId;

    @Column(name = "full_name", nullable = false)
    private String fullName;

    private String address;

    @Column(name = "id_type", nullable = false)
    private String idType;

    @Column(name = "id_number", nullable = false)
    private String idNumber;

    @Column(name = "registration_date", nullable = false)
    private LocalDate registrationDate;

    public Integer getCustomerId() { return customerId; }
    public String getFullName() { return fullName; }
    public String getAddress() { return address; }
    public String getIdType() { return idType; }
    public String getIdNumber() { return idNumber; }
    public LocalDate getRegistrationDate() { return registrationDate; }

    public void setCustomerId(Integer customerId) { this.customerId = customerId; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public void setAddress(String address) { this.address = address; }
    public void setIdType(String idType) { this.idType = idType; }
    public void setIdNumber(String idNumber) { this.idNumber = idNumber; }
    public void setRegistrationDate(LocalDate registrationDate) { this.registrationDate = registrationDate; }
}
