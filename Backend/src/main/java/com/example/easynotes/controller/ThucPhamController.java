package com.example.easynotes.controller;


import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.ThucPham;
import com.example.easynotes.service.ThucPhamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * Created by rajeevkumarsingh on 27/06/17.
 */
@RestController
@RequestMapping("/api/thucpham")
public class ThucPhamController  {

    @Autowired
    private ThucPhamService service;

    @GetMapping("/")
    public List<ThucPham> getAll() {
        return service.getList();
    }

    @PostMapping("/")
    public ThucPham addItem(@Valid @RequestBody ThucPham thucPham) {
        return service.add(thucPham);
    }

    @GetMapping("/{id}")
    public ThucPham getById(@PathVariable(value = "id") Long id) {
        try {
            return service.getById(id);
        } catch (Exception e) {
            throw new ResourceNotFoundException("ThucPham", "maThucPham", id);
        }
    }

    @PutMapping("/{id}")
    public ThucPham update(@PathVariable(value = "id") Long id,
                         @Valid @RequestBody ThucPham thucPham) {
        ThucPham rs = service.update(thucPham, id);
        if (rs != null) {
            return rs;
        } else {
            throw new ResourceNotFoundException("ThucPham", "maThucPham", id);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable(value = "id") Long id) {
        try{
            service.deleteById(id);
            return  ResponseEntity.ok().build();
        }catch (Exception e) {
            throw new ResourceNotFoundException("ThucPham", "maThucPham", id);
        }
    }

    @GetMapping("/laytheodanhmuc/{id}")
    public List<ThucPham> getTheoDanhMuc(@PathVariable(value = "id") Long maDanhMuc){
        try {
            return service.getListByDanhMuc(maDanhMuc);
        }catch (Exception e) {
            throw new ResourceNotFoundException("ThucPham", "maDanhMuc", maDanhMuc);
        }
    }
}
