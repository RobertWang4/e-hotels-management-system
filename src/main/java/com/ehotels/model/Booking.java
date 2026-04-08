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

    @Column(name = "customer_name_snapshot", nullable = false)
    private String customerNameSnapshot;

    @Column(name = "customer_id_number_snapshot", nullable = false)
    private String customerIdNumberSnapshot;

    @Column(name = "room_number_snapshot", nullable = false)
    private String roomNumberSnapshot;

    @Column(name = "hotel_name_snapshot", nullable = false)
    private String hotelNameSnapshot;

    @Column(name = "room_price_snapshot", nullable = false)
    private java.math.BigDecimal roomPriceSnapshot;

    @Column(name = "room_capacity_snapshot", nullable = false)
    private String roomCapacitySnapshot;

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
    public String getCustomerNameSnapshot() { return customerNameSnapshot; }
    public String getCustomerIdNumberSnapshot() { return customerIdNumberSnapshot; }
    public String getRoomNumberSnapshot() { return roomNumberSnapshot; }
    public String getHotelNameSnapshot() { return hotelNameSnapshot; }
    public java.math.BigDecimal getRoomPriceSnapshot() { return roomPriceSnapshot; }
    public String getRoomCapacitySnapshot() { return roomCapacitySnapshot; }
    public LocalDate getStartDate() { return startDate; }
    public LocalDate getEndDate() { return endDate; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public String getStatus() { return status; }

    public void setBookingId(Integer bookingId) { this.bookingId = bookingId; }
    public void setCustomerId(Integer customerId) { this.customerId = customerId; }
    public void setRoomId(Integer roomId) { this.roomId = roomId; }
    public void setCustomerNameSnapshot(String customerNameSnapshot) { this.customerNameSnapshot = customerNameSnapshot; }
    public void setCustomerIdNumberSnapshot(String customerIdNumberSnapshot) { this.customerIdNumberSnapshot = customerIdNumberSnapshot; }
    public void setRoomNumberSnapshot(String roomNumberSnapshot) { this.roomNumberSnapshot = roomNumberSnapshot; }
    public void setHotelNameSnapshot(String hotelNameSnapshot) { this.hotelNameSnapshot = hotelNameSnapshot; }
    public void setRoomPriceSnapshot(java.math.BigDecimal roomPriceSnapshot) { this.roomPriceSnapshot = roomPriceSnapshot; }
    public void setRoomCapacitySnapshot(String roomCapacitySnapshot) { this.roomCapacitySnapshot = roomCapacitySnapshot; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public void setStatus(String status) { this.status = status; }
}
