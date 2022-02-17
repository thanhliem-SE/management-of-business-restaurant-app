package com.example.easynotes.controller;

import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.NhanVien;
import com.example.easynotes.service.NhanVienService;
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
public class NhanVienController {

    @Autowired
    NhanVienService service;

    @GetMapping("/nhanVien")
    public List<NhanVien> getAll() {
        return service.getList();
    }

    @PostMapping("/nhanVien")
    public NhanVien addItem(@Valid @RequestBody NhanVien nhanVien) {
        return service.add(nhanVien);
    }

    @GetMapping("/nhanVien/{id}")
    public NhanVien getById(@PathVariable(value = "id") Long id) {
        try {
            return service.getById(id);
        } catch (Exception e) {
            throw new ResourceNotFoundException("NhanVien", "maNhanVien", id);
        }
    }

    @PutMapping("/nhanVien/{id}")
    public NhanVien update(@PathVariable(value = "id") Long id,
                                     @Valid @RequestBody NhanVien nhanVien) {
        NhanVien rs = service.update(nhanVien, id);
        if (rs != null) {
            return rs;
        } else {
            throw new ResourceNotFoundException("NhanVien", "maNhanVien", id);
        }
    }

    @DeleteMapping("/nhanVien/{id}")
    public ResponseEntity<?> delete(@PathVariable(value = "id") Long id) {
        try{
            service.deleteById(id);
            return  ResponseEntity.ok().build();
        }catch (Exception e) {
            throw new ResourceNotFoundException("NhanVien", "maNhanVien", id);
        }
    }
}
