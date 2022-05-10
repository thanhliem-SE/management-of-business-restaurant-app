package com.example.easynotes.service.repository;

import com.example.easynotes.model.ChiTietThucPham;
import com.example.easynotes.model.NhaCungCap;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface NhaCungCapRepository extends JpaRepository<NhaCungCap, Long> {

    @Query(value = "select * from nha_cung_cap where is_deleted = 0", nativeQuery = true)
    public List<NhaCungCap> getAll();
}
