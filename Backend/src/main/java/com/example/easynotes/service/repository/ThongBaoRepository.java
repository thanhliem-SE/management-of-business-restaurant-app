package com.example.easynotes.service.repository;

import com.example.easynotes.model.ThongBao;
import com.example.easynotes.model.TaiKhoan;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ThongBaoRepository extends JpaRepository<ThongBao, Long> {
    public List<ThongBao> findByTaiKhoan(TaiKhoan taiKhoan);
}
