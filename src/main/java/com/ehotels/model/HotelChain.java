package com.ehotels.model;

import jakarta.persistence.*;

@Entity
@Table(name = "hotel_chain")
public class HotelChain {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "chain_id")
    private Integer chainId;

    @Column(nullable = false)
    private String name;

    @Column(name = "central_office_address", nullable = false)
    private String centralOfficeAddress;

    @Column(name = "contact_email", nullable = false)
    private String contactEmail;

    @Column(name = "contact_phone", nullable = false)
    private String contactPhone;

    public Integer getChainId() { return chainId; }
    public String getName() { return name; }
    public String getCentralOfficeAddress() { return centralOfficeAddress; }
    public String getContactEmail() { return contactEmail; }
    public String getContactPhone() { return contactPhone; }

    public void setChainId(Integer chainId) { this.chainId = chainId; }
    public void setName(String name) { this.name = name; }
    public void setCentralOfficeAddress(String centralOfficeAddress) { this.centralOfficeAddress = centralOfficeAddress; }
    public void setContactEmail(String contactEmail) { this.contactEmail = contactEmail; }
    public void setContactPhone(String contactPhone) { this.contactPhone = contactPhone; }
}
