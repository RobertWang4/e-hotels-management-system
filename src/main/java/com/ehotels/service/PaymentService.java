package com.ehotels.service;

import com.ehotels.model.Payment;
import com.ehotels.repository.PaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Service
public class PaymentService {

    @Autowired
    private PaymentRepository paymentRepository;

    public Payment createPayment(Integer rentingId, BigDecimal amount) {
        Payment payment = new Payment();
        payment.setRentingId(rentingId);
        payment.setAmount(amount);
        payment.setPaidAt(LocalDateTime.now());
        return paymentRepository.save(payment);
    }
}
