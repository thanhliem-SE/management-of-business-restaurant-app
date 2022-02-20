package com.example.easynotes.repository;

import com.example.easynotes.model.Ban;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BanRepository extends JpaRepository<Ban, Long> {
}
