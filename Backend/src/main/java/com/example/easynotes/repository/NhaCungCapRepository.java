package com.example.easynotes.repository;

import com.example.easynotes.model.LieuLuong;
import com.example.easynotes.model.NhaCungCap;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NhaCungCapRepository extends JpaRepository<NhaCungCap, Long> {
}
