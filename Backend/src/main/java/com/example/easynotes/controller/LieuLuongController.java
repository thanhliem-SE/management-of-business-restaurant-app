package com.example.easynotes.controller;

import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.LieuLuong;
import com.example.easynotes.service.LieuLuongService;
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
public class LieuLuongController {

    @Autowired
    LieuLuongService service;

    @GetMapping("/lieuluong")
    public List<LieuLuong> getAll() {
        return service.getList();
    }

    @PostMapping("/lieuluong")
    public LieuLuong addItem(@Valid @RequestBody LieuLuong lieuLuong) {
        return service.add(lieuLuong);
    }

    @GetMapping("/lieuluong/{id}")
    public LieuLuong getById(@PathVariable(value = "id") Long id) {
        try {
            return service.getById(id);
        } catch (Exception e) {
            throw new ResourceNotFoundException("LieuLuong", "maLieuLuong", id);
        }
    }

    @PutMapping("/lieuluong/{id}")
    public LieuLuong update(@PathVariable(value = "id") Long id,
                                     @Valid @RequestBody LieuLuong lieuLuong) {
        LieuLuong rs = service.update(lieuLuong, id);
        if (rs != null) {
            return rs;
        } else {
            throw new ResourceNotFoundException("LieuLuong", "maLieuLuong", id);
        }
    }

    @DeleteMapping("/lieuluong/{id}")
    public ResponseEntity<?> delete(@PathVariable(value = "id") Long id) {
        try{
            service.deleteById(id);
            return  ResponseEntity.ok().build();
        }catch (Exception e) {
            throw new ResourceNotFoundException("LieuLuong", "maLieuLuong", id);
        }
    }
}
