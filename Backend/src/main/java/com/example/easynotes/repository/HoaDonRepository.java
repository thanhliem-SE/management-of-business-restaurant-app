package com.example.easynotes.repository;

import com.example.easynotes.model.HoaDon;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface HoaDonRepository extends JpaRepository<HoaDon, Long> {
    @Query(value = "select * from hoa_don where tinh_trang != 'PAYMENTED'", nativeQuery = true)
    public List<HoaDon> getHoaDonBeforePaymented();
}
