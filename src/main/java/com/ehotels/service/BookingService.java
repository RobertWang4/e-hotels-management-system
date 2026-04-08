package com.ehotels.service;

import com.ehotels.model.Booking;
import com.ehotels.repository.BookingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class BookingService {

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private ReservationSnapshotService reservationSnapshotService;

    public List<Booking> getAllBookings() {
        return bookingRepository.findAll();
    }

    public List<Booking> getActiveBookings() {
        return bookingRepository.findByStatus("active");
    }

    @CacheEvict(value = "availableRooms", allEntries = true)
    public Booking createBooking(Booking booking) {
        reservationSnapshotService.populateBookingSnapshot(booking);
        booking.setStatus("active");
        booking.setCreatedAt(LocalDateTime.now());
        return bookingRepository.save(booking);
    }

    @CacheEvict(value = "availableRooms", allEntries = true)
    public void cancelBooking(Integer bookingId) {
        Booking booking = bookingRepository.findById(bookingId).orElseThrow();
        booking.setStatus("cancelled");
        bookingRepository.save(booking);
    }
}
