package com.ehotels.controller;

import com.ehotels.model.*;
import com.ehotels.repository.*;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired private CustomerRepository customerRepository;
    @Autowired private EmployeeRepository employeeRepository;
    @Autowired private HotelRepository hotelRepository;
    @Autowired private HotelChainRepository hotelChainRepository;
    @Autowired private RoomRepository roomRepository;
    @Autowired private AmenityRepository amenityRepository;

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
    public String employees(@RequestParam(required = false) Integer hotelId,
                            @RequestParam(required = false) String message,
                            @RequestParam(required = false) String error,
                            Model model) {
        model.addAttribute("employees", employeeRepository.findAll());
        model.addAttribute("hotels", hotelRepository.findAll());
        model.addAttribute("selectedHotelId", hotelId);
        model.addAttribute("message", message);
        model.addAttribute("error", error);
        return "admin/employees";
    }

    @PostMapping("/employees")
    @Transactional
    public String createEmployee(@RequestParam String fullName,
                                 @RequestParam String address,
                                 @RequestParam String ssnSin,
                                 @RequestParam Integer hotelId,
                                 RedirectAttributes redirectAttributes) {
        Employee e = new Employee();
        e.setFullName(fullName);
        e.setAddress(address);
        e.setSsnSin(ssnSin);
        e.setHotelId(hotelId);
        employeeRepository.save(e);
        boolean managerAssigned = ensureHotelManagerAssigned(hotelId, e.getEmployeeId());
        if (managerAssigned) {
            redirectAttributes.addAttribute("message", "The first employee for this hotel was assigned as manager automatically.");
        }
        redirectAttributes.addAttribute("hotelId", hotelId);
        return "redirect:/admin/employees";
    }

    @PostMapping("/employees/delete")
    @Transactional
    public String deleteEmployee(@RequestParam Integer employeeId,
                                 RedirectAttributes redirectAttributes) {
        Employee employee = employeeRepository.findById(employeeId).orElseThrow();
        List<Employee> hotelEmployees = employeeRepository.findByHotelId(employee.getHotelId());
        if (hotelEmployees.size() <= 1) {
            redirectAttributes.addAttribute("error", "A hotel must keep at least one employee so it can keep a manager.");
            redirectAttributes.addAttribute("hotelId", employee.getHotelId());
            return "redirect:/admin/employees";
        }

        employeeRepository.deleteById(employeeId);
        boolean managerReassigned = ensureHotelManagerAssigned(employee.getHotelId(), null);
        if (managerReassigned) {
            redirectAttributes.addAttribute("message", "Manager was reassigned automatically after removing the previous one.");
        }
        redirectAttributes.addAttribute("hotelId", employee.getHotelId());
        return "redirect:/admin/employees";
    }

    @GetMapping("/employees/edit/{id}")
    public String editEmployee(@PathVariable Integer id,
                               @RequestParam(required = false) String message,
                               @RequestParam(required = false) String error,
                               Model model) {
        model.addAttribute("employee", employeeRepository.findById(id).orElseThrow());
        model.addAttribute("hotels", hotelRepository.findAll());
        model.addAttribute("message", message);
        model.addAttribute("error", error);
        return "admin/employee-edit";
    }

    @PostMapping("/employees/edit/{id}")
    @Transactional
    public String updateEmployee(@PathVariable Integer id,
                                 @RequestParam String fullName,
                                 @RequestParam String address,
                                 @RequestParam String ssnSin,
                                 @RequestParam Integer hotelId,
                                 RedirectAttributes redirectAttributes) {
        Employee e = employeeRepository.findById(id).orElseThrow();
        Integer previousHotelId = e.getHotelId();

        if (!previousHotelId.equals(hotelId)) {
            List<Employee> previousHotelEmployees = employeeRepository.findByHotelId(previousHotelId);
            if (previousHotelEmployees.size() <= 1) {
                redirectAttributes.addAttribute("error", "Move blocked because the source hotel would be left without a manager.");
                return "redirect:/admin/employees/edit/" + id;
            }
        }

        e.setFullName(fullName);
        e.setAddress(address);
        e.setSsnSin(ssnSin);
        e.setHotelId(hotelId);
        employeeRepository.save(e);

        boolean reassignedOldHotelManager = false;
        boolean assignedNewHotelManager = false;
        if (!previousHotelId.equals(hotelId)) {
            reassignedOldHotelManager = ensureHotelManagerAssigned(previousHotelId, null);
            assignedNewHotelManager = ensureHotelManagerAssigned(hotelId, e.getEmployeeId());
        }

        if (reassignedOldHotelManager || assignedNewHotelManager) {
            redirectAttributes.addAttribute("message", "Manager assignments were updated automatically after moving this employee.");
        }
        redirectAttributes.addAttribute("hotelId", hotelId);
        return "redirect:/admin/employees";
    }

    // --- Hotels ---
    @GetMapping("/hotels")
    public String hotels(@RequestParam(required = false) String message,
                         @RequestParam(required = false) String error,
                         Model model) {
        List<Hotel> hotels = hotelRepository.findAll();
        Map<Integer, Employee> employeesById = employeeRepository.findAll().stream()
            .collect(Collectors.toMap(Employee::getEmployeeId, Function.identity()));

        model.addAttribute("hotels", hotels);
        model.addAttribute("chains", hotelChainRepository.findAll());
        model.addAttribute("managerNamesByHotel", hotels.stream().collect(Collectors.toMap(
            Hotel::getHotelId,
            hotel -> {
                Employee manager = employeesById.get(hotel.getManagerEmployeeId());
                return manager == null ? "Unassigned" : manager.getFullName();
            }
        )));
        model.addAttribute("message", message);
        model.addAttribute("error", error);
        return "admin/hotels";
    }

    @PostMapping("/hotels")
    @Transactional
    public String createHotel(@RequestParam String name,
                              @RequestParam Integer chainId,
                              @RequestParam Integer category,
                              @RequestParam String address,
                              @RequestParam String area,
                              @RequestParam String contactEmail,
                              @RequestParam String contactPhone,
                              RedirectAttributes redirectAttributes) {
        Hotel h = new Hotel();
        h.setName(name);
        h.setChainId(chainId);
        h.setCategory(category);
        h.setAddress(address);
        h.setArea(area);
        h.setContactEmail(contactEmail);
        h.setContactPhone(contactPhone);
        hotelRepository.save(h);

        redirectAttributes.addAttribute("hotelId", h.getHotelId());
        redirectAttributes.addAttribute("message", "Hotel created. Add the first employee now; they will become manager automatically.");
        return "redirect:/admin/employees";
    }

    @PostMapping("/hotels/delete")
    public String deleteHotel(@RequestParam Integer hotelId) {
        hotelRepository.deleteById(hotelId);
        return "redirect:/admin/hotels";
    }

    @GetMapping("/hotels/edit/{id}")
    public String editHotel(@PathVariable Integer id,
                            @RequestParam(required = false) String message,
                            @RequestParam(required = false) String error,
                            Model model) {
        model.addAttribute("hotel", hotelRepository.findById(id).orElseThrow());
        model.addAttribute("chains", hotelChainRepository.findAll());
        model.addAttribute("managerOptions", employeeRepository.findByHotelId(id));
        model.addAttribute("message", message);
        model.addAttribute("error", error);
        return "admin/hotel-edit";
    }

    @PostMapping("/hotels/edit/{id}")
    @Transactional
    public String updateHotel(@PathVariable Integer id,
                              @RequestParam String name,
                              @RequestParam Integer chainId,
                              @RequestParam Integer category,
                              @RequestParam String address,
                              @RequestParam String area,
                              @RequestParam String contactEmail,
                              @RequestParam String contactPhone,
                              @RequestParam Integer managerEmployeeId,
                              RedirectAttributes redirectAttributes) {
        if (!employeeBelongsToHotel(managerEmployeeId, id)) {
            redirectAttributes.addAttribute("error", "Manager must be selected from employees assigned to this hotel.");
            return "redirect:/admin/hotels/edit/" + id;
        }

        Hotel h = hotelRepository.findById(id).orElseThrow();
        h.setName(name);
        h.setChainId(chainId);
        h.setCategory(category);
        h.setAddress(address);
        h.setArea(area);
        h.setContactEmail(contactEmail);
        h.setContactPhone(contactPhone);
        h.setManagerEmployeeId(managerEmployeeId);
        hotelRepository.save(h);
        redirectAttributes.addAttribute("message", "Hotel details and manager assignment updated.");
        return "redirect:/admin/hotels";
    }

    // --- Rooms ---
    @GetMapping("/rooms")
    public String rooms(Model model) {
        List<Room> rooms = roomRepository.findAllWithAmenities();
        model.addAttribute("rooms", rooms);
        model.addAttribute("hotels", hotelRepository.findAll());
        model.addAttribute("amenities", amenityRepository.findAll());
        return "admin/rooms";
    }

    @PostMapping("/rooms")
    @Transactional
    public String createRoom(@RequestParam Integer hotelId,
                             @RequestParam String roomNumber,
                             @RequestParam String capacity,
                             @RequestParam java.math.BigDecimal price,
                             @RequestParam(required = false) String viewType,
                             @RequestParam(required = false) String problems,
                             @RequestParam(required = false) List<Integer> amenityIds,
                             @RequestParam(defaultValue = "false") Boolean extendable) {
        Room r = new Room();
        r.setHotelId(hotelId);
        r.setRoomNumber(roomNumber);
        r.setCapacity(capacity);
        r.setPrice(price);
        r.setViewType(viewType);
        r.setProblems(problems);
        r.setExtendable(extendable);
        r.setAmenities(loadAmenities(amenityIds));
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
        Room room = roomRepository.findWithAmenitiesById(id).orElseThrow();
        model.addAttribute("room", room);
        model.addAttribute("hotels", hotelRepository.findAll());
        model.addAttribute("amenities", amenityRepository.findAll());
        model.addAttribute("selectedAmenityIds", room.getAmenities().stream().map(Amenity::getAmenityId).toList());
        return "admin/room-edit";
    }

    @PostMapping("/rooms/edit/{id}")
    @Transactional
    public String updateRoom(@PathVariable Integer id,
                             @RequestParam Integer hotelId,
                             @RequestParam String roomNumber,
                             @RequestParam String capacity,
                             @RequestParam java.math.BigDecimal price,
                             @RequestParam(required = false) String viewType,
                             @RequestParam(required = false) String problems,
                             @RequestParam(required = false) List<Integer> amenityIds,
                             @RequestParam(defaultValue = "false") Boolean extendable) {
        Room r = roomRepository.findWithAmenitiesById(id).orElseThrow();
        r.setHotelId(hotelId);
        r.setRoomNumber(roomNumber);
        r.setCapacity(capacity);
        r.setPrice(price);
        r.setViewType(viewType);
        r.setProblems(problems);
        r.setExtendable(extendable);
        r.setAmenities(loadAmenities(amenityIds));
        roomRepository.save(r);
        return "redirect:/admin/rooms";
    }

    private List<Amenity> loadAmenities(List<Integer> amenityIds) {
        if (amenityIds == null || amenityIds.isEmpty()) {
            return List.of();
        }
        return amenityRepository.findAllById(amenityIds);
    }

    private boolean employeeBelongsToHotel(Integer employeeId, Integer hotelId) {
        return employeeRepository.findById(employeeId)
            .map(employee -> employee.getHotelId().equals(hotelId))
            .orElse(false);
    }

    private boolean ensureHotelManagerAssigned(Integer hotelId, Integer preferredEmployeeId) {
        Hotel hotel = hotelRepository.findById(hotelId).orElse(null);
        if (hotel == null) {
            return false;
        }

        if (hotel.getManagerEmployeeId() != null && employeeBelongsToHotel(hotel.getManagerEmployeeId(), hotelId)) {
            return false;
        }

        List<Employee> employees = employeeRepository.findByHotelId(hotelId);
        if (employees.isEmpty()) {
            return false;
        }

        Integer managerEmployeeId = employees.stream()
            .map(Employee::getEmployeeId)
            .filter(employeeId -> employeeId.equals(preferredEmployeeId))
            .findFirst()
            .orElse(employees.get(0).getEmployeeId());

        hotel.setManagerEmployeeId(managerEmployeeId);
        hotelRepository.save(hotel);
        return true;
    }
}
