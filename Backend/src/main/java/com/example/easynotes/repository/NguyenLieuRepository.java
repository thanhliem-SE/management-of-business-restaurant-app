package com.example.easynotes.repository;

import com.example.easynotes.model.NguyenLieu;
import com.example.easynotes.model.TaiKhoan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NguyenLieuRepository extends JpaRepository<NguyenLieu, Long> {
}
