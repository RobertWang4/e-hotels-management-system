package com.ehotels.controller;

import com.ehotels.model.*;
import com.ehotels.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired private CustomerRepository customerRepository;
    @Autowired private EmployeeRepository employeeRepository;
    @Autowired private HotelRepository hotelRepository;
    @Autowired private HotelChainRepository hotelChainRepository;
    @Autowired private RoomRepository roomRepository;

    // --- Customers ---
    @GetMapping("/customers")
    public String customers(Model model) {
        model.addAttribute("customers", customerRepository.findAll());
        return "admin/customers";
    }

    @PostMapping("/customers")
    public String createCustomer(@RequestParam String fullName,
                                 @RequestParam String address,
                                 @RequestParam String idType,
                                 @RequestParam String idNumber) {
        Customer c = new Customer();
        c.setFullName(fullName);
        c.setAddress(address);
        c.setIdType(idType);
        c.setIdNumber(idNumber);
        c.setRegistrationDate(LocalDate.now());
        customerRepository.save(c);
        return "redirect:/admin/customers";
    }

    @PostMapping("/customers/delete")
    public String deleteCustomer(@RequestParam Integer customerId) {
        customerRepository.deleteById(customerId);
        return "redirect:/admin/customers";
    }

    @GetMapping("/customers/edit/{id}")
    public String editCustomer(@PathVariable Integer id, Model model) {
        model.addAttribute("customer", customerRepository.findById(id).orElseThrow());
        return "admin/customer-edit";
    }

    @PostMapping("/customers/edit/{id}")
    public String updateCustomer(@PathVariable Integer id,
                                 @RequestParam String fullName,
                                 @RequestParam String address,
                                 @RequestParam String idType,
                                 @RequestParam String idNumber) {
        Customer c = customerRepository.findById(id).orElseThrow();
        c.setFullName(fullName);
        c.setAddress(address);
        c.setIdType(idType);
        c.setIdNumber(idNumber);
        customerRepository.save(c);
        return "redirect:/admin/customers";
    }

    // --- Employees ---
    @GetMapping("/employees")
    public String employees(Model model) {
        model.addAttribute("employees", employeeRepository.findAll());
        model.addAttribute("hotels", hotelRepository.findAll());
        return "admin/employees";
    }

    @PostMapping("/employees")
    public String createEmployee(@RequestParam String fullName,
                                 @RequestParam String address,
                                 @RequestParam String ssnSin,
                                 @RequestParam Integer hotelId) {
        Employee e = new Employee();
        e.setFullName(fullName);
        e.setAddress(address);
        e.setSsnSin(ssnSin);
        e.setHotelId(hotelId);
        employeeRepository.save(e);
        return "redirect:/admin/employees";
    }

    @PostMapping("/employees/delete")
    public String deleteEmployee(@RequestParam Integer employeeId) {
        employeeRepository.deleteById(employeeId);
        return "redirect:/admin/employees";
    }

    @GetMapping("/employees/edit/{id}")
    public String editEmployee(@PathVariable Integer id, Model model) {
        model.addAttribute("employee", employeeRepository.findById(id).orElseThrow());
        model.addAttribute("hotels", hotelRepository.findAll());
        return "admin/employee-edit";
    }

    @PostMapping("/employees/edit/{id}")
    public String updateEmployee(@PathVariable Integer id,
                                 @RequestParam String fullName,
                                 @RequestParam String address,
                                 @RequestParam String ssnSin,
                                 @RequestParam Integer hotelId) {
        Employee e = employeeRepository.findById(id).orElseThrow();
        e.setFullName(fullName);
        e.setAddress(address);
        e.setSsnSin(ssnSin);
        e.setHotelId(hotelId);
        employeeRepository.save(e);
        return "redirect:/admin/employees";
    }

    // --- Hotels ---
    @GetMapping("/hotels")
    public String hotels(Model model) {
        model.addAttribute("hotels", hotelRepository.findAll());
        model.addAttribute("chains", hotelChainRepository.findAll());
        return "admin/hotels";
    }

    @PostMapping("/hotels")
    public String createHotel(@RequestParam String name,
                              @RequestParam Integer chainId,
                              @RequestParam Integer category,
                              @RequestParam String address,
                              @RequestParam String area,
                              @RequestParam String contactEmail,
                              @RequestParam String contactPhone) {
        Hotel h = new Hotel();
        h.setName(name);
        h.setChainId(chainId);
        h.setCategory(category);
        h.setAddress(address);
        h.setArea(area);
        h.setContactEmail(contactEmail);
        h.setContactPhone(contactPhone);
        hotelRepository.save(h);
        return "redirect:/admin/hotels";
    }

    @PostMapping("/hotels/delete")
    public String deleteHotel(@RequestParam Integer hotelId) {
        hotelRepository.deleteById(hotelId);
        return "redirect:/admin/hotels";
    }

    @GetMapping("/hotels/edit/{id}")
    public String editHotel(@PathVariable Integer id, Model model) {
        model.addAttribute("hotel", hotelRepository.findById(id).orElseThrow());
        model.addAttribute("chains", hotelChainRepository.findAll());
        return "admin/hotel-edit";
    }

    @PostMapping("/hotels/edit/{id}")
    public String updateHotel(@PathVariable Integer id,
                              @RequestParam String name,
                              @RequestParam Integer chainId,
                              @RequestParam Integer category,
                              @RequestParam String address,
                              @RequestParam String area,
                              @RequestParam String contactEmail,
                              @RequestParam String contactPhone) {
        Hotel h = hotelRepository.findById(id).orElseThrow();
        h.setName(name);
        h.setChainId(chainId);
        h.setCategory(category);
        h.setAddress(address);
        h.setArea(area);
        h.setContactEmail(contactEmail);
        h.setContactPhone(contactPhone);
        hotelRepository.save(h);
        return "redirect:/admin/hotels";
    }

    // --- Rooms ---
    @GetMapping("/rooms")
    public String rooms(Model model) {
        model.addAttribute("rooms", roomRepository.findAll());
        model.addAttribute("hotels", hotelRepository.findAll());
        return "admin/rooms";
    }

    @PostMapping("/rooms")
    public String createRoom(@RequestParam Integer hotelId,
                             @RequestParam String roomNumber,
                             @RequestParam String capacity,
                             @RequestParam java.math.BigDecimal price,
                             @RequestParam(required = false) String viewType,
                             @RequestParam(required = false) String problems,
                             @RequestParam(defaultValue = "false") Boolean extendable) {
        Room r = new Room();
        r.setHotelId(hotelId);
        r.setRoomNumber(roomNumber);
        r.setCapacity(capacity);
        r.setPrice(price);
        r.setViewType(viewType);
        r.setProblems(problems);
        r.setExtendable(extendable);
        roomRepository.save(r);
        return "redirect:/admin/rooms";
    }

    @PostMapping("/rooms/delete")
    public String deleteRoom(@RequestParam Integer roomId) {
        roomRepository.deleteById(roomId);
        return "redirect:/admin/rooms";
    }

    @GetMapping("/rooms/edit/{id}")
    public String editRoom(@PathVariable Integer id, Model model) {
        model.addAttribute("room", roomRepository.findById(id).orElseThrow());
        model.addAttribute("hotels", hotelRepository.findAll());
        return "admin/room-edit";
    }

    @PostMapping("/rooms/edit/{id}")
    public String updateRoom(@PathVariable Integer id,
                             @RequestParam Integer hotelId,
                             @RequestParam String roomNumber,
                             @RequestParam String capacity,
                             @RequestParam java.math.BigDecimal price,
                             @RequestParam(required = false) String viewType,
                             @RequestParam(required = false) String problems,
                             @RequestParam(defaultValue = "false") Boolean extendable) {
        Room r = roomRepository.findById(id).orElseThrow();
        r.setHotelId(hotelId);
        r.setRoomNumber(roomNumber);
        r.setCapacity(capacity);
        r.setPrice(price);
        r.setViewType(viewType);
        r.setProblems(problems);
        r.setExtendable(extendable);
        roomRepository.save(r);
        return "redirect:/admin/rooms";
    }
}
