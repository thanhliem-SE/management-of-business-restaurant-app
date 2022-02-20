package com.example.easynotes.controller;


import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.Ban;
import com.example.easynotes.service.BanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * Created by rajeevkumarsingh on 27/06/17.
 */
@RestController
@RequestMapping("/api/ban")
public class BanController  {

    @Autowired
    private BanService service;

    @GetMapping("/")
    public List<Ban> getAll() {
        return service.getList();
    }

    @PostMapping("/")
    public Ban addItem(@Valid @RequestBody Ban ban) {
        return service.add(ban);
    }

    @GetMapping("/{id}")
    public Ban getById(@PathVariable(value = "id") Long id) {
        try {
            return service.getById(id);
        } catch (Exception e) {
            throw new ResourceNotFoundException("Ban", "maSoBan", id);
        }
    }

    @PutMapping("/{id}")
    public Ban update(@PathVariable(value = "id") Long id,
                             @Valid @RequestBody Ban ban) {
        Ban rs = service.update(ban, id);
        if (rs != null) {
            return rs;
        } else {
            throw new ResourceNotFoundException("Ban", "maSoBan", id);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable(value = "id") Long id) {
        try{
            service.deleteById(id);
            return  ResponseEntity.ok().build();
        }catch (Exception e) {
            throw new ResourceNotFoundException("Ban", "maSoBan", id);
        }
    }
}
