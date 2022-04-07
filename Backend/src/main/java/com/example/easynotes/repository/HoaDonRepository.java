package com.example.easynotes.repository;

import com.example.easynotes.model.HoaDon;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface HoaDonRepository extends JpaRepository<HoaDon, Long> {
    @Query(value = "select ban from hoa_don", nativeQuery = true)
    public List<Integer> getAllTableNumbers();
}
