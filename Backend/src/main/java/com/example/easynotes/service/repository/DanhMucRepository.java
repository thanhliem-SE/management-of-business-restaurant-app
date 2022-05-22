package com.example.easynotes.service.repository;

import com.example.easynotes.model.ChiTietThucPham;
import com.example.easynotes.model.DanhMuc;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface DanhMucRepository extends JpaRepository<DanhMuc, Long> {
    @Query(value = "select * from DanhMuc where daXoa = 0", nativeQuery = true)
    public List<DanhMuc> getAll();
}
