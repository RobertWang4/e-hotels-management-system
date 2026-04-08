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
        populateSearchModel(model, null, null, null, null, null, null, null, null, null, List.of(), false);
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
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate,
            Model model) {
        area = normalizeBlank(area);
        capacity = normalizeBlank(capacity);
        startDate = normalizeBlank(startDate);
        endDate = normalizeBlank(endDate);
        List<Room> rooms = resolveRooms(area, chainId, category, capacity, totalRooms, minPrice, maxPrice, startDate, endDate);
        boolean hasSearched = hasDateRange(startDate, endDate);
        populateSearchModel(model, area, chainId, category, capacity, totalRooms, minPrice, maxPrice, startDate, endDate, rooms, hasSearched);
        return "search";
    }

    @GetMapping("/search/results-fragment")
    public String searchResultsFragment(
            @RequestParam(required = false) String area,
            @RequestParam(required = false) Integer chainId,
            @RequestParam(required = false) Integer category,
            @RequestParam(required = false) String capacity,
            @RequestParam(required = false) Integer totalRooms,
            @RequestParam(required = false) BigDecimal minPrice,
            @RequestParam(required = false) BigDecimal maxPrice,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate,
            Model model) {
        area = normalizeBlank(area);
        capacity = normalizeBlank(capacity);
        startDate = normalizeBlank(startDate);
        endDate = normalizeBlank(endDate);
        List<Room> rooms = resolveRooms(area, chainId, category, capacity, totalRooms, minPrice, maxPrice, startDate, endDate);
        boolean hasSearched = hasDateRange(startDate, endDate);
        populateSearchModel(model, area, chainId, category, capacity, totalRooms, minPrice, maxPrice, startDate, endDate, rooms, hasSearched);
        return "fragments/search-results :: results";
    }

    private List<Room> resolveRooms(String area,
                                    Integer chainId,
                                    Integer category,
                                    String capacity,
                                    Integer totalRooms,
                                    BigDecimal minPrice,
                                    BigDecimal maxPrice,
                                    String startDate,
                                    String endDate) {
        if (!hasDateRange(startDate, endDate)) {
            return List.of();
        }

        return roomSearchService.searchAvailableRooms(
            area, chainId, category, capacity, totalRooms, minPrice, maxPrice,
            LocalDate.parse(startDate), LocalDate.parse(endDate)
        );
    }

    private boolean hasDateRange(String startDate, String endDate) {
        return startDate != null && !startDate.isBlank() && endDate != null && !endDate.isBlank();
    }

    private String normalizeBlank(String value) {
        return value == null || value.isBlank() ? null : value;
    }

    private void populateSearchModel(Model model,
                                     String area,
                                     Integer chainId,
                                     Integer category,
                                     String capacity,
                                     Integer totalRooms,
                                     BigDecimal minPrice,
                                     BigDecimal maxPrice,
                                     String startDate,
                                     String endDate,
                                     List<Room> rooms,
                                     boolean hasSearched) {
        model.addAttribute("areas", hotelRepository.findDistinctAreas());
        model.addAttribute("chains", hotelChainRepository.findAll());
        model.addAttribute("rooms", rooms);
        model.addAttribute("selectedArea", area);
        model.addAttribute("selectedChainId", chainId);
        model.addAttribute("selectedCategory", category);
        model.addAttribute("selectedCapacity", capacity);
        model.addAttribute("selectedTotalRooms", totalRooms);
        model.addAttribute("selectedMinPrice", minPrice);
        model.addAttribute("selectedMaxPrice", maxPrice);
        model.addAttribute("selectedStartDate", startDate);
        model.addAttribute("selectedEndDate", endDate);
        model.addAttribute("hasSearched", hasSearched);
    }
}
