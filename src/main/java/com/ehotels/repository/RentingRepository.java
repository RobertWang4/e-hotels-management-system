package com.ehotels.repository;

import com.ehotels.model.Renting;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface RentingRepository extends JpaRepository<Renting, Integer> {
    List<Renting> findByStatus(String status);
}
