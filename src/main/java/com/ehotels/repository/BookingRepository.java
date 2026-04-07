package com.ehotels.repository;

import com.ehotels.model.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface BookingRepository extends JpaRepository<Booking, Integer> {
    List<Booking> findByStatus(String status);
    List<Booking> findByCustomerId(Integer customerId);
}
