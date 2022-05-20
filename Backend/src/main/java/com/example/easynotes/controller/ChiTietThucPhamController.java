package com.example.easynotes.controller;

import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.ChiTietThucPham;
import com.example.easynotes.service.ChiTietThucPhamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/chitietthucpham")
public class ChiTietThucPhamController {
    @Autowired
    private ChiTietThucPhamService service;

    @GetMapping("/")
    public List<ChiTietThucPham> getAll() {
        return service.getList();
    }

    @PostMapping("/")
    public ChiTietThucPham addItem(@Valid @RequestBody ChiTietThucPham chiTietThucPham) {
        return service.add(chiTietThucPham);
    }

    @GetMapping("/{id}")
    public ChiTietThucPham getById(@PathVariable(value = "id") Long id) {
        try {
            return service.getById(id);
        } catch (Exception e) {
            throw new ResourceNotFoundException("ChiTietThucPham", "maChiTietThucPham", id);
        }
    }

    @PutMapping("/{id}")
    public ChiTietThucPham update(@PathVariable(value = "id") Long id,
                                @Valid @RequestBody ChiTietThucPham chiTietHoaDon) {
        System.out.println(chiTietHoaDon);
        ChiTietThucPham rs = service.update(chiTietHoaDon, id);
        if (rs != null) {
            return rs;
        } else {
            throw new ResourceNotFoundException("ChiTietThucPham", "maChiTietThucPham", id);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable(value = "id") Long id) {
        try{
            service.deleteById(id);
            return  ResponseEntity.ok().build();
        }catch (Exception e) {
            throw new ResourceNotFoundException("ChiTietThucPham", "maChiTietThucPham", id);
        }
    }

    @GetMapping("/getbytoday")
    public List<ChiTietThucPham> getByToday() {
        return service.getChiTietThucPhamToday();
    }

    @GetMapping("/taochitiethomnay/{id}")
    public List<ChiTietThucPham> taoChiTiet( @PathVariable(value = "id") Long id){
        return service.taoChiTietThucPhamHomNayTheoDanhMuc(id);
    }
}
