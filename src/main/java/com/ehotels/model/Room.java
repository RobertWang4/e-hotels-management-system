package com.ehotels.model;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "room")
public class Room {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "room_id")
    private Integer roomId;

    @Column(name = "hotel_id", nullable = false)
    private Integer hotelId;

    @Column(name = "room_number", nullable = false)
    private String roomNumber;

    @Column(nullable = false)
    private String capacity;

    @Column(nullable = false)
    private BigDecimal price;

    @Column(name = "view_type")
    private String viewType;

    @Column(nullable = false)
    private Boolean extendable = false;

    private String problems;

    public Integer getRoomId() { return roomId; }
    public Integer getHotelId() { return hotelId; }
    public String getRoomNumber() { return roomNumber; }
    public String getCapacity() { return capacity; }
    public BigDecimal getPrice() { return price; }
    public String getViewType() { return viewType; }
    public Boolean getExtendable() { return extendable; }
    public String getProblems() { return problems; }

    public void setRoomId(Integer roomId) { this.roomId = roomId; }
    public void setHotelId(Integer hotelId) { this.hotelId = hotelId; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }
    public void setCapacity(String capacity) { this.capacity = capacity; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public void setViewType(String viewType) { this.viewType = viewType; }
    public void setExtendable(Boolean extendable) { this.extendable = extendable; }
    public void setProblems(String problems) { this.problems = problems; }
}
