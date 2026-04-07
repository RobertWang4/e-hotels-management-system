package com.ehotels.model;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "payment")
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "payment_id")
    private Integer paymentId;

    @Column(name = "renting_id", nullable = false)
    private Integer rentingId;

    @Column(nullable = false)
    private BigDecimal amount;

    @Column(name = "paid_at", nullable = false)
    private LocalDateTime paidAt;

    public Integer getPaymentId() { return paymentId; }
    public Integer getRentingId() { return rentingId; }
    public BigDecimal getAmount() { return amount; }
    public LocalDateTime getPaidAt() { return paidAt; }

    public void setPaymentId(Integer paymentId) { this.paymentId = paymentId; }
    public void setRentingId(Integer rentingId) { this.rentingId = rentingId; }
    public void setAmount(BigDecimal amount) { this.amount = amount; }
    public void setPaidAt(LocalDateTime paidAt) { this.paidAt = paidAt; }
}
