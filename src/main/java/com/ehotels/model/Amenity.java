package com.ehotels.model;

import jakarta.persistence.*;

@Entity
@Table(name = "amenity")
public class Amenity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "amenity_id")
    private Integer amenityId;

    @Column(nullable = false)
    private String name;

    public Integer getAmenityId() { return amenityId; }
    public String getName() { return name; }

    public void setAmenityId(Integer amenityId) { this.amenityId = amenityId; }
    public void setName(String name) { this.name = name; }
}
