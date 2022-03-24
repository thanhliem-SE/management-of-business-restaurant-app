package com.example.easynotes.controller;

import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.jwt.JwtTokenProvider;
import com.example.easynotes.model.TaiKhoan;
import com.example.easynotes.service.TaiKhoanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * Created by rajeevkumarsingh on 27/06/17.
 */
@RestController
@RequestMapping("/api")
public class TaiKhoanController {

    @Autowired
    TaiKhoanService service;

    @Autowired
    AuthenticationManager authenticationManager;

    @Autowired
    private JwtTokenProvider tokenProvider;

    @GetMapping("/taikhoan")
    public List<TaiKhoan> getAll() {
        return service.getList();
    }

    @PostMapping("/taikhoan")
    public TaiKhoan addItem(@Valid @RequestBody TaiKhoan taiKhoan) {
        return service.add(taiKhoan);
    }

    @GetMapping("/taikhoan/{id}")
    public TaiKhoan getById(@PathVariable(value = "id") String id) {
        try {
            return service.getByTenTaiKhoan(id);
        } catch (Exception e) {
            throw new ResourceNotFoundException("TaiKhoan", "maTaiKhoan", id);
        }
    }

    @PutMapping("/taikhoan/{id}")
    public TaiKhoan update(@PathVariable(value = "id") String id,
                           @Valid @RequestBody TaiKhoan taiKhoan) {
        TaiKhoan rs = service.update(taiKhoan, id);
        if (rs != null) {
            return rs;
        } else {
            throw new ResourceNotFoundException("TaiKhoan", "maTaiKhoan", id);
        }
    }

    @DeleteMapping("/taikhoan/{id}")
    public ResponseEntity<?> delete(@PathVariable(value = "id") String id) {
        try {
            service.deleteByTenTaiKhoan(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            throw new ResourceNotFoundException("TaiKhoan", "maTaiKhoan", id);
        }
    }
}