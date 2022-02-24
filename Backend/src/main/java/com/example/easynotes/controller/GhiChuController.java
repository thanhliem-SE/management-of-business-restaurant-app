package com.example.easynotes.controller;


import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.GhiChu;
import com.example.easynotes.repository.GhiChuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * Created by rajeevkumarsingh on 27/06/17.
 */
@RestController
@RequestMapping("/api")
public class GhiChuController {

    @Autowired
    com.example.easynotes.repository.GhiChuRepository GhiChuRepository;

    @GetMapping("/ghichu")
    public List<GhiChu> getAllghichu() {
        return GhiChuRepository.findAll();
    }

    @PostMapping("/ghichu")
    public GhiChu createGhiChu(@Valid @RequestBody GhiChu GhiChu) {
        return GhiChuRepository.save(GhiChu);
    }

    @GetMapping("/ghichu/{id}")
    public GhiChu getGhiChuById(@PathVariable(value = "id") Long GhiChuId) {
        return GhiChuRepository.findById(GhiChuId)
                .orElseThrow(() -> new ResourceNotFoundException("GhiChu", "id", GhiChuId));
    }

    @PutMapping("/ghichu/{id}")
    public GhiChu updateGhiChu(@PathVariable(value = "id") Long GhiChuId,
                                           @Valid @RequestBody GhiChu GhiChuDetails) {

        GhiChu GhiChu = GhiChuRepository.findById(GhiChuId)
                .orElseThrow(() -> new ResourceNotFoundException("GhiChu", "id", GhiChuId));

        GhiChu.setTieuDe(GhiChuDetails.getTieuDe());
        GhiChu.setNoiDung(GhiChuDetails.getNoiDung());

        GhiChu updatedGhiChu = GhiChuRepository.save(GhiChu);
        return updatedGhiChu;
    }

    @DeleteMapping("/ghichu/{id}")
    public ResponseEntity<?> deleteGhiChu(@PathVariable(value = "id") Long GhiChuId) {
        GhiChu GhiChu = GhiChuRepository.findById(GhiChuId)
                .orElseThrow(() -> new ResourceNotFoundException("GhiChu", "id", GhiChuId));

        GhiChuRepository.delete(GhiChu);

        return ResponseEntity.ok().build();
    }
}
