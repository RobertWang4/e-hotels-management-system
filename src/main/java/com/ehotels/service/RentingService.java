package com.ehotels.service;

import com.ehotels.model.Renting;
import com.ehotels.repository.RentingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class RentingService {

    @Autowired
    private RentingRepository rentingRepository;

    public List<Renting> getAllRentings() {
        return rentingRepository.findAll();
    }

    public List<Renting> getActiveRentings() {
        return rentingRepository.findByStatus("active");
    }

    @CacheEvict(value = "availableRooms", allEntries = true)
    public Renting createFromBooking(Integer bookingId, Integer roomId,
                                     Integer customerId, Integer employeeId,
                                     LocalDate startDate, LocalDate endDate) {
        Renting renting = new Renting();
        renting.setBookingId(bookingId);
        renting.setRoomId(roomId);
        renting.setCustomerId(customerId);
        renting.setEmployeeId(employeeId);
        renting.setStartDate(startDate);
        renting.setEndDate(endDate);
        renting.setCheckInAt(LocalDateTime.now());
        renting.setStatus("active");
        return rentingRepository.save(renting);
    }

    @CacheEvict(value = "availableRooms", allEntries = true)
    public Renting createWalkIn(Integer roomId, Integer customerId,
                                Integer employeeId,
                                LocalDate startDate, LocalDate endDate) {
        Renting renting = new Renting();
        renting.setRoomId(roomId);
        renting.setCustomerId(customerId);
        renting.setEmployeeId(employeeId);
        renting.setStartDate(startDate);
        renting.setEndDate(endDate);
        renting.setCheckInAt(LocalDateTime.now());
        renting.setStatus("active");
        return rentingRepository.save(renting);
    }
}
