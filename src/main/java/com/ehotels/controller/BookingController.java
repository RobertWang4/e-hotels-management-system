package com.ehotels.controller;

import com.ehotels.model.Booking;
import com.ehotels.repository.CustomerRepository;
import com.ehotels.repository.RoomRepository;
import com.ehotels.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;

@Controller
public class BookingController {

    @Autowired
    private BookingService bookingService;

    @Autowired
    private RoomRepository roomRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @GetMapping("/bookings/new")
    public String newBookingForm(@RequestParam Integer roomId, Model model) {
        model.addAttribute("room", roomRepository.findWithAmenitiesById(roomId).orElseThrow());
        model.addAttribute("customers", customerRepository.findAll());
        return "booking";
    }

    @PostMapping("/bookings")
    public String createBooking(@RequestParam Integer roomId,
                                @RequestParam Integer customerId,
                                @RequestParam String startDate,
                                @RequestParam String endDate) {
        Booking booking = new Booking();
        booking.setRoomId(roomId);
        booking.setCustomerId(customerId);
        booking.setStartDate(LocalDate.parse(startDate));
        booking.setEndDate(LocalDate.parse(endDate));
        bookingService.createBooking(booking);
        return "redirect:/bookings/success";
    }

    @GetMapping("/bookings/success")
    public String bookingSuccess() {
        return "booking-success";
    }
}
