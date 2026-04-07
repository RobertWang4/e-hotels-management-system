package com.ehotels.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "booking")
public class Booking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "booking_id")
    private Integer bookingId;

    @Column(name = "customer_id")
    private Integer customerId;

    @Column(name = "room_id")
    private Integer roomId;

    @Column(name = "start_date", nullable = false)
    private LocalDate startDate;

    @Column(name = "end_date", nullable = false)
    private LocalDate endDate;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(nullable = false)
    private String status;

    public Integer getBookingId() { return bookingId; }
    public Integer getCustomerId() { return customerId; }
    public Integer getRoomId() { return roomId; }
    public LocalDate getStartDate() { return startDate; }
    public LocalDate getEndDate() { return endDate; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public String getStatus() { return status; }

    public void setBookingId(Integer bookingId) { this.bookingId = bookingId; }
    public void setCustomerId(Integer customerId) { this.customerId = customerId; }
    public void setRoomId(Integer roomId) { this.roomId = roomId; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public void setStatus(String status) { this.status = status; }
}
