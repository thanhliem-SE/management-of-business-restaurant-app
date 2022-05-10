package com.example.easynotes.service.repository;

import com.example.easynotes.model.ChiTietHoaDon;
import com.example.easynotes.model.ChiTietThucPham;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ChiTietThucPhamRepository extends JpaRepository<ChiTietThucPham, Long> {

    @Query(value = "select * from chi_tiet_thuc_pham where is_deleted = 0", nativeQuery = true)
    public List<ChiTietThucPham> getAll();
}
