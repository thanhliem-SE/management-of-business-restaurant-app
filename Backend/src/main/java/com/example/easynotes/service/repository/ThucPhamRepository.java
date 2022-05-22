package com.example.easynotes.service.repository;

import com.example.easynotes.model.ChiTietThucPham;
import com.example.easynotes.model.ThucPham;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ThucPhamRepository extends JpaRepository<ThucPham, Long> {
    @Query(value = "select * from ThucPham where daXoa = 0 and trangThai = 'DADUYET'", nativeQuery = true)
    public List<ThucPham> getAll();

    @Query(value = "select * from ThucPham where daXoa = 0 and maDanhMuc = ?1 and trangThai = 'DADUYET'", nativeQuery = true)
    public List<ThucPham> getThucPhamByDanhMuc(Long maDanhMuc);

    @Query(value = "select * from ThucPham where daXoa = 0 and trangThai = 'CHUADUYET'", nativeQuery = true)
    public List<ThucPham> getThucPhamChuaDuyet();

    @Query(value = "delete from ThucPham where maThucPham = ?1", nativeQuery = true)
    public int deleteThucPham(Long maThucPham);
}
