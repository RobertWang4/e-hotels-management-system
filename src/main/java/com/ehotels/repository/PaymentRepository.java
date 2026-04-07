package com.ehotels.repository;

import com.ehotels.model.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface PaymentRepository extends JpaRepository<Payment, Integer> {
    List<Payment> findByRentingId(Integer rentingId);
}
