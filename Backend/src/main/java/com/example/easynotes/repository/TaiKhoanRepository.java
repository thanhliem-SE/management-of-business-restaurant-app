package com.example.easynotes.repository;

import com.example.easynotes.model.NhanVien;
import com.example.easynotes.model.TaiKhoan;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TaiKhoanRepository extends JpaRepository<TaiKhoan, String> {
}
