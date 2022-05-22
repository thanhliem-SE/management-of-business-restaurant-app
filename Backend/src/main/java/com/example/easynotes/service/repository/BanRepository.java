package com.example.easynotes.service.repository;

import com.example.easynotes.model.Ban;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface BanRepository extends JpaRepository<Ban, Long> {
    @Query(value = "select * from Ban where daXoa = 0", nativeQuery = true)
    public List<Ban> getAll();
}
