package com.ehotels.repository;

import com.ehotels.model.Hotel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface HotelRepository extends JpaRepository<Hotel, Integer> {
    List<Hotel> findByArea(String area);
    List<Hotel> findByChainId(Integer chainId);
    List<Hotel> findByCategory(Integer category);

    @Query("SELECT DISTINCT h.area FROM Hotel h ORDER BY h.area")
    List<String> findDistinctAreas();
}
