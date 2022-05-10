package com.example.easynotes.controller;


import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.Ban;
import com.example.easynotes.model.HoaDon;
import com.example.easynotes.model.TinhTrang;
import com.example.easynotes.service.BanService;
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
public class HoaDonControler {

    @Autowired
    private HoaDonService service;

    @Autowired
    private BanService banService;

    @GetMapping("/")
    public List<HoaDon> getAll() {
        return service.getList();
    }

    @PostMapping("/")
    public HoaDon addItem(@Valid @RequestBody HoaDon hoaDon) {
        Ban ban = banService.getById(hoaDon.getBan().getMaSoBan());
        if (hoaDon.getTinhTrang().equals(TinhTrang.HUY) || hoaDon.getTinhTrang().equals(TinhTrang.DATHANHTOAN))
            ban.setTinhTrang(null);
        else
            ban.setTinhTrang(TinhTrang.CHO);

        Ban resultBan = banService.update(ban, ban.getMaSoBan());
        if (resultBan != null) {
            HoaDon hoaDon1 = service.add(hoaDon);
            if (hoaDon1 != null) {
                return hoaDon1;
            } else {
                return new HoaDon();
            }
        } else {
            return new HoaDon();
        }
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
        Ban ban = banService.getById(rs.getBan().getMaSoBan());
        ban.setTinhTrang(hoaDon.getTinhTrang());
        banService.update(ban, ban.getMaSoBan());
        if (rs != null) {
            return rs;
        } else {
            throw new ResourceNotFoundException("HoaDon", "maHoaDon", id);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable(value = "id") Long id) {
        try {
            service.deleteById(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            throw new ResourceNotFoundException("HoaDon", "maHoaDon", id);
        }
    }

    @GetMapping("/chuathanhtoan")
    public List<HoaDon> getHoaDonBeforPaymented() {
        return service.getHoaDonBeforePaymented();
    }

    @GetMapping("/phucvutaiban/{masoban}")
    public HoaDon getHoaDonDangPhucVuTaiBan(@PathVariable(value = "masoban") int masoban) {
        return service.getHoaDonDangPhucVuTaiBan(masoban);
    }
}
