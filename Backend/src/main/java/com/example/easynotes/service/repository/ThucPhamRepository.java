package com.example.easynotes.service.repository;

import com.example.easynotes.model.ChiTietThucPham;
import com.example.easynotes.model.ThucPham;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ThucPhamRepository extends JpaRepository<ThucPham, Long> {
    @Query(value = "select * from thuc_pham where is_deleted = 0", nativeQuery = true)
    public List<ThucPham> getAll();

    @Query(value = "select * from thuc_pham where is_deleted = 0 and ma_danh_muc = ?1", nativeQuery = true)
    public List<ThucPham> getThucPhamByDanhMuc(Long maDanhMuc);
}
