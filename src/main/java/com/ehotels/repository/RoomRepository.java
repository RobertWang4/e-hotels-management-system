package com.ehotels.repository;

import com.ehotels.model.Room;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.time.LocalDate;
import java.util.List;

public interface RoomRepository extends JpaRepository<Room, Integer> {
    List<Room> findByHotelId(Integer hotelId);

    @Query("SELECT r FROM Room r JOIN Hotel h ON r.hotelId = h.hotelId " +
           "WHERE (:area IS NULL OR h.area = :area) " +
           "AND (:chainId IS NULL OR h.chainId = :chainId) " +
           "AND (:category IS NULL OR h.category = :category) " +
           "AND (:capacity IS NULL OR r.capacity = :capacity) " +
           "AND (:totalRooms IS NULL OR " +
           "  (SELECT COUNT(r2.roomId) FROM Room r2 WHERE r2.hotelId = h.hotelId) = :totalRooms) " +
           "AND (:minPrice IS NULL OR r.price >= :minPrice) " +
           "AND (:maxPrice IS NULL OR r.price <= :maxPrice) " +
           "AND NOT EXISTS (" +
           "  SELECT 1 FROM Booking b " +
           "  WHERE b.roomId = r.roomId AND b.status = 'active' " +
           "  AND b.startDate < :endDate AND b.endDate > :startDate) " +
           "AND NOT EXISTS (" +
           "  SELECT 1 FROM Renting rt " +
           "  WHERE rt.roomId = r.roomId AND rt.status = 'active' " +
           "  AND rt.startDate < :endDate AND rt.endDate > :startDate)")
    List<Room> searchAvailableRooms(
        @Param("area") String area,
        @Param("chainId") Integer chainId,
        @Param("category") Integer category,
        @Param("capacity") String capacity,
        @Param("totalRooms") Integer totalRooms,
        @Param("minPrice") java.math.BigDecimal minPrice,
        @Param("maxPrice") java.math.BigDecimal maxPrice,
        @Param("startDate") LocalDate startDate,
        @Param("endDate") LocalDate endDate
    );
}
