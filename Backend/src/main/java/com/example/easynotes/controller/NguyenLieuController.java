package com.example.easynotes.controller;

import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.NguyenLieu;
import com.example.easynotes.service.NguyenLieuService;
import com.example.easynotes.service.NguyenLieuService;
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
public class NguyenLieuController {

    @Autowired
    NguyenLieuService service;

    @GetMapping("/nguyenLieu")
    public List<NguyenLieu> getAll() {
        return service.getList();
    }

    @PostMapping("/nguyenLieu")
    public NguyenLieu addItem(@Valid @RequestBody NguyenLieu nguyenLieu) {
        return service.add(nguyenLieu);
    }

    @GetMapping("/nguyenLieu/{id}")
    public NguyenLieu getById(@PathVariable(value = "id") Long id) {
        try {
            return service.getById(id);
        } catch (Exception e) {
            throw new ResourceNotFoundException("NguyenLieu", "maNguyenLieu", id);
        }
    }

    @PutMapping("/nguyenLieu/{id}")
    public NguyenLieu update(@PathVariable(value = "id") Long id,
                                     @Valid @RequestBody NguyenLieu nguyenLieu) {
        NguyenLieu rs = service.update(nguyenLieu, id);
        if (rs != null) {
            return rs;
        } else {
            throw new ResourceNotFoundException("NguyenLieu", "maNguyenLieu", id);
        }
    }

    @DeleteMapping("/nguyenLieu/{id}")
    public ResponseEntity<?> delete(@PathVariable(value = "id") Long id) {
        try{
            service.deleteById(id);
            return  ResponseEntity.ok().build();
        }catch (Exception e) {
            throw new ResourceNotFoundException("NguyenLieu", "maNguyenLieu", id);
        }
    }
}
