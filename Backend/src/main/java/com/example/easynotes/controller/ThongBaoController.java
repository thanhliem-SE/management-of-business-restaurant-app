package com.example.easynotes.controller;

import com.example.easynotes.exception.ResourceNotFoundException;
import com.example.easynotes.model.Quyen;
import com.example.easynotes.model.TaiKhoan;
import com.example.easynotes.model.ThongBao;
import com.example.easynotes.service.NhaCungCapService;
import com.example.easynotes.service.ThongBaoService;
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
public class ThongBaoController {

    @Autowired
    ThongBaoService service;

    @GetMapping("/thongbao")
    public List<ThongBao> getAll() {
        return service.getAll();
    }

    @PostMapping("/thongbao/{quyen}")
    public void addThongBao(@RequestBody @Valid ThongBao thongBao, @PathVariable("quyen") String quyen){
        service.addThongBaoByQuyen(thongBao.getNoiDung(), quyen);
        if(quyen != "QUANLY"){
            service.addThongBaoByQuyen(thongBao.getNoiDung(), "QUANLY");
        }
    }

    @PostMapping("/thongbao/getbytaikhoan")
    public List<ThongBao> getByTaiKhoan(@RequestBody @Valid TaiKhoan taiKhoan) {
        System.out.println(taiKhoan.getTenTaiKhoan());
        return service.getThongBaoByTaiKhoan(taiKhoan);
    }

    @PutMapping("/thongbao/{id}")
    public ThongBao updateThongBao(@RequestBody @Valid ThongBao thongBao, @PathVariable("id") Long id){
        return service.updateThongBao(id, thongBao);
    }

}
