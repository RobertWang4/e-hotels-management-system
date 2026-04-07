package com.ehotels.controller;

import com.ehotels.model.Room;
import com.ehotels.repository.HotelChainRepository;
import com.ehotels.repository.HotelRepository;
import com.ehotels.service.RoomSearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Controller
public class SearchController {

    @Autowired
    private RoomSearchService roomSearchService;

    @Autowired
    private HotelRepository hotelRepository;

    @Autowired
    private HotelChainRepository hotelChainRepository;

    @GetMapping("/search")
    public String searchPage(Model model) {
        model.addAttribute("areas", hotelRepository.findDistinctAreas());
        model.addAttribute("chains", hotelChainRepository.findAll());
        model.addAttribute("rooms", List.of());
        return "search";
    }

    @GetMapping("/search/results")
    public String searchResults(
            @RequestParam(required = false) String area,
            @RequestParam(required = false) Integer chainId,
            @RequestParam(required = false) Integer category,
            @RequestParam(required = false) String capacity,
            @RequestParam(required = false) Integer totalRooms,
            @RequestParam(required = false) BigDecimal minPrice,
            @RequestParam(required = false) BigDecimal maxPrice,
            @RequestParam String startDate,
            @RequestParam String endDate,
            Model model) {

        List<Room> rooms = roomSearchService.searchAvailableRooms(
            area, chainId, category, capacity, totalRooms, minPrice, maxPrice,
            LocalDate.parse(startDate), LocalDate.parse(endDate)
        );

        model.addAttribute("areas", hotelRepository.findDistinctAreas());
        model.addAttribute("chains", hotelChainRepository.findAll());
        model.addAttribute("rooms", rooms);
        return "search";
    }
}
