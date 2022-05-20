package com.example.easynotes.service.repository;

import com.example.easynotes.model.ChiTietThucPham;
import com.example.easynotes.model.ThucPham;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ThucPhamRepository extends JpaRepository<ThucPham, Long> {
    @Query(value = "select * from thuc_pham where is_deleted = 0 and trang_thai = 'DADUYET'", nativeQuery = true)
    public List<ThucPham> getAll();

    @Query(value = "select * from thuc_pham where is_deleted = 0 and ma_danh_muc = ?1 and trang_thai = 'DADUYET'", nativeQuery = true)
    public List<ThucPham> getThucPhamByDanhMuc(Long maDanhMuc);

    @Query(value = "select * from thuc_pham where is_deleted = 0 and trang_thai = 'CHUADUYET'", nativeQuery = true)
    public List<ThucPham> getThucPhamChuaDuyet();

    @Query(value = "delete from thuc_pham where ma_thuc_pham = ?1", nativeQuery = true)
    public int deleteThucPham(Long maThucPham);
}
