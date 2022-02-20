package com.example.easynotes.controller;


import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.ThanhToan;
import com.example.easynotes.service.ThanhToanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * Created by rajeevkumarsingh on 27/06/17.
 */
@RestController
@RequestMapping("/api/thanhtoan")
public class ThanhToanController  {

    @Autowired
    private ThanhToanService service;

    @GetMapping("/")
    public List<ThanhToan> getAll() {
        return service.getList();
    }

    @PostMapping("/")
    public ThanhToan addItem(@Valid @RequestBody ThanhToan thanhToan) {
        return service.add(thanhToan);
    }

    @GetMapping("/{id}")
    public ThanhToan getById(@PathVariable(value = "id") Long id) {
        System.out.println("ma thanh toan :" + id);
        try {
            return service.getById(id);
        } catch (Exception e) {
            throw new ResourceNotFoundException("ThanhToan", "maThanhToan", id);
        }
    }

    @PutMapping("/{id}")
    public ThanhToan update(@PathVariable(value = "id") Long id,
                         @Valid @RequestBody ThanhToan thanhToan) {
        ThanhToan rs = service.update(thanhToan, id);
        if (rs != null) {
            return rs;
        } else {
            throw new ResourceNotFoundException("ThanhToan", "maThanhToan", id);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable(value = "id") Long id) {
        try{
            service.deleteById(id);
            return  ResponseEntity.ok().build();
        }catch (Exception e) {
            throw new ResourceNotFoundException("ThanhToan", "maThanhToan", id);
        }
    }
}
