package com.example.easynotes.service.repository;

import com.example.easynotes.model.Ban;
import com.example.easynotes.model.ChiTietHoaDon;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ChiTietHoaDonRepository extends JpaRepository<ChiTietHoaDon, Long> {
    @Query(value = "select * from ChiTietHoaDon where maHoaDon = :idHoaDon", nativeQuery = true)
    public List<ChiTietHoaDon> getChiTietHoaDonByMaHoaDon(@Param(value = "idHoaDon") Long idHoaDon);

    @Query(value = "select * from ChiTietHoaDon where daXoa = 0", nativeQuery = true)
    public List<ChiTietHoaDon> getAll();
}
