package com.example.easynotes.controller;

import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.NhaCungCap;
import com.example.easynotes.service.NhaCungCapService;
import com.example.easynotes.service.NhaCungCapService;
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
public class NhaCungCapController  {

    @Autowired
    NhaCungCapService service;

    @GetMapping("/nhaCungCap")
    public List<NhaCungCap> getAll() {
        return service.getList();
    }

    @PostMapping("/nhaCungCap")
    public NhaCungCap addItem(@Valid @RequestBody NhaCungCap nhaCungCap) {
        return service.add(nhaCungCap);
    }

    @GetMapping("/nhaCungCap/{id}")
    public NhaCungCap getById(@PathVariable(value = "id") Long id) {
        try {
            return service.getById(id);
        } catch (Exception e) {
            throw new ResourceNotFoundException("NhaCungCap", "maNhaCungCap", id);
        }
    }

    @PutMapping("/nhaCungCap/{id}")
    public NhaCungCap update(@PathVariable(value = "id") Long id,
                                     @Valid @RequestBody NhaCungCap nhaCungCap) {
        NhaCungCap rs = service.update(nhaCungCap, id);
        if (rs != null) {
            return rs;
        } else {
            throw new ResourceNotFoundException("NhaCungCap", "maNhaCungCap", id);
        }
    }

    @DeleteMapping("/nhaCungCap/{id}")
    public ResponseEntity<?> delete(@PathVariable(value = "id") Long id) {
        try{
            service.deleteById(id);
            return  ResponseEntity.ok().build();
        }catch (Exception e) {
            throw new ResourceNotFoundException("NhaCungCap", "maLieuLuong", id);
        }
    }
}
