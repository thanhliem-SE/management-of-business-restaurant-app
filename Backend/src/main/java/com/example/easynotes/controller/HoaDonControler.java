package com.example.easynotes.controller;


import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.HoaDon;
import com.example.easynotes.service.HoaDonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * Created by rajeevkumarsingh on 27/06/17.
 */
@RestController
@RequestMapping("/api/hoadon")
public class HoaDonControler  {

    @Autowired
    private HoaDonService service;

    @GetMapping("/")
    public List<HoaDon> getAll() {
        return service.getList();
    }

    @PostMapping("/")
    public HoaDon addItem(@Valid @RequestBody HoaDon hoaDon) {
        return service.add(hoaDon);
    }

    @GetMapping("/{id}")
    public HoaDon getById(@PathVariable(value = "id") Long id) {
        try {
            return service.getById(id);
        } catch (Exception e) {
            throw new ResourceNotFoundException("HoaDon", "maHoaDon", id);
        }
    }

    @PutMapping("/{id}")
    public HoaDon update(@PathVariable(value = "id") Long id,
                      @Valid @RequestBody HoaDon hoaDon) {
        HoaDon rs = service.update(hoaDon, id);
        if (rs != null) {
            return rs;
        } else {
            throw new ResourceNotFoundException("HoaDon", "maHoaDon", id);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable(value = "id") Long id) {
        try{
            service.deleteById(id);
            return  ResponseEntity.ok().build();
        }catch (Exception e) {
            throw new ResourceNotFoundException("HoaDon", "maHoaDon", id);
        }
    }
    @GetMapping("/chuathanhtoan")
    public List<HoaDon> getHoaDonBeforPaymented(){
        return service.getHoaDonBeforePaymented();
    }
}
