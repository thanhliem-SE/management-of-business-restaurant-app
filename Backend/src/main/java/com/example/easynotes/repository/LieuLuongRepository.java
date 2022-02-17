package com.example.easynotes.repository;

import com.example.easynotes.model.LieuLuong;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LieuLuongRepository extends JpaRepository<LieuLuong, Long> {
}
