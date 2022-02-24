package com.example.easynotes.controller;


import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.KhachHang;
import com.example.easynotes.service.KhachHangService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * Created by rajeevkumarsingh on 27/06/17.
 */
@RestController
@RequestMapping("/api/khachhang")
public class KhachHangController  {

    @Autowired
    private KhachHangService service;

    @GetMapping("/")
    public List<KhachHang> getAll() {
        return service.getList();
    }

    @PostMapping("/")
    public KhachHang addItem(@Valid @RequestBody KhachHang khachHang) {
        return service.add(khachHang);
    }

    @GetMapping("/{id}")
    public KhachHang getById(@PathVariable(value = "id") Long id) {
        try {
            return service.getById(id);
        } catch (Exception e) {
            throw new ResourceNotFoundException("KhachHang", "maKhachHang", id);
        }
    }

    @PutMapping("/{id}")
    public KhachHang update(@PathVariable(value = "id") Long id,
                         @Valid @RequestBody KhachHang khachHang) {
        KhachHang rs = service.update(khachHang, id);
        if (rs != null) {
            return rs;
        } else {
            throw new ResourceNotFoundException("KhachHang", "maKhachHang", id);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable(value = "id") Long id) {
        try{
            service.deleteById(id);
            return  ResponseEntity.ok().build();
        }catch (Exception e) {
            throw new ResourceNotFoundException("KhachHang", "maKhachHang", id);
        }
    }
}
