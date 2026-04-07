package com.ehotels.service;

import com.ehotels.model.Room;
import com.ehotels.repository.RoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Service
public class RoomSearchService {

    @Autowired
    private RoomRepository roomRepository;

    @Cacheable(value = "availableRooms")
    public List<Room> searchAvailableRooms(
            String area, Integer chainId, Integer category,
            String capacity, Integer totalRooms, BigDecimal minPrice, BigDecimal maxPrice,
            LocalDate startDate, LocalDate endDate) {
        return roomRepository.searchAvailableRooms(
            area, chainId, category, capacity, totalRooms,
            minPrice, maxPrice, startDate, endDate
        );
    }
}
