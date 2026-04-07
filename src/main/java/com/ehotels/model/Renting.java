package com.ehotels.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "renting")
public class Renting {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "renting_id")
    private Integer rentingId;

    @Column(name = "customer_id")
    private Integer customerId;

    @Column(name = "room_id")
    private Integer roomId;

    @Column(name = "employee_id")
    private Integer employeeId;

    @Column(name = "booking_id")
    private Integer bookingId;

    @Column(name = "start_date", nullable = false)
    private LocalDate startDate;

    @Column(name = "end_date", nullable = false)
    private LocalDate endDate;

    @Column(name = "check_in_at", nullable = false)
    private LocalDateTime checkInAt;

    @Column(nullable = false)
    private String status;

    public Integer getRentingId() { return rentingId; }
    public Integer getCustomerId() { return customerId; }
    public Integer getRoomId() { return roomId; }
    public Integer getEmployeeId() { return employeeId; }
    public Integer getBookingId() { return bookingId; }
    public LocalDate getStartDate() { return startDate; }
    public LocalDate getEndDate() { return endDate; }
    public LocalDateTime getCheckInAt() { return checkInAt; }
    public String getStatus() { return status; }

    public void setRentingId(Integer rentingId) { this.rentingId = rentingId; }
    public void setCustomerId(Integer customerId) { this.customerId = customerId; }
    public void setRoomId(Integer roomId) { this.roomId = roomId; }
    public void setEmployeeId(Integer employeeId) { this.employeeId = employeeId; }
    public void setBookingId(Integer bookingId) { this.bookingId = bookingId; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }
    public void setCheckInAt(LocalDateTime checkInAt) { this.checkInAt = checkInAt; }
    public void setStatus(String status) { this.status = status; }
}
