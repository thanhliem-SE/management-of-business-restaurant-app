package com.example.easynotes.service.repository;

import com.example.easynotes.model.ChiTietThucPham;
import com.example.easynotes.model.ThanhToan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ThanhToanRepository extends JpaRepository<ThanhToan, Long> {
    @Query(value = "select * from ThanhToan where daXoa = 0", nativeQuery = true)
    public List<ThanhToan> getAll();
}
