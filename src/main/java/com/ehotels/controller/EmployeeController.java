package com.ehotels.controller;

import com.ehotels.repository.BookingRepository;
import com.ehotels.repository.EmployeeRepository;
import com.ehotels.repository.CustomerRepository;
import com.ehotels.repository.RoomRepository;
import com.ehotels.service.BookingService;
import com.ehotels.service.RentingService;
import com.ehotels.service.PaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Controller
@RequestMapping("/employee")
public class EmployeeController {

    @Autowired private BookingService bookingService;
    @Autowired private RentingService rentingService;
    @Autowired private PaymentService paymentService;
    @Autowired private BookingRepository bookingRepository;
    @Autowired private EmployeeRepository employeeRepository;
    @Autowired private CustomerRepository customerRepository;
    @Autowired private RoomRepository roomRepository;

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("activeBookings", bookingService.getActiveBookings());
        model.addAttribute("activeRentings", rentingService.getActiveRentings());
        model.addAttribute("employees", employeeRepository.findAll());
        model.addAttribute("customers", customerRepository.findAll());
        model.addAttribute("rooms", roomRepository.findAll());
        return "employee-dashboard";
    }

    @PostMapping("/check-in")
    public String checkIn(@RequestParam Integer bookingId,
                          @RequestParam Integer employeeId) {
        var booking = bookingRepository.findById(bookingId).orElseThrow();
        rentingService.createFromBooking(
            bookingId, booking.getRoomId(), booking.getCustomerId(),
            employeeId, booking.getStartDate(), booking.getEndDate()
        );
        return "redirect:/employee/dashboard";
    }

    @PostMapping("/walk-in")
    public String walkIn(@RequestParam Integer roomId,
                         @RequestParam Integer customerId,
                         @RequestParam Integer employeeId,
                         @RequestParam String startDate,
                         @RequestParam String endDate) {
        rentingService.createWalkIn(
            roomId, customerId, employeeId,
            LocalDate.parse(startDate), LocalDate.parse(endDate)
        );
        return "redirect:/employee/dashboard";
    }

    @PostMapping("/payment")
    public String payment(@RequestParam Integer rentingId,
                          @RequestParam BigDecimal amount) {
        paymentService.createPayment(rentingId, amount);
        return "redirect:/employee/dashboard";
    }
}
