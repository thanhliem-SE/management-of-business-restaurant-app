package com.example.easynotes.controller;

import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.DanhMuc;
import com.example.easynotes.service.DanhMucService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/api/danhmuc")
public class DanhMucController {

    @Autowired
    private DanhMucService service;

    @GetMapping("/")
    public List<DanhMuc> getAll() {
        return service.getList();
    }

    @PostMapping("/")
    public DanhMuc addItem(@Valid @RequestBody DanhMuc DanhMuc) {
        return service.add(DanhMuc);
    }

    @GetMapping("/{id}")
    public DanhMuc getById(@PathVariable(value = "id") Long id) {
        try {
            return service.getById(id);
        } catch (Exception e) {
            throw new ResourceNotFoundException("DanhMuc", "maDanhMuc", id);
        }
    }

    @PutMapping("/{id}")
    public DanhMuc update(@PathVariable(value = "id") Long id,
                         @Valid @RequestBody DanhMuc DanhMuc) {
        DanhMuc rs = service.update(DanhMuc, id);
        if (rs != null) {
            return rs;
        } else {
            throw new ResourceNotFoundException("DanhMuc", "maDanhMuc", id);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable(value = "id") Long id) {
        try{
            service.deleteById(id);
            return  ResponseEntity.ok().build();
        }catch (Exception e) {
            throw new ResourceNotFoundException("DanhMuc", "maDanhMuc", id);
        }
    }
}
