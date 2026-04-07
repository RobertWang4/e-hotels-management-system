package com.ehotels.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/views")
public class ViewController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/available-rooms")
    public String availableRooms(Model model) {
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(
            "SELECT * FROM available_rooms_per_area"
        );
        model.addAttribute("rows", rows);
        return "views/available-rooms";
    }

    @GetMapping("/hotel-capacity")
    public String hotelCapacity(Model model) {
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(
            "SELECT * FROM hotel_aggregated_capacity"
        );
        model.addAttribute("rows", rows);
        return "views/hotel-capacity";
    }
}
